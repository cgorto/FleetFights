extends CharacterBody2D

var SPEED = 10
var accel = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_fleet()

func _physics_process(delta):
	handle_movement(delta)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func handle_movement(delta):
	var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var direction = input_dir.normalized()
	if direction:
		velocity.x = lerp(velocity.x,direction.x * SPEED, accel * delta)
		velocity.y = lerp(velocity.y,direction.y * SPEED,accel * delta)
		#Pivot.rotation.y = lerp_angle(Pivot.rotation.y, atan2(direction.x,direction.z)-self.rotation.y,cam_accel*delta)
		#$Pivot.rotate_y(atan2(-direction.x,-direction.z)-$Pivot.rotation.y)
	else:
		velocity.x = lerp(velocity.x,0.0, accel * delta)
		velocity.y = lerp(velocity.y,0.0,accel * delta)

func spawn_fleet():
	for ship in FleetManager.ships:
		$ShipList.add_item(ship.ship_name,ship.icon)
		
		add_child(ship)
		#Vector2(randf_range(-5,-5),randf_range(-5,5))
		



