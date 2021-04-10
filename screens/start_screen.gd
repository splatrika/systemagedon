extends Node


export var star_system_screen : String = ""

func _start_game():
	$StarSystemScene/AnimationPlayer.play("start_game")
	$StarScreenHUD/AnimationPlayer.play("hide")
	yield($StarSystemScene/AnimationPlayer, "animation_finished")
	get_tree().change_scene(star_system_screen)


func _input(event):
	if event.is_action_released("ui_accept"):
		self._start_game()
