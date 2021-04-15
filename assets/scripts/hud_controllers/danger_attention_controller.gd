# This file is part of Systemagedon project
# 2021 © Daniil Belov. All rights reserved

class_name DangerAttentionController
extends Node


export var dangert_attention_prefab : PackedScene


var main_camera : Camera

export var __main_camera : NodePath setget _set__main_camera
func _set__main_camera(value : NodePath):
	__main_camera = value
	var node : Node = get_node_or_null(value)
	if node is Camera:
		self.main_camera = node as Camera


var attensions_3D_positions : Dictionary = {}

var attentions_by_path_id : Dictionary = {}

export var attentions_max_count : int = 1

export var level_node : NodePath

var _attentions_count = 0


func _ready():
	call_deferred("_set__main_camera", __main_camera)
	self.add_to_group("PAsteroidPathListener")


func on_AsteroidPath_created(path_id : int, path_node : PAsteroidPath):
	if self._attentions_count >= self.attentions_max_count:
		return
	var curve : Curve3D = path_node.curve
	var center_point : Vector3 = curve.get_point_position(int(curve.get_point_count() / 2) + 1)
	var created_attention : Control = self.dangert_attention_prefab.instance() as Control
	var attention_position : Vector2 = self.main_camera.unproject_position(center_point)
	created_attention.rect_position = attention_position
	get_node(self.level_node).add_child(created_attention)
	self.attensions_3D_positions[created_attention.get_instance_id()] = center_point
	self.attentions_by_path_id[path_id] = created_attention
	self._attentions_count += 1


func on_AsteroidPath_removed(path_id : int):
	if self.attentions_by_path_id.has(path_id):
		self.attentions_by_path_id[path_id].queue_free()
		var _result = self.attentions_by_path_id.erase(path_id)


func _physics_process(_delta):
	for path_id in self.attentions_by_path_id.keys():
		var attention : Control = self.attentions_by_path_id[path_id]
		var position_3D : Vector3 = self.attensions_3D_positions[attention.get_instance_id()]
		var attention_position : Vector2 = self.main_camera.unproject_position(position_3D)
		attention.rect_position = attention_position
