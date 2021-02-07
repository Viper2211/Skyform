import "math" for Vector
import "input" for Keyboard

class Entity {
    // Getters
    x { _x }
    y { _y }
    w { _w }
    h { _h }
    dir { _dir }
    hidden { _hidden }
    tags { _tags }
    isPlayer { _tags.contains("player") }
    facing { _facingDirection }
    ticksJumping { _ticksJumping }
    id { _id }
    lifetime { _lifetime }
    score { _score }
    color { _color }
    // Setters
    x=(value) { _x = value }
    y=(value) { _y = value }
    w=(value) { _w = value }
    h=(value) { _h = value }
    dir=(value) { _dir = value }
    hidden=(value) { _hidden = value }
    facing=(value) { _facingDirection = value }
    ticksJumping=(value) { _ticksJumping = value }
    id=(value) { _id = value }
    score=(value) { _score = value }
    color=(value) { _color = value }
    lifetime=(value) { _lifetime = value }

    // Constructors
    init(x, y, w, h, tags, hidden){
        _x = x 
        _y = y 
        _w = w
        _h = h
        _dir = 0
        _ticksJumping = 0
        _tags = tags
        _hidden = hidden
        _facingDirection = 1
        _lifetime = 0
    }

    construct new(x, y, w, h, tags, hidden){
        init(x,y,w,h,tags,hidden)
    }

    construct new(x, y, w, h, tags, hidden, callback){
        init(x,y,w,h,tags,hidden)
        _triggerCallback = callback
    }

    construct new(x, y, w, h, tags, hidden, callback, moveCallback){
        init(x,y,w,h,tags,hidden)
        _triggerCallback = callback
        _controlledCallback = moveCallback
    }

    construct trigger(x, y, w, h, callback){
        init(x,y,w,h,"trigger",false)
        _triggerCallback = callback
    }

    construct player(x, y, w, h){
        init(x,y,w,h,"collider player",false)
        _score = 0
    }

    trigger(a,s){ 
        _triggerCallback.call(a,s) 
    }

    move(s){
        _controlledCallback.call(s)
    }
}