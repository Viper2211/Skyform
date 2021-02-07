import "graphics" for Canvas, Color

class GraphicsEngine {
    // Actors setter
    actors=(value){ _actors = actors }

    construct new(actors){
        _actors = actors
    }

    update(){
        Canvas.cls()
        for (actor in _actors){
            if (!actor.hidden){
                if (actor.isPlayer){
                    Canvas.offset(-1*actor.x + 100,0)
                    Canvas.print(actor.score,actor.x-90,10,Color.rgb(255,255,255))
                }
                Canvas.rect(actor.x, actor.y, actor.w, actor.h, (actor.color) ? actor.color : Color.rgb(180,180,180))
            }
        }
    }

    paused(quote){
        Canvas.cls()
        Canvas.offset()
        Canvas.print("Press [SPACE] to continue!",50,100,Color.rgb(255,255,255))
        Canvas.print(quote,20,150,Color.rgb(230,230,230))
    }
}