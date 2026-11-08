extends Control

# The dialogue array: [Speaker Name, Text]
var dialogue = [
	["Boss", "Hey rookie! Welcome to Delivery Dash."],
	["Boss", "Orders pop up on your phone. Press R to open it, then F to accept."],
	["Boss", "Pick up each package at the shop, then ride to the house and press E to toss it at the door."],
	["Boss", "Every order has a timer. Run out of time and you lose a star."],
	["Boss", "Lose all 3 stars and... well, you're fired. No pressure!"],
	["Boss", "Your bike is parked right next to you. Go get it!"]
]

var current_line = 0
var _typing: Tween = null

# Seconds per character for the typewriter effect
const TYPE_SPEED := 0.03

# Node References
@onready var name_label = $NameLabel
@onready var text_label = $TextLabel
@onready var skip_button = $SkipButton
@onready var press_space_label = $PressSpaceLabel

func _ready():
	skip_button.pressed.connect(_on_skip_pressed)
	update_dialogue()

func _input(event):
	# Advance with click, E (interact), or Space (ui_accept). ESC is reserved for pause.
	var advance := false
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		advance = true
	elif event.is_action_pressed("interact") or event.is_action_pressed("ui_accept"):
		advance = true
	if not advance:
		return

	# First press while typing completes the line; the next one advances
	if _typing and _typing.is_running():
		_typing.kill()
		_typing = null
		text_label.visible_ratio = 1.0
		return

	current_line += 1
	if current_line < dialogue.size():
		update_dialogue()
	else:
		start_game()

func update_dialogue():
	var speaker_name = dialogue[current_line][0]
	var speaker_text = dialogue[current_line][1]

	name_label.text = speaker_name

	# Typewriter effect
	text_label.text = speaker_text
	text_label.visible_ratio = 0.0
	if _typing:
		_typing.kill()
	_typing = create_tween()
	_typing.tween_property(text_label, "visible_ratio", 1.0, speaker_text.length() * TYPE_SPEED)

	# Change the indicator text when the player reaches the final line
	if current_line == dialogue.size() - 1:
		press_space_label.text = "PRESS SPACE TO START"
	else:
		press_space_label.text = "PRESS SPACE ▼"

func _on_skip_pressed():
	start_game()

func start_game():
	# Assumes your main game scene is saved as game.tscn
	Game.goto_scene("res://scenes/game.tscn")
