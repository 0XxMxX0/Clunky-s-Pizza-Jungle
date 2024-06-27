class_name Client
extends CharacterBody2D

var player_in_order_area: bool = false
var input_vector: Vector2 = Vector2.ZERO
var order_client = null
var get_pizza:bool = false
var in_warning: bool = false
var is_running: bool = false
var in_wait: float = 0.0
var customer_is_dissatisfield: bool = false

@onready var player: Player = GameManager.player
@onready var animation: AnimationPlayer = $animation
@onready var texture_emotions = $emotion/texture_emotions

func _process(delta):
	in_wait += delta
	
	if not get_pizza:
		if order_client:
			if in_wait >= 30 and in_wait <= 40:
				texture_emotions.set_texture(load("res://assents/clients/emotions/boredom.png"))
			elif in_wait >= 60:
				if in_wait >= 80:
					customer_is_dissatisfield = true
				texture_emotions.set_texture(load("res://assents/clients/emotions/dissatisfield.png"))
			else:
				texture_emotions.set_texture(load(""))
		else:
			if in_wait >= 20 and in_wait <= 30:
				texture_emotions.set_texture(load("res://assents/clients/emotions/boredom.png"))
			elif in_wait >= 50:
				if in_wait >= 70:
					customer_is_dissatisfield = true
				texture_emotions.set_texture(load("res://assents/clients/emotions/dissatisfield.png"))
			else:
				texture_emotions.set_texture(load(""))
	else:
		texture_emotions.set_texture(load("res://assents/clients/emotions/happy.png"))
		
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

func make_payment(payment):
	if get_pizza:
		GameManager.player_money += payment

func _on_client_area_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		var mouse_button_event = event as InputEventMouseButton
		var button_index = mouse_button_event.button_index
		
		if mouse_button_event.pressed and button_index == 1 and player_in_order_area:
			if player.get_pizza:
				if player.order_pizza['client'] == order_client:
					if not get_pizza:
						player.get_pizza = false
						get_pizza = true
						in_warning = false
						make_payment(player.order_pizza['price'])
						player.order_pizza = null

func _on_client_area_area_entered(area):
	if area.get_parent().is_in_group("Client"):
		in_warning = true

func _on_client_area_area_exited(area):
	if area.get_parent().is_in_group("Client"):
		in_warning = false
