extends CharacterBody3D


const SPEED = 3.0
const JUMP_VELOCITY = 4.5

@export var arrow : PackedScene

func _physics_process(delta: float) -> void:
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("ui_right", "ui_left", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, 0)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.y = 0
		if direction.x > 0:
			$Skeleton_Rogue/AnimationPlayer.play("Running_Strafe_Left")
		else:
			$Skeleton_Rogue/AnimationPlayer.play("Running_Strafe_Right")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		$Skeleton_Rogue/AnimationPlayer.play("Idle_B")
	move_and_slide()
	
	
func _on_area_3d_body_entered(body):
	get_tree().reload_current_scene()

func _on_timer_timeout() -> void:
	var arrow_instance = arrow.instantiate()
	get_parent().add_child(arrow_instance)
	arrow_instance.transform = global_transform
