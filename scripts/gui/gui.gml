function button(x1, y1, x2, y2, color, highcolor, outline, text_or_sprite) {
	var rreturn= -1
	var mode = "text"
	if is_real(text_or_sprite) mode = "sprite"
	
	var order = order_least_greatest(x1, x2)
	var yorder = order_least_greatest(y1, y2)
	
	//
	if mode = "text" {
		var length = string_width(text_or_sprite)
		if length-10 > order[1]-order[0] x2 = x1+length+10
		}
		
	var order = order_least_greatest(x1, x2)
	
	random_set_seed(y1)
	
	var outline_col = make_color_hsv(166.458333334,178.5,100.15)
	
	#region
	if outline {
	
	var density = 5
	//var yorder = order_least_greatest(y1, y2)
	
	var iy = 0
	repeat (yorder[1]-yorder[0])/density {
		draw_circle_color(x1, yorder[0]+iy+(density/2),  irandom_range(density+1, density-1), outline_col, outline_col, false)
		iy+= density
		
		}
		
	var iy = 0
	repeat (yorder[1]-yorder[0])/density {
		draw_circle_color(x2, yorder[0]+iy+(density/2),  irandom_range(density+1, density-1), outline_col, outline_col, false)
		iy+= density
		
		}
		
	//var order = order_least_greatest(x1, x2)
	
	var ix = 0
	repeat (order[1]-order[0])/density {
		draw_circle_color(order[0]+ix+(density/2), y1, irandom_range(density+1, density-1), outline_col, outline_col, false)
		ix+= density
		
		}
		
	var ix = 0
	repeat (order[1]-order[0])/density {
		draw_circle_color(order[0]+ix+(density/2), y2, irandom_range(density+1, density-1), outline_col, outline_col, false)
		ix+= density
		
		}
		
	//
	
	var ix = 0
	var iy = 0
	var size = 7
	repeat (order[1]-order[0])/density {
		ix+= density
		var size = 7
		var iy = 0
		if irandom_range(0, 1) = 1 repeat irandom_range(0, 6) {
			size -=irandom_range(.1, 2)
			iy += 5
			draw_circle_color(order[0]+ix+(density/2), iy+yorder[1], size, outline_col, outline_col, false)
			}
		}
		
	}
	#endregion
	
	draw_rectangle_color(x1, y1, x2, y2, color, color, color, color, false)
	
	if point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), x1, y1, x2, y2) {
		var rreturn= 0 //Return hover
		draw_rectangle_color(x1, y1, x2, y2, highcolor, highcolor, highcolor, highcolor, false)
		if mouse_check_button_released(mb_left) {
		var rreturn= 1 // Return release
		}
	}

if mode = "text" { 
	
	draw_text_outlined(order[0] + 5, yorder[0], c_dkgray, c_gray, text_or_sprite)
	
	}

return rreturn
}


function funkin_line(x1,y1,x2,y2,col) {

	var order = order_least_greatest(x1, x2)
	var yorder = order_least_greatest(y1, y2)


	var ix = order[0]
	var iy = yorder[0]
	var size = 7
	
	var density = 5

	var dir = point_direction(x1, y1, x2, y2)

	draw_sprite(spr_splot, 0, ix, iy)

	repeat (point_distance(x1, y1, x2, y2))/density {

			draw_circle_color(ix, iy, size, col, col, false)
			
			if irandom_range(0, 50) = 50 draw_sprite(spr_splot, 0, ix, iy)
		
			ix += lengthdir_x(density, dir)
			iy += lengthdir_y(density, dir)
			
			size = irandom_range(4, 9)
		}
		
	draw_sprite(spr_splot, 0, ix, iy)
	}