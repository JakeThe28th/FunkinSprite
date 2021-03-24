// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function save_sheet_XML() {
	var a = 1
	var filepath = get_save_filename("Spritesheet name|*","")
	if filepath = "" return -1
	
	var saved_cache = ds_map_create()
	
	var xres = get_integer("Sheet X resolution", 8192)
	var yres = get_integer("Sheet Y resolution", 4096)
	
	var surf = surface_create(xres, yres)
	
	var XML = file_text_open_write(filepath + ".xml")
		file_text_write_string(XML, "<?xml version=\"1.0\" encoding=\"utf-8\"?>")
		file_text_writeln(XML)
		file_text_write_string(XML, "<TextureAtlas imagePath=\""+ string_replace(filepath, filename_path(filepath), "") + ".png\">")
		file_text_writeln(XML)
		file_text_write_string(XML, "<!-- Created with  j a k e 2 8 -->")
		file_text_writeln(XML)
		
		
		surface_set_target(surf)
		
		var tallestOfThisRow = 0
		var xd = 0
		var yd = 0
		
		var entry = ds_map_find_first(animations)
		repeat ds_map_size(animations) {
			
			var frame = 0
			var ds = animations[? entry]
			repeat ds_list_size(ds) {
				if ds_map_find_value(saved_cache, ds[| frame]) = undefined {
				
				
				
				if xd+sprite_get_width(ds[| frame]) > xres {
					yd+=tallestOfThisRow
					tallestOfThisRow=0
					xd=0
					}
				
				
				draw_sprite(ds[| frame],0,xd,yd)
				if sprite_get_height(ds[| frame]) > tallestOfThisRow tallestOfThisRow = sprite_get_height(ds[| frame])	
				
				var spds = ds_map_create()
				spds[? "x"] = xd
				spds[? "y"] = yd
				spds[? "width"] = sprite_get_width(ds[| frame])
				spds[? "height"] = sprite_get_height(ds[| frame])
				ds_map_add_map(saved_cache, ds[| frame], spds)
				
				
				var zeroes = "000"
				if string_length(string(frame)) = 2 zeroes = "00"
				if string_length(string(frame)) = 3 zeroes = "0"
				if string_length(string(frame)) = 4 zeroes = ""
				
				file_text_write_string(XML, "<SubTexture name=\"" + string(entry) + zeroes + string(frame) + "\" x=\"" + string(xd) + "\" y=\"" + string(yd) + "\" width=\"" + string(sprite_get_width(ds[| frame])) + "\" height=\"" + string(sprite_get_height(ds[| frame])) + "\"/>")
				file_text_writeln(XML)
				
				xd+=sprite_get_width(ds[| frame])
				} else {
					var zeroes = "000"
					if string_length(string(frame)) = 2 zeroes = "00"
					if string_length(string(frame)) = 3 zeroes = "0"
					if string_length(string(frame)) = 4 zeroes = ""
					
					var spds = ds_map_find_value(saved_cache, ds[| frame])

					file_text_write_string(XML, "<SubTexture name=\"" + string(entry) + zeroes + string(frame) + "\" x=\"" + string(spds[? "x"]) + "\" y=\"" + string(spds[? "y"]) + "\" width=\"" + string(spds[? "width"]) + "\" height=\"" + string(spds[? "height"]) + "\"/>")
					file_text_writeln(XML)
					}
				frame++
				}
			
			entry = ds_map_find_next(animations, entry)
			}
		
		surface_reset_target()
		
		file_text_write_string(XML, "</TextureAtlas>")
		file_text_writeln(XML)
		file_text_close(XML)
		surface_save(surf, filepath + ".png")
	
}