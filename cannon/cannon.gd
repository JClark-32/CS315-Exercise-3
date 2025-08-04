extends Node3D

signal fired
signal cannon_ready

@export var ammo := 4
@export var power := 25.0
var _direction_change_rate := 5
var _launched := false
var _time_now := 0.0
var _fired_time_start := 0.0


func _process(delta) -> void:
	_time_now = Time.get_unix_time_from_system()

	if Input.is_action_pressed("pitch_up"):
		$CannonBody.rotation.x += _direction_change_rate * delta/2
	if Input.is_action_pressed("pitch_down"):
		$CannonBody.rotation.x -= _direction_change_rate * delta/2
	if Input.is_action_pressed("turn_left"):
		rotation.y += _direction_change_rate * delta /4
	if Input.is_action_pressed("turn_right"):
		rotation.y -= _direction_change_rate * delta /4
		
	$CannonBody.rotation.x = clamp($CannonBody.rotation.x, -1.5, 1.5)

	if Input.is_action_just_pressed("fire"):
		if _launched == false and ammo > 0:
			_fired_time_start = Time.get_unix_time_from_system()
			fired.emit()
			var Ball : RigidBody3D = preload("res://cannon/ball/ball.tscn").instantiate()
			get_parent().add_child(Ball)
			Ball.global_position=$CannonBody.global_position
			var forward : Vector3 = $CannonBody.get_global_transform().basis.y
			Ball.apply_impulse(forward * power)
			_launched = true
			
	if _launched and _time_now - _fired_time_start > .25:
		$CannonBody/OmniLight3D.visible = false
		$CannonBody/MuzzleFlash.visible = false
	if _time_now - _fired_time_start > 4:
		_launched = false


func _on_fired() -> void:
	$AudioStreamPlayer.play()
	$CannonBody/OmniLight3D.visible=true
	$CannonBody/MuzzleFlash.visible=true
	ammo -= 1
	ammo = clamp(ammo, 0, ammo)


func _on_ball_sleeping_state_changed() -> void:
	cannon_ready.emit()
	_launched = false
