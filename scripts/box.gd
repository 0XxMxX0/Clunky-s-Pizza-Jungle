extends StaticBody2D

var add_order: bool = false
var order_placed: bool = false

@onready var path_follow_2d: PathFollow2D = %PathFollow2D
@onready var client = null

var pizza_flavor = {
	"pizza": 25,
}

func _ready():
	GameManager.box_position = position

func _process(delta):
	if client == null: return
	
	if client.order_client == null and add_order:
		order_placed = false
	
	if add_order and not order_placed:
		order_placed = true
		add_order = false
		
		var order_scene = load("res://scenes/order.tscn")
		var order = order_scene.instantiate()
		
		client.order_client = pizza_flavor["pizza"]
		
		if client.get_pizza and client.order_client == null:
			client.get_pizza = false
		
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
