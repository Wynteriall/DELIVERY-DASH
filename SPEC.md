# SPEC — Delivery Dash

## 1. Project
- **Engine:** Godot 4.7
- **Resolution:** 640×360, stretch mode `canvas_items`, aspect `expand`
- **Entry point:** `main_menu.tscn` (set as main scene in `project.godot`)
- **Art:** 32×32 characters, 16×16 tiles, 24-color palette + transparency, top-left light source, all original PNG sprite sheets (Piskel/Photopea)

## 2. Architecture
**`Game.gd` autoload (singleton state manager)** owns all persistent state and drives scene swaps via `change_scene_to_file()`:
- `stars` (int, starts at 3)
- `current_order` (Order object or null)
- `order_timer` (float, seconds remaining)
- `deliveries_completed` (int, 0–3)
- `order_state` (WAITING / NOTIFIED / ACCEPTED / PICKED_UP / DELIVERED / FAILED)
- Content values at top: agency name (placeholder), developer names (placeholders), order times (60/50/45 s placeholders), rewards (TBD)
- Settings: Master/Music/SFX sliders saved via `ConfigFile` to `user://settings.cfg`

**Scenes:**
- `main_menu.tscn` — Start, Settings, Credits (Data Policy removed)
- `intro.tscn` — dialogue box → sprite swap → player control
- `game.tscn` — gameplay level
- `win.tscn` — "Rider of the Day" end screen
- `fired.tscn` — "You're Fired" end screen

## 3. Input Map (already in `project.godot`)
| Action | Key |
|--------|-----|
| move_up | W |
| move_down | S |
| move_left | A |
| move_right | D |
| boost | Left Shift |
| interact | E |
| phone_toggle | R |
| order_accept | F |
| order_cancel | Q |
| pause_game | ESC |

## 4. Screens

### Main Menu
- Background: Canva main menu image (buttons baked in)
- **Invisible click areas** over the Canva buttons (coordinates TBD from image)
- Buttons: Start, Settings, Credits
- Start opens "Ready to ride?" pop-up with a Play button → loads Intro
- Settings opens panel with Master/Music/SFX sliders (persist between runs)
- Credits lists 4 team members + roles (placeholders)

### Intro
- **Full dialogue box:** typewriter effect, speaker name, portrait, Skip button
- Advance with click, E, or Space
- Courier on foot (idle frame) beside the bike
- After dialogue, sprite swaps to courier-on-bike; player gains control

### Game
- Camera2D follows the rider
- Rider movement: 4-directional, **snaps to direction** (no turn animation yet — one-direction pedal asset), pedal animation while moving
- **Boost:** stamina bar; hold Shift drains, release refills, locks when empty; speed-lines VFX while boosting
- HUD: 3 individual star icons (full/empty), per-order timer, boost meter, phone icon, arrows (bouncing arrow at on-screen target + edge-of-screen arrow when off-screen)
- Order life cycle: WAITING → NOTIFIED → ACCEPTED → PICKED_UP → DELIVERED (or FAILED)
- One active order at a time
- **Timer:** starts on Accept; 60/50/45 s placeholders (near/medium/far); on 0 → order cancelled, −1 star, next order begins
- **Difficulty escalation:** time limits shorten as orders complete
- **Phone:** free-ride delay before first notification; buzz + badge; player clicks phone → order card with Accept/Decline; Decline is free; Accept starts timer
- **Shop:** single pickup zone for all orders; Area2D zone, press E while moving to pick up package
- **House:** 3 drop-off zones (near/medium/far); Area2D zone, press E while moving to toss package (arc toss with follow-through); coin pop particle burst on delivery
- **Obstacle:** slow-moving car; contact slows the courier (time penalty)
- 3 orders total per run

### End Screens
- **Win:** "Rider of the Day" — win condition TBD (open decision)
- **Lose:** "You're Fired" — all 3 stars lost
- Both: Retry button (restart run) + Main Menu button

### Pause Menu
- ESC opens: Continue, Restart, Exit

## 5. Open Decisions (tickets, not assumptions)
| # | Decision | Status |
|---|----------|--------|
| D1 | Win condition / star rating on win screen | Undecided — defer to playtests |
| D2 | Main menu invisible click-zone coordinates | Need from Canva image |
| D3 | Exact order time values | Placeholders (60/50/45 s); tune in playtests |

## 6. Removed (per ADR 0004)
- Minimap
- Data Policy screen / panel
