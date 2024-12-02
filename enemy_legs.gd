extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -800.0
var Leg_Type = 0
var All_Legs = 3
var faceL = false
var isDead = false
var knockback_State = false
var test = true
var KNOCKBACK = 1000
var charging = false
var prevFacing = faceL

func _physics_process(delta: float) -> void:
	prevFacing = faceL
	if !isDead and !knockback_State:
		if(get_tree().get_nodes_in_group("gHitbox")[0].global_position.x < global_position.x and is_on_floor()):
			if faceL == false:
				$CollisionShape2D/RooLegs.scale.x = -$CollisionShape2D/RooLegs.scale.x 
				$CollisionShape2D/BullCharge.scale.x = -$CollisionShape2D/BullCharge.scale.x 
				$CollisionShape2D/BullChargeUp.scale.x = -$CollisionShape2D/BullChargeUp.scale.x 
				$CollisionShape2D/RooLegs.position.x += 15
				print("FLIP")
				faceL = true
			if(Leg_Type== 0):
				velocity.x = -1 * SPEED
		elif is_on_floor():
			if(Leg_Type == 0):
				velocity.x = SPEED
			if faceL == true:
				print("FLIP")
				$CollisionShape2D/RooLegs.scale.x = -$CollisionShape2D/RooLegs.scale.x
				$CollisionShape2D/BullCharge.scale.x = -$CollisionShape2D/BullCharge.scale.x 
				$CollisionShape2D/BullChargeUp.scale.x = -$CollisionShape2D/BullChargeUp.scale.x 
				$CollisionShape2D/RooLegs.position.x -= 15
				faceL = false
			
		
		# Handle jump.
		if is_on_floor():
			if(Leg_Type == 0):
				#print("Jump")
				$CollisionShape2D/AnimationPlayer.play("KangarooJump")
			if(Leg_Type == 2):
				$CollisionShape2D/AnimationPlayer.play("Crabwalk")
	if prevFacing != faceL and Leg_Type ==1:
		if is_on_floor():
			velocity.x = lerp(velocity.x, 0.0, 0.25)
			$CollisionShape2D/AnimationPlayer.play("BullChargeUp")
		$CollisionShape2D/BullCharge.visible = false
		$CollisionShape2D/BullChargeUp.visible = true
		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.

	if not is_on_floor():
		velocity += get_gravity() * delta
	move_and_slide()

var pLeg_Type
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("eLegsOne"):
		Leg_Type = 0
	elif event.is_action_pressed("eLegsTwo"):
		Leg_Type = 1
	elif event.is_action_pressed("eLegsThree"):
		Leg_Type = 2
	if Leg_Type == 0 and Leg_Type != pLeg_Type:
		velocity.x = 0
		$CollisionShape2D/BullCharge.visible = false
		$CollisionShape2D/BullChargeUp.visible = false
		$CollisionShape2D/RooLegs.visible = true
		$CollisionShape2D/CrabLegs.visible = false
	elif Leg_Type == 1 and Leg_Type != pLeg_Type:
		velocity.x = 0
		$CollisionShape2D/BullChargeUp.visible = true
		$CollisionShape2D/AnimationPlayer.play("BullChargeUp")
		$CollisionShape2D/BullCharge.visible = false
		$CollisionShape2D/RooLegs.visible = false
		$CollisionShape2D/CrabLegs.visible = false
	elif Leg_Type == 2 and Leg_Type != pLeg_Type:
		velocity.x = 0
		$CollisionShape2D/BullCharge.visible = false
		$CollisionShape2D/BullChargeUp.visible = false
		$CollisionShape2D/RooLegs.visible = false
		$CollisionShape2D/CrabLegs.visible = true
	pLeg_Type = Leg_Type


func _jump():
	if(is_on_floor()):
		velocity.y = JUMP_VELOCITY

func hit(damage: int):
	print("Hit")
	get_parent().currentHealth -= damage
	if(damage >10):
		freezeFrame(0.03,1)

func freezeFrame(timescale, duration):
	print("KABOOOM")
	Engine.time_scale = timescale
	get_parent().get_parent().start_screenshake(duration*timescale/2, 8)
	await(get_tree().create_timer(duration*timescale).timeout)
	Engine.time_scale = 1

func knockback():
	print("LEGSHIT")
	velocity.y = -500
	if(get_tree().get_nodes_in_group("gHitbox")[0].global_position.x < global_position.x):
		velocity.x = KNOCKBACK
	else:
		velocity.x = -KNOCKBACK
	$Knock.start(0.5)
	knockback_State = true

func charge():
	if faceL == true:
		velocity.x = -1200
	else:
		velocity.x = 1200
	charging = true
	$CollisionShape2D/AnimationPlayer.play("BullCharge")
	$CollisionShape2D/BullCharge.visible = true
	$CollisionShape2D/BullChargeUp.visible = false


func crabRandom():
	if !isDead and !knockback_State:
		if randi() % 4 ==2:
			print("LEF")
			$CollisionShape2D/CrabLegs.scale.x = -4.125
			if(get_tree().get_nodes_in_group("gHitbox")[0].global_position.x < global_position.x):
				velocity.x = 1 * (SPEED * 5)
		else:
			$CollisionShape2D/CrabLegs.scale.x = 4.125
			if(get_tree().get_nodes_in_group("gHitbox")[0].global_position.x > global_position.x):
				velocity.x = -1 * (SPEED * 5)


func _on_knock_timeout() -> void:
	print("WOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO")
	knockback_State = false
	pass # Replace with function body.
