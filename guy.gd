extends Sprite2D

var base_y: float = 0.0 # The original Y position
var amplitude: float = 20.0 # How far it bobs up and down
var speed: float = 2.0 # How fast it bobs
var time: float = 0.0 # Keeps track of the elapsed time

func _ready() -> void:
	base_y = position.y + randi()%30 - 15 # Store the starting Y position
	# Assign a random color to the sprite
	modulate = Color(randf(), randf(), randf(), 1.0) 
	time = randf() * TAU # Set a random starting point in the sine wave (0 to 2π)

func _process(delta: float) -> void:
	time += delta * speed # Update time based on the speed
	position.y = base_y + sin(time) * amplitude # Adjust Y position
