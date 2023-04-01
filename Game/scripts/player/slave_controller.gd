extends CharacterBody3D

@onready var nav_agent : NavigationAgent3D = %NavigationAgent3D

var SPEED = 3.0

func _physics_process(delta):
	if nav_agent.is_navigation_finished():
		return
	var current_location = global_transform.origin
	var next_location = nav_agent.get_next_path_position()
	var new_velocity = (next_location - current_location).normalized() * SPEED
	
	velocity = new_velocity
	move_and_slide()

func update_target_localtion(target_location):
	var current_location = global_transform.origin
	if current_location.distance_to(target_location) > 1:
		nav_agent.set_target_position(target_location)
