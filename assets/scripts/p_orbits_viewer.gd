class_name POrbitsViewer
extends Spatial


export var size : Vector2 = Vector2(100, 100) setget _set_size
func _set_size(value : Vector2):
	size = value
	$DrawerViewport.size = value


export var pixel_size_in_3D : float = 0.01 setget _set_pixel_size_in_3D
func _set_pixel_size_in_3D(value : float):
	pixel_size_in_3D = value
	$Sprite3D.pixel_size = value
	$DrawerViewport/OrbitsDrawer.pixel_size_in_3D = value


export var orbit_line_width : float = 50 setget _set_orbit_line_width
func _set_orbit_line_width(value : float):
	orbit_line_width = value
	$DrawerViewport/OrbitsDrawer.line_width = value

export var line_color : Color = Color.white setget _set_line_color
func _set_line_color(value : Color):
	line_color = value
	$DrawerViewport/OrbitsDrawer.color = value

export var accent_color : Color = Color.yellow setget _set_accent_color
func _set_accent_color(value : Color):
	accent_color = value
	$DrawerViewport/OrbitsDrawer.accent_color = value

export var accent_orbit_index : int = -1 setget _set_accent_orbit_index
func _set_accent_orbit_index(value : int):
	accent_orbit_index = value
	$DrawerViewport/OrbitsDrawer.accent_orbit_index = value
