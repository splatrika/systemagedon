# This file is part of Systemagedon project
# 2021 © Daniil Belov. All rights reserved

class_name PPlanet
extends Area

func destroy() -> void:
	$AnimationPlayer.play("destroy")
	get_tree().call_group("PPlanetListener", "on_PPlanet_destroyed", self)


func _enter_tree():
	get_tree().call_deferred("call_group", "PPlanetListener", "on_PPlanet_created", self)


func _exit_tree():
	get_tree().call_deferred("call_group", "PPlanetListener", "on_PPlanet_removed", self)
