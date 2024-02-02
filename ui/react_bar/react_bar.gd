extends MarginContainer

signal good_pressed
signal bad_pressed

onready var good_button = $VBox/HBox/GoodButton
onready var bad_button = $VBox/HBox/BadButton
onready var status = $VBox/StatusLabel
onready var spinner = $VBox/HBox/VaultStatus


func _ready():
	good_button.connect("pressed", self, '_on_good_pressed')
	bad_button.connect("pressed", self, '_on_bad_pressed')
	self.status.modulate.a = 0.0
	self.spinner.modulate.a = 0.0
	self.good_button.modulate.a = 0.0
	self.bad_button.modulate.a = 0.0


func _physics_process(delta):
	spinner.rect_rotation += delta * 300.0


func _on_good_pressed():
	emit_signal('good_pressed')


func _on_bad_pressed():
	emit_signal('bad_pressed')
