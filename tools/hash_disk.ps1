# hash_disk.ps1 — hash shared modules on disk (same algorithm as tools/hash_shared.luau).
# Usage (from repo root):
#   powershell -ExecutionPolicy Bypass -File tools/hash_disk.ps1              # every file in shared/src
#   powershell -ExecutionPolicy Bypass -File tools/hash_disk.ps1 <file> ...   # specific files
#   powershell -ExecutionPolicy Bypass -File tools/hash_disk.ps1 -Text "a"    # hash a literal string (self-test)
# Algorithm: FNV-1a 32-bit over UTF-8 bytes, every CR removed, trailing whitespace (9,10,11,12,13,32) trimmed.
[CmdletBinding(PositionalBinding = $false)]
param(
    [Parameter()][string]$Text,
    [Parameter(Position = 0, ValueFromRemainingArguments = $true)][string[]]$Files
)

function Get-Fnv1a([byte[]]$bytes) {
    $list = New-Object System.Collections.Generic.List[byte]
    foreach ($b in $bytes) { if ($b -ne 13) { $list.Add($b) } }
    $ws = @(9, 10, 11, 12, 13, 32)
    $last = $list.Count
    while ($last -gt 0 -and $ws -contains [int]$list[$last - 1]) { $last-- }
    [uint64]$h = 2166136261
    [uint64]$prime = 16777619
    [uint64]$mask = 4294967295
    for ($i = 0; $i -lt $last; $i++) {
        $h = $h -bxor [uint64]$list[$i]
        $h = ($h * $prime) -band $mask
    }
    return ('{0:x8}' -f $h)
}

if ($PSBoundParameters.ContainsKey('Text')) {
    Get-Fnv1a ([System.Text.Encoding]::UTF8.GetBytes($Text))
    return
}

if (-not $Files -or $Files.Count -eq 0) {
    $root = Join-Path (Split-Path -Parent $PSScriptRoot) 'shared/src'
    $Files = Get-ChildItem -Path $root -File -Recurse | Where-Object { $_.Name -ne '.gitkeep' } | ForEach-Object { $_.FullName }
}
if (-not $Files -or $Files.Count -eq 0) { Write-Output 'no shared modules in shared/src'; return }

foreach ($f in $Files) {
    $bytes = [System.IO.File]::ReadAllBytes((Resolve-Path $f))
    # Strip a UTF-8 BOM if present (Studio sources never have one)
    if ($bytes.Length -ge 3 -and $bytes[0] -eq 0xEF -and $bytes[1] -eq 0xBB -and $bytes[2] -eq 0xBF) {
        $bytes = $bytes[3..($bytes.Length - 1)]
    }
    '{0}  {1}' -f (Get-Fnv1a $bytes), $f
}
