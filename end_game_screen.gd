extends Panel


@onready var _score_text := $CenterContainer/VBoxContainer/ScoreText


func _ready():
	_score_text.text = _score_text.text.replace("$amount", str(GlobalScore.current_score))
