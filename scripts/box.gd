extends StaticBody2D

var add_order: bool = false
var order_placed: bool = false

@onready var path_follow_2d: PathFollow2D = %PathFollow2D
@onready var client = null

var pizza_flavor = {
	"calabresa": 25,
	"mussarela": 15
}

func _ready():
	GameManager.box_position = position
	

func _process(delta):
	if client == null: return
	
	if client.order_client == null and add_order:
		order_placed = false
	
	if add_order and not order_placed:
		order_placed = true
		
		var order_scene = load("res://scenes/order.tscn")
		var order = order_scene.instantiate()
		var random_number = randi_range(0,2)
		var key_order = randi()
		
		if random_number == 1:
			order.add_order("mussarela", pizza_flavor["mussarela"], key_order)
		else:
			order.add_order("calabresa", pizza_flavor["calabresa"], key_order)
		
		add_order = false
		
		if client.get_pizza and client.order_client == null:
			client.get_pizza = false
			 
		client.order_client = key_order
		client.in_wait = 0
		order.global_position = $Marker2D.global_position
		get_parent().add_child(order)
		
func _on_area_body_entered(body):
	if body.is_in_group("Client"):
		if not body.get_pizza:
			client = body
			add_order = true
	
	if body.is_in_group("Player"):
		if client != null:
			client.player_in_order_area = true

func _on_area_body_exited(body):
	if  body.is_in_group("Player"):
		if client != null:
			client.player_in_order_area = false
