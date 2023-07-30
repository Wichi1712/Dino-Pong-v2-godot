extends Area2D

var rocky = load("res://scenes/player/TestPlayer.tscn")
#var nuevoColor = Color(1.0,0.0,0.0,0.5)

func _ready():
	#Permite cambiar el color del shader en material
	$AnimatedSprite.material.set_shader_param("color_afectar", Color(0.1,0.1,0.1,0.5))
	pass # Replace with function body.


#func _process(delta):
#	pass


func _on_ReloadRocky_timeout():
#	if global_var.stateGame == "play":
#		newRocky()
	global_var.statePlayer = "life"
	queue_free()
	pass

#Crea nuevamente a Player
#func newRocky():
#	var r = rocky.instance()
#	r.position = self.position
#	get_parent().get_node("../Game").add_child(r)
