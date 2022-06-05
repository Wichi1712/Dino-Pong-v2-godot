extends Area2D

var screenSize
var speed = 230
#var direction = Vector2.ZERO
var rockyShock = preload("res://scenes/player/ghostPlayer.tscn")

#Para esta forma se necesita que el nodo este añadido
#onready var snd_shoot : AudioStreamPlayer = get_node("res://sounds/SHOOT.wav")

#------------ESTADOS DE PLAYER---------------------
#El estado inicial de PLayer es "life", si colisiona con un Dino
#entonces su estado cambiará a "shock" y en ese momento pasará
#automaticamente a "phantom" solo por unos segundos.Esto dará tiempo
#para que nuestro personaje tenga ventaja despues de la colision
#con el Dino
#---life
#---shock
#---phantom

# Called when the node enters the scene tree for the first time.
func _ready():
	#OS.center_window()#centra la ventana en el monitor
	#Posicion inicial
	screenSize = get_viewport_rect().size
	position.x = screenSize.x / 2
	position.y = screenSize.y - 40
	#Color(0.2, 1.0, 0.7, 0.1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match global_var.stateGame:
		"play":
			#Solo se mueve si su estado es "phantom" o "life"
			if global_var.statePlayer != "shock":
				move(delta)
			elif global_var.statePlayer == "shock":
				#shockPlayer()
				$AnimationPlayer.play("shock")
				#yield()
				#En el estado phantom se mueve pero no
				#recibe daño
				global_var.statePlayer = "phantom"
				pass
				
			#Damos movimiento al balon
			if (Input.is_action_pressed("patear") && global_var.stateBall == "stop"):
				global_var.stateBall = "move"
				AudioShoot()#reproduce sonido de patear
				#snd_shoot.Play()				
		"gameOver":
			#$AnimationPlayer.stop(true)
			$AnimationPlayer.play("shock")
	#print(global_var.statePlayer)

#MOVE
func move(delta):
	if Input.is_action_pressed("ui_left"):
		position.x -= speed * delta
		$Sprite.flip_h = true
		if global_var.stateBall == "stop":
			$AnimationPlayer.play("chargeWalk")
		elif global_var.stateBall == "move":
			$AnimationPlayer.play("walk")
	elif Input.is_action_pressed("ui_right"):
		position.x += speed * delta
		$Sprite.flip_h = false
		if global_var.stateBall == "stop":
			$AnimationPlayer.play("chargeWalk")
		elif global_var.stateBall == "move":
			$AnimationPlayer.play("walk")
	else:
		if global_var.stateBall == "stop":
			$AnimationPlayer.play("stopCharge")
		elif global_var.stateBall == "move":
			$AnimationPlayer.play("stop")
		
		
	#LIMITES DE MOVIMIENTO
	position.x = clamp(position.x,100,screenSize.x - 100)
	position.y = clamp(position.y,0,screenSize.y)

func _on_Player_area_entered(area):
	#Si colisiona con un DINO y el estado de player es "life"
	#Entonces se ejecuta la funcion shockPlayer.
	if (area.is_in_group("Dinos") && global_var.statePlayer == "life"):
		#global_var.numLifes -=1
		#global_var.statePlayer = "shock"
		shockPlayer()
		

func shockPlayer():
	global_var.numLifes -=1
	global_var.statePlayer = "shock"
	$AudioShockPlayer.play()
	
	#Agregando ghostPlayer
	var rShock = rockyShock.instance()
	rShock.position = self.position
	get_parent().get_node("../Game").add_child(rShock)
	#queue_free()

func AudioShoot():
	var AudioScene = AudioStreamPlayer.new()
	AudioScene.stream = load("res://sounds/SHOOT.wav")
	add_child(AudioScene)
	AudioScene.volume_db = -5
	AudioScene.play()


