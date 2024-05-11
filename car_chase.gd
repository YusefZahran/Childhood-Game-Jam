extends Node2D

@export var segments : Array[PackedScene] = []
@onready var pos : Array[Marker2D] = [$"Far Right" , $"Middle Right", $"Middle Left" , $"Far Left"]
@onready var Car = preload("res://civilian_car.tscn")
@onready var civ_car = $"Civilian Car"
@onready var timer : Timer = $"Timer"
@onready var hud = $UILayer/HUD
@onready var GOS = $UILayer/GameOverScreen
@onready var player = $"Police Car"

@onready var score = 0:
	set(value):
		score = value
		#print(score)
		hud.score = score
var high_score 
var timer_pause = false
var amnt =20
@export var offset = 20
var rng = RandomNumberGenerator.new()
@export var camera : Camera2D
@onready var speed =255
@onready var game_pause : bool = false
# Called when the node enters the scene tree for the first time.
func _ready():
	var save_file = FileAccess.open("user://save.data", FileAccess.READ)
	if save_file != null:
		high_score = save_file.get_32()
	else:
		high_score = 0
		save_game()
	
	#Car.killed.connect(on_civ_car_killed)
	score = 0
	for n in range(-7,amnt):
		spawnSegment(-(n*offset))
	spawnCars()
	player.killed.connect(on_player_killed)

func save_game():
	var save_file = FileAccess.open("user://save.data", FileAccess.WRITE)
	save_file.store_32(high_score)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#	while(!pause):
#		speed=0
	#print(high_score)
	#print(score)
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
	instance1.killed.connect(on_civ_car_killed)
	add_child(instance1)
	var instance2 = Car.instantiate()
	instance2.killed.connect(on_civ_car_killed)
	instance2.position = pos2.position
	add_child(instance2)
	

func on_civ_car_killed():
	#print("i'm here")
	score += 10
	if score > high_score:
		#print("true")
		high_score = score

func _on_timer_timeout():
	if (!game_pause):
		if (!timer_pause):
			timer_pause = true 
		spawnCars()
		if (speed < 600):
			speed += 10
			timer.wait_time -= 0.02

func on_player_killed():
	GOS.set_score(score)
	GOS.set_high_score(high_score)
	save_game( )
	await get_tree().create_timer(0.5).timeout
	GOS.visible = true
