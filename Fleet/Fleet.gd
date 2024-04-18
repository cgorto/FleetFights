extends CharacterBody2D

var SPEED = 500
var accel = 5

# Called when the node enters the scene tree for the first time.

func _ready():
	spawn_fleet()

func _physics_process(delta):
	handle_movement(delta)
	move_and_slide()

	#for ship in FleetManager.ships:
		#ship.calculate_boid_steering()
		#ship.move_and_slide()

func _process(delta):
	pass


## Handles WASD movement and updates velocity
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


## Spawns the entire fleet held in the fleet manager
func spawn_fleet():
	for ship in FleetManager.ships:
		if ship.get_parent():
			ship.get_parent().remove_child(ship)
		add_child(ship)
		$ShipList.add_item(ship.ship_name,ship.icon)
		ship.add_to_group("InFleet")
		ship.position = Vector2(randf_range(-100,100),randf_range(-100,100))
		





func _on_button_pressed():
	var children = get_children()
	for child in children:
		if child is Ship:
			var grand_children = child.get_children()
			for gc in grand_children:
				print(gc.name)
