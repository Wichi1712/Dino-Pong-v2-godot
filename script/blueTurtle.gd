extends "res://script/Dino.gd"

func _ready():
	velocidad = 50
	valor = 40


func _on_blueTurtle_area_entered(area):
	if area.is_in_group("ball"):
		#Si el estado de ball es "stop" y estado de player es "life"
		#Entonces se ejecuta la funcion shockPlayer de Player
		if global_var.stateBall == "stop" && global_var.statePlayer == "life":
			#global_var.statePlayer = "shock"
			get_parent().get_node("../Player").shockPlayer()
		else:
			global_var.score +=valor
			var shockDino = preload("res://scenes/DustDino.tscn").instance()
			shockDino.position = self.position
			get_tree().root.add_child(shockDino)
			shockDino.get_node("Label").text = str(valor)
			queue_free()
