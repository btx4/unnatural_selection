extends RigidBody2D
var threshold = 70
var isDead = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	gravity_scale = -1
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	"""
	var rigid_body_position = get_parent().get_node("CharacterBody2D2").global_position
	# Calculate the distance to the target
	var distance_to_legs = global_position.distance_to(rigid_body_position)
	# Check if the distance is above the threshold
	if distance_to_legs > threshold:
		# Calculate the direction vector
		var direction = (rigid_body_position - global_position).normalized()
		global_position = rigid_body_position - direction * 60
	"""


func hit(damage: int):
	get_parent().get_node("Legs").hit(damage)
	
func knockback():
	print("CHESHIT")
	get_parent().get_node("Legs").knockback()
