extends CharacterBody3D


var SPEED = 3.0

@export var arrow : PackedScene
@export var edwin : PackedScene

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
		if velocity.x > 0:
			$Skeleton_Rogue/AnimationPlayer.play("Running_Strafe_Left")
		else:
			$Skeleton_Rogue/AnimationPlayer.play("Running_Strafe_Right")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		$Skeleton_Rogue/AnimationPlayer.play("Idle_B")
	move_and_slide()
	
	
func _on_area_3d_body_entered(body):
	if body.is_in_group("Walls"):
		var edwin_instance = edwin.instantiate()
		get_parent().add_child(edwin_instance)
	if body.is_in_group("Enemy"):
		get_tree().change_scene_to_file("res://scenes/main.tscn")

func _on_arrow_timeout() -> void:
	var arrow_instance = arrow.instantiate()
	get_parent().add_child(arrow_instance)
	arrow_instance.transform = global_transform

func apply_powerup(powerup_type: String, duration: float = 5.0):
	if powerup_type == "speed_boost":
		SPEED += 2.0;
		await get_tree().create_timer(duration).timeout
		SPEED -= 2.0;
	
	if powerup_type == "mitra":
		$Arrow.wait_time = 0.12
		await get_tree().create_timer(duration).timeout
		$Arrow.wait_time = 1

var move_direction := 0.0  # -1 = sinistra, 1 = destra, 0 = fermo

func _on_sx_pressed() -> void:
	move_direction = -1.0

func _on_dx_pressed() -> void:
	move_direction = 1.0

func _process(delta):
	# Usa la variabile per muovere il personaggio
	if move_direction != 0:
		var direction = Vector3(move_direction, 0, 0)
		velocity.x = direction.x * SPEED
		if velocity.x > 0:
			$Skeleton_Rogue/AnimationPlayer.play("Running_Strafe_Left", -1, move_direction)
		else:
			$Skeleton_Rogue/AnimationPlayer.play("Running_Strafe_Right", -1, -move_direction)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func _on_button_left_released():
	move_direction = 0.0

func _on_button_right_released():
	move_direction = 0.0


func _on_h_scroll_bar_value_changed(value: float) -> void:
	move_direction = -value
