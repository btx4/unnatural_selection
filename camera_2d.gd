extends Camera2D

@export var zoom_out_threshold = 100  # Threshold for diffY to trigger zoom out
@export var zoom_out_threshold2_x = 2000  # Threshold for diffY to trigger zoom out
@export var zoom_out_threshold_x = 1300  # Threshold for diffY to trigger zoom out
@export var min_zoom = Vector2(1, 1)  # Default zoom level
@export var mid_zoom = Vector2(.75, .75)  # Zoom out level
@export var max_zoom = Vector2(.3, .3)  # Zoom out level
@export var zoom_speed = 5         # Speed of zoom transition
var notDead = true
var freak
func _ready() -> void:
	$Music.play(Progress.musicProgress)
		
func _process(delta):
	# Get positions
	if(notDead):
		var enemy = get_parent().get_node("Freak One2/Legs").global_position
		var friend = get_parent().get_node("Freak One/Legs").global_position
		
		# Calculate difference in Y and midpoint
		var diffY = abs(enemy.y - friend.y)
		var diffX = abs(enemy.x - friend.x)
		position = (enemy + friend) / 2
		
		# Adjust zoom based on diffY
		if diffY > zoom_out_threshold2_x or diffX >zoom_out_threshold2_x:
			zoom = lerp(zoom, max_zoom, delta * zoom_speed)
		elif diffY > zoom_out_threshold or diffX >zoom_out_threshold_x:
			zoom = lerp(zoom, mid_zoom, delta * zoom_speed)
		else:
			zoom = lerp(zoom, min_zoom, delta * zoom_speed)
	else:
		if freak == 1:
			global_position = get_parent().get_node("Freak One/CHEST").global_position
		else:
			global_position = get_parent().get_node("Freak One2/CHEST").global_position
func changeVis():
	if get_parent().get_node("Freak One2").dead == false:
		lerp(position, get_parent().get_node("Freak One2/CHEST").position, .5)
		freak = 2
	if get_parent().get_node("Freak One").dead == false:
		lerp(position, get_parent().get_node("Freak One/CHEST").position, .5)
		freak = 1
	notDead = false
	$"Restart Timer".start()
