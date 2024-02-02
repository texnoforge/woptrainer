extends HTTPRequest

export var server_url = 'https://wopvault.texnoforge.dev/'
export var abc = 'texnolatin'


func get_url(path):
	return server_url + path


func vault_status():
	print("Vault status request test in progres...")
	request(get_url('status/'))


func submit_drawing(curves, tag=null):
	var n = 0
	for c in curves:
		n += len(c)
	print("SUBMIT DRAWING: %s points, %s curves" % [n, len(curves)])
	var url = get_url('submit/drawing/%s/test/' % abc)
	if tag:
		url += '?tag=%s' % tag
	var body = to_json({'curves': curves})
	request(url, [], false, HTTPClient.METHOD_POST, body)

