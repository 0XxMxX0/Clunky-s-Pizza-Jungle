extends Area2D

var pizza_client = {
	"flavor": "",
	"price": "",
	"client": ""
}
var player_in_order_area = false

@onready var player: Player = GameManager.player

func add_order(flavor, price, client):
	pizza_client.flavor = flavor
	pizza_client.price = price
	pizza_client.client = client

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		var mouse_button_event = event as InputEventMouseButton
		var button_index = mouse_button_event.button_index
		
		if player.get_pizza and player.order_pizza != null: return
		if mouse_button_event.pressed and button_index  == 1 and player_in_order_area:
			player.emit_signal("get_order", pizza_client)
			if player.order_pizza != null:
				queue_free()
			
func _on_body_entered(body):
	if body.is_in_group("Player"):
		player_in_order_area = true

func _on_body_exited(body):
	if body.is_in_group("Player"):
		player_in_order_area = false
