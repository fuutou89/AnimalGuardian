extends Node

class_name LevelManager

@export var player_scene_array : Array[PackedScene] = []
@export var spawn_delay : float = 0
@export var level_root : Node

var player_array : Array[Node]

# Called when the node enters the scene tree for the first time.
func _ready():
	await InitializationCoroutine()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func InitializationCoroutine():
	if spawn_delay > 0:
		await get_tree().create_timer(spawn_delay).timeout
	pass
	
	InstantiatePlayableCharacters()
	
	EventBus.publish(GlobalEvent.CAMERA_SET_TARGET_CHARACTER, player_array[0])

func InstantiatePlayableCharacters():
	if player_scene_array.size() > 0 :
		for player_scene in player_scene_array:
			var player = player_scene.instantiate()
			player.position = Vector3(0, 10, 0)
			level_root.add_child.call_deferred(player)
			player_array.append(player)
