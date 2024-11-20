extends Control  # Use Control if you want it in the UI

# Health variables
var max_health: float = 100
var current_health: float = 100

# Health bar dimensions
var bar_width: float = 180.0
var bar_height: float = 10.0
var bar_color_full: Color = Color.GREEN
var bar_color_empty: Color = Color.RED

# Draw the health bar based on current health
func _draw():
	# Calculate the width based on current health
	var health_ratio = current_health / max_health
	var current_bar_width = bar_width * health_ratio

	# Draw the background (empty health)
	draw_rect(Rect2(Vector2(0, 0), Vector2(bar_width, bar_height)), bar_color_empty)

	# Draw the current health (starting from the right side)
	var start_position = Vector2(bar_width - current_bar_width, 0)
	draw_rect(Rect2(start_position, Vector2(current_bar_width, bar_height)), bar_color_full)

# Update the health bar every time health changes
func set_health(new_health: float):
	current_health = clamp(new_health, 0, max_health)
	queue_redraw()  # Triggers _draw() to refresh the health bar
