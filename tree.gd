extends Node2D


const max_height = 10
const grow_amount = -16


var _height = 1
var _branch_points: Array[Node2D] = []


@onready var trunk := $Trunk
@onready var branch_points := $BranchPoints

func _grow():
	_height += 1
	var next_trunk_point = trunk.get_point_position(trunk.get_point_count() - 1)
	next_trunk_point.y += grow_amount
	trunk.add_point(next_trunk_point)
	branch_points


func _on_grow_timer_timeout():
	if _height >= max_height:
		$GrowTimer.stop()
		return
	else:
		_grow()
