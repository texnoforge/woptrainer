extends MarginContainer

signal good_pressed
signal bad_pressed

onready var buttons = $VBox/HButtons
onready var good_button = $VBox/HButtons/GoodButton
onready var bad_button = $VBox/HButtons/BadButton
onready var status = $VBox/StatusLabel


func _ready():
	good_button.connect("pressed", self, '_on_good_pressed')
	bad_button.connect("pressed", self, '_on_bad_pressed')
	buttons.modulate.a = 0.0
	status.modulate.a = 0.0


func _on_good_pressed():
	emit_signal('good_pressed')


func _on_bad_pressed():
	emit_signal('bad_pressed')
