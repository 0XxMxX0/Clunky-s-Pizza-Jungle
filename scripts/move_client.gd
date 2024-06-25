extends Node2D

var client: Client
var speed: float = 0.5

func _ready():
	client = get_parent()

func _physics_process(delta):
	
	#print(client.in_warning)
	
	if client.in_warning: 
		client.is_running = false
		return
	
	if client.get_pizza:
		var exit_position = GameManager.exit_position
		
		var difference = exit_position - client.position
		var distance_to_exit = difference.length()
		
		client.input_vector = difference.normalized()
		
		
		if distance_to_exit < 5:
			
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
