extends KinematicBody2D

#SOLO PARA PRUEBA NO SE USO EN EL JUEGO

var SPEED = 90
var velocity = Vector2(0,30)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	match global_var.stateGame:
		"play":
			colisionPlayer(delta)
			#position.y +=SPEED *delta
			position.y +=velocity.y * delta
			
			#Vuelve a la posicion inicial
			if position.y > global_var.screenSize.y + 60:
				randomize()
				position.x = rand_range(85,global_var.screenSize.x - 85)
				position.y = rand_range(-60,-560)

#Esta funcion se llama desde "ball" cada vez que colisiona
func hit():
	global_var.score +=1
	queue_free()

#SOLO PARA PRUEBA
func colisionPlayer(delta):
	if position.y >= 10:
		var collision = move_and_collide(velocity * delta)
		if collision:
			#print("ooooooooooooooooooooooooooo")
			#Cada vez que Dino colisiona con Player llama a su
			#funcion Shock
			if collision.collider.has_method("shock"):
				collision.collider.shock()
			#Si colisiona con ball en estado Stop
			if collision.collider.has_method("colisionDino"):
				collision.collider.colisionDino()
