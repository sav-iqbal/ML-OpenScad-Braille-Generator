/*
Braille Module
http://creativecommons.org/licenses/by/3.0/
*/

// V2.0 developed by Richard and Sav

use <fillets3d.scad>; //https://www.thingiverse.com/thing:2461392

// Type desired text here. 
// ONLY USE CAPITAL LETTERS.
// SEE module braille_char FOR SUPPORTED SPECIAL CHARACTERS.
// Use "" for a blank space. 
chars = 
["H","E","L","L","O","","W","O","R","L","D"];

// number of characters. Increase for blank space on the plate
char_count = len(chars);

// define braille size
radius = 1.6/2; // standard braille diameter 1.44, rounded to 1.6 for printability
braille_height = .48;
spacing = 2.34;
distance = 6.2;

// define plate size
plate_height = 0; // 0 for dots only
plate_depth = spacing * 4;
plate_length = distance * (char_count) + distance/2;

$fn = 20; //number of arc facets

// set up bitmap
row_size = 2;
col_size = 3;
bitmap_size = row_size * col_size;

// assemble braille using modules
union()
{
	rotate([0,0,0]) braille_str(chars, char_count);
}

// MODULES

// braille_str transforms each braille character into its position on the plate
module braille_str(chars, char_count) {
	echo(str("Total Width: ", plate_length, "mm"));
	union() {
        //make each braille character
		for (count = [0:char_count-1]) {
			translate([spacing, count * distance + distance/2, plate_height]) {
				braille_char(chars[count]);
			}
		}
        color([0,0,1]) {
            cube([plate_depth, plate_length, plate_height]);         //rectangular prism backing the braille
        }
        
	}
}

// letter creates the dots for each braille character
module letter(bitmap) {	
	// functions to calculate the X and Y positions of each dot
    function loc_x(loc) = floor(loc / row_size) * spacing;
	function loc_y(loc) = loc % row_size * spacing;

    // placing each dot
	for (loc = [0:bitmap_size - 1]) 
    {
		if (bitmap[loc] != 0) 
        {
			union() 
            {
				translate(v = [loc_x(loc), loc_y(loc), 0]) 
                {
                    color([1,0,0])
                    {
                        topFillet(t = braille_height, r = .6/2, s = 20)
                        cylinder(braille_height, radius* bitmap[loc], radius* bitmap[loc]);
                    }
             	}
			}
		}
	}
    
}

// braille layout for each letter
//1 ==> braille dot is placed
//0 ==> no braille dot placed
module braille_char(char) {
	if (char == "A") {
		letter([
			1,0,
			0,0,
			0,0
		]);
	} else if (char == "B") {
		letter([
			1,0,
			1,0,
			0,0
		]);
	} else if (char == "C") {
		letter([
			1,1,
			0,0,
			0,0
		]);
	} else if (char == "D") {
		letter([
			1,1,
			0,1,
			0,0
		]);
	} else if (char == "E") {
		letter([
			1,0,
			0,1,
			0,0
		]);
	} else if (char == "F") {
		letter([
			1,1,
			1,0,
			0,0
		]);
	} else if (char == "G") {
		letter([
			1,1,
			1,1,
			0,0
		]);
	} else if (char == "H") {
		letter([
			1,0,
			1,1,
			0,0
		]);
	} else if (char == "I") {
		letter([
			0,1,
			1,0,
			0,0
		]);
	} else if (char == "J") {
		letter([
			0,1,
			1,1,
			0,0
		]);
	} else if (char == "K") {
		letter([
			1,0,
			0,0,
			1,0
		]);
	} else if (char == "L") {
		letter([
			1,0,
			1,0,
			1,0
		]);
	} else if (char == "M") {
		letter([
			1,1,
			0,0,
			1,0
		]);
	} else if (char == "N") {
		letter([
			1,1,
			0,1,
			1,0
		]);
	} else if (char == "O") {
		letter([
			1,0,
			0,1,
			1,0
		]);
	} else if (char == "P") {
		letter([
			1,1,
			1,0,
			1,0
		]);
	} else if (char == "Q") {
		letter([
			1,1,
			1,1,
			1,0
		]);
	} else if (char == "R") {
		letter([
			1,0,
			1,1,
			1,0
		]);
	} else if (char == "S") {
		letter([
			0,1,
			1,0,
			1,0
		]);
	} else if (char == "T") {
		letter([
			0,1,
			1,1,
			1,0
		]);
	} else if (char == "U") {
		letter([
			1,0,
			0,0,
			1,1
		]);
	} else if (char == "V") {
		letter([
			1,0,
			1,0,
			1,1
		]);
	} else if (char == "W") {
		letter([
			0,1,
			1,1,
			0,1
		]);
	} else if (char == "X") {
		letter([
			1,1,
			0,0,
			1,1
		]);
	} else if (char == "Y") {
		letter([
			1,1,
			0,1,
			1,1
		]);
	} else if (char == "Z") {
		letter([
			1,0,
			0,1,
			1,1
		]);
	} else if (char == "CH") {
		letter([
			1,0,
			0,0,
			0,1
		]);
	} else if (char == "SH") {
		letter([
			1,1,
			0,0,
			0,1
		]);
	} else if (char == "TH") {
		letter([
			1,1,
			0,1,
			0,1
		]);
	} else if (char == "WH") {
		letter([
			1,0,
			0,1,
			0,1
		]);
	} else if (char == "OU") {
		letter([
			1,0,
			1,1,
			0,1
		]);
	} else if (char == "ST") {
		letter([
			0,1,
			0,0,
			1,0
		]);
	} else if (char == "AND") {
		letter([
			1,1,
			1,0,
			1,1
		]);
	} else if (char == "FOR") {
		letter([
			1,1,
			1,1,
			1,1
		]);
	} else if (char == "OF") {
		letter([
			1,0,
			1,1,
			1,1
		]);
	} else if (char == "THE") {
		letter([
			0,1,
			1,0,
			1,1
		]);
	} else if (char == "WITH") {
		letter([
			0,1,
			1,1,
			1,1
		]);
	} else if (char == "IN") {
		letter([
			0,0,
			0,1,
			1,0
		]);
	} else if (char == "EN") {
		letter([
			0,0,
			1,0,
			0,1
		]);
	} else if (char == "CON") {
		letter([
			0,0,
			1,1,
			0,0
		]);
	} else if (char == "DIS") {
		letter([
			0,0,
			1,1,
			0,1
		]);
	} else if (char == "COM") {
		letter([
			0,0,
			0,0,
			1,1
		]);
	} else if (char == "BE") {
		letter([
			0,0,
			1,0,
			1,0
		]);
	} else if (char == "EA") {
		letter([
			0,0,
			1,0,
			0,0
		]);
	} else if (char == "BB") {
		letter([
			0,0,
			1,0,
			1,0
		]);
	} else if (char == "CC") {
		letter([
			0,0,
			1,1,
			0,0
		]);
	} else if (char == "DD") {
		letter([
			0,0,
			1,1,
			0,1
		]);
	} else if (char == "FF") {
		letter([
			0,0,
			1,1,
			1,0
		]);
	} else if (char == "GG") {
		letter([
			0,0,
			1,1,
			1,1
		]);
	} else if (char == "AR") {
		letter([
			0,1,
			0,1,
			1,0
		]);
	} else if (char == "BLE") {
		letter([
			0,1,
			0,1,
			1,1
		]);
	} else if (char == "ED") {
		letter([
			1,1,
			1,0,
			0,1
		]);
	} else if (char == "ER") {
		letter([
			1,1,
			1,1,
			0,1
		]);
	} else if (char == "GH") {
		letter([
			1,0,
			1,0,
			0,1
		]);
	} else if (char == "ING") {
		letter([
			0,1,
			0,0,
			1,1
		]);
	} else if (char == "OW") {
		letter([
			0,1,
			1,0,
			0,1
		]);
	} else if (char == "cap") {
		letter([
			0,0,
			0,0,
			0,1
		]);
	} else if (char == "#") {
		letter([
			0,1,
			0,1,
			1,1
		]);
	} else if (char == "let") {
		letter([
			0,0,
			0,1,
			0,1
		]);
	} else if (char == ".") {
		letter([
			0,0,
			1,1,
			0,1
		]);
	} else if (char == "?") {
		letter([
			0,0,
			1,0,
			1,1
		]);
	} else if (char == "!") {
		letter([
			0,0,
			1,1,
			1,0
		]);
	} else if (char == "-") {
		letter([
			0,0,
			0,0,
			1,1
		]);
	} else if (char == "quote") {
		letter([
			0,0,
			0,1,
			1,1
		]);
	} else if (char == "1") {
		letter([
			0,0,
			1,0,
			0,0
		]);
	} else if (char == "2") {
		letter([
			0,0,
			1,0,
			1,0
		]);
	} else if (char == "3") {
		letter([
			0,0,
			1,1,
			0,0
		]);
	} else if (char == "4") {
		letter([
			0,0,
			1,1,
			0,1
		]);
	} else if (char == "5") {
		letter([
			0,0,
			1,0,
			0,1
		]);
	} else if (char == "6") {
		letter([
			0,0,
			1,1,
			1,0
		]);
	} else if (char == "7") {
		letter([
			0,0,
			1,1,
			1,1
		]);
	} else if (char == "8") {
		letter([
			0,0,
			1,0,
			1,1
		]);
	} else if (char == "9") {
		letter([
			0,0,
			0,1,
			1,0
		]);
	} else if (char == "0") {
		letter([
			0,0,
			0,1,
			1,1
		]);
	} else if (char == "dot3") {
		letter([
			0,0,
			0,0,
			1,0
		]);	
        } else if (char == "dot4") {
		letter([
			0,1,
			0,0,
			0,0
		]);	
	} else if (char == "dot5") {
		letter([
			0,0,
			0,1,
			0,0
		]);	
    } else if (char == "dot6") {
		letter([
			0,0,
			0,0,
			0,1
		]);	
     } else if (char == "dots46") {
		letter([
			0,1,
			0,0,
			0,1
		]);	
     } else if (char == "") {
		letter([
			0,0,
			0,0,
			0,0
		]);	
    } else {
		echo("Invalid Character: ", char);
	}
}