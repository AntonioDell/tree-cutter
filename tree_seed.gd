extends AnimatableBody2D


var speed := 100


var _current_direction := Vector2.DOWN
var _is_tree_spawning := false
var _tree_scene := preload("res://tree.tscn")

func _physics_process(delta):
	if _is_tree_spawning: return
	
	var motion = _current_direction * speed * delta
	var collision := move_and_collide(motion)
	if collision: _plant_tree(collision.get_position())

func _plant_tree(position: Vector2):
	_is_tree_spawning = true
	var new_tree := _tree_scene.instantiate() as Node2D
	new_tree.global_position = position
	add_sibling(new_tree)
	queue_free()

func _on_direction_change_timer_timeout():
	var x := randf_range(-1, 1)
	_current_direction = Vector2(x, 1)
