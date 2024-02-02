extends Control

onready var request = $WoPVaultRequest
onready var draw_area = $DrawArea
onready var react_bar = $ReactBar


const GOOD_COLOR = Color("70ff4d")
const BAD_COLOR = Color("ff3333")


func _ready():
	react_bar.connect("good_pressed", self, '_on_good_pressed')
	react_bar.connect("bad_pressed", self, '_on_bad_pressed')
	draw_area.connect("drawing_modified", self, '_on_drawing_modified')
	request.connect("request_completed", self, '_on_request_completed')

	request.vault_status()


func _on_good_pressed():
	request.submit_drawing(draw_area.curves_json())
	draw_area.clear()


func _on_bad_pressed():
	request.submit_drawing(draw_area.curves_json(), 'bad')
	draw_area.clear()
	_on_drawing_modified()


func _on_drawing_modified():
	if draw_area.curves:
		react_bar.good_button.modulate.a = 1.0
		react_bar.bad_button.modulate.a = 1.0
	else:
		react_bar.good_button.modulate.a = 0.0
		react_bar.bad_button.modulate.a = 0.0
	react_bar.status.modulate.a = 0.0


func _on_request_completed(result, response_code, headers, body):
	var msg = "[%s] %s" % [response_code, body.get_string_from_utf8()]
	react_bar.status.text = msg
	var color = GOOD_COLOR
	if response_code >= 300:
		color = BAD_COLOR
	react_bar.status.add_color_override("font_color", color)
	react_bar.status.modulate.a = 1.0


func _on_request_start():
	react_bar.status.modulate.a = 0.0
	react_bar.good_button.modulate.a = 0.0
	react_bar.bad_button.modulate.a = 0.0
