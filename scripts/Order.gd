extends Area2D

var pizza_client
var player_in_order_area = false

@onready var player: Player = GameManager.player

func add_order(pizza):
	pizza_client = pizza

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		var mouse_button_event = event as InputEventMouseButton
		var button_index = mouse_button_event.button_index
		
		if  mouse_button_event.pressed and button_index  == 1 and player_in_order_area:
			player.emit_signal("get_order", pizza_client[0])
			queue_free()
			
func _on_body_entered(body):
	if body.is_in_group("Player"):
		player_in_order_area = true


func _on_body_exited(body):
	if body.is_in_group("Player"):
		player_in_order_area = false
