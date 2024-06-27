extends Marker2D

func _ready():
	GameManager.exit_position = position

func update_count_client(value):
	var spawner_client: Marker2D = %entrace
	spawner_client.count_client -= value
