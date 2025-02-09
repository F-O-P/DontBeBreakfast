extends CharacterBody2D

@onready var jump = $jump
@onready var walking = $walking
@onready var flipPoint = $flipPoint

const SPEED = 150.0
const JUMP_VELOCITY = -300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# gravity!!!
	if not is_on_floor():
		velocity.y += gravity * delta

	# jump handling
	if Input.is_action_pressed("ui_accept") and is_on_floor():
		$jump.play()
		velocity.y = JUMP_VELOCITY
		
	# gets players input direction and handles the movement
	# DO LATER --> replace UI actions with custom gameplay actions
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction > 0:
		flipPoint.scale.x = 1
	elif direction < 0:
		flipPoint.scale.x = -1

	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	move_and_slide()
