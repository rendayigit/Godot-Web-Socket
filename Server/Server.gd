extends Node


# The port we will listen to.
const PORT = 1234
var tcp_server := TCPServer.new()
var socket := WebSocketPeer.new()


func _ready():
	if tcp_server.listen(PORT) != OK:
		$Log_Screen.log_error("Unable to start server.")
		set_process(false)
	else:
		$Log_Screen.log_event("Serving @ " + str(tcp_server.get_local_port()))


func _process(_delta):
	while tcp_server.is_connection_available():
		var conn: StreamPeerTCP = tcp_server.take_connection()
		assert(conn != null)
		socket.accept_stream(conn)
		$Log_Screen.log_event("Client connected")

	socket.poll()
	
	var socket_state = socket.get_ready_state()

	if socket_state == WebSocketPeer.STATE_OPEN:
		$Transmit_Button.disabled = false
		while socket.get_available_packet_count():
			$Log_Screen.log_response(socket.get_packet().get_string_from_ascii())
	elif socket_state == WebSocketPeer.STATE_CLOSED:
		$Transmit_Button.disabled = true


func _exit_tree():
	socket.close()
	tcp_server.stop()


func _on_transmit_button_pressed():
	socket.send_text("I am Server")
