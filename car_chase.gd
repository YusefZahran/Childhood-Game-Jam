extends Node2D

@export var segments : Array[PackedScene] = []
var amnt =10
@export var offest = 50
var rng = RandomNumberGenerator.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	for n in amnt:
		spawnSegment(n*offest)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func spawnSegment(n):
	rng.randomize()
	var num = rng.randi_range(0,segments.size()-1)
	var instance = segments[num].instantiate()
	instance.position.y = n
	add_child(instance)
