import "random" for Random
import "dome" for Window
import "./monsters_" for Patroller, Follower, Boss
import "./items_" for Coin, Block, Bullet, Box

class Generator {
    random { 
        if (_initializedRandom) {
            return _random
        } else {
            _random = Random.new()
            _initializedRandom = true
            return _random 
        }
    }
    checkCollision(x1,y1,w1,h1,x2,y2,w2,h2){
        if (x1 <= x2 + w2 && x1 + w1 >= x2 && y1 <= y2 + h2 && y1 + h1 >= y2){ 
            return true 
        }
        return false
    }

    construct new(player){
        _actors = []
        _player = player
    }

    generate(x,maxX){
        _actors.add(Block.call(x,230,maxX-x,10))
        for (x in (x...maxX).where {|n| n % 75 == 1 }){
            for (y in (30...220).where {|n| n % 75 == 1 }){
                if (random.sample([false,false,false,false,false,false,false,false,false,true])){
                    createPlatform(x,y)
                }

                if (random.sample([false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,true])){
                    createMonster(x,y)
                }

                if (random.sample([false,false,false,true])){
                    createCoin(x,y)
                }

                if (random.sample([false,false,false,false,false,false,false,false,false,false,false,false,true])){
                    createBox(x,y)
                }
            }
        }
        _actors.add(Boss.call(random.int(x,maxX),-10,_player))
        return _actors
    }

    createPlatform(x,y){
        var width = random.int(30,90)
        for (platform in _actors){
            if (checkCollision(x,y,width,10,platform.x,platform.y,platform.w,platform.h)){
                return
            }
        }
        _actors.add(Block.call(x,y,width,10))
    }

    createMonster(x,y){
        if (random.sample([false,true])) return _actors.add(Patroller.call(x,y,x-50,x+50))
        _actors.add(Follower.call(x,y-250,_player))
    }

    createCoin(x,y){
        _actors.add(Coin.call(x,y))
    }

    createBox(x,y){
        _actors.add(Box.call(x,y,5,5))
    }
}