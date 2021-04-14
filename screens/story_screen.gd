extends Node


export var next_screen : String = ""

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "story":
		$MessagesQueueController.restart()


func _on_PressSpaceToSkeep_skeep():
	$HUD/AnimationPlayer.play("hide")
	yield($HUD/AnimationPlayer, "animation_finished")
	get_tree().change_scene(self.next_screen)


func _on_MessagesQueueController_messages_ended():
	$HUD/AnimationPlayer.play("complete_hide")
	yield($HUD/AnimationPlayer, "animation_finished")
	get_tree().change_scene(self.next_screen)
