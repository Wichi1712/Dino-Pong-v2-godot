extends KinematicBody2D


var velocity = Vector2.ZERO
#Obtenemos la variable numBalls de Game.gd
#onready var countBalls = get_parent().get_node("../Game").numBalls

func _ready():
	global_var.stateBall = "stop"
	#countBalls = get_parent().get_node("../Game").numBalls

func _physics_process(delta):
	if global_var.stateGame == "play":
		moveBall(delta)
		
	print(velocity)
	#Rebote
#	if global_var.stateBall == "move":
#		var collision = move_and_collide(velocity * delta)
#		if collision:
#			velocity = velocity.bounce(collision.normal)
#			#Detiene movimiento cuando colisiona con player
#			if collision.collider.has_method("hit"):
#				collision.collider.hit()
#
#	if global_var.stateBall == "stop":
#		position.x = get_parent().get_node("TestPlayer").position.x
#		position.y = get_node("../TestPlayer").position.y - 30

func moveBall(delta):
	match global_var.stateBall:
		"stop":
			velocity.y = -250
			
			#Direccion de la coordinada X de acuerdo a la tecla seleccionada
			if Input.is_action_pressed("ui_left"):
				velocity.x = rand_range(-250,0)
			elif Input.is_action_pressed("ui_right"):
				velocity.x = rand_range(0,250)
			else: velocity.x = 0
			
			if is_instance_valid(get_parent().get_node("TestPlayer")):
				#Se ubica nuevamente en la posicion de player
				position.x = get_parent().get_node("TestPlayer").position.x
				position.y = get_node("../TestPlayer").position.y - 30
			else:
				#Si no se encuentra el player enviamos el ball fuera de pantalla
				position.x = global_var.screenSize.x + 100
				#queue_free()
			
		"move":
			var collision = move_and_collide(velocity * delta)
			if collision:
				velocity = velocity.bounce(collision.normal)
				#Detiene movimiento cuando colisiona con player
				#Incrementa score cuando colisiona con Dinos
				if collision.collider.has_method("hit"):
					collision.collider.hit()
			
			#Volvemos a la posicion inicial mediante el estado de ball
			#que cambia a "stop" mientras el numero de balls sea mayor a cero de lo contrario sera
			#eliminado al sobrepasar el alto de la pantalla.
			if position.y > global_var.screenSize.y + 10:
				global_var.numBalls -=1
				if global_var.numBalls > 0:
					global_var.stateBall = "stop"
				else:
					global_var.stateGame = "gameOver"
					queue_free()
				

#Llama a la funcion shock de Player
#Esta funcion es llamada desde Dino
func colisionDino():
	if global_var.stateBall == "stop" and global_var.statePlayer == "life":
		get_parent().get_node("TestPlayer").shock()
#		global_var.numLifes -=1
#		global_var.statePlayer = "hurt"
