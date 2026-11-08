# ADR 0002: Boost is a stamina bar

## Status
Accepted

## Context
The HUD includes a boost meter that "locks when drained." Boost could be a stamina bar (drains while holding Shift, refills when released) or a cooldown burst (press Shift for a burst, then recharge).

## Decision
Boost is a stamina bar: holding Shift drains the meter, releasing refills it, and it locks when empty.

## Consequences
- Player must manage boost duration actively.
- Alternative considered: cooldown burst. Rejected because the stamina bar gives the player more direct control and matches the "locks when drained" phrasing.
