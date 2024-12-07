extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	global_position.y = 550
	position.x = -300
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x = -300
	pass

	
func blast() -> void:
	$GPUParticles2D.restart()
	$SprayR.restart()
	$SprayR2.restart()
	pass # Replace with function body.
