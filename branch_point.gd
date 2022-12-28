extends Node2D
class_name BranchPoint

const MAX_ROTATION_DEGREES := 45.0
const MAX_BRANCHES := 3

@export var grow_direction := Vector2.ZERO
@export var max_length := 0.0

var can_grow := true

var _branches_count := 0
var _branch_point_scene := preload("res://branch_point.tscn")


func _ready():
	if grow_direction == Vector2.ZERO:
		push_error("BranchPoint %s added to tree without grow_direction set." % name)
	elif max_length == 0:
		push_error("BranchPoint %s added to tree without max_length set." % name)


func grow() -> BranchPoint:
	var direction := _get_grow_direction()
	var length := _get_grow_length()
	var branch_end := direction * length
	
	var branch_line = Line2D.new()
	branch_line.width = 2
	branch_line.add_point(Vector2.ZERO)
	branch_line.add_point(branch_end)
	add_child(branch_line)
	
	var new_branch_point = _branch_point_scene.instantiate()
	new_branch_point.position = branch_end
	new_branch_point.grow_direction = direction
	new_branch_point.max_length = length
	add_child(new_branch_point)
	
	_branches_count += 1
	if _branches_count >= MAX_BRANCHES:
		can_grow = false
	
	return new_branch_point


func _get_grow_direction() -> Vector2:
	var deviation = randf_range(-1, 1)
	var angle = MAX_ROTATION_DEGREES * deviation
	
	return grow_direction.rotated(deg_to_rad(angle)).normalized()


func _get_grow_length() -> float:
	#var deviation := randf_range(.75, 1)
	#return deviation * max_length
	return max_length
