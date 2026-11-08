extends CharacterBody2D

# Rider — the courier on the bike, playable during gameplay (see GLOSSARY).
# T1: 4-directional movement that snaps to the dominant axis, pedal animation placeholder.
# Camera follow lives on the Camera2D child in the scene (limits clip to the map).

const SPEED := 320.0

# Placeholder pedal animation: sprite bobs while moving (replaced by a real
# pedal animation once the one-direction pedal asset arrives).
const PEDAL_BOB_PIXELS := 4.0
const PEDAL_BOB_SPEED := 12.0
const PEDAL_BOB_Y := 18.0  # sprite baseline offset while bobbing

var _facing := Vector2.RIGHT
var _bob_time := 0.0

@onready var sprite: Sprite2D = $Sprite2D
@onready var sprite_base_y: float = sprite.position.y

func _physics_process(delta: float) -> void:
	var input := Input.get_vector("move_left", "move_right", "move_up", "move_down")

	# Snap: only the dominant axis moves the rider, so the one-direction
	# pedal asset is never caught turning diagonally.
	if input.x != 0.0 and input.y != 0.0:
		if absf(_facing.y) > 0.0:
			_facing = Vector2(signf(input.x), 0.0)
		else:
			_facing = Vector2(signf(input.x), 0.0) if absf(input.x) > absf(input.y) \
				else Vector2(0.0, signf(input.y))
	elif input.x != 0.0:
		_facing = Vector2(signf(input.x), 0.0)
	elif input.y != 0.0:
		_facing = Vector2(0.0, signf(input.y))

	var moving := input != Vector2.ZERO
	velocity = _facing * SPEED if moving else Vector2.ZERO
	move_and_slide()

	_animate_pedal(moving, delta)

func _animate_pedal(moving: bool, delta: float) -> void:
	if moving:
		_bob_time += delta * PEDAL_BOB_SPEED
		sprite.position.y = sprite_base_y - PEDAL_BOB_PIXELS * absf(sin(_bob_time))
	else:
		_bob_time = 0.0
		sprite.position.y = sprite_base_y
