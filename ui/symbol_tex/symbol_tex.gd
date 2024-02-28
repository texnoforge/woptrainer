extends TextureRect

const SYMBOL_TEXTURES = {
	'fire': preload("res://alphabets/texnolatin/png/fire.png"),
	'ice': preload("res://alphabets/texnolatin/png/ice.png"),
	'water': preload("res://alphabets/texnolatin/png/water.png"),
	'air': preload("res://alphabets/texnolatin/png/air.png"),
	'electro': preload("res://alphabets/texnolatin/png/electro.png"),
	'earth': preload("res://alphabets/texnolatin/png/earth.png"),
	'life': preload("res://alphabets/texnolatin/png/life.png"),
	'death': preload("res://alphabets/texnolatin/png/death.png"),
	'bolt': preload("res://alphabets/texnolatin/png/bolt.png"),
	'ball': preload("res://alphabets/texnolatin/png/ball.png"),
	'space': preload("res://alphabets/texnolatin/png/space.png"),
	'cone': preload("res://alphabets/texnolatin/png/cone.png"),
	'beam': preload("res://alphabets/texnolatin/png/beam.png"),
	'self': preload("res://alphabets/texnolatin/png/self.png"),
	'friend': preload("res://alphabets/texnolatin/png/friend.png"),
	'enemy': preload("res://alphabets/texnolatin/png/enemy.png"),
	'close': preload("res://alphabets/texnolatin/png/close.png"),
	'far': preload("res://alphabets/texnolatin/png/far.png"),
	'strong': preload("res://alphabets/texnolatin/png/strong.png"),
	'weak': preload("res://alphabets/texnolatin/png/weak.png"),
	'big': preload("res://alphabets/texnolatin/png/big.png"),
	'small': preload("res://alphabets/texnolatin/png/small.png"),
	'fast': preload("res://alphabets/texnolatin/png/fast.png"),
	'slow': preload("res://alphabets/texnolatin/png/slow.png"),
}

export var t_fade = 0.4
export var visible_alpha = 0.4

var animating = false
var symbol


func _ready():
	modulate.a = 0.0


func set_symbol(new_symbol):
	animating = true
	symbol = new_symbol
	var tw = get_tree().create_tween()
	if modulate.a > 0:
		tw.tween_property(self, "modulate:a", 0, t_fade)
	tw.tween_callback(self, "update_texture")
	tw.tween_property(self, "modulate:a", visible_alpha, t_fade)


func update_texture():
	texture = SYMBOL_TEXTURES.get(symbol)
