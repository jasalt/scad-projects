/*
Jarkko Saltiola
2013

TODO:
- Different hook types
	- Loop for screwdrivers
	- Thin hook
- Pass parameters to hook-function (process in switch of strings?)
	- Length or number of loop-holes
	- Hook type

- Choose most essential variables

*/
$fn=50;

wall_thickness = 3;
hole_width = 10;
hole_height = 10; // 5- for testing only 9.55

claw_length = hole_height + 0.5; //10 hyvä
claw_dist_extra = 0.1;

hook_length = 60;

hook_thickness = 3; //TODO WFT
tip_height = 4;
tip_thickness = 3;



rotate([0,90]) //Uncomment this before exporting stl for printer..
hook();

%test_wall();



module hook(){
	main_height = 4;

	color("Gainsboro"){

		main();
		claws();
		meta_hook();
		tip();
		hook_normal();

	}



	/*Normal style hook*/
	module hook_normal(){
		tip();
		meta_hook();
		translate([0,-wall_thickness -claw_dist_extra -hook_thickness, -claw_length + hook_thickness*2])
		strenghtener();

		module tip() {
			translate([0,-hook_length- wall_thickness + tip_thickness/2, tip_height*1.5 - claw_length]) //TODO tip height to parameter
			cube(size=[hole_width - 1, tip_thickness, tip_height], center=true);
		}


		module meta_hook(){
			translate([0, - wall_thickness - hook_length / 2, -claw_length + main_height/2 + hook_thickness/2])
				cube(size=[hole_width - 1, hook_length, hook_thickness], center=true);

				// Add strength
		}

		module strenghtener(){
			difference(){
					cube(size=[hole_width-1, hook_thickness, hook_thickness], center=true);

					translate([0,-hook_thickness/2,hook_thickness/2]) rotate([0,90])
					cylinder(r=hook_thickness, h=hole_width, center=true);
				}
		}
	}


	/*Common modules for all hook-types*/
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
		// cube(size=[hole_width, wall_thickness + 1, hole_height], center=true);

	}
}