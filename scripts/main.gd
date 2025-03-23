extends Node

@export var killer : PackedScene

var enemies_killed: int = 0

func _on_killer_spawn_timeout() -> void:
	var killer_instance = killer.instantiate()
	killer_instance.position = Vector3(randf_range(4.3, -4.3), 0, 30)
	var player = get_node("Edwin")
	killer_instance.player = player
	add_child(killer_instance)
