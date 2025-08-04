extends Node3D

var _hit = false;


func _process(_delta: float) -> void:
	$AmmoLabel.text = "Ammo: %d" % $Cannon.ammo
	
	if not _hit and $Cannon.ammo == 0:
		$EndButton.visible = true
		$HitLabel.text = "Try Again!"


func _on_crown_body_entered(_body: Node) -> void:
	if not _hit:
		$MetalHit.play()
		$GlassShatter.play()
	$HitLabel.visible = true
	$EndButton.visible = true
	$HitLabel.text = "Hit!!!!"
	$Crown.gravity_scale=1
	print("test")
	$CrownLight.visible=false
	_hit = true;


func _on_end_button_pressed() -> void:
	get_tree().change_scene_to_file("res://main_menu.tscn")
