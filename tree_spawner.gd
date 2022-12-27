extends AnimatableBody2D


var speed := 100


var _current_direction := Vector2.DOWN
var _is_tree_spawning := false


func _physics_process(delta):
	if _is_tree_spawning: return
	
	var motion = _current_direction * speed * delta
	var collision := move_and_collide(motion)
	if collision: _spawn_tree(collision.get_position())

func _spawn_tree(position: Vector2):
	_is_tree_spawning = true
	queue_free()

func _on_direction_change_timer_timeout():
	var x := randf_range(-1, 1)
	_current_direction = Vector2(x, 1)
