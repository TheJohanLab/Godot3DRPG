extends Control

@onready var healthBar = get_node("HealthBar")
@onready var goldText = get_node("GoldText")

func updateHealthBar(currHp, maxHp):
	healthBar.value = (100 / maxHp) * currHp
	
func updateGoldText(gold):
	goldText.text = "Gold: " + str(gold)

