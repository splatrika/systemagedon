# This file is part of Systemagedon project
# 2021 © Daniil Belov. All rights reserved

class_name AsteroidPathViewer
extends Spatial


export var asteroid_path_item : PackedScene


var _pathes_items : Array = []


var _is_small_accent = false


func push_asteroid_path(path : PAsteroidPath):
	var curve : Curve3D = path.curve
	var points_count : int = curve.get_point_count()
	for item in self._pathes_items:
		item.queue_free()
	self._pathes_items.clear()
	for i in range(points_count - 1):
		var first_point : Vector3 = curve.get_point_position(i)
		var second_point : Vector3 = curve.get_point_position(i + 1)
		var created_path_item : Spatial = asteroid_path_item.instance() as Spatial
		var distance_to_second : float = first_point.distance_to(second_point)
		add_child(created_path_item)
		created_path_item.scale.z = distance_to_second / 2
		created_path_item.translation = first_point
		created_path_item.look_at(second_point, Vector3(0, 1, 0))
		self._pathes_items.append(created_path_item)


func make_small_accent():
	if self._is_small_accent:
		return
	for item in _pathes_items:
		item.make_small_accent()
		self._is_small_accent = true
