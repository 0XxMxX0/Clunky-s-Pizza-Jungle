class_name Player
extends CharacterBody2D

var input_vector: Vector2 = Vector2.ZERO
var speed: float = 1.5

@onready var animation: AnimationPlayer = $animation
@onready var texture: Sprite2D = $texture
@onready var player: Player = self
@onready var orderText: Label = $order

@onready var money: Label = %money

signal get_order
var order_pizza = null
signal get_pizza_done
var get_pizza: bool = false

var in_cooking: bool = false

func _ready():
	GameManager.player = self

func _process(delta):
	if money.text >= '0':
		money.text = str(GameManager.player_money)
	else:
		money.text = '0'

func _physics_process(delta):
	
	read_input()
	if is_on_floor():
		z_index = -1 
	else:
		z_index = 0
	
func process_animation():
	if input_vector != Vector2(0,0):
		if input_vector.x < 0:
			texture.flip_h = true
		elif input_vector.x > 0:
			texture.flip_h = false
		if get_pizza:
			animation.play("run_pizza")
		else:
			animation.play("run")
	else:
		if get_pizza:
			animation.play("idle_pizza")
		else:
			animation.play("idle")

func read_input():
	if in_cooking: return
	input_vector = Input.get_vector("move_left","move_right","move_down", "move_up", 0.15)
	
	var target_velocity = input_vector * speed * 100
	velocity = lerp(velocity, target_velocity, 0.09)
	move_and_slide()
	process_animation()
	

func _on_get_order(order):
	if order != null:
		order_pizza = order
		orderText.text = order.flavor

func _on_get_pizza_done():
	get_pizza = true
