class_name AnimatedMessageLabel
extends Label

signal animation_ended()

export var message_to_show : String = ""
export var show_char_delay : float = 0.05

var _current_char_index_to_show : int = 0

var _show_wait : float = 0


func show_text():
	set_physics_process(true)
	self.text = ""
	_current_char_index_to_show = 0
	_show_wait = 0


func _ready():
	set_physics_process(false)


func _physics_process(delta : float):
	if self.text == message_to_show || _current_char_index_to_show >= len(self.message_to_show):
		set_physics_process(false)
		emit_signal("animation_ended")
		return
	_show_wait += delta
	while _show_wait > self.show_char_delay:
		if self.text == message_to_show || _current_char_index_to_show >= len(self.message_to_show):
			return
		self.text += message_to_show[_current_char_index_to_show]
		_current_char_index_to_show += 1
		_show_wait -= self.show_char_delay
