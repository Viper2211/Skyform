import "dome" for Window, Process
import "input" for Keyboard
import "./physics_" for PhysicsEngine
import "./graphics_" for GraphicsEngine
import "./input_" for InputController
import "./generate_" for Generator
import "./entity_" for Entity
import "./monsters_" for Patroller, Follower
import "./items_" for Coin, Block, Bullet, Box

class Game {
    static init(){
        Window.title = "Skyform"

        __player = Entity.player(100,100,5,5)
        __paused = true
        __quote = "Use WASD to move and E to shoot"

        var player = __player
        __generator = Generator.new(player)
        __generatedMax = 2000
        __actors = [
            // Section 1
            Block.call(50,230,180,10), Follower.call(60,70,player), // 1
            Block.call(170,180,50,10), // 2
            Block.call(235,205,80,10), Patroller.call(255,200,240,300), Box.call(310,200,5,5), // 3
            Block.call(235,160,30,10), // 4
            Block.call(285,150,30,10), Patroller.call(290,145,290,300), // 5
            Block.call(235,120,25,10), // 6
            Block.call(200,100,25,10), // 7
            Block.call(175,80,20,10), Box.call(180,75,5,5), Box.call(180,65,5,5), Box.call(180,55,5,5), // 8
            Block.call(145,65,20,10), // 9
            Block.call(30,50,100,10), Patroller.call(35,45,65,125), Coin.call(75,45), // 10
            // Section 2
            Block.call(320,230,60,10), // 11
            Block.call(390,185,80,10), Patroller.call(400,180,395,465), Coin.call(75,45), // 12
            Block.call(475,165,30,10), // 13
            Block.call(515,155,70,10), Patroller.call(550,140,520,580), Coin.call(530,150), // 14
            Block.call(550,120,20,10), // 15
            Block.call(550,95,20,10), // 16
            Block.call(330,80,200,10), Patroller.call(330,75,330,510), Patroller.call(340,75,400,460), Patroller.call(460,75,410,530), Coin.call(340,75), // 17
            Block.call(285,35,30,10), Follower.call(350,-100,player), Coin.call(290,30), // 18
            // Section 3
            Block.call(550,230,15,10), // 19
            Block.call(580,220,50,10), // 20
            Block.call(600,155,15,10), // 21
            Block.call(630,140,150,10), // 22
            Block.call(800,200,50,10), Box.call(840,190,5,5), Box.call(840,190,5,5), Box.call(840,190,5,5), Box.call(840,190,5,5), Box.call(840,190,5,5), // 23
            Block.call(860,180,30,10), // 24
        ] + __generator.generate(900,2000)

        __actors.add(player)
        __physicsEngine = PhysicsEngine.new(__actors)
        __graphicsEngine = GraphicsEngine.new(__actors)
        __inputController = InputController.new(__actors)
    }

    static update(){
        if (!__paused){
            var didShoot = __inputController.update()
            var failure = __physicsEngine.update()
            if (failure) Process.exit()
            if (didShoot) __actors.insert(__actors.count-1,Bullet.call(__actors[-1].x,__actors[-1].y,__actors[-1].facing))
            if (__player.x > __generatedMax-100){
                __actors = __actors + __generator.generate(__generatedMax, __generatedMax+1000)
                __generatedMax = __generatedMax + 1000
            }
            var live = []
            for (actor in __actors){
                if (!actor.hidden){
                    live.add(actor)
                }
            }
            __actors = live
            __physicsEngine = PhysicsEngine.new(__actors)
            __graphicsEngine = GraphicsEngine.new(__actors)
            __inputController = InputController.new(__actors)
        } 
        if (Keyboard["Space"].justPressed){
            __paused = !__paused
        }
    }

    static draw(dt){
        if (!__paused) {
            __graphicsEngine.update()
        } else {
            __graphicsEngine.paused(__quote)
        }
    }
}