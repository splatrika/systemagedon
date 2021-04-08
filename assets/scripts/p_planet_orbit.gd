class_name PPlanetOrbit
extends Spatial


export var orbit_radius : float setget _set_orbit_radius
func _set_orbit_radius(value : float) -> void:
	orbit_radius = value
	self._update_planet_orbit_transform()


export var planet_rotation_degress : float setget _set_planet_rotation_degress
func _set_planet_rotation_degress(value : float) -> void:
	planet_rotation_degress = value
	self._update_planet_orbit_transform()


export var planet_rotation_factor : float = 1 setget _set_planet_rotation_factor
func _set_planet_rotation_factor(value : float) -> void:
	planet_rotation_factor = value
	self._update_planet_orbit_transform()


var planet : PPlanet setget _set_planet
func _set_planet(value : PPlanet) -> void:
	planet = value
	self._update_planet_orbit_transform()


export var self_rotate_velocity : float = 5


export var __planet : NodePath setget _set__planet
func _set__planet(value : NodePath) -> void:
	__planet = value
	var node : Node = get_node(value)
	if (node is PPlanet):
		self.planet = node
	else:
		push_error("Invalid PPlanet node. Node must be PPlanet")


func get_planet_rotation_as_radians() -> float:
	return self.rotation.y


func get_planet_position_by_rotation(radians : float) -> Vector3:
	var created_position : Vector3 = Vector3.ZERO
	created_position.y = 0
	radians += 0.6
	created_position.x = cos(-radians) * self.orbit_radius
	created_position.z = sin(-radians) * self.orbit_radius
	return created_position


func _ready() -> void:
	call_deferred("_set__planet", __planet)


func _update_planet_orbit_transform() -> void:
	if not is_instance_valid(self.planet):
		return
	planet.translation = Vector3(orbit_radius, 0, 0)
	self.rotation_degrees = Vector3(0, planet_rotation_degress * planet_rotation_factor, 0)
	get_tree().call_deferred("call_group", "PPlanetOrbitListener", "_on_PPlanetOrbit_updated", self)


func _physics_process(delta : float):
	self.planet_rotation_degress += self.self_rotate_velocity * delta


func _enter_tree():
	get_tree().call_deferred("call_group", "PPlanetOrbitListener", "_on_PPlanetOrbit_updated", self)


func _exit_tree():
	get_tree().call_deferred("call_group", "PPlanetOrbitListener", "_on_PPlanetOrbit_removed", self)
