extends CharacterBody3D

var player: Node3D

var speed = 2.0
var is_dead = false
var shots_remaining = 10

func _process(delta):
	if is_dead or player == null:
		return 
	look_at(player.global_transform.origin, Vector3.UP)
		
func _physics_process(delta: float) -> void:
	if is_dead:
		return 
		
	$Skeleton_Warrior/AnimationPlayer.play("Walking_C")
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	var direction = (player.global_transform.origin - global_transform.origin).normalized()
	direction.y = 0 
	velocity = direction * speed
	move_and_slide()


func _on_area_3d_body_entered(body):
	if is_dead:
		return
		
	shots_remaining -= 1
	$Label3D.text = str(shots_remaining * 10)
	if shots_remaining > 0:
		return
		
	is_dead = true 
	speed = 0 
	velocity = Vector3.ZERO 
	set_physics_process(false)
	get_parent().enemy_died() 

	$Skeleton_Warrior/AnimationPlayer.stop()
	$Skeleton_Warrior/AnimationPlayer.play("Death_A")

	await $Skeleton_Warrior/AnimationPlayer.animation_finished
	
	$Area3D/CollisionShape3D.disabled = true
	await get_tree().create_timer(3.0).timeout
	queue_free()
