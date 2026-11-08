extends Node

# ── Content values (tune in playtests) ──────────────────────────────
const AGENCY_NAME = "Dash Couriers"
const DEV_NAMES = ["Dev 1", "Dev 2", "Dev 3", "Dev 4"]
const ORDER_TIMES = [60.0, 50.0, 45.0]  # near, medium, far

# ── Persistent game state ───────────────────────────────────────────
var stars: int = 3
var deliveries_completed: int = 0
var order_timer: float = 0.0

enum OrderState { WAITING, NOTIFIED, ACCEPTED, PICKED_UP, DELIVERED, FAILED }
var order_state: OrderState = OrderState.WAITING
var current_order: Dictionary = {}

# ── Settings (Master / Music / SFX) ─────────────────────────────────
var master_volume: float = 1.0
var music_volume: float = 1.0
var sfx_volume: float = 1.0

# ── Audio buses ─────────────────────────────────────────────────────
const BUS_MASTER = "Master"
const BUS_MUSIC = "Music"
const BUS_SFX = "SFX"

func _ready() -> void:
	_load_settings()
	_apply_audio_volumes()

# ── Scene switching ─────────────────────────────────────────────────
func goto_scene(path: String) -> void:
	get_tree().change_scene_to_file(path)

# ── Order helpers ───────────────────────────────────────────────────
func start_order(house_index: int) -> void:
	current_order = {
		"id": deliveries_completed + 1,
		"house_index": house_index,
		"time_limit": ORDER_TIMES[clamp(house_index, 0, ORDER_TIMES.size() - 1)]
	}
	order_state = OrderState.ACCEPTED
	order_timer = current_order["time_limit"]

func complete_order() -> void:
	order_state = OrderState.DELIVERED
	deliveries_completed += 1

func fail_order() -> void:
	order_state = OrderState.FAILED
	stars = max(0, stars - 1)
	current_order = {}

# ── Settings persistence ────────────────────────────────────────────
func _load_settings() -> void:
	var config = ConfigFile.new()
	var err = config.load("user://settings.cfg")
	if err != OK:
		return  # first run: use defaults
	master_volume = config.getvalue("settings", "master", 1.0)
	music_volume = config.getvalue("settings", "music", 1.0)
	sfx_volume = config.getvalue("settings", "sfx", 1.0)

func save_settings() -> void:
	var config = ConfigFile.new()
	config.setvalue("settings", "master", master_volume)
	config.setvalue("settings", "music", music_volume)
	config.setvalue("settings", "sfx", sfx_volume)
	config.save("user://settings.cfg")

func _apply_audio_volumes() -> void:
	AudioServer.set_bus_volume(AudioServer.get_bus_index(BUS_MASTER), master_volume)
	AudioServer.set_bus_volume(AudioServer.get_bus_index(BUS_MUSIC), music_volume)
	AudioServer.set_bus_volume(AudioServer.get_bus_index(BUS_SFX), sfx_volume)
