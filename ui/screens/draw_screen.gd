extends Control

const AbcInfo = preload("res://alphabets/texnolatin/abc_info.gd")

onready var request = $WoPVaultRequest
onready var draw_area = $DrawArea
onready var react_bar = $ReactBar
onready var symbol_tex = $MarginMid/SymbolTex
onready var abc_info = AbcInfo.new()
onready var n_sent_label = $HBoxStats/LabelNSent

var n_sent = 0

const GOOD_COLOR = Color("70ff4d")
const BAD_COLOR = Color("ff3333")

const GOOD_MSGS = [
	'Thanks! One step closer to Magic...',
	'Thank you, Mage!',
	'Thank you for your contribution <3',
	'One more drawing for the Vault, thanks!',
	'Got it, thanks!',
	'Awesome, thanks!',
	'Nice, thank you!',
]
const BAD_MSGS = [
	'Bad drawings might still be useful.',
	'Bad drawing is still a drawing.',
	'Try again?',
]

var symbol


func _ready():
	react_bar.connect("good_pressed", self, '_on_good_pressed')
	react_bar.connect("bad_pressed", self, '_on_bad_pressed')
	draw_area.connect("drawing_modified", self, '_on_drawing_modified')
	request.connect("request_completed", self, '_on_request_completed')
	
	randomize()
	next_symbol()
	request.vault_status()


func _on_good_pressed():
	request.submit_drawing(draw_area.curves_json(), symbol)
	draw_area.clear()
	next_symbol()


func _on_bad_pressed():
	request.submit_drawing(draw_area.curves_json(), symbol, 'bad')
	draw_area.clear()
	_on_drawing_modified()


func _on_drawing_modified():
	if draw_area.curves:
		react_bar.buttons.modulate.a = 1.0
	else:
		react_bar.buttons.modulate.a = 0.0
	react_bar.status.modulate.a = 0.0


func _on_request_completed(_result, response_code, _headers, body):
	var color = GOOD_COLOR
	var msg
	var txt = body.get_string_from_utf8()
	if response_code >= 300:
		color = BAD_COLOR
		msg = "[%s] %s" % [response_code, txt]
	else:
		var json = JSON.parse(txt).result
		var status = json.get('status')
		var symbol_j = json.get('symbol')
		var tag = json.get('tag')
		if symbol_j:
			n_sent += 1
			n_sent_label.text = str(n_sent)
			if status == 'ok':
				msg = GOOD_MSGS[randi() % len(GOOD_MSGS)]
				if tag == 'bad':
					msg = '%s %s' % [msg, BAD_MSGS[randi() % len(BAD_MSGS)]]
			else:
				color = BAD_COLOR
				msg = "Error submitting drawing to Vault: %s" % txt
		elif status in ['ok', 'ready']:
			msg = "Words of Power Vault ready and receiving!"
		else:
			color = BAD_COLOR
			msg = "Words of Power Vault error: %s" % txt

	react_bar.status.text = msg
	react_bar.status.add_color_override("font_color", color)
	react_bar.status.modulate.a = 1.0

func _on_request_start():
	react_bar.status.modulate.a = 0.0
	react_bar.good_button.modulate.a = 0.0
	react_bar.bad_button.modulate.a = 0.0


func next_symbol():
	react_bar.buttons.modulate.a = 0.0
	symbol = abc_info.SYMBOLS[randi() % len(abc_info.SYMBOLS)]
	symbol_tex.set_symbol(symbol)
