extends Marker2D

var client_cooldown = 0
var client_per_minute = 0
var count_client = 0

func _process(delta):
	client_cooldown += delta
	if client_cooldown >= 5:
		if client_per_minute < 5:
			client_per_minute += 1
			var client_scene = preload("res://scenes/client.tscn")
			var client = client_scene.instantiate()
			
			client.global_position = global_position
			get_parent().add_child(client)
			client_cooldown = 0
