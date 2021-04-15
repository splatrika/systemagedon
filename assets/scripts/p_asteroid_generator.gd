# This file is part of Systemagedon project
# 2021 © Daniil Belov. All rights reserved

tool
class_name PAsteroidGenerator
extends Spatial


export(Array, PackedScene) var asteroids_prefabs


export(PackedScene) var asteroid_path_prefab


export var level_node : NodePath


export var asteroids_speed : float = 10


export var pathes_smooth : int = 6


export var spawn_delay : float = 0.5 setget _set_spawn_delay
func _set_spawn_delay(value : float):
	var timer : Timer = get_node_or_null("SpawnTimer") as Timer
	if is_instance_valid(timer):
		timer.wait_time = value
	spawn_delay = value


export var size : Vector3 setget _set_size
func _set_size(value : Vector3) -> void:
	size = value
	if Engine.editor_hint:
		var size_half : Vector3 = size / 2
		if not is_instance_valid(get_node_or_null("Up")):
			return
		$Up/FrontLeft.translation = Vector3(size_half.x * -1, size_half.y, size_half.z)
		$Up/FrontRight.translation = Vector3(size_half.x, size_half.y, size_half.z)
		$Up/BackLeft.translation = Vector3(size_half.x * -1, size_half.y, size_half.z * -1)
		$Up/BackRight.translation = Vector3(size_half.x, size_half.y, size_half.z * -1)
		$Down/FrontLeft.translation = Vector3(size_half.x * -1, size_half.y * -1, size_half.z)
		$Down/FrontRight.translation = Vector3(size_half.x, size_half.y * -1, size_half.z)
		$Down/BackLeft.translation = Vector3(size_half.x * -1, size_half.y * -1, size_half.z * -1)
		$Down/BackRight.translation = Vector3(size_half.x, size_half.y * -1, size_half.z * -1)


var _planet_orbits : Array = []


func spawn_asteroid() -> void:
	var created_path : PAsteroidPath = asteroid_path_prefab.instance()
	var point_position : Vector3
	var size_half : Vector3 = self.size / 2
	
	var target_planet_orbit : int = randi() % len(self._planet_orbits)
	var points : Array = []
	var target_orbit : PPlanetOrbit = self._planet_orbits[target_planet_orbit]
	point_position = target_orbit.get_planet_position_by_rotation(target_orbit.get_planet_rotation_as_radians())
	points.append(point_position)

	var up_path_offset : float = 0
	var step_x = randi() % int((size_half.x / self.pathes_smooth * 2)) - (size_half.x / self.pathes_smooth)
	var step_z = randi() % int((size_half.z / self.pathes_smooth * 2)) - (size_half.z / self.pathes_smooth)
	var up_point : Vector3 = point_position
	var offset_step = size_half.y / pathes_smooth
	for i in range(self.pathes_smooth):
		up_path_offset += offset_step
		up_point.y = up_path_offset
		up_point.x += step_x * (i + 1)
		up_point.z += step_z * (i + 1)
		points.insert(0, up_point)
	
	up_path_offset = 0
	up_point = point_position
	for i in range(self.pathes_smooth):
		up_path_offset -= offset_step
		up_point.y = up_path_offset
		up_point.x += step_x * (i + 1)
		up_point.z += step_z * (i + 1)
		points.append(up_point)
	
	for point in points:
		created_path.curve.add_point(point)
	
	var curve_length = created_path.curve.get_baked_length()
	var time_to_planet : float = curve_length / 2 / self.asteroids_speed
	var orbit_rotation_after_time_to_planet : float = target_orbit.planet_rotation_degress + target_orbit.self_rotate_velocity * time_to_planet
	var planet_position_after_time_to_planet : Vector3 = target_orbit.get_planet_position_by_rotation(deg2rad(orbit_rotation_after_time_to_planet))
	var current_planet_position : Vector3 = target_orbit.get_planet_position_by_rotation(target_orbit.get_planet_rotation_as_radians())
	var offset = planet_position_after_time_to_planet - current_planet_position

	for i in range(created_path.curve.get_point_count()):
		created_path.curve.set_point_position(i, created_path.curve.get_point_position(i) + offset)

	created_path.asteroid_prefab = self.asteroids_prefabs[randi() % len(self.asteroids_prefabs)]
	created_path.speed = asteroids_speed
	get_node(self.level_node).add_child(created_path)
	created_path.push_asteroid()


func _ready() -> void:
	randomize()
	if not Engine.editor_hint:
		$Up.queue_free()
		$Down.queue_free()
	else:
		call_deferred("_set_size", size)
	$SpawnTimer.wait_time = self.spawn_delay
	add_to_group("PPlanetListener")
	add_to_group("PPlanetOrbitListener")


func _on_SpawnTimer_timeout():
	spawn_asteroid()


func _get_average_point(first : Vector3, second : Vector3) -> Vector3:
	var created_point : Vector3
	created_point.x = (first.x + second.x) / 2
	created_point.y = (first.y + second.y) / 2
	created_point.z = (first.z + second.z) / 2
	return created_point


func _on_PPlanetOrbit_updated(planet_orbit : PPlanetOrbit):
	self._planet_orbits.append(planet_orbit)


func _on_PPlanetOrbit_removed(planet_orbit : PPlanetOrbit):
	self._planet_orbits.remove(self._planet_orbits.find(planet_orbit))


func set_pause(value : bool):
	if (value):
		$SpawnTimer.stop()
	else:
		$SpawnTimer.start()
