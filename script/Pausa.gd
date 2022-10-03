extends Control
onready var selector = $Botons/CanvasLayer/TextureRect/Spr_selector
onready var ButonResume = $Botons/CanvasLayer/TextureRect/ButtonResume
onready var ButonExit = $Botons/CanvasLayer/TextureRect/ButtonExit

func _process(delta):
	#Solo se llama a la funcion pausa cuando este en la posicion
	#-450 ó 100 con respecto al eje X.
	if Input.is_action_just_pressed("ui_cancel") && global_var.stateGame != "gameOver":
		if $Botons/CanvasLayer/TextureRect.rect_position.x == -450 or $Botons/CanvasLayer/TextureRect.rect_position.x == 100:
			pausa()

	#print(get_tree().paused)
	#print("Estado juego " + str(global_var.estadoJuego))
	if get_tree().paused == true:
		if Input.is_action_just_pressed("ui_down"):
			selector.position.y = ButonExit.rect_position.y
			selector.position.x = 130
		if Input.is_action_just_pressed("ui_up"):
			selector.position.y = ButonResume.rect_position.y
			selector.position.x = 100
		if Input.is_action_just_pressed("Enter"):
			if selector.position.y == ButonResume.rect_position.y :
				pausa()
			if selector.position.y == ButonExit.rect_position.y :
				get_tree().quit()

func pausa():
	if get_tree().paused == true:
		get_tree().paused = false
		$Efect.interpolate_property($Botons/CanvasLayer/TextureRect,"rect_position",$Botons/CanvasLayer/TextureRect.rect_position,$Botons/CanvasLayer/TextureRect.rect_position-Vector2(550,0),0.5,Tween.TRANS_BACK,Tween.EASE_IN)
		$Efect.start()
	else:
		get_tree().paused = true
		$Efect.interpolate_property($Botons/CanvasLayer/TextureRect,"rect_position",$Botons/CanvasLayer/TextureRect.rect_position,$Botons/CanvasLayer/TextureRect.rect_position+Vector2(550,0),0.5,Tween.TRANS_BACK,Tween.EASE_IN)
		$Efect.start()
