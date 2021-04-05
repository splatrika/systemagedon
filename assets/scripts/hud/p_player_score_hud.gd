class_name PPlayerScoreHUD
extends Control


func push_score(value : int):
	$Label.text = str(value)
