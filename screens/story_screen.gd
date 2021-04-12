extends Node


export var next_screen : String = ""


func _on_AnimationPlayer_animation_finished(anim_name):
	get_tree().change_scene(self.next_screen)
