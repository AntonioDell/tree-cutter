extends Node2D
class_name Cuttable


const max_height = 10
const grow_amount = 16

var hit_points := 1
var max_hit_points := 5
var score_increase := 1

@onready var _trunk := $Trunk
@onready var _branches := $Branches
@onready var _cut_hit_box_shape := $CollisionShape2D

var _branch_point_scene := preload("res://branch_point.tscn")
var _height = 1
var _branch_points: Array[BranchPoint] = []
var _next_branch_point_direction = Vector2(-0.5, -1)


func cut():
	hit_points -= 1
	if hit_points == 0:
		queue_free()


func _ready():
	_add_branch_point()


func _grow():
	_height += 1
	hit_points += 1 if hit_points < max_hit_points else 0
	score_increase += 1
	
	_grow_trunk()
	_add_branch_point()
	var growing_branch_points = _get_growing_points()
	for branch_point in growing_branch_points:
		_branch_points.append(branch_point.grow())
	_move_branche_points()
	
	
	
func _move_branche_points():
	_branches.position.y -= grow_amount


func _add_branch_point():
	if _height >= .5 * max_height: return
	
	var new_branch_point = _branch_point_scene.instantiate()
	new_branch_point.grow_direction = _next_branch_point_direction
	new_branch_point.max_length = grow_amount
	new_branch_point.position.y += grow_amount * (_height - 1)
	_branch_points.append(new_branch_point)
	_branches.add_child(new_branch_point)
	_next_branch_point_direction.x = -_next_branch_point_direction.x


func _grow_trunk():
	var next_trunk_point = _trunk.get_point_position(_trunk.get_point_count() - 1)
	next_trunk_point.y -= grow_amount
	_trunk.add_point(next_trunk_point)
	
	var rect_shape := _cut_hit_box_shape.shape as RectangleShape2D
	rect_shape.size.y += grow_amount
	_cut_hit_box_shape.position.y -= .5 * grow_amount
	


func _get_growing_points() -> Array[BranchPoint]:
	var point_count = _branch_points.size()
	var potential_branch_points: Array[BranchPoint] = _branch_points.duplicate()
	var selected_points: Array[BranchPoint] = []
	var i = 0
	while i < point_count and potential_branch_points.size() > 0:
		var point = potential_branch_points.pick_random()
		if not point.can_grow:
			potential_branch_points.erase(point)
		elif not selected_points.has(point):
			selected_points.append(point)
			potential_branch_points.erase(point)
			i += 1
	return selected_points


func _on_grow_timer_timeout():
	if _height >= max_height:
		$GrowTimer.stop()
		return
	else:
		_grow()
