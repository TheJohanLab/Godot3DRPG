extends CharacterBody3D

var currHp: int = 10
var maxHp: int = 10
var damage: int = 1

var gold: int = 0

var attackRate: float = 0.3
var lastAttackTime: int = 0

var moveSpeed: float = 5.0
var jumpForce: float = 10.0
var gravity: float = 15.0

var vel: Vector3 = Vector3()

@onready var camera = get_node("CameraOrbit")
@onready var attackRayCast = get_node("AttackRayCast")

#called every physics step (60 times a seconde)
func _physics_process(delta):
	
	vel.x = 0
	vel.z = 0
	
	var input = Vector3()
	
	if Input.is_action_pressed("move_forward"):
		input.z += 1
	if Input.is_action_pressed("move_backward"):
		input.z -= 1
	if Input.is_action_pressed("move_left"):
		input.x += 1
	if Input.is_action_pressed("move_right"):
		input.x -= 1
		
	# normalize the input vector to prevent increased diagonally
	input = input.normalized()
	# get the relative direction
	var dir = ( transform.basis.z * input.z + transform.basis.x * input.x)
	
	vel.x = dir.x * moveSpeed
	vel.z = dir.z * moveSpeed
	
	vel.y -= gravity * delta
	
	if Input.is_action_pressed("jump") and is_on_floor():
		vel.y = jumpForce
		
		
	#move along the current veolcity
	velocity = vel
	move_and_slide()


func give_gold(amount):
	gold += amount
