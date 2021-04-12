extends Node


signal skeep()

func _input(event):
	if event.is_action_pressed("ui_accept"):
		$Timer.start()
	if event.is_action_released("ui_accept"):
		$Timer.stop()


func _on_Timer_timeout():
	emit_signal("skeep")
