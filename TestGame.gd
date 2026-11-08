extends Control

# TDD test for Game.gd autoload state manager.
# Runs assertions on _ready and prints PASS/FAIL to the console.

var passed: int = 0
var failed: int = 0

func _ready() -> void:
	_test("stars start at 3", Game.stars == 3)
	_test("deliveries_completed starts at 0", Game.deliveries_completed == 0)
	_test("order_state starts WAITING", Game.order_state == Game.OrderState.WAITING)
	_test("goto_scene is callable", typeof(Game.goto_scene) == TYPE_CALLABLE)
	_test("master_volume default 1.0", Game.master_volume == 1.0)
	_test("music_volume default 1.0", Game.music_volume == 1.0)
	_test("sfx_volume default 1.0", Game.sfx_volume == 1.0)

	# Order lifecycle
	Game.start_order(0)
	_test("start_order sets state ACCEPTED", Game.order_state == Game.OrderState.ACCEPTED)
	_test("start_order sets timer to ORDER_TIMES[0]", Game.order_timer == Game.ORDER_TIMES[0])
	_test("current_order has house_index 0", Game.current_order["house_index"] == 0)

	Game.fail_order()
	_test("fail_order sets state FAILED", Game.order_state == Game.OrderState.FAILED)
	_test("fail_order reduces stars to 2", Game.stars == 2)
	_test("current_order cleared", Game.current_order.size() == 0)

	Game.complete_order()
	_test("complete_order sets state DELIVERED", Game.order_state == Game.OrderState.DELIVERED)
	_test("complete_order increments deliveries_completed", Game.deliveries_completed == 1)

	# Settings persistence
	Game.master_volume = 0.5
	Game.save_settings()
	_test("save_settings writes user://settings.cfg", DirAccess.file_exists("user://settings.cfg"))

	# Summary
	var total: int = passed + failed
	print("\n=== Game.gd TDD results: %d/%d passed ===\n" % [passed, total])
	if failed == 0:
		print("ALL TESTS PASSED")
		get_tree().quit(0)
	else:
		print("SOME TESTS FAILED")
		get_tree().quit(1)

func _test(name: String, condition: bool) -> void:
	if condition:
		print("PASS: " + name)
		passed += 1
	else:
		print("FAIL: " + name)
		failed += 1
