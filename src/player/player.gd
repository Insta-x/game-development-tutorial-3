extends CharacterBody2D


@export_group("Movement")
@export var move_speed := 300.0
@export var dash_speed := 600.0
@export var jump_power := -400.0

@onready var state_chart: StateChart = $StateChart

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

var can_jump_count: int = 0


#region Normal State
func _on_normal_state_physics_processing(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		can_jump_count = 2

	if Input.is_action_just_pressed("jump") and can_jump_count > 0:
		velocity.y = jump_power
		can_jump_count -= 1

	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * move_speed
	else:
		velocity.x = move_toward(velocity.x, 0, move_speed)

	move_and_slide()
#endregion


#region Dashing State
func _on_dashing_state_entered() -> void:
	velocity.x = dash_speed


func _on_dashing_state_physics_processing(delta: float) -> void:
	move_and_slide()


func _on_dashing_state_exited() -> void:
	velocity.x = 0
#endregion
