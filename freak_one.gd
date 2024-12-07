extends Node2D
var MaxHealth = 100
var currentHealth = 100
var dead = false
# Called when the node enters the scene tree for the first time.
var children
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_in_group("good_guy"):
		get_parent().get_node("CanvasLayer/HealthBarLeft").set_health(currentHealth)
		if currentHealth <= 0 and dead == false:
			die()
	else :
		get_parent().get_node("CanvasLayer/HealthBarRight").set_health(currentHealth)
		if currentHealth <= 0 and dead == false:
			die()
	pass

func start(): 
	$Legs.started = true
	$Head.started = true
	
func die():
	$Legs.isDead = true
	$CHEST.isDead = true
	$Head.isDead = true
	$Legs/PinJoint2D.queue_free()
	$CHEST/PinJoint2D.queue_free()
	$Legs/CollisionShape2D2/AnimationPlayer.stop()
	$Head/CollisionShape2D2/AnimationPlayer.stop()
	$CHEST/Human_Collision/AnimationPlayer.stop()
	$CHEST.gravity_scale = 1
	$Head.gravity_scale = 1
	get_parent().get_node("Camera2D").changeVis()
	dead = true
