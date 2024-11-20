extends CollisionShape2D
var animalType = 1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if animalType == 0:
		$AnimationPlayer.play("alpaca_spit")
	pass

var left_direction = Vector2(-1, 0)

func _spit_fire():
	print("FIRING")
	var instance = spit_scene.instantiate()
	get_parent().get_parent().add_child(instance)
	instance.global_position = $LlamaMouth.global_position
	
	instance.fire(left_direction, 200)
	print(instance.global_position)
