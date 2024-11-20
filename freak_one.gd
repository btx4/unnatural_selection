extends Node2D
var MaxHealth = 100
var currentHealth = 100
var dead = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	get_parent().get_node("HealthBarLeft").set_health(currentHealth)
	if currentHealth <= 0 and dead == false:
		die()
	pass


func die():
	$Legs.isDead = true
	$CHEST.isDead = true
	$Head.isDead = true
	$Legs/PinJoint2D.queue_free()
	$CHEST/PinJoint2D.queue_free()
	$Legs/CollisionShape2D2/AnimationPlayer.stop()
	$Head/CollisionShape2D2/AnimationPlayer.stop()
	$CHEST.gravity_scale = 1
	$Head.gravity_scale = 1
	dead = true
