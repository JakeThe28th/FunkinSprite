// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function j_sprite_base64_encode(sprite){
	//turn off 3d testing for a sec
	//gpu_set_zwriteenable(false);//Enables writing to the z-buffer
	//gpu_set_ztestenable(false);//Enables the depth testing, so far away things are drawn beind closer things
	//DONT DO 
	

	//draw_sprite(sprite, 0 , 0 ,0)
	var surf = surface_create(sprite_get_width(sprite),sprite_get_height(sprite))
	surface_set_target(surf)
	draw_sprite(sprite, 0, 0, 0)
	surface_reset_target()
	
	var buff = buffer_create(1, buffer_grow, 1)
	buffer_get_surface(buff, surf, 0)
	
	var return_ = buffer_base64_encode(buff, 0, buffer_get_size(buff))
	buffer_delete(buff)
	surface_free(surf)
	
	//ok ok turn it back on now
	//gpu_set_zwriteenable(true);//Enables writing to the z-buffer
	//gpu_set_ztestenable(true);//Enables the depth testing, so far away things are drawn beind closer things
	//stupid stpudidi dumbfewuiiefmserkop[lerrogepofweiwetopyu
	
	return return_
}

function j_sprite_base64_decode(string_, xsize, ysize){
	//Decode tilemap
	var buff = buffer_base64_decode(string_)
	var surf = surface_create(xsize,ysize)
	buffer_set_surface(buff, surf, 0)
	
	
	var return_ = sprite_create_from_surface(surf, 0,0, surface_get_width(surf),surface_get_height(surf), 0,0,0,0)
	
	surface_free(surf)
	buffer_delete(buff)
	return return_
}