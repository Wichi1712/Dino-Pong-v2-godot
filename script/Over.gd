extends Control
onready var SelectorGameOver = $SelectorGameOver
onready var posX = get_viewport_rect().size.x / 3 + 19
var Y1 = 290
var Y2 = 365
var posY = Y1

func _ready():
	#posX = get_viewport_rect().size.x / 2
	$ColorRect.rect_position.x = posX
	$ColorRect.rect_position.y = posY
	$SelectorGameOver.position = Vector2(190,310)

func _process(delta):
	$ColorRect.rect_position.y = posY
	
	if Input.is_action_just_pressed("ui_down"):
		posY = Y2
		SelectorGameOver.position.y = 385
		SelectorGameOver.position.x = 230
	if Input.is_action_just_pressed("ui_up"):
		posY = Y1
		SelectorGameOver.position.y = 310
		SelectorGameOver.position.x = 190
	
	match posY:
		Y1:
			if Input.is_action_just_pressed("Enter"):
				#get_tree().reload_current_scene()
				get_tree().change_scene("res://scenes/Game.tscn")
				global_var.reload()
				#global_var.stateGame = "play"
				#queue_free()
				#print(global_var.stateGame)
			pass
		Y2:
			if Input.is_action_just_pressed("Enter"):
				get_tree().quit()
			pass
	
	pass
