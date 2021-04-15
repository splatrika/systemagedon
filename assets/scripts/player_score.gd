# This file is part of Systemagedon project
# 2021 © Daniil Belov. All rights reserved

class_name PlayerScore
extends Node


var score : int = 0 setget _set_score
func _set_score(value : int):
	score = value
	get_tree().call_group("PlayerScoreListener", "on_PlayerScore_updated", self)
