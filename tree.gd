extends Node2D


const max_height = 10
const grow_amount = 16


var _height = 1
var _branch_points: Array[BranchPoint] = []


@onready var _trunk := $Trunk
@onready var _branches := $Branches


func _ready():
	var initial_point = BranchPoint.new()
	initial_point.grow_direction = Vector2(-0.5, -1) if randi_range(0, 1) == 0 else Vector2(0.5, -1)
	initial_point.max_length = grow_amount
	initial_point.position.y -= grow_amount
	_branch_points.append(initial_point)
	_branches.add_child(initial_point)


func _grow():
	_height += 1
	_branches.position.y -= grow_amount
	
	var next_trunk_point = _trunk.get_point_position(_trunk.get_point_count() - 1)
	next_trunk_point.y -= grow_amount
	_trunk.add_point(next_trunk_point)
	
	
func _move_branche_points():
	if _height >= .5 * max_height:
		_branches.position.y -= grow_amount
	else: 
		for branch_point in _branch_points:
			branch_point.position.y -= grow_amount

func _get_growing_points() -> Array[BranchPoint]:
	var point_count = ceili(_branch_points.size() / 2)
	var selected_points: Array[BranchPoint] = []
	var i = 0
	while i < point_count:
		var point = _branch_points.pick_random()
		if not selected_points.has(point):
			selected_points.append(point)
			i += 1
	return selected_points


func _on_grow_timer_timeout():
	if _height >= max_height:
		$GrowTimer.stop()
		return
	else:
		_grow()
