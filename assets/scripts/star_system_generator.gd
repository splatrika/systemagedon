class_name StarSystemGenerator
extends Node


export var empty_star_system_prefab : PackedScene

export(Array, PackedScene) var star_prefabs : Array
export(Array, PackedScene) var planet_prefabs : Array

export var min_planets_count : int = 2
export var max_planets_count : int = 4


func generate_star_system() -> PStarSystem:
	randomize()
	var created_star_system : PStarSystem = self.empty_star_system_prefab.instance() as PStarSystem
	var planets_count : int = randi() % (self.max_planets_count - self.min_planets_count) + self.max_planets_count
	var star_prefab_index : int = randi() % len(self.star_prefabs)
	
	return null
