extends Node

var screenSize = Vector2()
var numeroDinos = 10
#var numBalls = 3
var dino = preload("res://scenes/dinos/Dino.tscn")
var raptor = preload("res://scenes/dinos/raptor.tscn")
var rino = preload("res://scenes/dinos/rino.tscn")
var blueTurlte = preload("res://scenes/dinos/blueTurtle.tscn")
var TestDino = preload("res://scenes/dinos/TestDino.tscn")
var gOver = preload("res://scenes/Over.tscn").instance()


func _ready():
	OS.center_window()#centrar ventana
	#Obtenemos tamaño de la ventana
	screenSize = get_viewport().get_visible_rect().size
	global_var.stateGame = "play"
	global_var.screenSize = screenSize
	get_node("TextureProgress").max_value = 300


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
	

	#Actualiza HUD
	$HUD/Score.text = str(global_var.score)
	$HUD/Life.text  = "x " + str(global_var.numLifes)
	$HUD/Balls.text = "x " + str(global_var.numBalls)
	
	#$Leveldinos.rect_size.x = global_var.lostDinos
	$TextureProgress.value = global_var.lostDinos
	$TextureProgress/LostDinosIcon.position.x = $TextureProgress.value + 16
	$TextureProgress/HomeIcon.position.x = $TextureProgress.max_value + 16
	

#cada vez que se acaba los dinos el nivel del juego incrementa en 1
	if $ContenDinos.get_child_count() == 0:
		crea_dinos()
		global_var.levelGame +=1

#Crea dos tipos de dinos en posicion aleatoria
func crea_dinos():
	for _i in range(numeroDinos):
		var Dino = dino.instance()
		var Raptor = raptor.instance()
		var Rino = rino.instance()
		var BlueTurtle = blueTurlte.instance()
		#var tstDino = TestDino.instance()
		randomize()
		var dinoRandom = randi() % 5
		Dino.position = Vector2(rand_range(100,screenSize.x - 100),rand_range(-60,-560))
		Raptor.position = Vector2(rand_range(100,screenSize.x - 100),rand_range(-60,-560))
		Rino.position = Vector2(rand_range(100,screenSize.x - 100),rand_range(-60,-560))
		BlueTurtle.position = Vector2(rand_range(100,screenSize.x - 100),rand_range(-60,-560))
		#for d in range(0,20):
		if dinoRandom == 0: ##i < numeroDinos/2:
			$ContenDinos.add_child(Raptor)
		elif dinoRandom == 1:## i < numeroDinos/3:
			$ContenDinos.add_child(Rino)
		elif dinoRandom == 2:
			$ContenDinos.add_child(BlueTurtle)
		else:
			$ContenDinos.add_child(Dino)
			


func _on_TextureProgress_value_changed(value):
	if value >= $TextureProgress.max_value:
		global_var.stateGame = "gameOver"
	pass # Replace with function body.
