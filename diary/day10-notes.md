# Diagonal movement not normalized - test

## Node 1 script - moving superfast diagonally

```python
extends RigidBody2D

func _physics_process(delta):
	var movement_vec = Vector2(1, -1) # not normalized, will result in movement over a longer distance
	position += movement_vec
```

## Node 2 script - moving at normal speed diagonally

```python
extends RigidBody2D

func _physics_process(delta):
	var movement_vec = Vector2(1, -1)
	movement_vec = movement_vec.normalized() # normalized, will match movement distance with Nodes moving in a single direction
	position += movement_vec
```

## Node 3 script - moving only upwards

```python
extends RigidBody2D

func _physics_process(delta):
	var movement_vector
	movement_vector = Vector2(0, -1) # already is normalized
	position += movement_vector
```


## Node 4 script - moving only rightwards

```python
extends RigidBody2D

func _physics_process(delta):
	var movement_vector
	movement_vector = Vector2(1, 0) # already is normalized		
	position += movement_vector
```


# Diagonal movement with direction_to is normalized - test

## Node 1 script - node moving diagonally

```python
extends RigidBody2D

@onready var target = Vector2(position.x + 316, position.y - 316)

var speed = 0.5

func _physics_process(delta):
	var velocity = position.direction_to(target) * speed # direction vector * speed is called velocity
	position += velocity
```

## Node 2 script - node moving rightwards

```python
extends RigidBody2D

@onready var target = Vector2(position.x + 316, position.y)

var speed = 0.5

func _physics_process(delta):
	var direction = position.direction_to(target)
	var velocity = direction.normalized() * speed # direction vector * speed is called velocity
	position += velocity
```