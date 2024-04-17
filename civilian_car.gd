extends StaticBody2D
@onready var level = $"../"

#var speed = level.speed
var speed = 50
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	speed = level.speed
	position.y += speed * delta

func kill():
	#print("killed car")
	level.score +=10
	queue_free()


func _on_despawn_area_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	#print("entered area")
	area.get_parent().kill()
