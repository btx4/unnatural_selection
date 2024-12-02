extends Node2D
var NUM_TARGETS = 4
var targets = NUM_TARGETS

var shake_intensity = 5.0  # How strong the shake is
var shake_duration = 0.5  # How long the shake lasts in seconds
var original_position = Vector2()  # To store the original position before shaking
var shake_timer = 0.0  # Internal timer to track shake duration

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	original_position = position  # Store the original position
	set_process(false)  # Disable process unless shaking
	pass # Replace with function body.

func start_screenshake(duration: float, intensity: float):
	shake_duration = duration
	shake_intensity = intensity
	shake_timer = shake_duration
	set_process(true)  # Enable processing to start shaking

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if shake_timer > 0:
		shake_timer -= delta

		# Apply random offset within the intensity range
		position = original_position + Vector2(
			randf_range(-shake_intensity, shake_intensity),
			randf_range(-shake_intensity, shake_intensity)
		)
	else:
		# Reset position after shaking
		position = original_position
		set_process(false)  # Stop shaking once timer ends
