class_name PLoseHUD
extends Control


func _on_RetryButton_button_up():
	get_tree().call_group("PLoseHUDListener", "_on_PLoseHUDListener_retry_press")
	queue_free()
