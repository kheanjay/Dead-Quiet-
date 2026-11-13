# Style guide — art, UI, sound
<!-- Owner: DQ-UI (UI + sound sections), DQ-Game (world art). Colour tokens are starting values; the user may retune them in Studio — ask before "correcting" anything that looks different. -->

## Colour tokens
| Token | Hex | Use |
|---|---|---|
| `Rust` | `#C8612B` | primary accent, buttons, highlights |
| `RustDark` | `#7A3515` | button shadow, borders |
| `Teal` | `#2E8C8A` | secondary accent, tech, friendly |
| `TealGlow` | `#3FF2E0` | emissive tech, turret lights, selection |
| `Steel` | `#2B2F33` | panel base |
| `SteelLight` | `#4A5056` | panel bevel, rivets |
| `Bone` | `#E8DCC4` | body text |
| `Hazard` | `#F2B31B` | warnings, hazard stripes, Noise meter |
| `Mutant` | `#B4F23F` | enemy emissive (toxic green) |
| `Danger` | `#E0402B` | damage, low health |

## World art
- Stylized low-poly, chunky readable silhouettes, bevelled edges; few parts per model (mobile budget).
- Materials: SmoothPlastic / Metal / CorrodedMetal / Wood; avoid noisy textures. Rust-orange + teal palette, desaturated ground.
- Emissive glow (Neon parts or SurfaceLights) on tech (turrets, workbenches) in Teal, on enemies in Mutant green.
- Night: dark blue ambient, strong contrast so glow reads. Day: warm, hazy, dusty atmosphere.
- Tintable art is made white and coloured in-engine; every generated image/border also ships a glow version.
- No coplanar faces: offset overlapping surfaces ≥0.01 studs or merge them.

## UI
- Industrial scrap: riveted Steel panels, Rust bevelled buttons, Hazard stripes on warnings, stencil font (e.g. `Enum.Font.Michroma`/`Oswald`-style heading, readable sans for body).
- Chunky buttons: min ~56 px tall on mobile, gamepad selection highlight in TealGlow.
- All UI authored in Studio as ScreenGuis; lists clone a `*Template`; only the Close button closes a panel.
- Every prompt shows the right glyph for the current input (KB/M, gamepad, touch).

## Sound palette
- Metallic and industrial: clanks, ratchets, servo whirs, Geiger crackle, wind through scrap, distant howls.
- Night: low synth drone that swells with wave intensity; Noise meter rises with a Geiger-style tick rate.
- UI: short metal clicks/clunks; confirm = heavier clank; error = buzzer.
- Folder: `SoundService/Palette/<Category>/<Name>`; categories: Ambience, Gather, Build, Combat, Enemy, UI, Music.
- Creator Store clips are placeholders, marked `-- PLACEHOLDER SFX` and listed in the sound system doc until replaced.
