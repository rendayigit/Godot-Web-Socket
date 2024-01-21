extends RichTextLabel


func log_event(message):
	var time = "[color=#aaaaaa] %s [/color]" % Time.get_time_string_from_system()
	text += time + message + "\n"

	
func log_error(message):
	var time = "[color=#aaaaaa] %s [/color]" % Time.get_time_string_from_system()
	message = "[color=#f55868] %s [/color]" % message
	text += time + message + "\n"


func log_response(message):
	var time = "[color=#aaaaaa] %s [/color]" % Time.get_time_string_from_system()
	message = "[color=#58bef5] %s [/color]" % message
	text += time + message + "\n"
