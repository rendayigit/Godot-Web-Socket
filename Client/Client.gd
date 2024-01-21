extends Node


# The URL we will connect to.
var websocket_url = "ws://localhost:1234"
var socket := WebSocketPeer.new()


func _ready():
	$Log_Screen.log_event("Connecting to " + websocket_url)
	
	var fail_code = socket.connect_to_url(websocket_url)
	
	if fail_code != OK:
		$Log_Screen.log_error("Unable to connect.")
		set_process(false)


func _process(_delta):
	socket.poll()

	var socket_state = socket.get_ready_state()
	
	if socket_state == WebSocketPeer.STATE_OPEN:
		while socket.get_available_packet_count():
			$Log_Screen.log_response(socket.get_packet().get_string_from_ascii())
	elif socket_state == WebSocketPeer.STATE_CONNECTING:
		await get_tree().create_timer(0.5).timeout 
	else:
		$Log_Screen.log_error("Server disconnected")
		set_process(false)
		$Transmit_Button.disabled = true


func _exit_tree():
	socket.close()


func _on_transmit_button_pressed():
	socket.send_text("I am Client")
