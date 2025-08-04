extends RigidBody3D

signal state_changed


func _ready() -> void:
	$CPUParticles3D.emitting=true


func _on_sleeping_state_changed() -> void:
	state_changed.emit()
