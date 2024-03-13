extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if Input.is_action_pressed("right"):
		position.x +=10
	if Input.is_action_pressed("left"):
		position.x -=10 
	if Input.is_action_pressed("up"):
		position.y -=10 
	if Input.is_action_pressed("down"):
		position.y +=10

	move_and_slide()





func _on_area_2d_body_entered(body):
	print("hi")
