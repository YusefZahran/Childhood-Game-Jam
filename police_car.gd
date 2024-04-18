extends CharacterBody2D

@onready var level = $"../" 
var speed = 200
var acceleration = 300 
signal killed
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var direction = Input.get_axis("left","right")
	velocity = Vector2(direction,0) * speed
	move_and_slide() 

func kill():
	level.speed=0
	level.game_pause = true
	print("game over")
	print("score: " + str(level.score))
	killed.emit()
	queue_free()
	
