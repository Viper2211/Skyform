import "math" for Vector

class PhysicsEngine {
    // Actors setter
    actors=(value){ _actors = actors }

    construct new(actors){
        _actors = actors
        var i = 0
        for (actor in _actors){
            actor.id = i
            i = i + 1
        }
    }

    update(){
        for (actor in _actors){
            if (!actor.hidden) {  
                if (actor.isPlayer){
                    if (actor.y > 250){
                        return true
                    }
                }

                if (actor.tags.contains("collider")){
                    if (!this.checkCollision(actor)) actor.x = actor.x + (actor.dir * 2)

                    actor.y = actor.y + 0.5
                    if (actor.ticksJumping == 1){
                        if (!this.checkCollision(actor)){
                            actor.ticksJumping = 0
                        }
                    }
                    actor.y = actor.y - 0.5

                    if (actor.ticksJumping > 0 && actor.ticksJumping < 12){
                        actor.y = actor.y - (12/actor.ticksJumping)
                        actor.ticksJumping = actor.ticksJumping + 1
                    } else if (actor.ticksJumping >= 12) {
                        actor.ticksJumping = 0
                    }

                    if (!this.checkCollision(actor)) actor.y = actor.y + 1
                    while (this.checkCollision(actor)) actor.y = actor.y - 0.1
                }
                if (actor.tags.contains("controlled")){
                    actor.move(actor)
                } 
            }
        }
        return false
    }

    checkCollision(actor){
        for (other in _actors){
            if (checkCollision(actor,other)) return true
        }
    }

    checkCollision(actor, other){
        if (other.id != actor.id && !other.hidden){
            if (actor.x <= other.x + other.w && actor.x + actor.w >= other.x && actor.y <= other.y + other.h && actor.y + actor.h >= other.y){
                if (other.tags.contains("trigger")) {
                    other.trigger(actor,other)
                }
                if (other.tags.contains("non-physics")){
                    return false
                }
                return true
            }
        }
    }
}