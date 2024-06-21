extends Area2D

var pizza_flavor = {
	"1": [
		"calabresa",
		"25"
	],
	"2": [
		"mussarela",
		"15"
	]
}

var pizza_client
var player_in_order_area = false

func _ready():
	var random_number = randi_range(1,2)
	for pizza in pizza_flavor:
		if random_number == 1:
			pizza_client = pizza_flavor[pizza][0]
		else:
			pizza_client =  pizza_flavor[pizza][0]

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		var mouse_button_event = event as InputEventMouseButton
		var button_index = mouse_button_event.button_index
		
		if  mouse_button_event.pressed and button_index  == 1 and player_in_order_area:
			GameManager.player.emit_signal("get_order", pizza_client)
			queue_free()
			
func _on_body_entered(body):
	if body.is_in_group("Player"):
		player_in_order_area = true


func _on_body_exited(body):
	if body.is_in_group("Player"):
		player_in_order_area = false

