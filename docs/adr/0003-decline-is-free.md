# ADR 0003: Declining an order card is free

## Status
Accepted

## Context
When a phone notification arrives, the player opens an order card with Accept/Decline. The cancel rule says cancelling an active order (Q) or a timeout costs one star. It was unclear whether declining before accepting also costs a star.

## Decision
Declining an order card before accepting costs nothing. Only cancelling an accepted order or a timeout costs one star.

## Consequences
- Players can browse orders without penalty.
- Star loss only happens once the player commits to an order (accepts it) and then fails.
- Harder to reverse: game balance depends on this distinction.
