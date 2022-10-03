extends AnimatedSprite

func _ready():
	$Label.text = ""
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if frame >= 7:
		playing = false
		frames = null # queue_free()



func _on_TiempoTexto_timeout():
	queue_free()
