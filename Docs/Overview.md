# WIP: Pong Redux

## Elevator Pitch:
Battle pong, with some breakout shenanigans, fun pixel art backgrounds, and Licensed chiptune music (or used with permission, which is the same).

## Table of Contents


 - <a href="#code-overview">Code Overview</a>
    - <a href="#composition-pattern">Composition Pattern</a>
    - <a href="#signals">Signals</a>
    - <a href="#scenes-explainer">Scenes Explainer</a>
 - <a href="#music">Music</a>
 - <a href="#art">Art</a>
 - <a href="Business">Business</a>
    - <a href="#marketing">Marketing</a>

# Code Overview

## Composition Pattern

## Signals

## Scenes Explainer

### ball.tscn
Exactly what it says on the can. 

Instantiate with 
```
var ball_scene = load("res://tscn/ball.tscn")
var new_ball = ball_scene.instantiate()
new_ball.name = "Ball"  
new_ball.position = Vector2(outer_court_size.x/2, outer_court_size.y/2)
add_child(new_ball)
```

**Instantiated by:** Player Layer.gd

**Script(s):** Ball.gd; Purpose: handles ball movement, exclusively.

### ball_explode.tscn
It's the particle effect for the Goal Explosion, both for aesthetics, and to hide the ball-kill. Little polish goes a long way. 

One-shot. Instantiate with
```
var vfx = ballExplosion.instantiate()
vfx.position = body.position
vfx.rotation = body.rotation
vfx.emitting = true
add_child(vfx)
```
The goal explosion gets adjusted based on the point-gaining player. So Left Goal will always explode with Right player's color, and visa versa.

### Player Layer

### UI Elements

# Music

# Art

# Business

## Marketing
Whether I love it or hate it, marketing is a reality, and I have to take that seriously. Here are some blurbs and ideas to make the process easier when that time evertually does come, as I have the ideas, so I keep working on the task at hand and worry less.

 - "Officially Licensed soundtrack from the best underground chiptune aritsts"
    - Ask around the underground scene, find a < 1000 sub playlist and ask your faves
        - 20% royalties pot from revenue for musicians, split equally among them
        - Reduce cost by writing some/all original chiptune music and put some damn skin in the game there, too.
    - 