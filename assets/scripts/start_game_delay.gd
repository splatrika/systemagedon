# This file is part of Systemagedon project
# 2021 © Daniil Belov. All rights reserved

class_name GameStartDelay
extends Timer


var asteroid_generator : PAsteroidGenerator setget set_asteroid_generator
func set_asteroid_generator(value : PAsteroidGenerator):
	asteroid_generator = value


export var __asteroid_generator : NodePath setget _set__asteroid_generator
func _set__asteroid_generator(value : NodePath) -> void:
	__asteroid_generator = value
	var node : Node = get_node_or_null(value)
	if node is PAsteroidGenerator:
		self.asteroid_generator = node


var player_score_controller : PPlayerScoreTimeController

export var __player_score_controller : NodePath setget _set__player_score_controller
func _set__player_score_controller(value : NodePath) -> void:
	__player_score_controller = value
	var node : Node = get_node_or_null(value)
	if node is PPlayerScoreTimeController:
		self.player_score_controller = node


func _ready():
	var _result = self.connect("timeout", self, "_start_game")
	self.one_shot = true
	call_deferred("_set__asteroid_generator", self.__asteroid_generator)
	call_deferred("_set__player_score_controller", self.__player_score_controller)


func _start_game():
	self.asteroid_generator.set_pause(false)
	self.player_score_controller.set_pause(false)
