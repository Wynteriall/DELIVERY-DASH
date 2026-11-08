# Glossary — Delivery Dash

Domain terms used across the project. Devoid of implementation details.

**Agency** — The delivery company the player works for. Named on the title screen and credits.

**Courier** — The player character on foot (idle frame beside the bike in the intro).

**Rider** — The courier on the bike, the playable character during gameplay.

**Order** — A delivery request. Life cycle: WAITING → NOTIFIED → ACCEPTED → PICKED_UP → DELIVERED (or FAILED on timeout/cancel). One active order at a time.

**Star** — One of three lives. Lost when an order fails (timeout or cancel). Game over at zero stars.

**Boost** — Temporary speed increase activated by the player, limited by a stamina bar that locks when drained.

**Phone** — In-game UI through which orders arrive (notification badge) and are accepted (order card with Accept/Decline).

**Package** — Item picked up at the shop and tossed at the house door.

**Shop** — The single pickup location for all orders.

**House** — A drop-off location. Three houses (near, medium, far).

**Timer** — Per-order countdown that starts when the order is accepted. Failing it cancels the order and costs a star.

**Difficulty escalation** — Order time limits shorten as the player completes more orders.

**Cancel rule** — Cancelling an active order (Q) costs one star, same as a timeout. Declining an order card before accepting is free.

**End screen** — "Rider of the Day" (win) or "You're Fired" (lose), each offering Retry or Main Menu.
