tool
extends Spatial


func _physics_process(delta):
	$AsteroidPathItem.look_at($Spatial.translation, Vector3(0, 1, 0))
