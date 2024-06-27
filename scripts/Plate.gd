extends Area2D

@onready var store: Store = get_parent()
@onready var texture: Sprite2D = $texture

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		var mouse_button_event = event as InputEventMouseButton
		var button_index = mouse_button_event.button_index
		
		if mouse_button_event.pressed and button_index == 1:
			if store.store_is_open:
				store.store_is_open = false
				texture.set_texture(load("res://assents/tiles/plate_closed.png"))
			elif not store.store_is_open:
				store.store_is_open = true
				texture.set_texture(load("res://assents/tiles/plate_open.png"))
