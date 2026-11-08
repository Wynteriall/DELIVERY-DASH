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

# Node References
@onready var name_label = $NameLabel
@onready var text_label = $TextLabel
@onready var skip_button = $SkipButton
@onready var press_space_label = $PressSpaceLabel # <-- NEW LABEL ADDED HERE


func _ready():
	skip_button.pressed.connect(_on_skip_pressed)
	update_dialogue()

func _input(event):
	# 1. Listen for the Escape key (ui_cancel) to skip the whole scene
	if event.is_action_pressed("ui_cancel"):
		start_game()
		
	# 2. Listen for the Spacebar (ui_accept) to advance dialogue
	if event.is_action_pressed("ui_accept"):
		current_line += 1
		
		# If there is more dialogue, load the next line
		if current_line < dialogue.size():
			update_dialogue()
		else:
			# If dialogue is over, go to the game scene
			start_game()

func update_dialogue():
	var speaker_name = dialogue[current_line][0]
	var speaker_text = dialogue[current_line][1]
	
	name_label.text = speaker_name
	text_label.text = speaker_text
	
		
	# Change the indicator text when the player reaches the final line
	if current_line == dialogue.size() - 1:
		press_space_label.text = "PRESS SPACE TO START"
	else:
		press_space_label.text = "PRESS SPACE ▼"

func _on_skip_pressed():
	start_game()

func start_game():
	# Assumes your main game scene is saved as game.tscn
	get_tree().change_scene_to_file("res://scenes/game.tscn")
