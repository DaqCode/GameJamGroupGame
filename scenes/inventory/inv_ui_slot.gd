extends Panel

@onready var item_display = $CenterContainer/Panel/ItemDisplay
@onready var item_visuals: Sprite2D = item_display
@onready var amount_display: Label = $CenterContainer/Panel/Label


func update(slot: InvSlot):
	if !slot.item:
		item_visuals.visible = false
		amount_display.visible = false
	else:
		item_visuals.visible = true
		item_visuals.texture = slot.item.texture
		item_visuals.scale = Vector2(0.5,0.5)
		if slot.amount > 1:
			amount_display.visible = true
		amount_display.text = str(slot.amount)

		
