class_name HighFrequencyEnemy extends DamageHandler

var cutoff = 660.0 # 7/12 and bove pass (perfect fifth)
var color = Color.NAVY_BLUE
func take_damage(hp: int, amount: Damage) -> int:
	if(amount.freq.frequency>=cutoff):
		hp -= amount.damage
		hp = max(hp, 0)
	
	return hp
