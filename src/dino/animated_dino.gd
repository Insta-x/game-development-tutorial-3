extends CharacterBody2D


@onready var anger_audio: AudioStreamPlayer2D = $AngerAudio


func _on_anger_area_body_entered(body: Node2D) -> void:
	anger_audio.play()
