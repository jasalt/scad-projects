/*
Jarkko Saltiola
2013


*/

wall_thickness = 2;
hole_width = 5;
hole_height = 5; // for testing only

claw_length =10;
claw_dist_extra = 0.1;

hook_length = 20;

hook_thickness = 3;
tip_thickness = 2;



color("Gainsboro")
hook();
test_wall();

module hook(){
	main_height = 2;



	main();
	claws();
	meta_hook();
	tip();

	module tip() {
		translate([0,-hook_length- wall_thickness + tip_thickness/2, -5])
		cube(size=[hole_width - 1, tip_thickness, 4], center=true);
	}


	module meta_hook(){
		translate([0,-wall_thickness - hook_length/2,-hook_thickness/2 - claw_length/2])
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