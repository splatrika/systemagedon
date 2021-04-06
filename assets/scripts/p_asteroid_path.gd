class_name PAsteroidPath
extends Path


export var speed : float = 10
export(PackedScene) var asteroid_prefab : PackedScene
export var run_on_start : bool = false


func push_asteroid():
	var asteroid : Node = asteroid_prefab.instance()
	$PathFollow.add_child(asteroid)
	set_physics_process(true)


func _ready():
	set_physics_process(false)
	if run_on_start:
		self.push_asteroid()


func _physics_process(delta : float):
	$PathFollow.offset += self.speed * delta
	if $PathFollow.unit_offset == 1:
		queue_free()


func _enter_tree():
	get_tree().call_group("PAsteroidPathListener", "on_AsteroidPath_created", self.get_instance_id(), self)


func _exit_tree():
	get_tree().call_group("PAsteroidPathListener", "on_AsteroidPath_removed", self.get_instance_id())
