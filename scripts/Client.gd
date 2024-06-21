class_name Client
extends Area2D

var player_in_order_area: bool = false
@onready var player: Player = GameManager.player
@onready var animation: AnimationPlayer = $animation

var order_client = null

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		var mouse_button_event = event as InputEventMouseButton
		var button_index = mouse_button_event.button_index
		
		if  mouse_button_event.pressed and button_index  == 1 and player_in_order_area:
			if player.get_pizza:
				player.get_pizza = false
				animation.play("idle_pizza")
				print(player.order_pizza)

func _on_body_entered(body):
	if body.is_in_group("Player"):
		player_in_order_area = true


func _on_body_exited(body):
	if body.is_in_group("Player"):
		player_in_order_area = false
