extends CharacterBody3D

@export var speed = 5.0
const JUMP_VELOCITY = 4.5
@export var mouse_sensitivity = 0.5 # Adjust as needed


func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	

func _input(event):
	if event.is_action_pressed("ui_cancel"): # Assuming "ui_cancel" is mapped to Escape
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
# Rotate the player/camera around the Y-axis (horizontal look)
		rotation_degrees.y -= event.relative.x * mouse_sensitivity

		# Rotate the camera around the X-axis (vertical look)
		# Assuming a separate camera node as a child of the player or a pivot
		$Camera3D.rotation_degrees.x -= event.relative.y * mouse_sensitivity
		# Clamp vertical rotation to prevent flipping
		$Camera3D.rotation_degrees.x = clamp($Camera3D.rotation_degrees.x, -90, 90)




func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
	#	velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)

	move_and_slide()
