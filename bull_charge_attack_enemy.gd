extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
var bodies

func attack():
	bodies = get_overlapping_bodies()
	for body in bodies:
		if body.is_in_group("gHitbox"):
			body.hit(5)
			body.knockback()
			get_parent().get_node("AnimationPlayer").play("BullChargeUp")
			get_parent().get_node("BullCharge").visible = false
			get_parent().get_node("BullChargeUp").visible = true
			break
