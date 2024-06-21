extends Path2D

@onready var path_follow_2d: PathFollow2D = %PathFollow2D
var add_order: bool = false
var order_placed: bool = false

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

func _process(delta):
	
	if add_order and not order_placed:
		order_placed = true
		
		var order_scene = preload("res://scenes/order.tscn")
		var order = order_scene.instantiate()
		
		var random_number = randi_range(1,2)
		for pizza in pizza_flavor:
			if random_number == 1:
				order.add_order(pizza_flavor[pizza])
			else:
				order.add_order(pizza_flavor[pizza])
		
		
		order.global_position = get_point()
		get_parent().add_child(order)
	
func get_point():
	path_follow_2d.progress_ratio = randf()
	return path_follow_2d.global_position

func _on_area_2d_area_entered(area):
	if area.is_in_group("Client"):
		add_order = true
