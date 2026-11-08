# ADR 0001: Central Game.gd state manager

## Status
Accepted

## Context
Delivery Dash flows through multiple screens: title → intro → gameplay → end screens. `main_menu.tscn` is already the main scene, and there are no `.gd` scripts yet. Game state (stars, current order, timer, delivery count, order state) must persist across screen transitions.

## Decision
Use a central `Game.gd` autoload (singleton) as the state manager. It owns all persistent game state and drives scene swaps via `change_scene_to_file()`. Each screen is its own scene loaded by the manager.

## Consequences
- Game state lives in one place, making screens testable in isolation.
- Content values (agency name, developer names, order times, rewards) live at the top of `Game.gd`.
- Harder to reverse later: every screen will depend on the autoload for state.
- Alternative considered: letting each screen load the next directly. Rejected because state would be scattered and harder to persist.
