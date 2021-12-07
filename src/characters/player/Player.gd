class_name Player extends Character

var attacking: bool
onready var gun: Gun = $Body/Wings/Gun

func _ready() -> void:
	$Body/Sprite.frame = 0

func _physics_process(_delta: float) -> void:
	if is_on_floor() and Input.is_action_pressed("attack"):
		attacking = true
		$Body/Wings.visible = true
	else:
		attacking = false
		$Body/Wings.visible = false

	if attacking:
		gun.use((Vector2($Body.scale.x, 0)))


func _on_gun_shoot(bullet) -> void:
	get_parent().add_child(bullet)
	$Shoot.play()
