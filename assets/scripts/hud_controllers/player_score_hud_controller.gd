# This file is part of Systemagedon project
# 2021 © Daniil Belov. All rights reserved

class_name PlayerScoreHUDController
extends Node


var player_score_hud : PPlayerScoreHUD


export var __player_score_hud : NodePath
func _set__player_score_hud(value : NodePath):
	__player_score_hud = value
	var node : Node = get_node_or_null(value)
	if node is PPlayerScoreHUD:
		player_score_hud = node as PPlayerScoreHUD


func _ready():
	add_to_group("PlayerScoreListener")
	call_deferred("_set__player_score_hud", self.__player_score_hud)


func on_PlayerScore_updated(score_node : PlayerScore):
	if is_instance_valid(player_score_hud):
		self.player_score_hud.push_score(score_node.score)
