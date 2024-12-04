extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func blast():
	position.x = get_parent().get_node("Legs").position.x
	$BFL.blast()
	$BL.blast()
	$BFR.blast()
	$BR.blast()
	$BFL/GeyserBlast.attack()
	$BL/GeyserBlast.attack()
	$BFR/GeyserBlast.attack()
	$BR/GeyserBlast.attack()
