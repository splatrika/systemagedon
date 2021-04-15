# This file is part of Systemagedon project
# 2021 © Daniil Belov. All rights reserved

class_name PPlayerScoreHUD
extends Control


func push_score(value : int):
	$Label.text = str(value)
