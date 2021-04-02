class_name PAsteroid
extends Area


func _on_Asteroid_area_entered(area : Area) -> void:
	if area is PPlanet:
		var planet : PPlanet = area as PPlanet
		planet.destroy()
		print("DESTROY")
