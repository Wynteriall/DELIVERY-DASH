extends Control

@onready var back_btn = $BackButton
@onready var loading_bar = $LoadingBar
@onready var load_timer = $LoadTimer

func _ready():
	# 1. Connect the Back Button
	back_btn.pressed.connect(_on_back_pressed)
	
	# 2. Connect the Timer
	load_timer.timeout.connect(_on_timer_timeout)
	
	# 3. Make sure the progress bar starts at 0
	loading_bar.value = 0

func _on_back_pressed():
	# Stop the timer so it doesn't accidentally change scenes in the background
	load_timer.stop()
	# Go back to the main menu (Make sure the spelling is exactly as it is in your FileSystem!)
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func _on_timer_timeout():
	# Add 2 to the progress bar every time the timer ticks (every 0.05 seconds)
	loading_bar.value += 2
	
	# Check if the loading bar is full
	if loading_bar.value >= 100:
		load_timer.stop() # Stop the timer
		
		# Move to your partner's intro scene! 
		# (Update "intro.tscn" to match whatever you named the intro file)
		get_tree().change_scene_to_file("res://scenes/intro.tscn")
