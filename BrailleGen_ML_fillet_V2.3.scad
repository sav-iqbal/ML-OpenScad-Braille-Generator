/*
Braille Module
http://creativecommons.org/licenses/by/3.0/
*/

// V2.2 developed by Richard and Sav

use <fillets3d.scad>; //https://www.thingiverse.com/thing:2461392

// Type desired text here. 
// SEE module braille_char FOR SUPPORTED SPECIAL CHARACTERS.
// Use "" for a blank space. 
chars = 
["h", "e", "l", "l", "o", "", "w", "o", "r", "l", "d"];

// number of characters. Increase for blank space on the plate
char_count = len(chars);

// define braille size
radius = 1.6/2; // standard braille diameter 1.44, rounded to 1.6 for printability
braille_height = .48;
spacing = 2.34;
distance = 6.2;

// define plate size
plate_height = 3.6; // 0 for dots only
plate_depth = spacing * 4;
plate_length = distance * (char_count - 0.5) + distance/2;

$fn = 20; //number of arc facets
//makes smoother with greater number and less smooth with lower number

// set up bitmap
row_size = 2;
col_size = 3;
bitmap_size = row_size * col_size;

// assemble braille using modules
union()
{
    braille_str(chars, char_count);
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
        color([0,0,1]) { //preview color, blue 
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
                    color([1,0,0]) //preview color, red
                    {
                        topFillet(t = braille_height, r = .6/2, s = 20) //creates braille rounded top
                        cylinder(braille_height, radius* bitmap[loc], radius* bitmap[loc]); //fillet on top of cylinder to make shape
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
	if (char == "A" || char == "a") {
		letter([
			1,0,
			0,0,
			0,0
		]);
	} else if (char == "B" || char == "b") {
		letter([
			1,0,
			1,0,
			0,0
		]);
	} else if (char == "C" || char == "c") {
		letter([
			1,1,
			0,0,
			0,0
		]);
	} else if (char == "D" || char == "d") {
		letter([
			1,1,
			0,1,
			0,0
		]);
	} else if (char == "E" || char == "e") {
		letter([
			1,0,
			0,1,
			0,0
		]);
	} else if (char == "F" || char == "f") {
		letter([
			1,1,
			1,0,
			0,0
		]);
	} else if (char == "G" || char == "g") {
		letter([
			1,1,
			1,1,
			0,0
		]);
	} else if (char == "H" || char == "h") {
		letter([
			1,0,
			1,1,
			0,0
		]);
	} else if (char == "I" || char == "i") {
		letter([
			0,1,
			1,0,
			0,0
		]);
	} else if (char == "J" || char == "j") {
		letter([
			0,1,
			1,1,
			0,0
		]);
	} else if (char == "K" || char == "k") {
		letter([
			1,0,
			0,0,
			1,0
		]);
	} else if (char == "L" || char == "l") {
		letter([
			1,0,
			1,0,
			1,0
		]);
	} else if (char == "M" || char == "m") {
		letter([
			1,1,
			0,0,
			1,0
		]);
	} else if (char == "N" || char == "n") {
		letter([
			1,1,
			0,1,
			1,0
		]);
	} else if (char == "O" || char == "o") {
		letter([
			1,0,
			0,1,
			1,0
		]);
	} else if (char == "P" || char == "p") {
		letter([
			1,1,
			1,0,
			1,0
		]);
	} else if (char == "Q" || char == "q") {
		letter([
			1,1,
			1,1,
			1,0
		]);
	} else if (char == "R" || char == "r") {
		letter([
			1,0,
			1,1,
			1,0
		]);
	} else if (char == "S" || char == "s") {
		letter([
			0,1,
			1,0,
			1,0
		]);
	} else if (char == "T" || char == "t") {
		letter([
			0,1,
			1,1,
			1,0
		]);
	} else if (char == "U" || char == "u") {
		letter([
			1,0,
			0,0,
			1,1
		]);
	} else if (char == "V" || char == "v") {
		letter([
			1,0,
			1,0,
			1,1
		]);
	} else if (char == "W" || char == "w") {
		letter([
			0,1,
			1,1,
			0,1
		]);
	} else if (char == "X" || char == "x") {
		letter([
			1,1,
			0,0,
			1,1
		]);
	} else if (char == "Y" || char == "y") {
		letter([
			1,1,
			0,1,
			1,1
		]);
	} else if (char == "Z" || char == "z") {
		letter([
			1,0,
			0,1,
			1,1
		]);
	} else if (char == "CH" || char == "ch") {
		letter([
			1,0,
			0,0,
			0,1
		]);
	} else if (char == "SH" || char == "sh") {
		letter([
			1,1,
			0,0,
			0,1
		]);
	} else if (char == "TH" || char == "th") {
		letter([
			1,1,
			0,1,
			0,1
		]);
	} else if (char == "WH" || char == "wh") {
		letter([
			1,0,
			0,1,
			0,1
		]);
	} else if (char == "OU" || char == "ou") {
		letter([
			1,0,
			1,1,
			0,1
		]);
	} else if (char == "ST" || char == "st") {
		letter([
			0,1,
			0,0,
			1,0
		]);
	} else if (char == "AND" || char == "and") {
		letter([
			1,1,
			1,0,
			1,1
		]);
	} else if (char == "FOR" || char == "for") {
		letter([
			1,1,
			1,1,
			1,1
		]);
	} else if (char == "OF" || char == "of") {
		letter([
			1,0,
			1,1,
			1,1
		]);
	} else if (char == "THE" || char == "the") {
		letter([
			0,1,
			1,0,
			1,1
		]);
	} else if (char == "WITH" || char == "with") {
		letter([
			0,1,
			1,1,
			1,1
		]);
	} else if (char == "IN" || char == "in") {
		letter([
			0,0,
			0,1,
			1,0
		]);
	} else if (char == "EN" || char == "en") {
		letter([
			0,0,
			1,0,
			0,1
		]);
	} else if (char == "CON" || char == "con") {
		letter([
			0,0,
			1,1,
			0,0
		]);
	} else if (char == "DIS" || char == "dis") {
		letter([
			0,0,
			1,1,
			0,1
		]);
	} else if (char == "COM" || char == "com") {
		letter([
			0,0,
			0,0,
			1,1
		]);
	} else if (char == "BE" || char == "be") {
		letter([
			0,0,
			1,0,
			1,0
		]);
	} else if (char == "EA" || char == "ea") {
		letter([
			0,0,
			1,0,
			0,0
		]);
	} else if (char == "BB" || char == "bb") {
		letter([
			0,0,
			1,0,
			1,0
		]);
	} else if (char == "CC" || char == "cc") {
		letter([
			0,0,
			1,1,
			0,0
		]);
	} else if (char == "DD" || char == "dd") {
		letter([
			0,0,
			1,1,
			0,1
		]);
	} else if (char == "FF" || char == "ff") {
		letter([
			0,0,
			1,1,
			1,0
		]);
	} else if (char == "GG" || char == "gg") {
		letter([
			0,0,
			1,1,
			1,1
		]);
	} else if (char == "AR" || char == "ar") {
		letter([
			0,1,
			0,1,
			1,0
		]);
	} else if (char == "BLE" || char == "ble") {
		letter([
			0,1,
			0,1,
			1,1
		]);
	} else if (char == "ED" || char == "ed") {
		letter([
			1,1,
			1,0,
			0,1
		]);
	} else if (char == "ER" || char == "er") {
		letter([
			1,1,
			1,1,
			0,1
		]);
	} else if (char == "GH" || char == "gh") {
		letter([
			1,0,
			1,0,
			0,1
		]);
	} else if (char == "ING" || char == "ing") {
		letter([
			0,1,
			0,0,
			1,1
		]);
	} else if (char == "OW" || char == "ow") {
		letter([
			0,1,
			1,0,
			0,1
		]);
	} else if (char == "cap" || char == "CAP") {
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
	} else if (char == "let" || char == "LET") {
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
	} else if (char == "quote" || char == "QUOTE") {
		letter([
			0,0,
			0,1,
			1,1
		]);
	} else if (char == "1") {
		letter([
			1,0,
			0,0,
			0,0
		]);
	} else if (char == "2") {
		letter([
			1,0,
			1,0,
			0,0
		]);
	} else if (char == "3") {
		letter([
			1,1,
			0,0,
			0,0
		]);
	} else if (char == "4") {
		letter([
			1,1,
			0,1,
			0,0
		]);
	} else if (char == "5") {
		letter([
			1,0,
			0,1,
			0,0
		]);
	} else if (char == "6") {
		letter([
			1,1,
			1,0,
			0,0
		]);
	} else if (char == "7") {
		letter([
			1,1,
			1,1,
			0,0
		]);
	} else if (char == "8") {
		letter([
			1,0,
			1,1,
			0,0
		]);
	} else if (char == "9") {
		letter([
			0,1,
			1,0,
			0,0
		]);
	} else if (char == "0") {
		letter([
			0,1,
			1,1,
			0,0
		]);
	} else if (char == "dot3" || char == "DOT3") {
		letter([
			0,0,
			0,0,
			1,0
		]);	
        } else if (char == "dot4" || char == "DOT4") {
		letter([
			0,1,
			0,0,
			0,0
		]);	
	} else if (char == "dot5" || char == "DOT5") {
		letter([
			0,0,
			0,1,
			0,0
		]);	
    } else if (char == "dot6" || char == "DOT6") {
		letter([
			0,0,
			0,0,
			0,1
		]);	
     } else if (char == "dots46" || char == "DOTS46") {
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
