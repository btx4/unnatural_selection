extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

var bodies
func attack():
	bodies = get_overlapping_bodies()
	for body in bodies:
		if is_in_group("eHitbox"):
			if body.is_in_group("gHitbox"):
				body.hit(5)
				break
		elif is_in_group("gHitbox"):
			if body.is_in_group("eHitbox"):
				body.hit(5)
				break
