// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function clean_old_sprites() {
	var entry = ds_map_find_first(animations)
	repeat ds_map_size(animations) {
	
	var delete_increment = 0
			repeat ds_list_size(animations[? entry]) {
				ds_list_add(global.spritesToDelete, ds_list_find_value(animations[? entry], delete_increment))
				delete_increment++
				}
				
				
	entry = ds_map_find_next(animations, entry)
	}

}