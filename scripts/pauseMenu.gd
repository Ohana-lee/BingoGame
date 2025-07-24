extends Control

func _process(delta:float) -> void:
	if Input.is_action_just_pressed("esc"):
		print("pause menu")
		pause_or_unpause()
		
func pause_or_unpause():
	if get_tree().paused == true:
		$".".hide()
		get_tree().paused = false
	elif get_tree().paused == false:
		$".".show()
		get_tree().paused = true

func backToMainMenu():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scene/Main menu.tscn")
