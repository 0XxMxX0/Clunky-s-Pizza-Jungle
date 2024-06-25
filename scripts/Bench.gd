extends StaticBody2D

var pizza_in_prepare: bool = false
var prepare_cooldown: float = 0
var pizza_is_done: bool = false
var order_pizza = null

@onready var player: Player = GameManager.player

func _process(delta):
	
	if pizza_in_prepare:
		prepare_cooldown += delta
		if prepare_cooldown > 5:
			pizza_in_prepare = false
			prepare_cooldown = 0 
			pizza_is_done = true
			$order.text = "pizza pronta"

func _on_area_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		var mouse_button_event = event as InputEventMouseButton
		var button_index = mouse_button_event.button_index
		
		if  mouse_button_event.pressed and button_index == 1 and player.order_pizza != null and not pizza_in_prepare and not pizza_is_done:
			$order.text = "preparando"
			pizza_in_prepare = true
			order_pizza = player.order_pizza
			player.order_pizza = null
			player.orderText.text = ""
		elif mouse_button_event.pressed and button_index == 1 and not pizza_in_prepare and pizza_is_done:
			$order.text = ""
			pizza_is_done = false
			player.emit_signal("get_pizza_done")
			player.order_pizza = order_pizza
