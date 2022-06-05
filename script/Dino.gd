extends Area2D

var velocidad = 100


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	position.y += velocidad * delta
	
	#Vuelve a la posicion inicial
	if position.y > global_var.screenSize.y + 60:
		randomize()
		position.x = rand_range(100,global_var.screenSize.x - 100)
		position.y = rand_range(-60,-560)


func _on_Dino_area_entered(area):
	if area.is_in_group("ball"):
		#Si el estado de ball es "stop" y estado de player es "life"
		#Entonces se ejecuta la funcion shockPlayer de Player
		if global_var.stateBall == "stop" && global_var.statePlayer == "life":
			#global_var.statePlayer = "shock"
			get_parent().get_node("../Player").shockPlayer()
		else:
			global_var.score +=1
			queue_free()
			
