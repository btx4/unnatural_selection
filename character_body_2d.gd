extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -800.0
var Leg_Type = 2
var All_Legs = 3
var faceL = false
var isDead = false
var knockback_State = false
var prevFacing = faceL
var KNOCKBACK = 1000 
var charging = false
func _physics_process(delta: float) -> void:
	prevFacing = faceL
	if !isDead and !knockback_State:
		if is_in_group("gHitbox"):
			if(get_tree().get_nodes_in_group("eHitbox")[0].global_position.x < global_position.x and is_on_floor()):
				if faceL == false:
					$CollisionShape2D2/RooLegs.scale.x = -$CollisionShape2D2/RooLegs.scale.x 
					$CollisionShape2D2/BullCharge.scale.x = -$CollisionShape2D2/BullCharge.scale.x 
					$CollisionShape2D2/BullChargeUp.scale.x = -$CollisionShape2D2/BullChargeUp.scale.x 
					$CollisionShape2D2/RooLegs.position.x += 15
					faceL = true
			elif is_on_floor():
				if faceL == true:
					$CollisionShape2D2/RooLegs.scale.x = -$CollisionShape2D2/RooLegs.scale.x
					$CollisionShape2D2/BullCharge.scale.x = -$CollisionShape2D2/BullCharge.scale.x 
					$CollisionShape2D2/BullChargeUp.scale.x = -$CollisionShape2D2/BullChargeUp.scale.x 
					$CollisionShape2D2/RooLegs.position.x -= 15
					faceL = false
		else:
			if(get_tree().get_nodes_in_group("gHitbox")[0].global_position.x < global_position.x and is_on_floor()):
				if faceL == false:
					$CollisionShape2D2/RooLegs.scale.x = -$CollisionShape2D2/RooLegs.scale.x 
					$CollisionShape2D2/BullCharge.scale.x = -$CollisionShape2D2/BullCharge.scale.x 
					$CollisionShape2D2/BullChargeUp.scale.x = -$CollisionShape2D2/BullChargeUp.scale.x 
					$CollisionShape2D2/RooLegs.position.x += 15
					faceL = true
			elif is_on_floor():
				if faceL == true:
					$CollisionShape2D2/RooLegs.scale.x = -$CollisionShape2D2/RooLegs.scale.x
					$CollisionShape2D2/BullCharge.scale.x = -$CollisionShape2D2/BullCharge.scale.x 
					$CollisionShape2D2/BullChargeUp.scale.x = -$CollisionShape2D2/BullChargeUp.scale.x 
					$CollisionShape2D2/RooLegs.position.x -= 15
					faceL = false
		# Handle jump.
		if is_on_floor():
			if(Leg_Type == 0):
				$CollisionShape2D2/AnimationPlayer.play("KangarooJump")
			if(Leg_Type == 2):
				$CollisionShape2D2/AnimationPlayer.play("Crabwalk")
	if prevFacing != faceL and Leg_Type ==1:
		velocity.x = lerp(velocity.x, 0.0, 0.25)
		$CollisionShape2D2/AnimationPlayer.play("BullChargeUp")
		$CollisionShape2D2/BullCharge.visible = false
		$CollisionShape2D2/BullChargeUp.visible = true
		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.

	if not is_on_floor():
		velocity += get_gravity() * delta
	move_and_slide()
var pLeg_Type
func _input(event: InputEvent) -> void:
	if is_in_group("gHitbox"):
		if event.is_action_pressed("LegsOne"):
			Leg_Type = 0
		elif event.is_action_pressed("LegsTwo"):
			Leg_Type = 1
		elif event.is_action_pressed("LegsThree"):
			Leg_Type = 2
	else:
		if event.is_action_pressed("eLegsOne"):
			Leg_Type = 0
		elif event.is_action_pressed("eLegsTwo"):
			Leg_Type = 1
		elif event.is_action_pressed("eLegsThree"):
			Leg_Type = 2
	if Leg_Type == 0 and Leg_Type != pLeg_Type:
		velocity.x = 0
		$CollisionShape2D2/BullCharge.visible = false
		$CollisionShape2D2/BullChargeUp.visible = false
		$CollisionShape2D2/RooLegs.visible = true
		$CollisionShape2D2/CrabLegs.visible = false
	elif Leg_Type == 1 and Leg_Type != pLeg_Type:
		velocity.x = 0
		$CollisionShape2D2/BullChargeUp.visible = true
		$CollisionShape2D2/AnimationPlayer.play("BullChargeUp")
		$CollisionShape2D2/BullCharge.visible = false
		$CollisionShape2D2/RooLegs.visible = false
		$CollisionShape2D2/CrabLegs.visible = false
	elif Leg_Type == 2 and Leg_Type != pLeg_Type:
		velocity.x = 0
		$CollisionShape2D2/BullCharge.visible = false
		$CollisionShape2D2/BullChargeUp.visible = false
		$CollisionShape2D2/RooLegs.visible = false
		$CollisionShape2D2/CrabLegs.visible = true
	pLeg_Type = Leg_Type
	
func chargeReset():
	chargeTimer = 3
	
func _jump():
	if(is_on_floor()):
		velocity.y = JUMP_VELOCITY
		if is_in_group("gHitbox"):
			if get_tree().get_nodes_in_group("eHitbox")[0].global_position.x < global_position.x:
				velocity.x = -SPEED
			else :
				velocity.x = SPEED
		else:
			if get_tree().get_nodes_in_group("gHitbox")[0].global_position.x < global_position.x:
				velocity.x = -SPEED
			else :
				velocity.x = SPEED

func hit(damage: int):
	get_parent().currentHealth -= damage
	if(damage >10):
		freezeFrame(0.03,1)

func freezeFrame(timescale, duration):
	Engine.time_scale = timescale
	get_parent().get_parent().start_screenshake(duration*timescale/2, 8)
	await(get_tree().create_timer(duration*timescale).timeout)
	Engine.time_scale = 1
	
	
func crabRandom():
	if is_in_group("gHitbox"):
		if(!knockback_State):
			if randi() % 4 ==2:
				$CollisionShape2D2/CrabLegs.scale.x = -4.125
				if(get_tree().get_nodes_in_group("eHitbox")[0].global_position.x < global_position.x):
					velocity.x = 1 * (SPEED * 3)
			else:
				$CollisionShape2D2/CrabLegs.scale.x = 4.125
				if(get_tree().get_nodes_in_group("eHitbox")[0].global_position.x > global_position.x):
					velocity.x = -1 * (SPEED * 3)
	else:
		if(!knockback_State):
			if randi() % 4 ==2:
				$CollisionShape2D2/CrabLegs.scale.x = -4.125
				if(get_tree().get_nodes_in_group("gHitbox")[0].global_position.x < global_position.x):
					velocity.x = 1 * (SPEED * 3)
			else:
				$CollisionShape2D2/CrabLegs.scale.x = 4.125
				if(get_tree().get_nodes_in_group("gHitbox")[0].global_position.x > global_position.x):
					velocity.x = -1 * (SPEED * 3)
		

var chargeTimer = 3

func charge():
	chargeTimer -=1
	if chargeTimer > 0:
		if is_in_group("gHitbox"):
			print("goodguycharge")
		else:
			print("badguycharge")
		if faceL == true:
			velocity.x = -1200
		else:
			velocity.x = 1200
		charging = true
		$CollisionShape2D2/AnimationPlayer.play("BullCharge")
		$CollisionShape2D2/BullCharge.visible = true
		$CollisionShape2D2/BullChargeUp.visible = false
	else:
		velocity.x = 0
		$CollisionShape2D2/BullCharge.visible = false
		$CollisionShape2D2/BullChargeUp.visible = true
		$CollisionShape2D2/AnimationPlayer.play("BullChargeUp")
		

func knockback():
	if is_in_group("gHitbox"):
		if(get_tree().get_nodes_in_group("eHitbox")[0].global_position.x < global_position.x):
			velocity.x = KNOCKBACK
		else:
			velocity.x = -KNOCKBACK
		velocity.y = -500
		$Knock.start()
		knockback_State = true
	else :
		if(get_tree().get_nodes_in_group("gHitbox")[0].global_position.x < global_position.x):
			velocity.x = KNOCKBACK
		else:
			velocity.x = -KNOCKBACK
		velocity.y = -500
		$Knock.start()
		knockback_State = true
		
	
func _on_knock_timeout() -> void:
	knockback_State = false
	pass # Replace with function body.
