class_name MoveOrbitsUI
extends Node


var star_system : PStarSystem

export var __star_system : NodePath setget _set__star_system
func _set__star_system(value : NodePath):
	__star_system = value
	var node : Node = get_node_or_null(value)
	if node is PStarSystem:
		self.star_system = node as PStarSystem


var orbit_viewer : POrbitsViewer

export var __orbit_drawer : NodePath setget _set__orbit_drawer
func _set__orbit_drawer(value : NodePath):
	__orbit_drawer = value
	var node : Node = get_node_or_null(value)
	if node is POrbitsViewer:
		self.orbit_viewer = node as POrbitsViewer


export var move_speed : float


var selected_orbit_index : int = 0 setget set_selected_orbit_index
func set_selected_orbit_index(value : int):
	if value < 0:
		selected_orbit_index = 0
	elif is_instance_valid(self.star_system) and value >= len(self.star_system.PPlanetOrbit_orbits):
		selected_orbit_index = len(self.star_system.PPlanetOrbit_orbits) - 1
	else:
		selected_orbit_index = value
	if is_instance_valid(self.orbit_viewer):
		self.orbit_viewer.accent_orbit_index = self.selected_orbit_index


func _ready() -> void:
	call_deferred("_set__star_system", self.__star_system)
	call_deferred("_set__orbit_drawer", self.__orbit_drawer)
	call_deferred("set_selected_orbit_index", 0)


func _input(event : InputEvent) -> void:
	if event.is_action_pressed("ui_up"):
		self.selected_orbit_index += 1
	elif event.is_action_pressed("ui_down"):
		self.selected_orbit_index -= 1


func _physics_process(delta : float) -> void:
	if Input.is_action_pressed("ui_left"):
		star_system.PPlanetOrbit_orbits[self.selected_orbit_index].planet_rotation_degress -= self.move_speed * delta
	elif Input.is_action_pressed("ui_right"):
		star_system.PPlanetOrbit_orbits[self.selected_orbit_index].planet_rotation_degress += self.move_speed * delta
