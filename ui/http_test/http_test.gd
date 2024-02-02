extends Label

onready var request = $HTTPRequest


func _ready():
	request.connect("request_completed", self, "_on_request_completed")
	test_http()


func test_http():
	text = "HTTP request test in progres..."
	request.request("https://run.mocky.io/v3/7edbee37-c762-4ceb-b965-1c554bd49f33")


func _on_request_completed(result, response_code, headers, body):
	if response_code != 200:
		text = "HTTP test request failed with code: %s" % response_code
		return

	text = "HTTP test reponse: %s" % body.get_string_from_utf8()
