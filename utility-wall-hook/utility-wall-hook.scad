/*
Jarkko Saltiola
2013


*/

wall_thickness = 2;
hole_width = 9.4;
hole_height = 9.55; // for testing only 9.55

claw_length = hole_height + 0.5; //10 hyvä
claw_dist_extra = 0.1;

hook_length = 35;

hook_thickness = 3;
tip_height = 4;
tip_thickness = 3;


// rotate([0,90]) //Uncomment this before exporting stl for printer..
test_wall();

color("Gainsboro")
hook();

module hook(){
	main_height = 2;



	main();
	claws();
	meta_hook();
	tip();

	module tip() {
		translate([0,-hook_length- wall_thickness + tip_thickness/2, tip_height*1.5 - claw_length]) //TODO tip height to parameter
		cube(size=[hole_width - 1, tip_thickness, tip_height], center=true);
	}


	module meta_hook(){
		translate([0,-wall_thickness - hook_length/2,  - claw_length + hook_thickness])
		cube(size=[hole_width - 1, hook_length, hook_thickness], center=true);
	}

	module claws(){		
		translate([0, wall_thickness, -claw_length/2 + main_height/2]){
			difference(){
				cube(size=[hole_width - 1, wall_thickness, claw_length], center=true);
				rotate([-8,0,0]) translate([0,+wall_thickness/2,0])
				cube(size=[hole_width, wall_thickness, claw_length+5], center=true);
			}
		}

		translate([0, -wall_thickness -claw_dist_extra, -claw_length/2 + main_height/2])
		cube(size=[hole_width - 1, wall_thickness , claw_length], center=true);
	}

	module main(){
	difference(){
		cube(size=[hole_width - 1, wall_thickness * 2, main_height], center=true);
		// rotate([-8,0,0]) translate([0,+wall_thickness,0])
		// cube(size=[hole_width, wall_thickness, claw_length+5], center=true);		
	}

	}
}

module test_wall() {
	color("gray")
	difference(){
		cube(size=[30, wall_thickness, 30], center=true);
		cube(size=[hole_width, wall_thickness + 1, hole_height], center=true);
				
	}
}