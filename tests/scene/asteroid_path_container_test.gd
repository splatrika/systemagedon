extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	call_deferred("start")

func start():
	$AsteroidPathContainer.push_asteroid_path($Path)
