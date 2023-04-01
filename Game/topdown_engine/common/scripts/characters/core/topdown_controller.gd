extends TopDownNode

class_name TopDownController

@export_category("Gravity")
@export var gravity : float = 40
@export var gravity_active : bool = true

@export_category("General Raycasts")
@export var crouched_raycast_length_multiplier : float = 1
@export var perform_cardinal_obstacle_raycast_detection : bool = false

@export var speed : Vector3
@export var velocity : Vector3
@export var velocity_last_frame : Vector3
@export var acceleration : Vector3
@export var grounded : bool
@export var just_got_grounded : bool
@export var current_movement : Vector3
@export var current_direction : Vector3
@export var friction : float
@export var added_force : Vector3
@export var free_movement : bool

func _get_collider_center() -> Vector3:
	return Vector3.ZERO
	
func _get_collider_bottom() -> Vector3:
	return Vector3.ZERO

func _get_collider_top() -> Vector3:
	return Vector3.ZERO
	
var object_below : Node

func _get_object_below() -> Node:
	return object_below

func _set_object_below(_obj):
	object_below = _obj

var surface_modifier_below : SurfaceModifier

func _get_surface_modifier_below() -> SurfaceModifier:
	return surface_modifier_below

func _set_surface_modifier_below(_obj):
	surface_modifier_below = _obj
	
var _impact : Vector3

func _get_applied_impact() -> Vector3:
	return _impact
