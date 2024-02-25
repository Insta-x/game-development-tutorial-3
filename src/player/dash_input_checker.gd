extends Node

class_name DashInputChecker


signal dash_detected(direction: Direction)

enum Direction {
	NONE,
	LEFT,
	RIGHT,
}

@onready var reset_timer: Timer = $ResetTimer

var last_input: Direction = Direction.NONE


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("move_left"):
		if last_input == Direction.LEFT:
			dash_detected.emit(Direction.LEFT)
			last_input = Direction.NONE
		else:
			last_input = Direction.LEFT
			reset_timer.start()
	
	if event.is_action_pressed("move_right"):
		if last_input == Direction.RIGHT:
			dash_detected.emit(Direction.RIGHT)
			last_input = Direction.NONE
		else:
			last_input = Direction.RIGHT
			reset_timer.start()


func _on_reset_timer_timeout() -> void:
	last_input = Direction.NONE
