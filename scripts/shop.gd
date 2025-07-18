extends Node2D

func _ready():
	var dialogic = get_node("DialogicController")
	Dialogic.start("測試周目2")
	#Dialogic.signal_event.connect("dialogic_signal")
	Dialogic.signal_event.connect(_on_dialogic_signal)

func _on_dialogic_signal(signal_name):
	print(signal_name)
	if signal_name == "returnToHunting":
		print("returning...")
		get_tree().change_scene_to_file("res://scene/hunting area.tscn")
