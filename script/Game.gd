extends Node

var screenSize = Vector2()
var numeroDinos = 10
#var numBalls = 3
var dino = preload("res://scenes/dinos/Dino.tscn")
var Dino2 = preload("res://scenes/dinos/raptor.tscn")
var TestDino = preload("res://scenes/dinos/TestDino.tscn")
var gOver = preload("res://scenes/Over.tscn").instance()

func _ready():
	OS.center_window()#centrar ventana
	#Obtenemos tamaño de la ventana
	screenSize = get_viewport().get_visible_rect().size
	global_var.stateGame = "play"
	global_var.screenSize = screenSize


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	#-----CONTROL DE ESTADOS DE JUEGO------
	match global_var.stateGame:
		"play":
			if (global_var.numBalls <= 0 or global_var.numLifes <= 0):
				global_var.stateGame = "gameOver"
				pass
		"gameOver":
			#if !is_instance_valid(get_parent().get_node("Over")):
			add_child(gOver)
			set_process(false)
			pass
	
	
	#Valor inicial del ball en el eje X
	#Se comprueba que la instancia BallTurtle exista
#	if global_var.stateBall == "stop":
#		if (is_instance_valid(get_node("../BallTurtle"))):
#			if Input.is_action_pressed("ui_left"):
#				$BallTurtle.dirX = -400
#			if Input.is_action_pressed("ui_right"):
#				$BallTurtle.dirX = 400
#			print("ball: " + global_var.stateBall)
		#pass
	
	#print("SCREEN: " + str(screenSize))
	
	#Actualiza HUD
	$HUD/Score.text = str(global_var.score)
	$HUD/Life.text  = "x " + str(global_var.numLifes)
	$HUD/Balls.text = "x " + str(global_var.numBalls)
	
#	if $ContenEnenigo.get_child_count() == 0:
#		level+=1
#		time_left += 5
#		spawn_enemigo()#llama a la funcion spawn_enemigo
#
#	#Crea enemigos en posicion aleatoria
#	func spawn_enemigo():
#		for index in range(BASIC_LEVEL + level):
#			var Enemy = Enemigo.instance()
#			Enemy.position = Vector2(rand_range(0,screensize.x), rand_range(0,screensize.y))
#			$ContenEnenigo.add_child(Enemy)


	if $ContenDinos.get_child_count() == 0:
		crea_dinos()
		global_var.levelGame +=1

#Crea dos tipos de dinos en posicion aleatoria
func crea_dinos():
	for i in range(numeroDinos):
		var D = dino.instance()
		var D2 = Dino2.instance()
		#var tstDino = TestDino.instance()
		randomize()
		D.position = Vector2(rand_range(100,screenSize.x - 100),rand_range(-60,-560))
		#tstDino.position = Vector2(rand_range(85,screenSize.x - 85),rand_range(-60,-560))
		D2.position = Vector2(rand_range(100,screenSize.x - 100),rand_range(-60,-560))
		#for d in range(0,20):
		if i < numeroDinos/2:
			$ContenDinos.add_child(D)
			pass
		else:
			$ContenDinos.add_child(D2)
