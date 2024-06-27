extends Node2D

var client: Client
var speed: float = 0.5
var entrace

func _ready():
	client = get_parent()

func _physics_process(delta):
	for children in get_parent().get_parent().get_children():
		if children.name == "entrace":
			entrace = children
	
	if client.in_warning: 
		if not client.customer_is_dissatisfield:
			client.is_running = false
			return
	
	if client.get_pizza or client.customer_is_dissatisfield:
		var exit_position = GameManager.exit_position
		
		var difference = exit_position - client.position
		var distance_to_exit = difference.length()
		
		client.input_vector = difference.normalized()
		
		if distance_to_exit < 5:
			var count_client = 0
			if entrace != null:
				count_client = entrace.count_client
				
				if count_client != 0:
					entrace.count_client -= 1
			
			if count_client != entrace.count_client:
				client.queue_free()
	else:
		
		var box_position = GameManager.box_position
		var difference = box_position - client.position
		var distance_to_box = difference.length()
		
		client.input_vector = difference.normalized()
	
		if distance_to_box < 30: 
			client.is_running = false
			return
	
	client.velocity = client.input_vector * speed * 100.0
	client.is_running = true
	client.move_and_slide()
