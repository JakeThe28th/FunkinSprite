//var delete_inc = 0
repeat ds_list_size(global.spritesToDelete) {
	
	sprite_delete(global.spritesToDelete[| 0])
	ds_list_delete(global.spritesToDelete, 0)
	
	//delete_inc++
	}