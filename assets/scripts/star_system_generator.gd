class_name StarSystemGenerator
extends Node


export var empty_star_system_prefab : PackedScene
export var planet_orbit_prefab : PackedScene

export(Array, PackedScene) var star_prefabs : Array
export(Array, PackedScene) var planet_prefabs : Array

export var min_planets_count : int = 2
export var max_planets_count : int = 4

export var min_orbit_radius_step : float = 2
export var max_orbit_radius_step : float = 4

export var min_planet_velocity : float = 10
export var max_planet_velocity : float = 40

export var first_orbit_radius_step : float = 17

func generate_star_system() -> PStarSystem:
	randomize()
	var created_star_system : PStarSystem = self.empty_star_system_prefab.instance() as PStarSystem
	var planets_count : int = randi() % (self.max_planets_count - self.min_planets_count) + self.min_planets_count
	var star_prefab_index : int = randi() % len(self.star_prefabs)

	var created_star : Spatial = self.star_prefabs[star_prefab_index].instance()
	created_star_system.add_child(created_star)
	
	var orbit_radius : float = self.first_orbit_radius_step
	for _i in planets_count:
		var created_orbit : PPlanetOrbit = self.planet_orbit_prefab.instance() as PPlanetOrbit
		created_orbit.orbit_radius = orbit_radius
		created_orbit.self_rotate_velocity = randf() * (self.max_planet_velocity - self.min_planet_velocity) + self.min_planet_velocity
		created_orbit.self_rotate_velocity *= 1 if (randi() % 2 == 0) else -1
		var planet_prefab_index : int = randi() % len(self.planet_prefabs)
		var created_planet : PPlanet = self.planet_prefabs[planet_prefab_index].instance() as PPlanet
		add_child(created_orbit) #костылий TODO избавиться
		created_orbit.planet = created_planet
		created_orbit.add_child(created_planet)
		remove_child(created_orbit)
		created_star_system.add_child(created_orbit)
		created_star_system.PPlanetOrbit_orbits.append(created_orbit)
		orbit_radius += randf() * (self.max_orbit_radius_step - self.min_orbit_radius_step) + self.min_orbit_radius_step
	return created_star_system
