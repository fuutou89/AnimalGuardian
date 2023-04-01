class_name Player
extends CharacterBody3D

@export_group("Move speed")
## Maximum character movement speed
@export var move_speed := 8.0
## How fast the character will achieve its maximum movement speed
@export var acceleration := 3.0
## How fast the character stop moving if no input is given
@export var break_force := 12.0
## How fast it will change rotate its velocity in the xz plane
@export var turning_speed := 12.0
## Minimum velocity for the character, to avoid sliding
@export var stopping_speed := 1.0
## Minimum velocity for the character to slide when turning abruptly
@export var sliding_threshold_velocity := 5.5


@onready var camera_controller: CameraController = %CameraController
@onready var _ground_height: float = 0.0
@onready var _start_position := global_transform.origin

# Called when the node enters the scene tree for the first time.
func _ready():
	camera_controller.setup(self)
	
func _get_camera_oriented_input() -> Vector3:
	var raw_input := Input.get_vector("move_left", "move_right", "move_up", "move_down")

	var input := Vector3.ZERO
	# This is to ensure that diagonal input isn't stronger than axis aligned input
	input.x = -raw_input.x * sqrt(1.0 - raw_input.y * raw_input.y / 2.0)
	input.z = -raw_input.y * sqrt(1.0 - raw_input.x * raw_input.x / 2.0)

	input = camera_controller.global_transform.basis * input
	input.y = 0.0
	return input.normalized()

func _physics_process(delta):
	# Get input and movement state
	var move_direction := _get_camera_oriented_input()
	var angle_to_move := velocity.signed_angle_to(move_direction, Vector3.UP)
	if velocity.is_zero_approx():
		velocity = velocity.lerp(move_direction * move_speed, acceleration * delta)
	else:
		var angle_to_clamped := clampf(angle_to_move, -turning_speed * delta, turning_speed * delta)
		velocity = velocity.rotated(Vector3.UP, angle_to_clamped)
		
		var velocity_length: float = clamp(velocity.length(), 0, move_speed)
		if move_direction.is_zero_approx():
			velocity_length = lerp(velocity_length, 0.0, break_force * delta)
		else:
			velocity_length = lerp(velocity_length, move_direction.length() * move_speed, acceleration * delta)
		velocity = velocity.normalized() * velocity_length
		
		if move_direction.length() == 0 and velocity.length() < stopping_speed:
			velocity = Vector3.ZERO	
	
	if get_real_velocity().length() > 0.01:
		camera_controller.update_camera(global_position, delta)
	
	# Move and collide
	move_and_slide()
	
	get_tree().call_group("slaves", "update_target_localtion", $SlaveSlot.global_transform.origin)
