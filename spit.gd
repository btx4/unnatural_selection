extends Area2D

var velocity: Vector2 = Vector2(0, 0)
var source  
# Called when the node enters the scene tree for the first time.
func fire(direction: Vector2, speed: float, from: int) -> void:
	velocity = direction * speed
	$Sprite2D.rotation = -velocity.angle()
	source = from

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	global_position += velocity * delta




func _on_body_entered(body: Node2D) -> void:
	if source == 0:
		if body.is_in_group("eHitbox"):
			body.hit(3)
			queue_free()
			print(body)
	else:
		if body.is_in_group("gHitbox"):
			body.hit(3)
			queue_free()
			print(body)
	pass # Replace with function body.
