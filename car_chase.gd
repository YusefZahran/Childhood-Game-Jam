extends Node2D

@export var segments : Array[PackedScene] = []
@onready var pos : Array[Marker2D] = [$"Far Right" , $"Middle Right", $"Middle Left" , $"Far Left"]
@onready var Car = preload("res://civilian_car.tscn")
@onready var timer : Timer = $"Timer"

var amnt =20
@export var offset = 20
var rng = RandomNumberGenerator.new()
@export var camera : Camera2D
@onready var speed =255
# Called when the node enters the scene tree for the first time.
func _ready():
	for n in range(-7,amnt):
		spawnSegment(-(n*offset))
	spawnCars()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func spawnSegment(n):
	rng.randomize()
	var num = rng.randi_range(0,segments.size()-1)
	var instance = segments[num].instantiate()
	instance.position.y = n
	add_child(instance)
	
func spawnCars():
	var pos1 = pos.pick_random()
	var pos2 = pos.pick_random()
	while(pos2 == pos1):
		pos2 = pos.pick_random()
	var instance1 = Car.instantiate()
	instance1.position = pos1.position
	add_child(instance1)
	var instance2 = Car.instantiate()
	instance2.position = pos2.position
	add_child(instance2)
	


func _on_timer_timeout():
	spawnCars()
	if (speed < 600):
		speed += 10
		timer.wait_time -= 0.08
