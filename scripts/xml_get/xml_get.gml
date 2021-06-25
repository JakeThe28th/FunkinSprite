// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function xml_get(xml, property, name_number, variable) {
	
	var current_property = undefined
	var current_variable = undefined
	var current_value = undefined
	var current_name_number = 0
	var type = 0 //number
	if is_string(name_number) type = 1 //name
	
	
	
	
	////////////////////SCRAPPED
	
	
	
	
	
	
	//file_text_
	//
	var i = 0
	var count = 0
	do {
		var line = file_text_readln(xml)
		var i_prop = 0
		var count = 0
		do {
			var temx = string_char_at(line, i_prop)
			
			i_prop++
			count++
			if i_prop > string_length(line) return current_property = -1
			} until temx = " "
		if current_property != -1 current_property = string_copy(line, 2, count-3)
		if current_property = property {
			if type = 0 {
				if current_name_number = name_number {
			var i_val = i_prop
			do {
			count = 0
			do {
			var temx = string_char_at(line, i_val)
			
			i_val++
			count++
			if i_val > string_length(line) current_variable = -1
			} until temx = "="
				if current_variable != -1 current_variable = string_copy(line, i_prop, count-1)
			
				if current_variable = variable {
				i_prop = count + i_prop
				
				count = 0
				i_val++
			do {
				
				
				var temx = string_char_at(line, i_val)
			
				i_val++
				count++
				if i_val > string_length(line)+3 return -1
				} until temx = "\""
				
				current_value = string_copy(line, i_prop+1, count-1)
				
				return current_value
				} else current_variable = -1
				
				} until current_variable = variable or current_variable = -1
				} }
				if type = 0 current_name_number++
				}
			
		
		} until current_name_number = name_number+1
	
	}
	

function xml_to_ds(xml) {
	var ds = ds_list_create()
	
	while !file_text_eof(xml) {
		var line = file_text_readln(xml)
		var ds_map_current = ds_map_create()
		ds_list_add(ds, ds_map_current)
		ds_list_mark_as_map(ds, ds_list_size(ds)-1)
		
		var i = 0
		do {
			if i > string_length(line) break;
			
			show_debug_message(string_char_at(line, i))
			
			var temx = string_char_at(line, i)
			i++
			} until temx = " "
		
		ds_map_add(ds_map_current, "XML_Name", string_copy(line, 2, i-3))
		var property_i = i
		
		var var_i = property_i
		while !file_text_eoln(xml) and i < string_length(line) {
			
			do {
			if i > string_length(line) break;
			
			show_debug_message(string_char_at(line, i))
			
			var temx = string_char_at(line, i)
			i++
			} until temx = "="
			
			var vari = string_copy(line, var_i, i-var_i-1)
			
			var_i = i
			i++
			
			do {
			if i > string_length(line) break;
			
			show_debug_message(string_char_at(line, i))
			
			var temx = string_char_at(line, i)
			i++
			} until temx = "\""

			
			ds_map_add(ds_map_current, vari, string_replace_all(string_copy(line, var_i, i-var_i), "\"", ""))
			
			var_i = i+1
			
			}
		
		
		}

	return ds
	}