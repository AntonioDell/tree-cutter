extends Node2D

@export var spawn_count := 5

var _seeds_spawned := 0

var _tree_seed_scene := preload("res://tree_seed.tscn")

@onready var boundary1 = $Boundary1
@onready var boundary2 = $Boundary2

func _ready():
	pass


func _spawn_tree_seed():
	var new_tree_seed = _tree_seed_scene.instantiate() as Node2D
	var x = randf_range(boundary1.global_position.x, boundary2.global_position.x)
	new_tree_seed.global_position = Vector2(x, global_position.y)
	add_sibling(new_tree_seed)
	_seeds_spawned += 1


func _on_spawn_timer_timeout():
	if _seeds_spawned >= spawn_count:
		$SpawnTimer.stop()
		return
	
	_spawn_tree_seed()
