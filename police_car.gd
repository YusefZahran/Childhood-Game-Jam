extends CharacterBody2D

var speed = 200
var acceleration = 300 
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var direction = Input.get_axis("up","down")
	velocity = Vector2(0,direction) * speed
	move_and_slide()
