class_name LoseHUDGotoMainScreenController
extends Node


export var main_screen : String


func _ready():
	add_to_group("PLoseHUDListener")


func _on_PLoseHUDListener_main_screen_press():
	get_tree().paused = false
	get_tree().change_scene(self.main_screen)

