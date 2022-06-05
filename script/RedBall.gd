extends RigidBody2D

func _ready():
	global_var.stateBall = "stop"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if global_var.stateBall == "stop":
		#linear_velocity.x = get_node("../Player").position.x
		position.x = get_node("../Player").position.x
		linear_velocity.y = 0
		#pass
		
		
		
	#if global_var.stateBall == "move":
	#	linear_velocity.y = -200
		

func moveBall():
	match global_var.stateBall:
		"move":
			#call_deferred()
			#set_process(false)
			#linear_velocity.x = 200
			#linear_velocity.y = -200
			linear_velocity = Vector2(rand_range(-200,200),-200)
			#set_process(false)


func _on_RedBall_body_entered(body):
	if body.is_in_group("PLayer"):
		global_var.stateBall = "stop"
		print("COLLISION REDBALL")
