# This file is part of Systemagedon project
# 2021 © Daniil Belov. All rights reserved

class_name MessagesQueueController
extends Node


signal messages_ended()


export(Array, String) var messages : Array


var messages_label : AnimatedMessageLabel setget _set_messages_label
func _set_messages_label(value : AnimatedMessageLabel):
	messages_label = value
	var _result = messages_label.connect("animation_ended", self, "_on_messages_label_animation_ended")
	self._update_current_message()



export var __messages_label : NodePath setget _set__messages_label
func _set__messages_label(value : NodePath) -> void:
	__messages_label = value
	var node : Node = get_node_or_null(value)
	if node is AnimatedMessageLabel:
		self.messages_label = node


var press_arrow : CanvasItem

export var __press_arrow : NodePath setget _set__press_arrow
func _set__press_arrow(value : NodePath) -> void:
	__press_arrow = value
	var node : Node = get_node_or_null(value)
	if node is CanvasItem:
		self.press_arrow = node


var _current_message_index : int = 0

var _ready_to_next_message : bool = false


func restart():
	_current_message_index = 0
	_update_current_message()


func _ready():
	call_deferred("_set__messages_label", __messages_label)
	call_deferred("_set__press_arrow", __press_arrow)


func _on_messages_label_animation_ended():
	_ready_to_next_message = true
	if is_instance_valid(self.press_arrow):
		self.press_arrow.show()


func _push_next_message():
	if is_instance_valid(self.press_arrow):
		self.press_arrow.hide()
	if _current_message_index + 1 >= len(self.messages):
		emit_signal("messages_ended")
		return
	_current_message_index += 1
	_update_current_message()


func _update_current_message():
	if not is_instance_valid(self.messages_label):
		return
	if len(self.messages) > _current_message_index:
		messages_label.message_to_show = self.messages[_current_message_index]
		self.messages_label.show_text()


func _input(event : InputEvent):
	if event.is_action_released("ui_accept") and _ready_to_next_message:
		_push_next_message()
