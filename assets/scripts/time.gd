# This file is part of Systemagedon project
# 2021 © Daniil Belov. All rights reserved

class_name Time
extends Node


var star_system : PStarSystem


export var __star_system : NodePath setget _set__star_system
func _set__star_system(value : NodePath):
	__star_system = value
	var node : Node = get_node(value)
	if node is PStarSystem:
		self.star_system = node


func travel(direction : float) -> void:
	for orbit in self.star_system.PPlanetOrbit_orbits:
		orbit.planet_rotation_degress += direction


func _ready():
	call_deferred("_set__star_system", self.__star_system)
