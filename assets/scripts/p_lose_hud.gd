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
