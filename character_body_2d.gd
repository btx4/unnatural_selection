extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -800.0
var Leg_Type = 2
var All_Legs = 3
var faceL = false
var isDead = false
var knockback_State = false
var KNOCKBACK = 700 
func _physics_process(delta: float) -> void:
		if !isDead and !knockback_State:
			if(get_tree().get_nodes_in_group("eHitbox")[0].global_position.x < global_position.x and is_on_floor()):
				if faceL == false:
					$CollisionShape2D2/RooLegs.scale.x = -$CollisionShape2D2/RooLegs.scale.x 
					$CollisionShape2D2/RooLegs.position.x += 15
					faceL = true
				if(Leg_Type!= 2):
					velocity.x = -1 * SPEED
			elif is_on_floor():
				if(Leg_Type != 2):
					velocity.x = SPEED
				if faceL == true:
					$CollisionShape2D2/RooLegs.scale.x = -$CollisionShape2D2/RooLegs.scale.x
					$CollisionShape2D2/RooLegs.position.x -= 15
					faceL = false
				
			
			# Handle jump.
			if is_on_floor():
				if(Leg_Type == 0):
					#print("Jump")
					$CollisionShape2D2/AnimationPlayer.play("KangarooJump")
				if(Leg_Type == 2):
					$CollisionShape2D2/AnimationPlayer.play("Crabwalk")

			# Get the input direction and handle the movement/deceleration.
			# As good practice, you should replace UI actions with custom gameplay actions.

		if not is_on_floor():
			velocity += get_gravity() * delta
		move_and_slide()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("LegsPlusOne"):
		Leg_Type = Leg_Type + 1
		Leg_Type = Leg_Type % All_Legs
		print("LEGTYPE: ", Leg_Type)
	if Leg_Type == 0:
		$CollisionShape2D2/CarLegs.visible = false
		$CollisionShape2D2/RooLegs.visible = true
		$CollisionShape2D2/CrabLegs.visible = false
	elif Leg_Type == 1:
		$CollisionShape2D2/CarLegs.visible = true
		$CollisionShape2D2/RooLegs.visible = false
		$CollisionShape2D2/CrabLegs.visible = false
	elif Leg_Type == 2:
		$CollisionShape2D2/CarLegs.visible = false
		$CollisionShape2D2/RooLegs.visible = false
		$CollisionShape2D2/CrabLegs.visible = true

func _jump():
	if(is_on_floor()):
		velocity.y = JUMP_VELOCITY

func hit(damage: int):
	print("Hit")
	get_parent().currentHealth -= damage
	
func crabRandom():
	if(!knockback_State):
		if randi() % 3 ==2:
			print("LEF")
			$CollisionShape2D2/CrabLegs.scale.x = -4.125
			velocity.x = -1 * (SPEED * 3)
		else:
			$CollisionShape2D2/CrabLegs.scale.x = 4.125
			velocity.x = SPEED * 3
		

func knockback():
	print("LEGSHIT")
	if(get_tree().get_nodes_in_group("eHitbox")[0].global_position.x < global_position.x):
		velocity.x = KNOCKBACK
	else:
		velocity.x = -KNOCKBACK
	velocity.y = -500
	$Knock.start()
	knockback_State = true

func _on_knock_timeout() -> void:
	knockback_State = false
	pass # Replace with function body.
