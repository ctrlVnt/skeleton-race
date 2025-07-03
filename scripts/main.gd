extends Node

@export var killer : PackedScene
@export var boss1 : PackedScene
@export var barrel : PackedScene
@export var wall : PackedScene

@onready var counter_label := $CanvasLayer/Label

var enemies_killed: int = 0

var spawn_pos: int = 65

func _on_killer_spawn_timeout() -> void:
	var killer_instance = killer.instantiate()
	killer_instance.position = Vector3(randf_range(4.3, -4.3), 0, spawn_pos)
	var player = get_node("Edwin")
	killer_instance.player = player
	add_child(killer_instance)


func _on_boss_1_spawn_timeout() -> void:
	var boss1_instance = boss1.instantiate()
	boss1_instance.position = Vector3(randf_range(4.3, -4.3), 0, spawn_pos)
	var player = get_node("Edwin")
	boss1_instance.player = player
	add_child(boss1_instance)


func _on_barrel_spawn_timeout() -> void:
	var num_barrels = randi() % 2 + 1  # Randomly decide to spawn 1 or 2 barrels

	if num_barrels == 1:
		var barrel_instance = barrel.instantiate()
		barrel_instance.position = Vector3(randf_range(4.3, -4.3), 0, spawn_pos)
		barrel_instance.rotation_degrees = Vector3(0, 180, 0)
		add_child(barrel_instance)
	else:
		var left_barrel_instance = barrel.instantiate()
		left_barrel_instance.position = Vector3(-4.3, 0, spawn_pos)
		left_barrel_instance.rotation_degrees = Vector3(0, 180, 0)
		add_child(left_barrel_instance)

		var right_barrel_instance = barrel.instantiate()
		right_barrel_instance.position = Vector3(4.3, 0, spawn_pos)
		right_barrel_instance.rotation_degrees = Vector3(0, 180, 0)
		add_child(right_barrel_instance)


func _on_wall_spawn_timeout() -> void:
	var num_walls = randi() % 2 + 1  # Randomly decide to spawn 1 or 2 barrels

	if num_walls == 1:
		var wall_instance = wall.instantiate()
		wall_instance.position = Vector3(randf_range(4.3, -4.3), 0, spawn_pos)
		wall_instance.rotation_degrees = Vector3(0, 180, 0)
		add_child(wall_instance)
	else:
		var left_wall_instance = wall.instantiate()
		left_wall_instance.position = Vector3(-4.3, 0, spawn_pos)
		left_wall_instance.rotation_degrees = Vector3(0, 180, 0)
		add_child(left_wall_instance)

		var right_wall_instance = wall.instantiate()
		right_wall_instance.position = Vector3(4.3, 0, spawn_pos)
		right_wall_instance.rotation_degrees = Vector3(0, 180, 0)
		add_child(right_wall_instance)
		
func enemy_died():
	enemies_killed += 1
	counter_label.text = "Enemies killed: %d" % enemies_killed
	update_spawn_timers()
	
func update_spawn_timers():
	var new_killer_time = 1.5 - enemies_killed * 0.01
	var new_boss_time = 10.0 - enemies_killed * 0.1

	$Killer_spawn.wait_time = new_killer_time


func _on_mute_pressed() :
	var bus_idx = AudioServer.get_bus_index("Master")
	AudioServer.set_bus_mute(bus_idx, true)
