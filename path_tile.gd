extends Node2D


func add_enemy(enemy: Enemy):
	if enemy is Enemy:
		add_child(enemy)


func get_enemy():
	if get_child_count() > 0:
		return get_child(0)
	else:
		return null


func remove_enemies():
	for child in get_children():
		remove_child(child)


func enemies_take_damage(damage):
	for child in get_children():
		child.take_damage(damage)
