shader_type canvas_item;

// This is disgusting, but it's only until I can figure out how arrays work in shaders
uniform vec4 color0: source_color = vec4(0, 0, 0, 1);
uniform vec4 color1: source_color = vec4(.8, .8, .3, 1);
uniform vec4 color2: source_color = vec4(.4, .2, .6, 1);
uniform vec4 color3: source_color = vec4(.9, .7, .1, 1);
uniform vec4 color4: source_color = vec4(.0, .1, .4, 1);
uniform vec4 color5: source_color = vec4(.2, .5, .7, 1);
uniform vec4 color6: source_color = vec4(.9, .4, .3, 1);
uniform vec4 color7: source_color = vec4(.8, .8, .3, 1);
uniform vec4 color8: source_color = vec4(.8, .8, .3, 1);
uniform vec4 color9: source_color = vec4(.8, .8, .3, 1);
uniform vec4 color10: source_color = vec4(.8, .8, .3, 1);
uniform vec4 color11: source_color = vec4(.8, .8, .3, 1);
uniform vec4 color12: source_color = vec4(.8, .8, .3, 1);
uniform vec4 color13: source_color = vec4(.8, .8, .3, 1);
uniform vec4 color14: source_color = vec4(.8, .8, .3, 1);
uniform vec4 color15: source_color = vec4(.8, .8, .3, 1);

void fragment() {
    vec4 original_color = texture(TEXTURE, UV);
	vec4 output_color = vec4(0);
    
    // Calculate the palette index from the red channel.
	int index = clamp(int(original_color.r * 255.0) / 16, 0, 15);
	
	if (index == 0)
		output_color = color0;
	else if (index == 1)
		output_color = color1;
	else if (index == 2)
		output_color = color2;
	else if (index == 3)
		output_color = color3;
	else if (index == 4)
		output_color = color4;
	else if (index == 5)
		output_color = color5;
	else if (index == 6)
		output_color = color6;
	else if (index == 7)
		output_color = color7;
	else if (index == 8)
		output_color = color8;
	else if (index == 9)
		output_color = color9;
	else if (index == 10)
		output_color = color10;
	else if (index == 11)
		output_color = color11;
	else if (index == 12)
		output_color = color12;
	else if (index == 13)
		output_color = color13;
	else if (index == 14)
		output_color = color14;
	else if (index == 15)
		output_color = color15;
	
    output_color.a = original_color.a; // Preserve the alpha channel

    COLOR = output_color;
}