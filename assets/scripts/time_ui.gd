# This file is part of Systemagedon project
# 2021 © Daniil Belov. All rights reserved

class_name TimeUI
extends Node

var time : Time


export var __time : NodePath
func _set__time(value : NodePath) -> void:
	__time = value
	var node : Node = get_node(value)
	if node is Time:
		self.time = node


export var rotate_input_factor : float = 100
export var rotate_gesture_input_factor : float = 3


var _rotate_input : float


func _ready() -> void:
	call_deferred("_set__time", self.__time)


func _input(event : InputEvent) -> void:
	if event is InputEventPanGesture:
		self._rotate_input = (event as InputEventPanGesture).delta.x

func _physics_process(delta : float) -> void:
	if not is_instance_valid(self.time):
		return
	self.time.travel(self._rotate_input * self.rotate_gesture_input_factor)
	if Input.is_action_pressed('ui_left'):
		self.time.travel(self.rotate_input_factor * delta * -1)
	elif Input.is_action_pressed('ui_right'):
		self.time.travel(self.rotate_input_factor * delta)
