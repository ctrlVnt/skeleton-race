extends CharacterBody3D


const SPEED = 10.0


func _physics_process(delta: float) -> void:
	global_transform.origin.y = 0.5
	velocity.z = SPEED
	move_and_slide()
