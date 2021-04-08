class_name POrbitDrawer
extends Node2D


export var pixel_size_in_3D : float = 0.01 setget _set_pixel_size_in_3D
func _set_pixel_size_in_3D(value : float):
	pixel_size_in_3D = value
	update()


export var smoothness : float = 50 setget _set_smoothness
func _set_smoothness(value : float):
	smoothness = value
	update()

export var line_width : float = 5 setget _set_line_width
func _set_line_width(value : float):
	line_width = value
	update()


export var color : Color = Color.white setget _set_color
func _set_color(value : Color):
	color = value
	update()


export var accent_color : Color = Color.yellow setget _set_accent_color
func _set_accent_color(value : Color):
	accent_color = value
	update()


export var accent_orbit_index : int = -1 setget _set_accent_orbit_index
func _set_accent_orbit_index(value : int):
	accent_orbit_index = value
	update()


var _PPlanetOrbit_orbits_to_draw : Array


func _on_PPlanetOrbit_updated(orbit : PPlanetOrbit):
	if self._PPlanetOrbit_orbits_to_draw.find(orbit) == -1:
		self._PPlanetOrbit_orbits_to_draw.append(orbit)
	self.update()


func _on_PPlanetOrbit_removed(orbit : PPlanetOrbit):
	if self._PPlanetOrbit_orbits_to_draw.find(orbit) != -1:
		self._PPlanetOrbit_orbits_to_draw.append(orbit)
	self.update()


func _draw():
	var i : int = 0
	for orbit in self._PPlanetOrbit_orbits_to_draw:
		var center : Vector2 = Vector2(0, 0)
		var radius : float = 1 / self.pixel_size_in_3D * orbit.orbit_radius
		var line_color = self.accent_color if (i == self.accent_orbit_index) else self.color
		draw_arc(center, radius, 0, PI*2, self.smoothness, line_color, line_width)
		i += 1
