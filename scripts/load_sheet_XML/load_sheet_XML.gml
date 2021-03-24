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
	var str = ""
	do {
		file_text_readln(XML)
		str = file_text_read_string(XML)
		} until string_pos("SubTexture", str) > 0
		
	
	animations = ds_map_create()
	
	//Subtexture loop
	do {
		
	var anim_data = string_replace_all(str, "<SubTexture ", "")
	var anim_data = string_replace_all(anim_data, "/>", "")
	var anim_data = split_string(anim_data, " ")
		
	var anim_name = anim_data[0] //string_replace_all(split_string(anim_data[0], "=")[1],  "\"", "")
	
	var chars = ""
	var cchar = ""
	var ieechar = 0
	var quotespassed = 0
	do {
		cchar = anim_data[ieechar]
		
		chars = chars + anim_data[ieechar] + " "
		
		if string_pos("\"", cchar) > 0 quotespassed ++
		
		ieechar++
		} until string_pos("\"", cchar) > 0 and quotespassed > 1
		
	var anim_name = string_replace_all(chars, "\"", "")
	
	
	var chars = ""
	var cchar = ""
	var ichar = 1
	do {
		chars = chars + cchar
		cchar = string_char_at(anim_name, ichar)
				
		ichar++
		} until cchar = 0
	
	var anim_frame = string_copy(anim_name, ichar-1, string_length(anim_name)-(ichar-1))
	var anim_name = string_replace_all(chars, "name=", "")
	
	
	var anim_x = string_replace_all(split_string(anim_data[ieechar], "=")[1],  "\"", "")
	var anim_y = string_replace_all(split_string(anim_data[ieechar+1], "=")[1],  "\"", "")
	var anim_width = string_replace_all(split_string(anim_data[ieechar+2], "=")[1],  "\"", "")
	var anim_height = string_replace_all(split_string(anim_data[ieechar+3], "=")[1],  "\"", "")
	
	
	var current_anim_import = animations[? anim_name]
	if current_anim_import = undefined {
		current_anim_import = ds_list_create()
		ds_map_add_list(animations, anim_name, current_anim_import)
		}
		
	var cacheplace = loaded_cache[? string(anim_x) + ";" + string(anim_y) + ";" + string(anim_width) + ";" + string(anim_height)]
	if cacheplace = undefined {
	
		var sprite_import = sprite_create_from_surface(sheet, anim_x, anim_y, anim_width, anim_height, 0, 0, 0, 0);
		 loaded_cache[? string(anim_x) + ";" + string(anim_y) + ";" + string(anim_width) + ";" + string(anim_height)] = sprite_import
		ds_list_add(current_anim_import, sprite_import)
	
		} else {
			
			ds_list_add(current_anim_import, cacheplace)
			
			}		// + string(anim_frame)
		
	
	
	
	file_text_readln(XML)
	str = file_text_read_string(XML)
	
	} until str = "</TextureAtlas>"
	
}