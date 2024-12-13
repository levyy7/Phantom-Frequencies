class_name PathTile
extends Node2D


func add_enemy(enemy: Enemy):
	if enemy is Enemy:
		add_child(enemy)


func get_enemy() -> Enemy:
	if get_child_count() > 0:
		var possible_enemy := get_child(0) as Enemy
		if possible_enemy.dead:
			return null
		return possible_enemy
	else:
		return null


func remove_enemies():
	for child in get_children():
		remove_child(child)


func enemies_take_damage(damage):
	for child in get_children():
		child.take_damage(damage)
