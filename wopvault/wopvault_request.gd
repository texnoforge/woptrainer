extends HTTPRequest

export var server_url = 'https://wopvault.texnoforge.dev/'
export var abc = 'texnolatin'


func get_url(path):
	return server_url + path


func vault_status():
	print("Vault status request test in progres...")
	var r = request(get_url('status/'))
	assert(r == OK)


func submit_drawing(curves, symbol, tag=null):
	var n = 0
	for c in curves:
		n += len(c)

	var tag_str = ''
	if tag:
		tag_str = '[%s]' % tag
	print("SUBMIT DRAWING: %s%s: %s points, %s curves" % [symbol, tag_str, n, len(curves)])
	var url = get_url('submit/drawing/%s/%s/' % [abc, symbol])
	if tag:
		url += '?tag=%s' % tag
	var body = to_json({'curves': curves})
	var r = request(url, [], false, HTTPClient.METHOD_POST, body)
	assert(r == OK)
