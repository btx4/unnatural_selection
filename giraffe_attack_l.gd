extends Area2D
var isActive = false;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
var bodies

func attack():
	bodies = get_overlapping_bodies()
	for body in bodies:
		print(body)
		if is_in_group("eHitbox"):
			print("ENEMYATTACKHit")
			if body.is_in_group("gHitbox"):
				body.hit(20)
				body.knockback()
				break
		elif is_in_group("gHitbox"):
			print("GOODGUYATTACKHIT")
			if body.is_in_group("eHitbox"):
				body.hit(20)
				body.knockback()
				break
			
