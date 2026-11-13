--!strict
-- hash_shared.luau — drift check, run in Roblox Studio (edit mode).
-- How: paste into the Studio command bar, or run via the Roblox Studio MCP `execute_luau` tool.
-- Prints one line per ModuleScript under ReplicatedStorage/Shared:  [DRIFT] <Name> <hash>
-- Compare each hash with shared/manifest.json -> modules.<Name>.hash (and deployed.<Place>).
-- Algorithm MUST match tools/hash_disk.ps1: FNV-1a 32-bit over the source bytes,
-- with every CR (13) removed and trailing whitespace (9,10,11,12,13,32) trimmed.

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local WHITESPACE: { [number]: boolean } = { [9] = true, [10] = true, [11] = true, [12] = true, [13] = true, [32] = true }

local function fnv1a(source: string): string
	local stripped = string.gsub(source, "\r", "")
	local last = #stripped
	while last > 0 and WHITESPACE[string.byte(stripped, last)] do
		last -= 1
	end
	local h = 2166136261
	for i = 1, last do
		h = bit32.bxor(h, string.byte(stripped, i))
		-- h * 16777619 mod 2^32, split to stay exact in doubles: 16777619 = 2^24 + 403
		h = (bit32.lshift(h, 24) + h * 403) % 4294967296
	end
	return string.format("%08x", h)
end

local shared = ReplicatedStorage:FindFirstChild("Shared")
if not shared then
	print("[DRIFT] ReplicatedStorage/Shared not found (no shared modules deployed in this Place)")
else
	local count = 0
	for _, inst in shared:GetDescendants() do
		if inst:IsA("ModuleScript") then
			count += 1
			print(string.format("[DRIFT] %s %s", inst.Name, fnv1a((inst :: ModuleScript).Source)))
		end
	end
	print(string.format("[DRIFT] done, %d module(s) in %s", count, game.Name))
end
