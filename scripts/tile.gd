extends Area2D

@export var tile_color: Color
@export var bingo_item: int  # Unique identifier for the tile’s bingo item

signal tile_touched(bingo_item)

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body):
	if body.name == "player":  # double check your player node's actual name!
		emit_signal("tile_touched", bingo_item)
