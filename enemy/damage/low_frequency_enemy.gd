class_name LowFrequencyEnemy extends DamageHandler

var cutoff = 660.0 # below 7/12 pass (perfect fifth)
var color = Color.ROSY_BROWN
func take_damage(hp: int, amount: Damage) -> int:
	if(amount.freq.frequency<cutoff):
		hp -= amount.damage
		hp = max(hp, 0)
	
	return hp
