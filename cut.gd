extends Node2D

signal cut_finished
signal cut_started

@onready var _cut_line_points: PackedVector2Array = $Line2D.points.duplicate()
@onready var _animation_player := $AnimationPlayer
@onready var _ray_cast := $RayCast2D


func _ready():
	$Line2D.clear_points()


func _unhandled_key_input(event):
	if Input.is_action_just_pressed("cut"):
		_cut()


func _cut():
	if _animation_player.is_playing(): return
	
	emit_signal("cut_started")
	if _ray_cast.is_colliding():
		var tree_to_cut = _ray_cast.get_collider() as Cuttable
		tree_to_cut.cut()
	_animation_player.play("cut")
	await _animation_player.animation_finished
	emit_signal("cut_finished")
