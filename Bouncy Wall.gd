extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass




func _on_body_entered(body: Node2D) -> void:
	print("OOGA")
	if body.is_in_group("legs"):
		body.velocity.x = -body.velocity.x
		body.velocity.y = -100
	pass # Replace with function body.
	
