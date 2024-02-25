extends CharacterBody2D


@export_group("Movement")
@export var normal_speed := 300.0
@export var crouch_speed := 150.0
@export var dash_speed := 600.0
@export var jump_power := -400.0

@onready var state_chart: StateChart = $StateChart
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D
@onready var dash_input_checker: DashInputChecker = $DashInputChecker
@onready var normal_collision_shape: CollisionShape2D = $NormalCollisionShape2D
@onready var crouch_collision_shape: CollisionShape2D = $CrouchCollisionShape2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

var can_jump_count: int = 0
var dash_direction: DashInputChecker.Direction = DashInputChecker.Direction.NONE


#region Normal State
func _on_normal_state_entered() -> void:
	dash_input_checker.dash_detected.connect(_on_dash_input_checker_dash_detected)
	normal_collision_shape.disabled = false


func _on_normal_state_processing(delta: float) -> void:
	sprite.flip_h = velocity.x < 0 if abs(velocity.x) > 0.1 else sprite.flip_h
	
	if velocity.y < 0:
		animation_player.play("jumping")
	elif velocity.y > 0.2:
		animation_player.play("falling")
	else:
		animation_player.play("idle" if abs(velocity.x) < 0.1 else "walking")


func _on_normal_state_physics_processing(delta: float) -> void:
	if Input.is_action_just_pressed("crouch"):
		state_chart.send_event("ToCrouching")
	
	_vertical_movement(delta)
	_horizontal_movement(delta, normal_speed)
	
	move_and_slide()


func _on_normal_state_exited() -> void:
	dash_input_checker.dash_detected.disconnect(_on_dash_input_checker_dash_detected)
	normal_collision_shape.disabled = true
#endregion


#region Dashing State
func _on_dashing_state_entered() -> void:
	velocity.x = dash_speed if dash_direction == DashInputChecker.Direction.RIGHT else -dash_speed
	velocity.y = 0
	
	sprite.flip_h = dash_direction == DashInputChecker.Direction.LEFT
	
	animation_player.play("dashing")
	
	normal_collision_shape.disabled = false


func _on_dashing_state_physics_processing(delta: float) -> void:
	move_and_slide()


func _on_dashing_state_exited() -> void:
	velocity.x = 0
	
	normal_collision_shape.disabled = true
#endregion


#region Crouching State
func _on_crouching_state_entered() -> void:
	crouch_collision_shape.disabled = false


func _on_crouching_state_processing(delta: float) -> void:
	sprite.flip_h = velocity.x < 0 if abs(velocity.x) > 0.1 else sprite.flip_h
	
	if velocity.y < 0:
		animation_player.play("jumping")
	elif velocity.y > 0.2:
		animation_player.play("falling")
	else:
		animation_player.play("crouching")


func _on_crouching_state_physics_processing(delta: float) -> void:
	if Input.is_action_just_released("crouch"):
		state_chart.send_event("ToNormal")
	
	_vertical_movement(delta)
	_horizontal_movement(delta, crouch_speed)
	
	move_and_slide()


func _on_crouching_state_exited() -> void:
	crouch_collision_shape.disabled = true
#endregion


#region Private Helper Functions
## Physics process helper function. NOT TO BE ACCESSED ELSEWHERE!
func _vertical_movement(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		can_jump_count = 2
	
	if Input.is_action_just_pressed("jump") and can_jump_count > 0:
		velocity.y = jump_power
		can_jump_count -= 1

## Physics process helper function. NOT TO BE ACCESSED ELSEWHERE!
func _horizontal_movement(delta: float, move_speed: float) -> void:
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * move_speed
	else:
		velocity.x = move_toward(velocity.x, 0, move_speed)
#endregion


func _on_dash_input_checker_dash_detected(direction: DashInputChecker.Direction) -> void:
	dash_direction = direction
	state_chart.send_event("ToDashing")
