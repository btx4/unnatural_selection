extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func destroy():
	$TempFloor/CollisionShape2D.disabled = true
	$TempFloor2/CollisionShape2D.disabled = true
	$TempFloor3/CollisionShape2D.disabled = true
	$TempFloor4/CollisionShape2D.disabled = true
	
func rebuild():
	$TempFloor/CollisionShape2D.disabled = false
	$TempFloor2/CollisionShape2D.disabled = false
	$TempFloor3/CollisionShape2D.disabled = false
	$TempFloor4/CollisionShape2D.disabled = false
