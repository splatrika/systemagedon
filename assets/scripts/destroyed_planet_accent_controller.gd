class_name DestroyedPlanetAccentController
extends Node


export var level_node : NodePath


var main_camera : Camera


export var __main_camera : NodePath setget _set__main_camera
func _set__main_camera(value : NodePath):
	__main_camera = value
	var node : Node = get_node_or_null(value)
	if node is Camera:
		main_camera = node as Camera


func _ready():
	call_deferred("_set__main_camera", self.__main_camera)
	self.pause_mode = PAUSE_MODE_PROCESS
	self.add_to_group("PPlanetListener")


func on_PPlanet_destroyed(planet : PPlanet):
	var camera_target : Position3D = Position3D.new()
	camera_target.translation = Vector3(0, 0, 6)
	planet.add_child(camera_target)
	var created_camera : InterpolatedCamera = InterpolatedCamera.new()
	created_camera.pause_mode = PAUSE_MODE_PROCESS
	created_camera.target = camera_target.get_path()
	get_node(self.level_node).add_child(created_camera)
	created_camera.global_transform = main_camera.global_transform
	created_camera.enabled = true
	created_camera.speed = 2
	created_camera.current = true


