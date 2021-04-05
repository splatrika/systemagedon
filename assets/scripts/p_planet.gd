class_name PPlanet
extends Area

func destroy() -> void:
	$AnimationPlayer.play("destroy")
	get_tree().call_group("PPlanetListener", "on_PPlanet_destroyed", self)
