# HuntingArea.gd
extends Node2D

func _ready():
	connect_tile_signals()

func connect_tile_signals():
	for tile in get_tree().get_nodes_in_group("tiles"):
		tile.connect("tile_touched", Callable(self, "_on_tile_touched"))

func _on_tile_touched(bingo_item):
	print("Touched tile: %s" % bingo_item)
	var bingo = $player/Camera2D/BingoManager
	var bingoItem = str(bingo_item).strip_edges(true) #convert int to string
	bingo.register_hit(bingoItem)

func _on_exit_area_entered(body):
	if body.name == "Player":
		get_tree().change_scene_to_file("res://shop.tscn")  # Adjust path as needed
		
func _input(event):
	if event is InputEventKey and event.pressed and event.keycode == Key.KEY_Q:
		print("Q pressed")
		var panel = $player/Camera2D/BingoManager/BingoPanelControl
		var BG = $player/Camera2D/BingoManager/BingoPanelBG
		panel.visible = !panel.visible
		BG.visible = !BG.visible
		if panel.visible:
			update_bingo_panel()
			
func update_bingo_panel():
	var grid = $player/Camera2D/BingoManager/BingoPanelControl/GridContainer
	var all_items = $player/Camera2D/BingoManager.get_all_items()
	var completed = $player/Camera2D/BingoManager.completed

	for i in range(grid.get_child_count()):
		var cell = grid.get_child(i)
		if cell is Control and i < all_items.size():
			var label = cell.get_node("Label")
			var strike = cell.get_node("ColorRect")

			label.text = all_items[i]
			strike.visible = all_items[i] in completed
