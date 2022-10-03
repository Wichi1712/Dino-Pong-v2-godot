extends Area2D

var posIni
var dirX = 250 #  = rand_range(-250,250)
var dirY = 250
var direccion = Vector2.ZERO
#var move = Vector2()
#onready var polvo = preload("res://scenes/Polvo.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	#z_index = 1#profundidad con respecto a las demas imagenes
	posIni = get_viewport_rect().size
	#position.x = posIni.x/2
	position.y = get_node("../Player").position.y - 30
	
	direccion = Vector2(dirX,-dirY)
	global_var.stateBall = "stop"
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#position -= direccion * delta
	if global_var.stateGame == "play":
		moveBall(delta)
	

func moveBall(delta):
	#Movimimiento
	match global_var.stateBall:
		"stop":
			$Particles2D.emitting = false;
			#Establece la direccion inicial en el eje X
			if Input.is_action_pressed("ui_left"):
				dirX = -250
			elif Input.is_action_pressed("ui_right"):
				dirX = 250
			
			#Establece la direccion en el eje Y como negativo
			#para que el balon vaya hacia arriba
			direccion.y = -dirY
			
			#Se ubica nuevamente en la posicion de player
			if (is_instance_valid(get_node("../Player")) && global_var.statePlayer != "shock"):
				position.x = get_node("../Player").position.x #global_var.posPlayer
				position.y = get_node("../Player").position.y - 30
			else:
				#Si no se encuentra el player enviamos el ball fuera de pantalla
				position.x = global_var.screenSize.x + 100
				#queue_free()
		
		"move":
#			var polvos = polvo.instance()
#			get_parent().get_node("../Game").add_child(polvos)
#			polvos.position = self.position
			#rotacion de ballon
			$Particles2D.emitting = true;
			$Sprite.rotation_degrees += 5
			
			direccion.x = dirX
			#move = move_and_slide(direccion)
		
			position += direccion * delta
		
			#Rebote horizontal
			if position.x < 100:
				dirX = 250
			elif position.x > 500:
				dirX = -250
		
	#		if position.x < get_parent().get_node("../Game/Paredes/CollisionI").position.x + 100:
	#			dirX = 400
	#		if position.x > get_parent().get_node("../Game/Paredes/CollisionD").position.x:
	#			dirX = -400
			#Rebote vertical
			if position.y < 0:
				direccion.y = dirY# * delta
			#Si el balon sobrepasa el borde inferior de la
			#pantalla el estado será "stop" o "Game Over"
			elif position.y > global_var.screenSize.y + 10:
				global_var.numBalls -=1
				
				if global_var.numBalls > 0:
					global_var.stateBall = "stop"
				else:
					global_var.stateGame = "gameOver"
					#queue_free()
				#direccion.y = -dirY# * delta
				
				
			#print("ball" + str(dirX))
	
		


func _on_BallTurtle_area_entered(area):
	if area.is_in_group("Player"):
		global_var.stateBall = "stop"
		
	#Rebote con los Dinos
	if area.is_in_group("Dinos"):
		if area.position.x < position.x:
			dirX = 250
		elif area.position.x > position.x:
			dirX = -250
			
		audioShockDino()
#		if area.position.y < position.y:
#			dirY = -400
#		elif area.position.y > position.y:
#			dirY = 400
	pass # Replace with function body.

func audioShockDino():
	var audioDinoShock = AudioStreamPlayer.new()
	audioDinoShock.stream = load("res://sounds/dinoShock2.wav")
	add_child(audioDinoShock)
	audioDinoShock.volume_db = -5
	audioDinoShock.play()
	pass
