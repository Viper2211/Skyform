import "./entity_" for Entity
import "graphics" for Color

var Patroller = Fn.new {|x,y,maxLeft,maxRight|
    var goal = maxLeft
    var move = Fn.new {|actor|
        if (actor.x < goal){
            actor.x = actor.x + 0.5
        } else if (actor.x > goal) {
           actor.x = actor.x - 0.5
        } else if (actor.x == goal){
            if (goal == maxLeft) goal = maxRight else if (goal == maxRight) goal = maxLeft
        }
    }
    var attack = Fn.new {|actor,self|
        if (actor.isPlayer){
            actor.y = 270
        }
    }

    var entity = Entity.new(x,y,5,5,"collider controlled trigger monster",false,attack,move)
    entity.color = Color.rgb(230, 94, 94)
    return entity
}

var Follower = Fn.new {|x,y,player|
    var move = Fn.new {|actor|
        if (actor.x < player.x){
            actor.x = actor.x + 0.3
        } else if (actor.x > player.x) {
           actor.x = actor.x - 0.3
        }
    }
    var attack = Fn.new {|actor,self|
        if (actor.isPlayer){
            actor.y = 270
        }
    }

    var entity = Entity.new(x,y,5,5,"collider controlled trigger monster",false,attack,move)
    entity.color = Color.rgb(230, 94, 94)
    return entity
}

var Boss = Fn.new {|x,y,player|
    var move = Fn.new {|actor|
        if (player.x > 920){
            if (actor.x < player.x){
                actor.x = actor.x + 1
            } else if (actor.x > player.x) {
               actor.x = actor.x - 1
            }

            if (player.y+5 < actor.y && actor.ticksJumping == 0){
                actor.ticksJumping = 1
            } else if (player.y-5 > actor.y){
                actor.y = actor.y + 25
            }
        }
    }

    var attack = Fn.new {|actor,self|
        if (actor.isPlayer){
            actor.y = 270
        }
    }

    var entity = Entity.new(x,y,10,10,"collider controlled trigger boss monster",false,attack,move)
    entity.color = Color.rgb(255, 70, 39)
    return entity
}