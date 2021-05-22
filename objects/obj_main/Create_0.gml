animations = ds_map_create()


//var current_anim = ds_list_create()
//current_anim[| 0] = sprite_add("tile000.png",1,0,0,0,0)
//current_anim[| 1] = sprite_add("tile001.png",1,0,0,0,0)
//current_anim[| 2] = sprite_add("tile002.png",1,0,0,0,0)
//current_anim[| 3] = sprite_add("tile003.png",1,0,0,0,0)
//current_anim[| 4] = sprite_add("tile004.png",1,0,0,0,0)

//ds_map_add_list(animations, "BF_IDLE", current_anim)

//

var current_anim = ds_list_create()
add_sprite_anim(current_anim, sprite_add("tile000.png",1,0,0,0,0),undefined,undefined,undefined,undefined)
add_sprite_anim(current_anim, sprite_add("tile001.png",1,0,0,0,0),undefined,undefined,undefined,undefined)
add_sprite_anim(current_anim, sprite_add("tile002.png",1,0,0,0,0),undefined,undefined,undefined,undefined)
add_sprite_anim(current_anim, sprite_add("tile003.png",1,0,0,0,0),undefined,undefined,undefined,undefined)
add_sprite_anim(current_anim, sprite_add("tile004.png",1,0,0,0,0),undefined,undefined,undefined,undefined)

ds_map_add_list(animations, "BF_IDLE2", current_anim)

current_editing = -1

ind = 0
fpersecond = 24

global.spritesToDelete = ds_list_create()
fnameCache = ds_map_create()


//NewVars

timelineScale = 1
holdsNumbers = true
useOffset = true
doOutline = true