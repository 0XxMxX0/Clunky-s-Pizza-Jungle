class_name Client
extends CharacterBody2D

var player_in_order_area: bool = false
var input_vector: Vector2 = Vector2.ZERO

@onready var player: Player = GameManager.player
@onready var animation: AnimationPlayer = $animation

var order_client = null
var get_pizza:bool = false
var in_warning: bool = false
var is_running: bool = false

func _physics_process(delta):
	process_animation()
	

func process_animation():
	
	if is_running:
		if not get_pizza:
			animation.play("run")
		elif get_pizza:
			animation.play("run_pizza")
	else:
		if not get_pizza:
			animation.play("idle")
		elif get_pizza:
			animation.play("idle_pizza")
	
	print(input_vector)

func make_payment(payment):
	if get_pizza:
		GameManager.player_money += payment

func _on_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		player_in_order_area = true

func _on_area_2d_body_exited(body):
	if body.is_in_group("Player"):
		player_in_order_area = false

func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		var mouse_button_event = event as InputEventMouseButton
		var button_index = mouse_button_event.button_index
		
		if  mouse_button_event.pressed and button_index == 1 and player_in_order_area:
			if player.get_pizza:
				if player.order_pizza['client'] == order_client:
					if not get_pizza:
						player.get_pizza = false
						get_pizza = true
						in_warning = false
						make_payment(player.order_pizza['price'])


func _on_area_2d_area_entered(area):
	if area.get_parent().is_in_group("Client"):
		if order_client == null or get_pizza == false:
			in_warning = true
		else:
			in_warning = false

func _on_client_area_area_exited(area):
	if area.get_parent().is_in_group("Client"):
		in_warning = false
