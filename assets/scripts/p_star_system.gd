class_name PStarSystem
extends Spatial


var PPlanetOrbit_orbits : Array


export(Array, NodePath) var __PPlanetOrbit_orbits : Array setget _set__PPlanetOrbit_orbits
func _set__PPlanetOrbit_orbits(value : Array) -> void:
	__PPlanetOrbit_orbits = value
	self.PPlanetOrbit_orbits.clear()
	for orbit in value:
		var node : Node = get_node(orbit)
		if node is PPlanetOrbit:
			self.__PPlanetOrbit_orbits.append(node)


func _ready() -> void:
	self.__PPlanetOrbit_orbits = __PPlanetOrbit_orbits
