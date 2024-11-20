extends Area2D
var isActive = false;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if isActive:
		$CollisionShape2D/ColorRect.visible = true
	else:
		$CollisionShape2D/ColorRect.visible = false
	pass
	
var bodies
func attack():
	bodies = get_overlapping_bodies()
	for body in bodies:
		if body.is_in_group("eHitbox"):
			body.hit(20)
			body.knockback()
			break
	
