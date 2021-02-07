import "./entity_" for Entity
import "graphics" for Color



var Coin = Fn.new {|x,y|
    var entity = Entity.new(x,y,3,3,"non-physics trigger coin",false){|a, s|
        if (!a.isPlayer) {
            return
        }
        a.score = a.score + 1
        s.hidden = true
    }
    entity.color = Color.rgb(230, 205, 94)
    return entity
}

var Bullet = Fn.new {|x,y,direction|
    if (direction>0) x = x + 6
    if (direction<0) x = x - 2
    y = y + 2

    var controlledCallback = Fn.new {|self|
        self.lifetime = self.lifetime + 1
        if (self.lifetime > 100){
            self.hidden = true
        }
        self.x = self.x + direction * 0.5
    }
    var triggerCallback = Fn.new {|actor,self|
        if (actor.tags.contains("monster")){
            actor.hidden = true
        }
        self.hidden = true
    }
    var entity = Entity.new(x,y,2,1,"controlled trigger bullet",false,triggerCallback,controlledCallback)
    //entity.color = Color.rgb(255,255,255)
    return entity
}

var Block = Fn.new {|x,y,w,h|
    var entity = Entity.new(x,y,w,h,"static block", false)
    return entity
}

var Box = Fn.new {|x,y,w,h|
    var entity = Entity.new(x,y,w,h,"collider trigger pushable",false) {|a,s|
        s.x = s.x + a.dir
        a.x = a.x - a.dir
    }
    entity.color = Color.rgb(115, 115, 115)
    return entity
}