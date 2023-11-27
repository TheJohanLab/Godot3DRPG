extends CharacterBody3D

var currHp : int = 3
var maxHp : int = 3

var damage: int = 1
var attackDist : float = 1.5
var attackRate: float = 1.0

var moveSpeed: float = 2.5

var vel : Vector3 = Vector3()

@onready var timer = get_node("Timer")
@onready var player = get_node("/root/MainScene/Player")

func _ready():
	#set the timer wait time
	timer.wait_time = attackRate
	timer.start()


func _physics_process(delta):
	#distance to player
	var dist = position.distance_to(player.position)
	
	#chase after the player, if we're outside of the attack
	if dist > attackDist:
		#direction between us and the player
		var dir = (player.position - position).normalized()
		vel.x = dir.x * moveSpeed
		vel.y = 0
		vel.z = dir.z * moveSpeed
		
		#move towards the player
		velocity = vel
		move_and_slide()

#called every "attackRate" seconds
func _on_timer_timeout():
	if position.distance_to(player.position) <= attackDist:
		player.takeDamage(damage)
		
func takeDamage( damageToTake):
	currHp -= damageToTake
	if currHp <= 0:
		die()

func die():
	queue_free()
