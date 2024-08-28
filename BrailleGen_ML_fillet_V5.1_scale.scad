/*
Braille Module
http://creativecommons.org/licenses/by/3.0/
Developed by Sav, Richard, and the Mountain Lakes Public Library Makerspace

We use branah.com to generate the Grade 2 ASCII braille that this program accepts on line 22
https://www.branah.com/braille-translator

Single line: 
Paste the Grade 2 ASCII braille into the array as a string
"hello world" 
EXAMPLE: text_input = ["HELLO _W"];

Multi line: 
Paste each line of Grade 2 ASCII braille into the array on line 22 as separate strings
"hello world"
"woah multi line" 
EXAMPLE: text_input = ["HELLO _W", "WOAH MULTI L9E"];
 */
assert(version()[0] > 2023, "Use latest dev version of OpenSCAD with fast_csg feature enabled for speedy rendering! https://openscad.org/downloads.html#snapshots"); // comment out this line if you do not want to use the dev version!

text_input = ["HELLO _W", "WOAH MULTI L9E"]; // ENTER Grade 2 ASCII braille HERE

/*
Change to export the STL at a different scale. 1 is the default for no scaling.
Can solve model import sizing issues because .stl is a unitless format.
*/
export_scale = 1;

// define braille dot size
// https://brailleauthority.org/size-and-spacing-braille-characters
diameter = 1.6; // 1.44 standard braille diameter, rounded to 1.6 for printability with .4 mm nozzle
radius = diameter / 2; 
braille_height = .6; // .48 standard braille dot height, rounded to .6 for printability with .2 mm layer height
fillet_radius = .4; // must be less than radius and braille height

// define braille cell size
spacing = 2.54; // 2.34 standard braille dot spacing within a cell, rounded to 2.54 mm for printability
distance = 6.2; // 6.2 standard braille cell spacing between corresponding dots

// define braille starting position
letfc = 2; // left edge to first column of braille

// define plate size
plate_height = 1; // 0 for dots only, z axis dimension
plate_depth = spacing * 4; // x axis dimension

// set up braille cell bitmap
row_size = 2;
col_size = 3;
bitmap_size = row_size * col_size;

// braille dot revolve profile points
points = concat([[0,braille_height],[0,0],[radius,0]],[for(a = [0:18:90]) [fillet_radius * cos(a) + radius-fillet_radius, fillet_radius * sin(a) + braille_height-fillet_radius]]);

scale([export_scale, export_scale, export_scale]) {
    union(){
        for (line = [0 : len(text_input) - 1]) {  
            current_line = [for (c = [0 : len(text_input[line]) - 1]) text_input[line][c]];
            braille_str(current_line, line);
        }
    }
}    

/* MODULES
assemble braille tile using modules

braille_str calls braille_char
braille_char calls letter
*/

// braille_str transforms each braille character into its position on the plate
module braille_str(chars, line_number) {
	union() {
        //make each braille character
        plate_length = (distance * len(chars)) + letfc - diameter; // y axis dimension
        translate([line_number * plate_depth,0,0]) {
            for (count = [0:len(chars) - 1]) {
                translate([spacing, count * distance + letfc, plate_height]) {
                    braille_char(chars[count]);
                }
            }
            color([19/255,56/255,190/255]) { //preview color, blue 
                cube([plate_depth, plate_length, plate_height]); //rectangular prism backing the braille
            }
        }
	}
}

// letter creates the dots for each braille character
module letter(bitmap) {	
	// functions to calculate the X and Y positions of each dot
    function loc_x(loc) = floor(loc / row_size) * spacing;
	function loc_y(loc) = loc % row_size * spacing;
    // placing each dot
	for (loc = [0:bitmap_size - 1]) {
		if (bitmap[loc] != 0) {
			union() {
				translate(v = [loc_x(loc), loc_y(loc), 0]) {
                    color([255/255,104/255,49/255]) { //preview color, orange
                        rotate_extrude($fn = 20) // revolve each braille dot
                            polygon(points);
                    }
             	}
			}
		}
	}
}

// braille layout for each letter
// 1 ==> braille dot is placed
// 0 ==> no braille dot placed
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
	} else if (char == "@" || char == "@") {
		letter([
			0,1,
			0,0,
			0,0
		]);
	} else if (char == "!" || char == "!") {
		letter([
			0,1,
			1,0,
			1,1
		]);
	} else if (char == "#" || char == "#") {
		letter([
			0,1,
			0,1,
			1,1
		]);
	} else if (char == "$" || char == "$") {
		letter([
			1,1,
			1,0,
			0,1
		]);
	} else if (char == "%" || char == "%") {
		letter([
			1,1,
			0,0,
			0,1
		]);
	} else if (char == "&" || char == "&") {
		letter([
			1,1,
			1,0,
			1,1
		]);
	} else if (char == "'" || char == "'") {
		letter([
			0,0,
			0,0,
			1,0
		]);
	} else if (char == "(" || char == "(") {
		letter([
			1,0,
			1,1,
			1,1
		]);
	} else if (char == ")" || char == ")") {
		letter([
			0,1,
			1,1,
			1,1
		]);
	} else if (char == "*" || char == "*") {
		letter([
			1,0,
			0,0,
			0,1
		]);
	} else if (char == "+" || char == "+") {
		letter([
			0,1,
			0,0,
			1,1
		]);
	} else if (char == "," || char == ",") {
		letter([
			0,0,
			0,0,
			0,1
		]);
	} else if (char == "-" || char == "-") {
		letter([
			0,0,
			0,0,
			1,1
		]);
	} else if (char == "." || char == ".") {
		letter([
			0,1,
			0,0,
			0,1
		]);
	} else if (char == "/" || char == "/") {
		letter([
			0,1,
			0,0,
			1,0
		]);
	} else if (char == "0" || char == "0") {
		letter([
			0,0,
			0,1,
			1,1
		]);
	} else if (char == "1" || char == "1") {
		letter([
			0,0,
			1,0,
			0,0
		]);
	} else if (char == "2" || char == "2") {
		letter([
			0,0,
			1,0,
			1,0
		]);
	} else if (char == "3" || char == "3") {
		letter([
			0,0,
			1,1,
			0,0
		]);
	} else if (char == "4" || char == "4") {
		letter([
			0,0,
			1,1,
			0,1
		]);
	} else if (char == "5" || char == "5") {
		letter([
			0,0,
			1,0,
			0,1
		]);
	} else if (char == "6" || char == "6") {
		letter([
			0,0,
			1,1,
			1,0
		]);
	} else if (char == "7" || char == "7") {
		letter([
			0,0,
			1,1,
			1,1
		]);
	} else if (char == "8" || char == "8") {
		letter([
			0,0,
			1,0,
			1,1
		]);
	} else if (char == "9" || char == "oun") {
		letter([
			0,1,
			0,0,
			0,1
		]);
	} else if (char == ":" || char == ":") {
		letter([
			1,0,
			0,1,
			0,1
		]);
	} else if (char == ";" || char == ";") {
		letter([
			0,0,
			0,1,
			0,1
		]);
	} else if (char == "<") {
		letter([
			1,0,
			1,0,
			0,1
		]);
	} else if (char == "=" || char == "=") {
		letter([
			1,4,
			2,5,
			3,6
		]);
	} else if (char == ">") {
		letter([
			0,1,
			0,1,
			1,0
		]);
	} else if (char == "?") {
		letter([
			1,1,
			0,1,
			0,1
		]);
	} else if (char == "!") {
		letter([
			0,0,
			1,1,
			1,0
		]);
	} else if (char == "[") {
		letter([
			0,1,
			1,0,
			0,1
		]);
	} else if (char == "]") {
		letter([
			1,1,
			1,1,
			0,1
		]);
	} else if (char == "^") {
		letter([
			0,1,
			0,1,
			0,0
		]);
	} else if (char == "_") {
		letter([
			0,1,
			0,1,
			0,1
		]);
    } else if (char == "{") { // replacing backslash <\>
		letter([
			1,0,
			1,1,
			0,1
		]);
    } else if (char == "}") { // replacing forwardslash </>
		letter([
			0,1,
			0,0,
			1,0
		]);
    } else if (char == "|") { // replacing quote <">
		letter([
			0,0,
			0,1,
			0,0
		]);
     } else if (char == " ") {
		letter([
			0,0,
			0,0,
			0,0
		]);	
    } else {
		echo(str("Invalid Character: < ", char, " >"));
	}
}
// what are you doing down here :P