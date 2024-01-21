extends Node


func _on_server_button_pressed():
	get_tree().change_scene_to_file("res://Server/Server.tscn")


func _on_client_button_pressed():
	get_tree().change_scene_to_file("res://Client/Client.tscn")
