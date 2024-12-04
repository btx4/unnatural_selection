extends RigidBody2D
var Head_Type = 0
var All_Heads = 2
var pHead_Type = 0
var spit_scene = preload("res://spit.tscn")
var started = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	gravity_scale = -7
	pass # Replace with function body.
var faceL = true
var isDead = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if started == true:
		if !isDead:
			if(is_in_group("gHitbox")):
				if(get_tree().get_nodes_in_group("eHitbox")[0].global_position.x < global_position.x - 15):
					if faceL == false:
						$CollisionShape2D2/LlamaHead.scale.x = -$CollisionShape2D2/LlamaHead.scale.x
						$CollisionShape2D2/Giraffe.scale.x = -$CollisionShape2D2/Giraffe.scale.x
						$CollisionShape2D2/OrcaHead.scale.x = -$CollisionShape2D2/OrcaHead.scale.x
						faceL = true
				else:
					if faceL == true:
						$CollisionShape2D2/LlamaHead.scale.x = -$CollisionShape2D2/LlamaHead.scale.x
						$CollisionShape2D2/Giraffe.scale.x = -$CollisionShape2D2/Giraffe.scale.x
						$CollisionShape2D2/OrcaHead.scale.x = -$CollisionShape2D2/OrcaHead.scale.x
						faceL = false
			else:
				if(get_tree().get_nodes_in_group("gHitbox")[0].global_position.x < global_position.x - 15):
					if faceL == false:
						$CollisionShape2D2/LlamaHead.scale.x = -$CollisionShape2D2/LlamaHead.scale.x
						$CollisionShape2D2/Giraffe.scale.x = -$CollisionShape2D2/Giraffe.scale.x
						$CollisionShape2D2/OrcaHead.scale.x = -$CollisionShape2D2/OrcaHead.scale.x
						faceL = true
				else:
					if faceL == true:
						$CollisionShape2D2/LlamaHead.scale.x = -$CollisionShape2D2/LlamaHead.scale.x
						$CollisionShape2D2/Giraffe.scale.x = -$CollisionShape2D2/Giraffe.scale.x
						$CollisionShape2D2/OrcaHead.scale.x = -$CollisionShape2D2/OrcaHead.scale.x
						faceL = false
					
			if Head_Type == 0:
				$CollisionShape2D2/AnimationPlayer.play("alpaca_spit")
			elif Head_Type == 1:
				$CollisionShape2D2/AnimationPlayer.play("giraffe_attack")
			elif Head_Type == 2:
				$CollisionShape2D2/AnimationPlayer.play("orcablast")
			pass

var AttackDirection = Vector2(-1, 0)
var enemyposition

func _spit_fire():
	var instance = spit_scene.instantiate()
	get_parent().get_parent().add_child(instance)
	instance.global_position = $CollisionShape2D2/LlamaMouth.global_position
	if is_in_group("gHitbox"):
		enemyposition = get_tree().get_nodes_in_group("eHitbox")[0].global_position
		AttackDirection = (enemyposition - $CollisionShape2D2/LlamaMouth.global_position).normalized()
		instance.fire(AttackDirection, 350,0)
	else :
		enemyposition = get_tree().get_nodes_in_group("gHitbox")[0].global_position
		AttackDirection = (enemyposition - $CollisionShape2D2/LlamaMouth.global_position).normalized()
		instance.fire(AttackDirection, 350,1)

func _input(event: InputEvent) -> void:
	if is_in_group("gHitbox"):
		if event.is_action_pressed("HeadOne"):
			Head_Type = 0
		if event.is_action_pressed("HeadTwo"):
			Head_Type = 1
		if event.is_action_pressed("HeadThree"):
			Head_Type = 2
	else:
		if event.is_action_pressed("eHeadOne"):
			Head_Type = 0
		if event.is_action_pressed("eHeadTwo"):
			Head_Type = 1
		if event.is_action_pressed("eHeadThree"):
			Head_Type = 2
		
	if Head_Type == 0:
		$CollisionShape2D2/LlamaHead.visible = true
		$CollisionShape2D2/Giraffe.visible = false
		$CollisionShape2D2/OrcaHead.visible = false
	elif Head_Type == 1:
		$CollisionShape2D2/LlamaHead.visible = false
		$CollisionShape2D2/Giraffe.visible = true
		$CollisionShape2D2/OrcaHead.visible = false
	elif Head_Type == 2:
		$CollisionShape2D2/OrcaHead.visible = true
		$CollisionShape2D2/LlamaHead.visible = false
		$CollisionShape2D2/Giraffe.visible = false
	if pHead_Type != Head_Type:
		$"Smoke Bomb".restart()
		get_parent().get_node("Poof")
	pHead_Type = Head_Type
		
func giraffeAttack():
	if is_in_group("gHitbox"):
		print("GG_GiraffeAttac")
	else:
		print("Enemy_GiraffeAttac")
	if faceL == true:
		$CollisionShape2D2/GiraffeAttackL.attack()
	else:
		$CollisionShape2D2/GiraffeAttackR.attack()

func endGiraffeAttack():
	#print("EndGiraffeAttack")
	if faceL == true:
		$CollisionShape2D2/GiraffeAttackR.isActive = false
	else:
		$CollisionShape2D2/GiraffeAttackL.isActive = false

func blast():
	$blastMiddle.blast()
	$GeyserBlast.attack()
	get_parent().get_node("geysers").blast()

func hit(damage: int):
	get_parent().get_node("Legs").hit(damage)
	
func knockback(type: int):
	get_parent().get_node("Legs").knockback(type)
