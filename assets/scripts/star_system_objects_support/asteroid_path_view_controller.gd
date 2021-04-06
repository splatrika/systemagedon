class_name AsteroidPathViewController
extends Node


export var level_scene : NodePath


export var viewer_prefab : PackedScene


export var run_small_accent_y_position : float = 0


var _viewers : Dictionary = {}


func _ready():
	add_to_group("PAsteroidPathListener")


func on_AsteroidPath_created(path_id : int, path : PAsteroidPath):
	var created_viewer : AsteroidPathViewer = viewer_prefab.instance()
	get_node(level_scene).add_child(created_viewer)
	created_viewer.push_asteroid_path(path)
	self._viewers[path_id] = created_viewer


func on_AsteroidPath_removed(path_id : int):
	if is_instance_valid(self._viewers[path_id]):
		self._viewers[path_id].queue_free()


func on_AsteroidPath_asteroid_moved(path_id : int, asteroid : PAsteroid):
	if is_instance_valid(self._viewers[path_id]):
		if asteroid.global_transform.origin.y < self.run_small_accent_y_position:
			self._viewers[path_id].make_small_accent()
