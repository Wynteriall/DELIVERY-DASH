# ADR 0006: Loading screen in; "Ready to ride?" popup cut

## Status
Accepted

## Context
The SPEC had Start → "Ready to ride?" confirmation popup → Intro. The collaborator shipped a different flow: Start → cosmetic loading screen (timer-faked progress bar, Back button) → Intro → Game. The popup was never built.

## Decision
Accept the collaborator's flow. The loading screen is a permanent flow step; the "Ready to ride?" popup is cut from the SPEC.

## Consequences
- The loading screen is cosmetic: a fake bar set to a fixed fill rate, not real asset loading. It can be wired to real `ResourceLoader` later.
- One more screen lives between menu and play — acceptable; the popup did little the loading screen doesn't already do.
- Reversible: the popup can be re-added to `main_menu.tscn` without changing any other screen.
