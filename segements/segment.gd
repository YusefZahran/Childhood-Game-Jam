extends Node2D
@onready var level = $"../"
@export var speed = 50
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#	print(position)4
	speed = level.speed
	position.y += speed * delta
	if global_position.y > 250:
#		print("reached bottom")
		level.spawnSegment(position.y-(level.amnt*level.offset))
		queue_free()
