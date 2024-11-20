extends Control

"""
var max_health
var current_health 

@onready var health_bar = $ColorRect/ColorRect

func _ready():
	update_health_bar()

func set_current_health(value: int):
	current_health = clamp(value, 0, max_health)
	update_health_bar()

func update_health_bar():
	var health_ratio = float(current_health) / max_health
	health_bar.size_flags_horizontal = 0  # Ensure the bar's size is controlled via `rect_size`
	health_bar.rect_size.x = health_ratio * rect_size.x
"""
