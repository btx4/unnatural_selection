extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	global_position.y = 550
	position.x = -150
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

	
func blast() -> void:
	position.x = -150
	$GPUParticles2D.restart()
	$SprayR.restart()
	$SprayR2.restart()
	pass # Replace with function body.
