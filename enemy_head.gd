extends RigidBody2D
var Head_Type = 0
var All_Heads = 2
var isDead = false
var spit_scene = preload("res://spit.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	gravity_scale = -7
	pass # Replace with function body.
var faceL = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(isDead == false):
		if(get_tree().get_nodes_in_group("gHitbox")[0].global_position.x < global_position.x - 15):
			if faceL == true:
				$CollisionShape2D2/LlamaHead.scale.x = -$CollisionShape2D2/LlamaHead.scale.x
				$CollisionShape2D2/Giraffe.scale.x = - $CollisionShape2D2/Giraffe.scale.x
				faceL = false
		else:
			if faceL == false:
				$CollisionShape2D2/LlamaHead.scale.x = -$CollisionShape2D2/LlamaHead.scale.x
				$CollisionShape2D2/Giraffe.scale.x = - $CollisionShape2D2/Giraffe.scale.x
				faceL = true
				
		if Head_Type == 0:
			$CollisionShape2D2/AnimationPlayer.play("alpaca_spit")
		elif Head_Type == 1:
			$CollisionShape2D2/AnimationPlayer.play("giraffe_attack")
		pass

var AttackDirection = Vector2(-1, 0)
var enemyposition

func _spit_fire():
	var instance = spit_scene.instantiate()
	get_parent().get_parent().add_child(instance)
	instance.global_position = $CollisionShape2D2/LlamaMouth.global_position
	enemyposition = get_parent().get_parent().get_node("Freak One/CHEST").global_position
	AttackDirection = (enemyposition - $CollisionShape2D2/LlamaMouth.global_position).normalized()

	instance.fire(AttackDirection, 350,1)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("eHeadOne"):
		Head_Type = 0
	if event.is_action_pressed("eHeadTwo"):
		Head_Type = 1
		
	if Head_Type == 0:
		$CollisionShape2D2/LlamaHead.visible = true
		$CollisionShape2D2/Giraffe.visible = false
	elif Head_Type == 1:
		$CollisionShape2D2/LlamaHead.visible = false
		$CollisionShape2D2/Giraffe.visible = true
		


func giraffeAttack():
	#print("GiraffeAttack")
	if faceL == true:
		$CollisionShape2D2/GiraffeAttackR.attack()
	else:
		$CollisionShape2D2/GiraffeAttackL.attack()

func endGiraffeAttack():
	#print("EndGiraffeAttack")
	if faceL == true:
		$CollisionShape2D2/GiraffeAttackR.isActive = false
	else:
		$CollisionShape2D2/GiraffeAttackL.isActive = false

func hit(damage: int):
	get_parent().get_node("Legs").hit(damage)

func knockback():
	print("CHESHIT")
	get_parent().get_node("Legs").knockback()
