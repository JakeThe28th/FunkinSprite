// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

function util_file_to_string(file) {
	var txtfile = file_text_open_read(file)
	var text = ""
	do {
		text = text + file_text_read_string(txtfile)
		file_text_readln(txtfile)
	
		} until file_text_eof(txtfile)

	file_text_close(txtfile)
	return text
}


function split_string(stringsplit, charsplit) {
	//string
	//character to split at
	var array = array_create(1, "")

	var i=1
	var o=0
	var accumulate = ""
	repeat string_length(stringsplit) { 
		var str_char_at = string_char_at(stringsplit, i)
	
		if str_char_at = charsplit  { 
			accumulate = string_replace(accumulate, chr(9), "")
			array[o] = accumulate 
			o++
			accumulate = ""
			} else if str_char_at !=chr(9) accumulate = accumulate + str_char_at
		i++
		}
	
	accumulate = string_replace(accumulate, chr(9), "")
	accumulate = string_replace(accumulate, "\n", "")
	accumulate = string_replace(accumulate, "\r", "")
	array[o] = accumulate 
	return array


}


function util_ds_path(ds, seperator, path, type) {
	//This script requires util_split_string
	//types: map_only, list_only, both
	
	path = split_string(path, seperator)
	
	var value = ds
	var ds_type;
	var i = 0
	repeat array_length(path) {
		if type = "map_only" ds_type = "ds_map"
		if type = "list_only" ds_type = "ds_list"
		
		if is_real(path[i]) show_debug_message("yolo") //path[i] = real(path[i])
		
		try {
			path[i] = real(path[i])
			} catch (error) {
				var error = "caught"
				}
		
		if type = "both" {
			//If type is both, check if numbers are list entries before changing to map.
			ds_type = "ds_list"
			if !is_real(path[i]) or ds_list_find_value(value, real(path[i])) = undefined ds_type = "ds_map"
			}
			
	//	show_debug_message(current_block)
			
		if is_undefined(value) return undefined
		
		if path[i] = "?" {
			
			if ds_type = "ds_map" {
				path[i] = ds_map_find_first(value)
				value = ds_map_find_value(value, path[i])
				}
			if ds_type = "ds_list" value = ds_list_find_value(value, 0)
			
			debug_log("DS_PATH", "MISSING '" + current_block + "'")
			
			} else {
				
			if ds_type = "ds_map" value = ds_map_find_value(value, path[i])
			if ds_type = "ds_list" value = ds_list_find_value(value, real(path[i]))
			
			}
			
		if is_undefined(value) return undefined
		
		
		//if is_undefined(value) {
		//	if current_block !="minecraft:stone" debug_log("DS_PATH", current_block)
		//	}
		
		i++
		}
		
		return value
}
	
	
function textfile_copy_replace(file_, phrase, newphrase, output_) {
	
	if !file_exists(file_) {
		debug_log("ERROR", "Missing text file: " + file_)
		return -1
		}
	
	var file = file_text_open_read(file_)
	var output = file_text_open_write(output_)

	do { 
		var current_line = file_text_read_string(file)
		file_text_readln(file)
	
		current_line = string_replace_all(current_line, phrase, newphrase)
	
		file_text_write_string(output, current_line)
		file_text_writeln(output)
		} until file_text_eof(file)
	
	file_text_close(file)
	file_text_close(output)


}


function point_in_area(x1, y1, x2, y2, px1, py1) {

	in_x = false
	in_y = false

	if y1 < y2 {
		if py1 > y1 and py1 < y2 var in_y = true
		} //if y1 is above y2
	
	if y2 < y1 {
		if py1 > y2 and py1 < y1 var in_y = true
		} //if y2 is above y1
	
	if x1 < x2 {
		if px1 > x1 and px1 < x2 var in_x = true
		} //if x1 is to the left of x2
	
	if x2 < x1 {
		if px1 > x2 and px1 < x1 var in_x = true
		} //if x2 is above x1
	
	if in_x = true and in_y = true return true else return false
}
	
	
function order_least_greatest(num1, num2) {

	if num1 < num2 { //Make X1 on the left, and X2 on the right.
			var outnum1 = num1;
			var outnum2 = num2;
			} else {
				var outnum2 = num1;
				var outnum1 = num2;
				}
			
			
		var array = array_create(2, "")
	
		array[0] = outnum1
		array[1] = outnum2
	
		return array


}
	
	
function copy_string_between(start_, end_, string_) {
	var out = ""
	var i = 0

	var started = false

	repeat string_length(string_) {
		var str_char_at = string_char_at(string_, i)
	
		if str_char_at = end_ break
	
		if started = true {
			out = out + string(str_char_at)
			}
	
		if str_char_at = start_ started = true
	
		i++
		}
	
	return out
}