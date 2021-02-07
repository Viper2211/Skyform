import "input" for Keyboard
import "./entity_" for Entity

class InputController {
    // Actors setter
    actors=(value){ _actors = actors }

    construct new(actors){
        _actors = actors
    }

    update(){
        var shot = false
        for (actor in _actors){
            if (actor.isPlayer){
                if (Keyboard.isKeyDown("A") || Keyboard.isKeyDown("Left")){
                    actor.dir = -1
                    actor.facing = -1
                } else if (Keyboard.isKeyDown("D") || Keyboard.isKeyDown("Right")){
                    actor.dir = 1
                    actor.facing = 1
                } else if (Keyboard.isKeyDown("S") || Keyboard.isKeyDown("Down")){
                    actor.h = 4  
                } else {
                    actor.dir = 0
                    actor.h = 5
                }
                if (Keyboard["W"].justPressed){
                    actor.ticksJumping = 1
                }
                if (Keyboard["E"].justPressed){
                    shot = true
                }
            }
        }
        return shot
    }
}