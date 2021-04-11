class_name LoseController
extends Node


export var lose_screen_prefab : PackedScene
export var level_scene : NodePath


func _ready():
	add_to_group("PPlanetListener")
	add_to_group("PLoseHUDListener")
	pause_mode = PAUSE_MODE_PROCESS


func on_PPlanet_destroyed(_planet : PPlanet) -> void:
	var lose_screen : Node = lose_screen_prefab.instance() as Node
	get_tree().paused = true
	get_tree().get_root().add_child(lose_screen)


func _on_PLoseHUDListener_retry_press():
	var _result = get_tree().reload_current_scene()
	get_tree().paused = false
