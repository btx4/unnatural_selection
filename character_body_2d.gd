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
var started = false

func _ready() -> void:
	$Hitflash.play("HF")
	
func _physics_process(delta: float) -> void:
	if abs(velocity.x ) < 200:
		$CollisionShape2D2/Dustcloud.emitting = false
	if started == true:
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
		$"Smoke Bomb".restart()
		$CollisionShape2D2/BullCharge.visible = false
		$CollisionShape2D2/BullChargeUp.visible = false
		$CollisionShape2D2/RooLegs.visible = true
		$CollisionShape2D2/CrabLegs.visible = false
		get_parent().get_node("Poof").play()
		$CollisionShape2D2/AnimationPlayer.stop()
	elif Leg_Type == 1 and Leg_Type != pLeg_Type:
		$"Smoke Bomb".restart()
		$CollisionShape2D2/BullChargeUp.visible = true
		$CollisionShape2D2/BullCharge.visible = false
		$CollisionShape2D2/RooLegs.visible = false
		$CollisionShape2D2/CrabLegs.visible = false
		$CollisionShape2D2/AnimationPlayer.stop()
		$CollisionShape2D2/AnimationPlayer.play("BullChargeUp")
		get_parent().get_node("Poof").play()
	elif Leg_Type == 2 and Leg_Type != pLeg_Type:
		$"Smoke Bomb".restart()
		$CollisionShape2D2/BullCharge.visible = false
		$CollisionShape2D2/BullChargeUp.visible = false
		$CollisionShape2D2/RooLegs.visible = false
		$CollisionShape2D2/CrabLegs.visible = true
		$CollisionShape2D2/AnimationPlayer.stop()
		get_parent().get_node("Poof").play()
	pLeg_Type = Leg_Type
	
func chargeReset():
	chargeTimer = 8
	
func chargeUp():
	if is_on_floor():
		if velocity.x != 0:
			velocity.x = lerp(velocity.x, 0.0, 1)
		
func _jump():
	if(is_on_floor()):
		velocity.y = JUMP_VELOCITY
		if is_in_group("gHitbox"):
			if get_tree().get_nodes_in_group("eHitbox")[0].global_position.x < global_position.x: #if enemy is left
				if velocity.x > -SPEED: #if speed is right
					velocity.x = -SPEED #make speed left
			else :
				if velocity.x < SPEED: #if speed is left
					velocity.x = SPEED
		else:
			if get_tree().get_nodes_in_group("gHitbox")[0].global_position.x < global_position.x:
				if velocity.x > -SPEED: #if speed is right
					velocity.x = -SPEED #make speed left
			else :
				if velocity.x < SPEED: #if speed is left
					velocity.x = SPEED

func hit(damage: int):
	get_parent().currentHealth -= damage
	$Hitflash.play("HF")
	if(damage >10):
		$Hit.play()
		freezeFrame(0.03,.7)

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
		

var chargeTimer = 8

func charge():
	$CollisionShape2D2/Dustcloud.emitting = true
	chargeTimer -=1
	if chargeTimer > 0:
		if faceL == true:
			velocity.x = -800
		else:
			velocity.x = 800
		charging = true
		$CollisionShape2D2/AnimationPlayer.play("BullCharge")
		$CollisionShape2D2/BullCharge.visible = true
		$CollisionShape2D2/BullChargeUp.visible = false
	else:
		velocity.x = 0
		$CollisionShape2D2/Dustcloud.emitting = false
		print("STOPPED")
		$CollisionShape2D2/BullCharge.visible = false
		$CollisionShape2D2/BullChargeUp.visible = true
		$CollisionShape2D2/AnimationPlayer.play("BullChargeUp")
		chargeTimer = 8
		

func knockback(type: int):
	if charging == true:
		charging = false
	if is_in_group("gHitbox"):
		if(type == 0):
			if(get_tree().get_nodes_in_group("eHitbox")[0].global_position.x < global_position.x):
				velocity.x = KNOCKBACK
			else:
				velocity.x = -KNOCKBACK
			velocity.y = -500
			$Knock.start()
			knockback_State = true
	else :
		if(type == 0):
			if(get_tree().get_nodes_in_group("gHitbox")[0].global_position.x < global_position.x):
				velocity.x = KNOCKBACK
			else:
				velocity.x = -KNOCKBACK
			velocity.y = -500
			$Knock.start()
			knockback_State = true
	if type == 1:
		velocity.y = -700
	
func _on_knock_timeout() -> void:
	knockback_State = false
	pass # Replace with function body.
