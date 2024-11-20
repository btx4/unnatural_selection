extends Area2D
var isActive = false;

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
		if body.is_in_group("gHitbox"):
			print("Success")	
			body.hit(20)
			body.knockback()
			break
		else: 
			print("failure")
	
	pass
