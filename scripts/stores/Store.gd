class_name Store
extends Node2D

var store_is_open = true
var ranking = 1 #vai até o 5
var ranking_cooldown = 0

func process_clients_for_ranking() -> int:
	var spawner_client: Marker2D = %entrace
	var client_per_minute = 0
	
	if ranking == 1:
		client_per_minute = randi_range(1, 3)
		ranking_cooldown = 5
		
	return client_per_minute
