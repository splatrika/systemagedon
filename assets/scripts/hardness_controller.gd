# This file is part of Systemagedon project
# 2021 © Daniil Belov. All rights reserved

class_name HardnessController
extends Node


var asteroid_generator : PAsteroidGenerator


export var __asteroid_generator : NodePath setget _set__asteroid_generator
func _set__asteroid_generator(value : NodePath):
	__asteroid_generator = value
	var node : Node = get_node_or_null(value)
	if node is PAsteroidGenerator:
		asteroid_generator = node as PAsteroidGenerator


export var score_to_hardness_up : int = 40


export var hardness_up_asteroid_speed : float = 10

export var hardness_up_asteroid_spawn_delay : float = -0.5


func _ready():
	call_deferred("_set__asteroid_generator", __asteroid_generator)
	add_to_group("PlayerScoreListener")


func on_PlayerScore_updated(score_node : PlayerScore):
	if score_node.score % self.score_to_hardness_up == 0:
		self.asteroid_generator.spawn_delay += self.hardness_up_asteroid_spawn_delay
		self.asteroid_generator.asteroids_speed += self.hardness_up_asteroid_speed
