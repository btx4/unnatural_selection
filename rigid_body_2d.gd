extends RigidBody2D
var threshold = 70
var isDead = false
var chest_type = 0
var num_chests = 2
var pchest_type
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	gravity_scale = -1
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if isDead == false:
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
	get_parent().get_node("Legs").knockback()
	
func _input(event: InputEvent) -> void:
	if is_in_group("gHitbox"):
		if event.is_action_pressed("chestOne"):
			chest_type = 0
		elif event.is_action_pressed("chestTwo"):
			chest_type = 1
		elif event.is_action_pressed("chestThree"):
			chest_type = 2
	else:
		if event.is_action_pressed("eChestOne"):
			chest_type = 0
		elif event.is_action_pressed("eChestTwo"):
			chest_type = 1
		elif event.is_action_pressed("eChestThree"):
			chest_type = 2
	if chest_type == 0 and chest_type != pchest_type:
		$Human_Collision/HumanChest.visible = true
		$Human_Collision/AnimationPlayer.stop()
		$Human_Collision/BirdChest.visible = false
	elif chest_type == 1 and chest_type != pchest_type:
		$Human_Collision/HumanChest.visible = false
		$Human_Collision/BirdChest.visible = true
		$Human_Collision/AnimationPlayer.play("birdFlap")
	elif chest_type == 2 and chest_type != pchest_type:
		$Human_Collision/HumanChest.visible = false
		$Human_Collision/AnimationPlayer.stop()
		$Human_Collision/BirdChest.visible = false
	pchest_type = chest_type

var maxFlaps = 10
func flap():
	maxFlaps -=1
	if maxFlaps > 0:
		get_parent().get_node("Legs").velocity.y = -400
	
