extends Node

const WIN_SCORE := 5

var current_score := 0

func increase_score(amount: int):
	current_score += amount
	current_score = min(current_score, WIN_SCORE)
	if current_score == WIN_SCORE:
		get_tree().change_scene_to_file("res://end_game_screen.tscn")
	
