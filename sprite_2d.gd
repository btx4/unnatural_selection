extends Sprite2D
var SPEED = 20
var scaleF
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SPEED = randi()%100 + 20
	scaleF = randi()%10
	position.y += -100 + randi()%200
	scale.x = scaleF
	scale.y = scaleF
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x += SPEED * delta
	rotation = 0  # Keeps the rotation fixed at 0 degrees
	if position.x > 9200:
		position.x = - 5000
	pass
