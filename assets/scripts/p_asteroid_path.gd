# This file is part of Systemagedon project
# 2021 © Daniil Belov. All rights reserved

class_name PAsteroidPath
extends Path


export var speed : float = 10
export(PackedScene) var asteroid_prefab : PackedScene
export var run_on_start : bool = false

var _asteroid : PAsteroid


func push_asteroid():
	var asteroid : Node = asteroid_prefab.instance()
	$PathFollow.add_child(asteroid)
	self._asteroid = asteroid
	set_physics_process(true)


func _ready():
	set_physics_process(false)
	if run_on_start:
		self.push_asteroid()


func _physics_process(delta : float):
	$PathFollow.offset += self.speed * delta
	get_tree().call_group("PAsteroidPathListener", "on_AsteroidPath_asteroid_moved", self.get_instance_id(), self._asteroid)
	if $PathFollow.unit_offset == 1:
		queue_free()


func _enter_tree():
	get_tree().call_group("PAsteroidPathListener", "on_AsteroidPath_created", self.get_instance_id(), self)


func _exit_tree():
	get_tree().call_group("PAsteroidPathListener", "on_AsteroidPath_removed", self.get_instance_id())
