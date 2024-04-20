extends CharacterBody2D

var SPEED: float = 500
var accel:float = 5

# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	spawn_fleet()

func _physics_process(delta) -> void:
	handle_movement(delta)
	move_and_slide()

	#for ship in FleetManager.ships:
		#ship.calculate_boid_steering()
		#ship.move_and_slide()


## Handles WASD movement and updates velocity
func handle_movement(delta) -> void:
	var input_dir:Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var direction:Vector2 = input_dir.normalized()
	if direction:
		velocity.x = lerp(velocity.x,direction.x * SPEED, accel * delta)
		velocity.y = lerp(velocity.y,direction.y * SPEED,accel * delta)
		#Pivot.rotation.y = lerp_angle(Pivot.rotation.y, atan2(direction.x,direction.z)-self.rotation.y,cam_accel*delta)
		#$Pivot.rotate_y(atan2(-direction.x,-direction.z)-$Pivot.rotation.y)
	else:
		velocity.x = lerp(velocity.x,0.0, accel * delta)
		velocity.y = lerp(velocity.y,0.0,accel * delta)


## Spawns the entire fleet held in the fleet manager
func spawn_fleet() -> void:
	for ship in FleetManager.ships:
		if ship.get_parent():
			ship.get_parent().remove_child(ship)
		add_child(ship)
		$ShipList.add_item(ship.ship_name,ship.icon)
		ship.add_to_group("InFleet")
		ship.position = Vector2(randf_range(-100,100),randf_range(-100,100))
		

