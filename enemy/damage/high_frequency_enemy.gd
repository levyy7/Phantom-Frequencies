class_name HighFrequencyEnemy extends DamageHandler


func take_damage(hp: int, amount: Damage) -> int:
	hp -= amount.damage
	hp = max(hp, 0)
	
	return hp
