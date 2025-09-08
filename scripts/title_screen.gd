extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _on_button_pressed() -> void:
	animation_player.play("fadeOut")

func startIntro():
	
	get_tree().change_scene_to_file("res://ui/intro_cutscene.tscn")
