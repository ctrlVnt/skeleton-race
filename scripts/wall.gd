extends CharacterBody3D

var speed = 3.0
var hit_points = 0

func _ready():
	$Label3D.text = str(hit_points)
	return

func _physics_process(delta: float) -> void:
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	var direction = Vector3(0, 0, -1)
	direction.y = 0 
	velocity = direction * speed
	move_and_slide()


func _on_area_3d_body_entered(body):

	hit_points += 1
	$Label3D.text = str(hit_points)
