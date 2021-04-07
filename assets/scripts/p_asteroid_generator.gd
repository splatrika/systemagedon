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


var _planets : Array = []


enum _Direction {
	FromUp,
	FromDown,
	FromFront,
	FromBack,
	FromLeft,
	FromRight
}


func spawn_asteroid() -> void:
	var direction : int = _Direction.FromUp
	var created_path : PAsteroidPath = asteroid_path_prefab.instance()
	var point_position : Vector3
	var second_point_position : Vector3
	var sub_point_position : Vector3
	var size_half : Vector3 = self.size / 2
	if direction == _Direction.FromUp:
		var target_planet : int = randi() % len(self._planets)
		var points : Array = []
		point_position = self._planets[target_planet].global_transform.origin
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


func _on_SpawnTimer_timeout():
	spawn_asteroid()


func _get_average_point(first : Vector3, second : Vector3) -> Vector3:
	var created_point : Vector3
	created_point.x = (first.x + second.x) / 2
	created_point.y = (first.y + second.y) / 2
	created_point.z = (first.z + second.z) / 2
	return created_point


func on_PPlanet_created(planet : PPlanet):
	self._planets.append(planet)


func on_PPlanet_removed(planet : PPlanet):
	self._planets.remove(self._planets.find(planet))
