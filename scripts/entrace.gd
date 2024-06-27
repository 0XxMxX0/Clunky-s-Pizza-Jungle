extends Marker2D

var client_cooldown = 0
var client_per_minute = 0

var count_client = 0
var ranking_cooldown = 0

@onready var store: Store = get_parent()

func _process(delta):
	client_cooldown += delta
	
	if store != null:
		if not store.store_is_open: return
		
		if client_per_minute == 0:
			if count_client == 0:
				if store.ranking_cooldown != 0:
					ranking_cooldown += delta
					if ranking_cooldown >= store.ranking_cooldown:
						client_per_minute = store.process_clients_for_ranking()
						ranking_cooldown = 0
				else:
					client_per_minute = store.process_clients_for_ranking()
		
		if client_cooldown >= 5:
			if client_per_minute > 0:
				count_client += 1
				client_per_minute -= 1
				var client_scene = preload("res://scenes/client.tscn")
				var client = client_scene.instantiate()
				
				client.global_position = global_position
				get_parent().add_child(client)
				client_cooldown = 0
