extends Node

#var diccionario = {"ColorPlayer":"Blanco", "Nivel":"Facil", "Velocidad":"1"}
var reloj = 0
var numLifes = 3
var numBalls = 3
var stateGame = ""
var levelGame = 0
var stateBall = ""
var statePlayer = "life"

var posPlayer
#var posBall = posPlayer
var screenSize
var score = 0

func reload():
	numLifes = 3
	numBalls = 3
	score = 0
	levelGame = 0
	statePlayer = "life"
	stateBall = ""
	stateGame = ""
