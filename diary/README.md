# Dev diary - materials

I will be maintaining notes for each step and planing next steps here.

## Day #0

Topic: Intro and welcome  
[Daily vlog #0](https://www.youtube.com/watch?v=tK4yK3d1Flg&list=PLij67yf0bICPZl7FxQ5w4sn3nveCW8yf3)

## Day #1

> “What you gonna see when you wake up?”  
> Lyrics : Karnivool - Goliath

Topic: Vanila Godot project and GitHub desktop configuration  
[Daily vlog #1](https://www.youtube.com/watch?v=hC9cj0s29Xo&list=PLij67yf0bICPZl7FxQ5w4sn3nveCW8yf3&index=2)

## Day #2

> “Black then white are all I see”  
> Lyrics: Tool - Lateralus

Topic: Defining Main scene Node, Camera and Player Node  
[Daily vlog #2](https://www.youtube.com/watch?v=vnA81df5uDs&list=PLij67yf0bICPZl7FxQ5w4sn3nveCW8yf3&index=3)

- main node and main scene
- set background to white - Project -> project settings -> Rendering.Environment -> default clear color 
- create a png in pain(t)
- add a camera Node
- player Node
    - RigidBody2d - object that is affected by physics, collide, has mass; 
    - sprite to be visible
	- CollisionShape2D (should occupy the same space as the sprite for good UX)

## Day #3

> “Take one step left and one step right  
> One to the front and one to the side”  
> Lyrics: Lou Bega - Mambo no. 5

Topic: Player Movement script  
[Daily vlog #3](https://www.youtube.com/watch?v=Ru_UVCVOv_g&list=PLij67yf0bICPZl7FxQ5w4sn3nveCW8yf3&index=4)

- player - RigidBody2d - object that is affected by physics, collide, has mass
	- `_physics_process(delta)` is the function that is triggered by game loop, movement logic might be there for now; it might be better to extract it to `_process(delta)` later on, if maintaining all Nodes will take more time than `delta`
        - `delta` is time between previous execution
        - `_physics_process` is triggered at regular interval of around 1/60 sec - trying to get 60FPS by default (this can be changed in project settings)
        - `_process` is triggered at irregular interval, so every function that moves Nodes should be multiply by delta, to accomodate for this
        - maximum FPS can be set in projects settings to test how algorythms with and without delta works
        - some built-in functions multiply by delta out-of-the-box (for example: `move_and_slide`)
	- higher mass makes the RigidBody2D to move slower
	- setting Linear.Damp makes the RigidBody2D to lose speed (slow down and eventually stop)
    - GravityScale is used to control wheter player will be pulled downwards

## Day #4

> "I got the mooooooves like jagger"  
> Maroon 5 - Moves Like Jagger

Topic: Abstracting input with Input Map  
[Daily vlog #4](https://www.youtube.com/watch?v=1rPrcSxJ-fE&list=PLij67yf0bICPZl7FxQ5w4sn3nveCW8yf3&index=5)

https://docs.godotengine.org/en/stable/tutorials/2d/2d_movement.html

## Day #5

> “Red and yellow then came to be”  
> Lyrics: Tool - Lateralus

Topic: Enemies as reuseable assets and collisions  
[Daily vlog #5](https://www.youtube.com/watch?v=i57Ks2qwz4Y&list=PLij67yf0bICPZl7FxQ5w4sn3nveCW8yf3&index=6)

- enemy Node
	- RigidBody2D
	- sprite
	- collitionShape2D
- drag enemy Node to FileSystem to create scene
- drag few enemy scenes to 2d pane 
- check Gravity
- fixing GravityScale and Linear.Damp in scene does change it for enemies already added to the main scene unless it has been changed on the instance
- fix enemy scene
- add new enemy
- `lock_rotation` on player to prevent from spinning

## Day #6

> "This shit is not random"  
> Lyrics: G-Eazy - Random

Topic: Script for spawning enemies  
[Daily vlog #6](https://www.youtube.com/watch?v=Q1WwTJUXYjk&list=PLij67yf0bICPZl7FxQ5w4sn3nveCW8yf3&index=7)

Today we will be spawning some enemies

- https://docs.godotengine.org/en/stable/classes/class_randomnumbergenerator.html
- `@export var var_name` makes the variable visible in Inspector and you can specify the value for it there
- `preload` function allows for preloading a scene - `var enemy_scene = preload("res://enemy.tscn)`
- then to instantiate a scene you can use `var enemy = enemy_scene.instantiate()` - this creates the object in memory, we have to add it to the main node `add_child(enemy)`
- `randi_range` - calculates random integer in specified range
- `randf_range` - calculates random float in specified range 
- `enemy.position.x`, `enemy.position.y` - to say where the enemy should be
- `enemy.scale.x`, `enemy.scale.y` - to say how big or small the enemy should be

## Day #7 - starting diary

> Dear Diary, I'm here to stay  
> Lyrics: Ozzy Osbourne - Diary of a Madman

Topic: Improving README.md and moving project notes into git repository
[Daily vlog #7](https://www.youtube.com/watch?v=OhThxiCf8RQ&list=PLij67yf0bICPZl7FxQ5w4sn3nveCW8yf3&index=8) 


## Day #8 - analysing Nordic Ashes

> Earth to earth, ashes to ashes, dust to dust
> Lyrics: Book of Common Prayer

Topic: Analyze mechanics of Nordic Ashes to get some inspiration
<!-- [Daily vlog #8]()  -->

[Steam - Nordic Ashes: Survivors of Ragnarok](https://store.steampowered.com/app/2068280/Nordic_Ashes_Survivors_of_Ragnarok/)


---

## Future 

### Day # align camera and viewport - world boundaries 
Block the option of player going outside of the map
fix object's positions
	- make camera fully inside the viewport
	- adjust calculations to accomodate for the change


### Day # improve enemies spawning
we will add visual hint that enemy will spawn here
we will use timer to spawn enemies at random times
	- `Timer` class to execute action based on elapsed time 
	- `preload` function allows for preloading a scene - `var enemy_scene = preload("res://enemy.tscn)`

### Day # - more working on movement 

 `delta` parameter and `linear_velocity` 
- godot docs - `RigidBody2D.linear_velocity` is bad way to move player, they suggest to use `_integrate_forces` - to check in future 

- limit fps -> Project -> Project Settings -> advanced settings -> search for FPS -> set to 10 frames per second => 1 frame each 0.1 second
- `_physics_process` vs `_process`
	- process - runs as often as possible
	- physics_process - This separate process is run at a capped framerate which is set in the projects physics settings (Physics → Common → Physics Ticks per Second), at 60 FPS by default. However, there are some important caveats to this. For one, the execution is not guaranteed to be at a constant rate - if too many operations take place in a single physics step it will slow down

### Day # - enemies go to character and
“And just when I think I've worked it out
These pieces move and I'm back to the start”
Lyrics: Karnivool - Umbra

### Day # - enemies start to hurt


### Day # - github actions that build project


### Day # - attach exe as Github Release
