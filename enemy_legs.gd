extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -800.0
var Leg_Type = 1
var All_Legs = 3
var faceL = false
var isDead = false
var knockback_State = false
var test = true
var KNOCKBACK = 700

func _physics_process(delta: float) -> void:
	if(get_tree().get_nodes_in_group("gHitbox")[0].global_position.x < global_position.x - 15):
		if faceL == false:
			print("FLIP")
			$CollisionShape2D/RooLegs.scale.x = -$CollisionShape2D/RooLegs.scale.x
			faceL = true
	elif (get_tree().get_nodes_in_group("gHitbox")[0].global_position.x > global_position.x + 15):
		if faceL == true:
			$CollisionShape2D/RooLegs.scale.x = -$CollisionShape2D/RooLegs.scale.x
			print("FLIP")
			faceL = false
	
	
	if !isDead and !knockback_State:
		if(get_tree().get_nodes_in_group("gHitbox")[0].global_position.x < global_position.x and is_on_floor()):
			if(Leg_Type!= 2):
				velocity.x = -1 * SPEED
		elif is_on_floor() :
			if(Leg_Type!= 2):
				velocity.x = SPEED
		# Handle jump.
		if is_on_floor():
			if(Leg_Type == 0):
				#print("Jump")
				$CollisionShape2D/AnimationPlayer.play("KangarooJump")
			if(Leg_Type == 2):
				$CollisionShape2D/AnimationPlayer.play("Crabwalk")
	if not is_on_floor():
		velocity += get_gravity() * delta
	move_and_slide()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("eLegsPlusOne"):
		Leg_Type = Leg_Type + 1
		Leg_Type = Leg_Type % All_Legs
		print("LEGTYPE: ", Leg_Type)
	if Leg_Type == 0:
		$CollisionShape2D/CarLegs.visible = false
		$CollisionShape2D/RooLegs.visible = true
		$CollisionShape2D/CrabLegs.visible = false
	elif Leg_Type == 1:
		$CollisionShape2D/CarLegs.visible = true
		$CollisionShape2D/RooLegs.visible = false
		$CollisionShape2D/CrabLegs.visible = false
		$CollisionShape2D/CrabLegs.visible = false
	elif Leg_Type == 2:
		$CollisionShape2D/CarLegs.visible = false
		$CollisionShape2D/RooLegs.visible = false
		$CollisionShape2D/CrabLegs.visible = true

func _jump():
	if(is_on_floor()):
		velocity.y = JUMP_VELOCITY


func hit(damage: int):
	print("Hit")
	get_parent().currentHealth -= damage

func knockback():
	print("LEGSHIT")
	velocity.y = -500
	if(get_tree().get_nodes_in_group("gHitbox")[0].global_position.x < global_position.x):
		velocity.x = KNOCKBACK
	else:
		velocity.x = -KNOCKBACK
	$Knock.start(0.5)
	knockback_State = true

func crabRandom():
	if !isDead and !knockback_State:
		print("CRABRANDOM")
		if randi() % 3 ==2:
			print("LEF")
			$CollisionShape2D/CrabLegs.scale.x = -4.125
			velocity.x = -1 * (SPEED * 2)
		else:
			print("RIg")
			$CollisionShape2D/CrabLegs.scale.x = 4.125
			velocity.x = SPEED * 2


func _on_knock_timeout() -> void:
	print("WOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO")
	knockback_State = false
	pass # Replace with function body.
