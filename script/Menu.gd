extends Node



# Called when the node enters the scene tree for the first time.
func _ready():
	OS.window_maximized = true
	#OS.window_fullscreen = true
	pass # Replace with function body.

func _process(_delta):
	if Input.is_action_just_pressed("Enter"):
		get_tree().change_scene("res://scenes/Game.tscn")
	pass


func _on_Timer_timeout():
	#Envia automaticamnete al juego
	get_tree().change_scene("res://scenes/Game.tscn")
	pass # Replace with function body.
