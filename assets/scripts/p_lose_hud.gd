# This file is part of Systemagedon project
# 2021 © Daniil Belov. All rights reserved

class_name PLoseHUD
extends CanvasLayer


func _on_RetryButton_button_up():
	$AnimationPlayer.play("close")
	yield($AnimationPlayer, "animation_finished")
	get_tree().call_group("PLoseHUDListener", "_on_PLoseHUDListener_retry_press")
	queue_free()


func _on_RetryButton2_button_up():
	$AnimationPlayer.play("close")
	yield($AnimationPlayer, "animation_finished")
	get_tree().call_group("PLoseHUDListener", "_on_PLoseHUDListener_main_screen_press")
	queue_free()


func _input(event : InputEvent):
	if event.is_action_released("ui_accept"):
		_on_RetryButton_button_up()
	if event.is_action_released("ui_cancel"):
		_on_RetryButton2_button_up()
