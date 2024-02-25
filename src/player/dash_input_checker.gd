extends Node

class_name DashInputChecker


signal dash_detected

enum Direction {
	LEFT,
	RIGHT,
}

@onready var reset_timer: Timer = $ResetTimer


func _unhandled_input(event: InputEvent) -> void:
	pass
