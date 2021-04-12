class_name FirstPlayHintController
extends Node


enum State {
	SelectOrbitHint,
	MovePlanetsHint,
	FreeGame
}


var asteroid_generator : PAsteroidGenerator setget set_asteroid_generator
func set_asteroid_generator(value : PAsteroidGenerator):
	asteroid_generator = value


export var __asteroid_generator : NodePath setget _set__asteroid_generator
func _set__asteroid_generator(value : NodePath) -> void:
	__asteroid_generator = value
	var node : Node = get_node_or_null(value)
	if node is PAsteroidGenerator:
		self.asteroid_generator = node


var player_score_controller : PPlayerScoreTimeController

export var __player_score_controller : NodePath setget _set__player_score_controller
func _set__player_score_controller(value : NodePath) -> void:
	__player_score_controller = value
	var node : Node = get_node_or_null(value)
	if node is PPlayerScoreTimeController:
		self.player_score_controller = node


var key_hint : PKeyHints

export var __key_hint : NodePath setget _set__key_hint
func _set__key_hint(value : NodePath) -> void:
	__key_hint = value
	var node : Node = get_node_or_null(value)
	if node is PKeyHints:
		self.key_hint = node


var current_state : int = State.SelectOrbitHint setget set_current_state
func set_current_state(value : int):
	current_state = value
	self._update_state()


export var warning_hud_prefab : PackedScene


var first_ok : bool = false
var second_ok : bool = false


func _ready():
	add_to_group("MoveOrbitsUILitener")
	call_deferred("_set__asteroid_generator", self.__asteroid_generator)
	call_deferred("_set__player_score_controller", self.__player_score_controller)
	call_deferred("_set__key_hint", self.__key_hint)
	call_deferred("_update_state")


func _update_state():
	if not is_instance_valid(self.asteroid_generator) || not is_instance_valid(self.key_hint):
		return
	
	if first_ok and second_ok:
		if self.current_state == State.SelectOrbitHint:
			current_state = State.MovePlanetsHint
			self.first_ok = false
			self.second_ok = false
		elif self.current_state == State.MovePlanetsHint:
			self._push_warning_hud()
			current_state = State.FreeGame
	
	if self.current_state == State.SelectOrbitHint || self.current_state == State.MovePlanetsHint:
		self.asteroid_generator.set_pause(true)
		self.player_score_controller.set_pause(true)
		self.key_hint.show()
	else:
		self.asteroid_generator.set_pause(false)
		self.player_score_controller.set_pause(false)
		self.key_hint.hide()
	
	if self.current_state == State.SelectOrbitHint:
		self.key_hint.play_orbit_select()
	if self.current_state == State.MovePlanetsHint:
		self.key_hint.play_move_planets()


func _push_warning_hud():
	var hud : Node = self.warning_hud_prefab.instance()
	get_tree().get_root().add_child(hud)

func _on_MoveOrbitsUILitener_up_pressed():
	if self.current_state == State.SelectOrbitHint:
		self.first_ok = true
	self._update_state()

func _on_MoveOrbitsUILitener_down_pressed():
	if self.current_state == State.SelectOrbitHint:
		self.second_ok = true
	self._update_state()

func _on_MoveOrbitsUILitener_left_pressing():
	if self.current_state == State.MovePlanetsHint:
		self.first_ok = true
	self._update_state()

func _on_MoveOrbitsUILitener_right_pressing():
	if self.current_state == State.MovePlanetsHint:
		self.second_ok = true
	self._update_state()
