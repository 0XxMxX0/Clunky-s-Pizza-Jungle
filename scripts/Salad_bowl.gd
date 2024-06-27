extends StaticBody2D

@onready var player: Player = GameManager.player

var pizza_in_prepare: bool = false
var prepare_cooldown: float = 0
var pizza_is_done: bool = false
var order_pizza = null

func _process(delta):
	
	if pizza_in_prepare:
		prepare_cooldown += delta
		if prepare_cooldown > 5:
			pizza_in_prepare = false
			player.in_cooking = false
			prepare_cooldown = 0 
			$order.text = "pizza pronta"
			$animation.play("default")
			$order.text = ""
			player.emit_signal("get_pizza_done")
			player.order_pizza = order_pizza
			
func _on_area_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		var mouse_button_event = event as InputEventMouseButton
		var button_index = mouse_button_event.button_index
		
		if  mouse_button_event.pressed and button_index == 1 and player.order_pizza != null and not player.get_pizza and not pizza_in_prepare and not pizza_is_done:
			$order.text = "preparando"
			pizza_in_prepare = true
			player.in_cooking = true
			order_pizza = player.order_pizza
			player.order_pizza = null
			player.orderText.text = ""
			$animation.play("is_on")
