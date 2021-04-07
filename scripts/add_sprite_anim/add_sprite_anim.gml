// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function add_sprite_anim(ds, spr, frameX, frameY, frameWidth, frameHeight) {
	
	//handle -1 frame args as default
	
	var cds = ds_map_create()
	cds[? "sprite"] = spr
			ds_list_add(ds, cds)
			ds_list_mark_as_map(ds, ds_list_size(ds)-1)
			
	cds[? "frameX"] = frameX
	cds[? "frameY"] = frameY
	cds[? "frameWidth"] = frameWidth
	cds[? "frameHeight"] = frameHeight

}