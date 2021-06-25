// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function load_sheet_XML() {

	ds_map_destroy(fnameCache)
	fnameCache = ds_map_create()
	
	clean_old_sprites()
	current_editing =-1
	
	var loaded_cache = ds_map_create()
	
	var XMLpath = get_open_filename("*XML|*.xml", "")
	if XMLpath = "" return -1
	
	var sheetpath = string_copy(XMLpath, 1, string_length(XMLpath)-4) + ".png"
	var sheetbuff = buffer_load(sheetpath)
	var sheet_spr_temp = sprite_add(sheetpath, 1,0,0,0,0)
	var sheet_res_x = sprite_get_width(sheet_spr_temp)
	var sheet_res_y = sprite_get_height(sheet_spr_temp)
	//sprite_delete(sheet_spr_temp)
	var sheet = surface_create(sheet_res_x, sheet_res_y)
	surface_set_target(sheet)
	draw_sprite(sheet_spr_temp, 0,0,0)
	surface_reset_target()
	//buffer_set_surface(sheetbuff, sheet, 0)
	
	ds_list_add(global.spritesToDelete, sheet_spr_temp)
	
	var XML = file_text_open_read(XMLpath)
	
	var XML_ = xml_to_ds(XML)
	
	
	animations = ds_map_create()
	
	var incremental_i = 0;
	do {
		
		var current_property = ds_list_find_value(XML_, incremental_i)
		
		if current_property[? "XML_Name"] = "SubTexture" {
		
		var anim_name = current_property[? "name"]
		
		var chars = ""
		var cchar = ""
		var ichar = 1
		do {
			chars = chars + cchar
			cchar = string_char_at(anim_name, ichar)
				
			ichar++
			} until cchar = 0

		var anim_name = chars
		
		
		var anim_x = current_property[? "x"]
		var anim_y = current_property[? "y"]
		var anim_width = current_property[? "width"]
		var anim_height = current_property[? "height"]
		
		if current_property[? "frameX"] != -1 {
		var frame_x = current_property[? "frameX"]
		var frame_y = current_property[? "frameY"]
		var frame_width = current_property[? "frameWidth"]
		var frame_height = current_property[? "frameHeight"]
		} else {
			var frame_x = 0;
			var frame_y = 0;
			var frame_width = 0;
			var frame_height = 0;
			
			
			
			}
		
		
		var current_anim_import = animations[? anim_name]
		if current_anim_import = undefined {
			current_anim_import = ds_list_create()
			ds_map_add_list(animations, anim_name, current_anim_import)
			}
		
	var cacheplace = loaded_cache[? string(anim_x) + ";" + string(anim_y) + ";" + string(anim_width) + ";" + string(anim_height)]
	if cacheplace = undefined {
	
		var sprite_import = sprite_create_from_surface(sheet, anim_x, anim_y, anim_width, anim_height, 0, 0, 0, 0);
		 loaded_cache[? string(anim_x) + ";" + string(anim_y) + ";" + string(anim_width) + ";" + string(anim_height)] = sprite_import
		 
		add_sprite_anim(current_anim_import, sprite_import, frame_x, frame_y, frame_width, frame_height)
		} else {
			
			add_sprite_anim(current_anim_import, cacheplace, frame_x, frame_y, frame_width, frame_height)
			}		// + string(anim_frame)
		

		}
		
		incremental_i += 1;		
		} until incremental_i = ds_list_size(XML_)-1
	
}