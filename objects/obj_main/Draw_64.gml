/// @description Insert description here
// You can write your code in this editor
var sidebar_size = window_get_width()/5 + 20
draw_rectangle(0, 0, sidebar_size, window_get_height(), false)

//Go back menu
if current_editing !=-1 {
size = 158
xd = 10
yd = 10
draw_set_color(c_gray)
	draw_rectangle(xd, yd, xd+size, yd+20, false)
	if point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), xd, yd, xd+size, yd+20) {
		draw_set_color(c_dkgray)
		draw_rectangle(xd, yd, xd+size, yd+20, false)
		if mouse_check_button_released(mb_left) current_editing = -1
		}
	draw_set_color(c_white)
	
	draw_text(xd, yd, "Back to main menu")
	draw_rectangle(xd, yd, xd+size, yd+size, true)
	
}	

//export
size = 158
xd = 10
yd = 50
draw_set_color(c_gray)
	draw_rectangle(xd, yd, xd+size, yd+20, false)
	if point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), xd, yd, xd+size, yd+20) {
		draw_set_color(c_dkgray)
		draw_rectangle(xd, yd, xd+size, yd+20, false)
		if mouse_check_button_released(mb_left) save_sheet_XML()
		}
	draw_set_color(c_white)
	
	draw_text(xd, yd, "Save sheet & XML")
	draw_rectangle(xd, yd, xd+size, yd+size, true)
	

//import
size = 158
xd = 10
yd = 80
draw_set_color(c_gray)
	draw_rectangle(xd, yd, xd+size, yd+20, false)
	if point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), xd, yd, xd+size, yd+20) {
		draw_set_color(c_dkgray)
		draw_rectangle(xd, yd, xd+size, yd+20, false)
		if mouse_check_button_released(mb_left) load_sheet_XML()
		}
	draw_set_color(c_white)
	
	draw_text(xd, yd, "Load sheet & XML")
	draw_rectangle(xd, yd, xd+size, yd+size, true)


//Draw a box for an animation
//draw anim name
if current_editing = -1 {

var xd = sidebar_size + 20
var yd = 20
var size = 128

var entry = ds_map_find_first(animations)
repeat ds_map_size(animations) {
	draw_set_color(c_yellow)
	if point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), xd, yd, xd+size, yd+size) {
		draw_set_color(c_orange)
		if mouse_check_button_released(mb_left) {
			current_editing = entry
			}
		if mouse_check_button_released(mb_right) {
			//var delete_increment = 0
			//repeat ds_list_size(animations[? entry]) {
			//	ds_list_add(global.spritesToDelete, ds_list_find_value(animations[? entry], delete_increment))
			//	delete_increment++
			//	}
			ds_map_delete(animations, entry)
			break;
			}
		}
	draw_rectangle(xd, yd, xd+size, yd+size, false)
	draw_set_color(c_white)
	
	ind = ((current_time/(1000/fpersecond)))
		
	if ds_list_size(animations[? entry]) > 0 {
		spr = ds_list_find_value(animations[? entry], ind mod ds_list_size(animations[? entry]))
	
		var aspect = (sprite_get_width(spr)/sprite_get_height(spr))
		var yscale = (size)/sprite_get_height(spr)
		var xscale = (size)/sprite_get_width(spr)*aspect
		
		if sprite_get_width(spr) > sprite_get_height(spr) {
			var yscale = (size)/sprite_get_height(spr)/aspect
			var xscale = (size)/sprite_get_width(spr)
			}
	
	
	if spr != undefined draw_sprite_ext(spr, 0, (xd+size/2)-((sprite_get_width(spr)/2)*xscale),(yd+size/2)-((sprite_get_height(spr)/2)*yscale),yscale,yscale,0,c_white,1)
	
	}
	
	draw_set_halign(fa_center)
	draw_text(xd+(size/2), yd + size + 10, entry)
	draw_set_halign(fa_left)
	
	draw_rectangle(xd, yd, xd+size, yd+size, true)
	
	xd+=size+40
	if xd >= window_get_width() - size - 40 {
		xd = sidebar_size + 20
		yd+=size+40
		}
	entry = ds_map_find_next(animations, entry)
	}
	
	draw_set_color(c_gray)
	draw_rectangle(xd, yd, xd+size, yd+size, false)
	draw_set_color(c_white)
	
	var center = 50 //(current_time/10) mod 100
	
	if point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), xd, yd, xd+size, yd+size) {
		center -= 20
		if mouse_check_button_released(mb_left) {
			var name = get_string("Animation name","")
			if name != "" {
				var d = ds_list_create()
				ds_map_add_list(animations, name, d)
				}
			}
		}
	
	draw_sprite_ext(spr_plus, 0, xd+(center/2),yd+(center/2),(size-center)/sprite_get_width(spr_plus),(size-center)/sprite_get_height(spr_plus),0,c_white,1)
	draw_rectangle(xd, yd, xd+size, yd+size, true)
	
	

	} else {
		
		//Sprite editing menu
		
		draw_set_color(c_maroon)
		var timeline_scale = window_get_height()/6
		draw_rectangle(sidebar_size,0,window_get_width(),window_get_height()-timeline_scale,false)
		
		var ds = animations[? current_editing]
		
		//fpersecond = 12
		ind = ((current_time/(1000/fpersecond)))
		
		if ds_list_size(ds) > 0 and  ds_list_find_value(ds, ind mod ds_list_size(ds)) != undefined{
				
		var spr = ds_list_find_value(ds, ind mod ds_list_size(ds))
		
		var aspect = (sprite_get_width(spr)/sprite_get_height(spr))
		var yscale = (window_get_height()-timeline_scale)/sprite_get_height(spr)
		var xscale = (window_get_height()-timeline_scale)/sprite_get_width(spr)*aspect
		
		if sprite_get_width(spr) > sprite_get_height(spr) {
			var yscale = (window_get_height()-timeline_scale)/sprite_get_height(spr)/aspect
			var xscale = (window_get_height()-timeline_scale)/sprite_get_width(spr)
			}
			
		var x1 = sidebar_size + ((window_get_width()-sidebar_size)/2) - ((sprite_get_width(spr)*xscale)/2)
		var y1 = ((window_get_height()-timeline_scale)/2) - ((sprite_get_height(spr)*yscale)/2)
		
		//BG for normal area
		draw_set_alpha(.5)
		draw_rectangle_color(x1, y1, x1+(xscale*sprite_get_width(spr)), y1+(yscale*sprite_get_height(spr)), c_white, c_navy, c_blue, c_teal, false)
		draw_set_alpha(1)
		
		draw_sprite_ext(spr,0,x1, y1, xscale, yscale, 0, c_white, 1)
		draw_set_color(c_white)
		
		}
		
		/// Timeline (Reused from list earlier, i should make this plus spritelist a GUI func.)
		var xd = sidebar_size + 20
		var yd = window_get_height()-timeline_scale+10
		var size = 64
		var i = 0
		repeat ds_list_size(ds) {
			draw_rectangle(xd, yd, xd+size, yd+size, false)
			draw_set_color(c_white)
	
			if point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), xd, yd, xd+size, yd+size) {
				draw_rectangle_color(xd, yd, xd+size, yd+size, c_red, c_red, c_red, c_orange, false)
				if mouse_check_button_released(mb_right) {
					//ds_list_add(global.spritesToDelete, ds[| i])
					ds_list_delete(ds, i)
					i-=1
					if i < 0 break;
					}
				}
		
			var spr = ds[| i]
			draw_sprite_ext(spr, 0, xd,yd,size/sprite_get_width(spr),size/sprite_get_height(spr),0,c_white,1)
			
			draw_rectangle(xd, yd, xd+size, yd+size, true)
			i++
			xd += size + 5
			}
		
			draw_set_color(c_gray)
			draw_rectangle(xd, yd, xd+size, yd+size, false)
			draw_set_color(c_white)
	
			var center = 50 //(current_time/10) mod 100
	
			if point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), xd, yd, xd+size, yd+size) {
				center -= 10
				if mouse_check_button_released(mb_left) {
					var fname = get_open_filename("PNG Images|*.png","")
					if fnameCache[? fname] = undefined {
						spr = sprite_add(fname,1,0,0,0,0)
						fnameCache[? fname] = spr
						ds_list_add(ds, spr)
						} else ds_list_add(ds, fnameCache[? fname])
					}
				}
	
			draw_sprite_ext(spr_plus, 0, xd+(center/2),yd+(center/2),(size-center)/sprite_get_width(spr_plus),(size-center)/sprite_get_height(spr_plus),0,c_white,1)
			draw_rectangle(xd, yd, xd+size, yd+size, true)
		}

// ...

//Draw a plus on a blank box, to add one


