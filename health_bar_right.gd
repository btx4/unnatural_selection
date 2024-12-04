extends Control  # Use Control if you want it in the UI

# Health variables
var max_health: float = 100
var current_health: float = 100

# Health bar dimensions
var bar_width: float = 450.0
var bar_height: float = 30.0
var bar_color_full: Color = Color.GREEN
var bar_color_empty: Color = Color.RED

# Trapezoid skew factor (adjust to control the slant of the trapezoid)
var skew_factor: float = 10.0

# Draw the health bar based on current health
func _draw():
	# Calculate the width based on current health
	var health_ratio = current_health / max_health
	var current_bar_width = bar_width * health_ratio

	# Points for the empty (background) trapezoid
	var empty_points = [
		Vector2(0, 0),  # Top-left
		Vector2(bar_width, 0),  # Top-right
		Vector2(bar_width + skew_factor, bar_height),  # Bottom-right (skewing rightward)
		Vector2(skew_factor, bar_height)  # Bottom-left (skewing leftward)
	]
	
	# Points for the full (current health) trapezoid
	var full_points = [
		Vector2(0, 0),  # Top-left
		Vector2(current_bar_width, 0),  # Top-right
		Vector2(current_bar_width + skew_factor, bar_height),  # Bottom-right (skewing rightward)
		Vector2(skew_factor, bar_height)  # Bottom-left (skewing leftward)
	]
	
	# Draw the empty (background) trapezoid
	draw_polygon(empty_points, [bar_color_empty])
	
	# Draw the full (current health) trapezoid
	draw_polygon(full_points, [bar_color_full])

# Update the health bar every time health changes
func set_health(new_health: float):
	current_health = clamp(new_health, 0, max_health)
	queue_redraw()  # Triggers _draw() to refresh the health bar
