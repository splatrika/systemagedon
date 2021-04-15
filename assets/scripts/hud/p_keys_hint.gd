# This file is part of Systemagedon project
# 2021 © Daniil Belov. All rights reserved

class_name PKeyHints
extends Control


func play_orbit_select():
	$AnimationPlayer.play("orbit_select")


func play_move_planets():
	$AnimationPlayer.play("move_planets")
