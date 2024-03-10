extends Control


func _on_Button_pressed():
	self.visible = false


func _on_Content_meta_clicked(meta):
	if OS.has_feature('JavaScript'):
		JavaScript.eval("""window.open('%s', '_blank').focus();""" % meta)
	else:
		OS.shell_open(meta)
