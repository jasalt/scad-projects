/*
Jarkko Saltiola
2013

3D Printer Hot-End Cooler Fan Holder / "air director"

40mm fan dimensions http://www.endpcnoise.com/cgi-bin/e/40mmpapst.html
- Outside 40x40x10 mm
- Screw hole distance 32mm


This is one of my first openscad-scripts so it's very far from perfect.
You can currently adjust tube thickness easily, but other modifications
demand some attention to the code.

*/


tube(); //Tube-part
// platform(); //Clamp-part

//Adjust tube thickness
thickness = 0.52 * 3; // for 3 perimeters (juslem-prusa)



/*Jungle of modules starts from here*/

fan_width = 40;
module tube(){
	rotate([-90,0,0]){
		color("gray"){
			hole(thickness);
			translate([3,-3.5,22]) rotate([90,0,-90])
			clamps(3,7,1.3,2);
		}
	}
}

module holes(){
	hole_r = 3.5/2;
	hole_h = 3;
	hole_dist = 32;

	$fn=15;
	cylinder(r=hole_r, h=hole_h, center=true);

	translate([-hole_dist,0,0])
	cylinder(r=hole_r, h=hole_h, center=true);
	
	translate([0,-hole_dist,0])
	cylinder(r=hole_r, h=hole_h, center=true);


	translate([-hole_dist,-hole_dist,0])
	cylinder(r=hole_r, h=hole_h, center=true);
}

module platform(){
	translate()

	clamp();
	
	translate([0,5,0])
	reinforcement();
	translate([1.5,-3,2]) rotate([180,90,0])
	clamps(2,6,1.3,2);

	module reinforcement(){
		rotate([0, 90, 0])
		difference(){
			translate([0,-5,0])
			cylinder(r=5, h=8, center=true);

			//Delete parts from cylinder
			translate([3,-4, 0]) //TODO adjusting this is ugly because of the rotation..
			cube(size=[4, 10, 10], center=true);
			translate([3,-8, 0]) 
			cube(size=[20, 6, 15], center=true);
			}
	}


	module clamp(){
		clamp_width = 12;
		clamp_height = 2;
		clamp_length = 20;
		screwhole_diameter = 3;

		module solid(){
			translate([0,clamp_length/2,0]) 
			cube(size=[clamp_width, clamp_length, clamp_height], center=true);
			
			translate([0,clamp_length,0]) 
			cylinder(r=clamp_width/2, h=clamp_height, center=true);
		}

		difference(){
			solid();
			translate([0,clamp_length,0]) 
			cylinder(r=screwhole_diameter, h=clamp_height+1, center=true, $fn=30);


		}
	}
}


/*Add clamps
count: number of clamps
clamp_width: width of clamp
clamp_strength: depth of clamp
screwhole_diameter: ..
*/
module clamps(count, clamp_width, clamp_strength, screwhole_diameter){
	//TODO adjust clamp distance
	for (i = [0 : count-1]){
		translate([0, 0, i*3])
		clamp();
	}

	//Single clamp
	module clamp(){

		module solid(){
			cube(size=[clamp_width, clamp_width, clamp_strength], center=true);
			translate([0,clamp_width/2,0]) 
			
			cylinder(r=clamp_width/2, h=clamp_strength, center=true);
		}

		difference(){
			solid();
			translate([0,clamp_width/2,0]) 
			cylinder(r=screwhole_diameter, h=clamp_strength+0.1, center=true, $fn=15);
		}
	}

}

/* Create tube with holes */
module hole(strength) {
	difference(){
		solid(1);
		
		translate([fan_width/2 -4 ,-1,fan_width/2 -4]) rotate([90,0,0])
		holes();

		// Add hole to the tube
		translate([0, -(fan_width/2)-2, 0]) rotate([90,0,0])
		cylinder(r1=(fan_width-strength)/2, r2=(31.6-strength)/2, h=45, center=true);

		//Add hole to top side TODO: nicer edge
		translate([0, -45, 19]) rotate([0,0,0]) scale([1,2.4,1])
		cylinder(r=14, h=30, center=true);
	}
}

mink_value = 1;
/* Create "solid tube" with bottom layer  */
module solid(strength){
	translate([0, -(fan_width/2)-2, 0]) rotate([90,0,0])
	cylinder(r1=fan_width/2, r2=31.6/2, h=40, center=true);

	rotate([90,0,0]) translate ([-(fan_width/2) + mink_value/2,-(fan_width/2) + mink_value/2,0])
	
	//Create the bottom layer (part that has screw-holes)
	minkowski(){
	cube(size=[fan_width - mink_value, fan_width - mink_value, 2], center=false);
	cylinder(r=mink_value, h=0.01, center=true, $fn=30, center=false);
	}
}