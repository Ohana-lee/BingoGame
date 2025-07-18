extends Area2D

@export var tile_color: Color
@export var bingo_item: int  # Unique identifier for the tile’s bingo item
@export var tile_type: String = "normal"  # Can be "shop", "normal", "danger", etc.

signal tile_touched(bingo_item)

var player_inside = false

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))
	connect("body_exited", Callable(self, "_on_body_exited"))

func _on_body_entered(body):
	if body.name == "player":
		print("player inside")
		player_inside = true
		if tile_type == "normal":
			emit_signal("tile_touched", bingo_item)

func _on_body_exited(body):
	if body.name == "player":
		print("player left")
		player_inside = false
		
func _process(delta):
	if player_inside and Input.is_action_just_pressed("interact"):
		print("interacting: ", Input.is_action_just_pressed("interact"))
		if tile_type == "shop":
			print("entering shop")
			enter_shop()
			
func enter_shop():
	get_tree().change_scene_to_file("res://scene/shop.tscn")
