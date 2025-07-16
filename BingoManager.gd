# BingoManager.gd
extends Node

# Customize grid dimensions
var grid_size = Vector2(3, 3)

var bingo_grid : Array = [
	["1", "2", "3"], 
	["4", "5", "6"],
	["7", "8", "9"]
]

# Tracks which items have been hit
var completed : Array = []

signal bingo_detected

func register_hit(item):
	print(item)
	
	if item in get_all_items() and !(item in completed):
		print(item)
		completed.append(item)
		print("Hit registered: %s" % item)
		check_for_bingo()

func get_all_items():
	var flattened = []
	for row in bingo_grid:
		flattened += row
	return flattened

func check_for_bingo():
	print("-------------------------------------------")
	# Check rows (horizontal bingo)
	for row in bingo_grid:
		var bingo = true
		for item in row:
			if not (item in completed):
				bingo = false
				break
		if bingo:
			print("🎉 Horizontal bingo on row:", row)
			emit_signal("bingo_detected")
			break

	# Check columns (vertical bingo)
	for x in range(grid_size.x):
		var column = []
		for y in range(grid_size.y):
			column.append(bingo_grid[y][x])
		
		var bingo = true
		for item in column:
			if not (item in completed):
				bingo = false
				break
		if bingo:
			print("🎉 Vertical bingo on column:", column)
			emit_signal("bingo_detected")
			break

	# Check diagonals
	var main_diag = []
	var anti_diag = []
	for i in range(grid_size.x):
		main_diag.append(bingo_grid[i][i])
		anti_diag.append(bingo_grid[i][grid_size.x - 1 - i])

	var bingo_main = true
	for item in main_diag:
		if not (item in completed):
			bingo_main = false
			break
	if bingo_main:
		print("🎉 Main diagonal bingo:", main_diag)
		emit_signal("bingo_detected")
		#break

	var bingo_anti = true
	for item in anti_diag:
		if not (item in completed):
			bingo_anti = false
			break
	if bingo_anti:
		print("🎉 Anti-diagonal bingo:", anti_diag)
		emit_signal("bingo_detected")
		#break

	print("🧐Completed items:", completed)
	return
