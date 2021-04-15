# This file is part of Systemagedon project
# 2021 © Daniil Belov. All rights reserved

class_name PPlayerScoreTimeController
extends Node


var player_score : PlayerScore


export var __player_score : NodePath setget _set__player_score
func _set__player_score(value : NodePath):
	__player_score = value
	var node : Node = get_node_or_null(value)
	if node is PlayerScore:
		player_score = node as PlayerScore

	

func _ready():
	call_deferred("_set__player_score", self.__player_score)


func _on_Timer_timeout():
	if is_instance_valid(self.player_score):
		self.player_score.score += 1

func set_pause(value : bool):
	if (value):
		$Timer.stop()
	else:
		$Timer.start()
