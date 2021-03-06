extends Control

onready var button_next_phase := $TurnPhase/VBoxContainer/NextPhase
onready var label_turn_phase := $TurnPhase/VBoxContainer/TurnPhase
onready var log_panel := $Log
onready var log_scroll := $Log/ScrollContainer
onready var log_container := $Log/ScrollContainer/VBoxContainer

func _ready():
	game.connect("set_turn_phase", self, "_on_Game_set_turn_phase")
	_on_Game_set_turn_phase()

	game.connect("set_state", self, "_on_Game_set_state")
	_on_Game_set_state()

	animations_controller.connect("add_animation_to_screen", self, "_on_add_animation_to_screen")

	console.connect("log_message", self, "_on_Game_log_message")
	log_scroll.get_v_scrollbar().connect("changed", self, "_on_LogScroll_changed")

func _on_Game_set_turn_phase():
	label_turn_phase.text = TurnPhase.name(game.turn_phase)

func _on_Game_set_state():
	button_next_phase.disabled = not game.state().can_go_to_next_phase()

func _on_NextPhase_pressed():
	game.go_to_next_phase()

var force_scroll_log_to_end := false

func _on_Game_log_message(message: String):
	var new_label := Label.new()
	new_label.autowrap = true
	new_label.text = message
	
	force_scroll_log_to_end = true
	log_container.add_child(new_label)
	force_scroll_log_to_end = false

var lock_scroll_changed := false

func _on_LogScroll_changed():
	if force_scroll_log_to_end and not lock_scroll_changed:
		lock_scroll_changed = true
		log_scroll.scroll_vertical = 999999
		lock_scroll_changed = false

func _on_add_animation_to_screen(animated_sprite: AnimatedSprite):
	add_child(animated_sprite)

func _on_ShowLog_toggled(button_pressed: bool):
	log_panel.visible = button_pressed
