extends CharacterBody3D

var player: Node3D

var speed = 3.0

var hit_points = 10
var is_dead = false

func _ready():
	$Label3D.text = str(hit_points)
	# To do: Assign a weapon 
	return

func _physics_process(delta: float) -> void:
	
	$barrel_large/AnimationPlayer.play("rotation")
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	var direction = Vector3(0, 0, -1)
	direction.y = 0 
	velocity = direction * speed
	move_and_slide()


func _on_area_3d_body_entered(body):
	if is_dead:
		return

	hit_points -= 1
	$Label3D.text = str(hit_points)

	if hit_points <= 0:
		is_dead = true
		$Label3D.text = "0"

		#await get_tree().create_timer(2.0).timeout #temporary, to delete after
		
		#speed = 0
		
		# To do:
		# Add animation explosion or similar
		var player = get_node("../Edwin")
		var powers = ["speed_boost", "mitra"]
		var random_power_index = randi() % powers.size()
		var chosen_power = powers[random_power_index]
		
		# apply power for 5 seconds
		player.apply_powerup(chosen_power, 5.0)
		
		queue_free()
