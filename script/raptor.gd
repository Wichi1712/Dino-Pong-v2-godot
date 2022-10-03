extends "res://script/Dino.gd"

var dust = preload("res://scenes/DustDino.tscn")


func _ready():
	velocidad = 180
	valor = 30
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_raptor_area_entered(area):
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
