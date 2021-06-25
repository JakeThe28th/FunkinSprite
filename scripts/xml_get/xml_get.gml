// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

function xml_to_ds(xml) {
	var ds = ds_list_create()							//DS for entire XML
	
	while !file_text_eof(xml) {
		var line = file_text_readln(xml)				//Read line from XML
		var ds_map_current = ds_map_create()			//Create DS for line
		ds_list_add(ds, ds_map_current)					//Add to DS for XML
		ds_list_mark_as_map(ds, ds_list_size(ds)-1)
		
		//Read until we get to a space. This gets the name of the property
		var i = 0
		do {
			if i > string_length(line) break; //Make sure to not go out of line bounds
			
			var temx = string_char_at(line, i)
			i++
			} until temx = " "
		
		//Add XML name to DS.
		ds_map_add(ds_map_current, "XML_Name", string_replace(string_copy(line, 2, i-3), "<", ""))
		var property_i = i
		
		var var_i = property_i
		while !file_text_eoln(xml) and i < string_length(line) {  //Make sure to not go out of line bounds
			
			//Copy from var_i (previous variable's end to i (end of current variable's name)
			//This gets the variable's name
			do {
				if i > string_length(line) break; //Make sure to not go out of line bounds
			
				var temx = string_char_at(line, i)
				i++
				} until temx = "="
			
			var vari = string_copy(line, var_i, i-var_i-1)
			
			var_i = i
			i++
			
			//Copy from var_i (variable's name's end to i (end of current variable)
			//This gets the variable
			do {
			if i > string_length(line) break;
			
			var temx = string_char_at(line, i)
			i++
			} until temx = "\""

			//Add it to the DS map for this line.
			ds_map_add(ds_map_current, vari, string_replace_all(string_copy(line, var_i, i-var_i), "\"", ""))
			
			var_i = i+1
			} }

	return ds
	}