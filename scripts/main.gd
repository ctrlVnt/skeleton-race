extends Node

@export var killer : PackedScene
@export var boss1 : PackedScene
@export var barrel : PackedScene

var enemies_killed: int = 0

func _on_killer_spawn_timeout() -> void:
	var killer_instance = killer.instantiate()
	killer_instance.position = Vector3(randf_range(4.3, -4.3), 0, 30)
	var player = get_node("Edwin")
	killer_instance.player = player
	add_child(killer_instance)


func _on_boss_1_spawn_timeout() -> void:
	var boss1_instance = boss1.instantiate()
	boss1_instance.position = Vector3(randf_range(4.3, -4.3), 0, 30)
	var player = get_node("Edwin")
	boss1_instance.player = player
	add_child(boss1_instance)


func _on_barrel_spawn_timeout() -> void:
	var num_barrels = randi() % 2 + 1  # Randomly decide to spawn 1 or 2 barrels

	if num_barrels == 1:
		var barrel_instance = barrel.instantiate()
		barrel_instance.position = Vector3(randf_range(4.3, -4.3), 0, 30)
		barrel_instance.rotation_degrees = Vector3(0, 180, 0)
		add_child(barrel_instance)
	else:
		var left_barrel_instance = barrel.instantiate()
		left_barrel_instance.position = Vector3(-4.3, 0, 30)
		left_barrel_instance.rotation_degrees = Vector3(0, 180, 0)
		add_child(left_barrel_instance)

		var right_barrel_instance = barrel.instantiate()
		right_barrel_instance.position = Vector3(4.3, 0, 30)
		right_barrel_instance.rotation_degrees = Vector3(0, 180, 0)
		add_child(right_barrel_instance)
