extends CharacterBody2D


const SPEED = 600.0
const JUMP_VELOCITY = -500.0
const DASH_SPEED = 2200.0
var dash = false
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("Saut") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	if Input.is_action_just_pressed("Dash"):
		dash = true
		$Timer.start()
	
	# Get the input direction and handle the movement/deceleration.
	var direction = Input.get_axis("Gauche" , "Droite")
	if direction:
		if dash:
			velocity.x = direction * DASH_SPEED
		else:
			velocity.x = direction * SPEED
	else:
		if dash:
			velocity.x = move_toward(velocity.x, 0, DASH_SPEED)
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func _on_timer_timeout():
	dash = false
