tool
class_name PAsteroidGenerator
extends Spatial


export(Array, PackedScene) var asteroids_prefabs
export(PackedScene) var asteroid_path_prefab
export var level_node : NodePath


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


enum _Direction {
	FromUp,
	FromDown,
	FromFront,
	FromBack,
	FromLeft,
	FromRight
}


func spawn_asteroid() -> void:
	var direction : int = randi() % 6
	var created_path : PAsteroidPath = asteroid_path_prefab.instance()
	var point_position : Vector3
	var size_half : Vector3 = self.size / 2
	if direction == _Direction.FromUp:
		point_position.x = randi() % int(size.x) - size_half.x
		point_position.y = size_half.y
		point_position.z = randi() % int(size.z) - size_half.z
		created_path.curve.add_point(point_position)
		point_position.x = randi() % int(size.x) - size_half.x
		point_position.y = 0
		point_position.z = randi() % int(size.z) - size_half.z
		created_path.curve.add_point(point_position)
		point_position.x = randi() % int(size.x) - size_half.x
		point_position.y = size_half.y * -1
		point_position.z = randi() % int(size.z) - size_half.z
		created_path.curve.add_point(point_position)
	elif direction == _Direction.FromDown:
		point_position.x = randi() % int(size.x) - size_half.x
		point_position.y = size_half.y * -1
		point_position.z = randi() % int(size.z) - size_half.z
		created_path.curve.add_point(point_position)
		point_position.x = randi() % int(size.x) - size_half.x
		point_position.y = 0
		point_position.z = randi() % int(size.z) - size_half.z
		created_path.curve.add_point(point_position)
		point_position.x = randi() % int(size.x) - size_half.x
		point_position.y = size_half.y
		point_position.z = randi() % int(size.z) - size_half.z
		created_path.curve.add_point(point_position)
	elif direction == _Direction.FromLeft:
		point_position.x = size_half.x * -1
		point_position.y = randi() % int(size.y) - size_half.y
		point_position.z = randi() % int(size.z) - size_half.z
		created_path.curve.add_point(point_position)
		point_position.x = 0
		point_position.y = randi() % int(size.y) - size_half.y
		point_position.z = randi() % int(size.z) - size_half.z
		created_path.curve.add_point(point_position)
		point_position.x = size_half.x
		point_position.y = randi() % int(size.y) - size_half.y
		point_position.z = randi() % int(size.z) - size_half.z
		created_path.curve.add_point(point_position)
	elif direction == _Direction.FromRight:
		point_position.x = size_half.x
		point_position.y = randi() % int(size.y) - size_half.y
		point_position.z = randi() % int(size.z) - size_half.z
		created_path.curve.add_point(point_position)
		point_position.x = 0
		point_position.y = randi() % int(size.y) - size_half.y
		point_position.z = randi() % int(size.z) - size_half.z
		created_path.curve.add_point(point_position)
		point_position.x = size_half.x * -1
		point_position.y = randi() % int(size.y) - size_half.y
		point_position.z = randi() % int(size.z) - size_half.z
		created_path.curve.add_point(point_position)
	elif direction == _Direction.FromBack:
		point_position.x = randi() % int(size.x) - size_half.x
		point_position.y = randi() % int(size.y) - size_half.y
		point_position.z = size_half.z * -1
		created_path.curve.add_point(point_position)
		point_position.x = randi() % int(size.x) - size_half.x
		point_position.y = randi() % int(size.y) - size_half.y
		point_position.z = 0
		created_path.curve.add_point(point_position)
		point_position.x = randi() % int(size.x) - size_half.x
		point_position.y = randi() % int(size.y) - size_half.y
		point_position.z = size_half.z
		created_path.curve.add_point(point_position)
	elif direction == _Direction.FromBack:
		point_position.x = randi() % int(size.x) - size_half.x
		point_position.y = randi() % int(size.y) - size_half.y
		point_position.z = size_half.z * -1
		created_path.curve.add_point(point_position)
		point_position.x = randi() % int(size.x) - size_half.x
		point_position.y = randi() % int(size.y) - size_half.y
		point_position.z = 0
		created_path.curve.add_point(point_position)
		point_position.x = randi() % int(size.x) - size_half.x
		point_position.y = randi() % int(size.y) - size_half.y
		point_position.z = size_half.z
		created_path.curve.add_point(point_position)
	created_path.asteroid_prefab = self.asteroids_prefabs[randi() % len(self.asteroids_prefabs)]
	get_node(self.level_node).add_child(created_path)
	created_path.push_asteroid()


func _ready() -> void:
	if not Engine.editor_hint:
		$Up.queue_free()
		$Down.queue_free()
	else:
		call_deferred("_set_size", size)


func _on_SpawnTimer_timeout():
	spawn_asteroid()


func _generate_path(direction : int, from_start : bool) -> PAsteroidPath:
	var created_path : PAsteroidPath = asteroid_path_prefab.instance()
	var start_mask = -1 if from_start else 1
	var end_mask = 1 if from_start else -1

	return created_path
