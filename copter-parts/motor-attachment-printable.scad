/*
Jarkko Saltiola
2013

 */

$fn = 70;

tolerance = 0.5;

main_z = 8;

motor_radius = 15.3/2+ tolerance;     // <--- Adjust motor size
wall_thickness = 2.5;

module motor_hole(){
    bigger_hole_radius = 3+ tolerance;

    translate([0,0,main_z/2])  // Move to z=0
    difference(){

        difference(){
        cylinder(r=motor_radius + wall_thickness/2, h=main_z, center=true);
        translate([0,0,wall_thickness])
        cylinder(r=motor_radius, h=7, center=true);  // Moottorin kokoinen reikä
        }
        // Create holes to base
        cylinder(r=bigger_hole_radius, h=10, center=true); // Bigger hole
        // Smaller holes
        translate([0,4.3,0])
  //      cube(size=[3, 1, 10], center=true);
        translate([0,-4.3,0])
        cube(size=[3, 1, 10], center=true);
    }

}

long_tube_z = 19.6;
long_tube_r = 4;  // TODO check
long_tube_x = 15;

long_tube_hole_r = 2.5;    // Hole inner radius
long_tube_cylinder_r = 3+tolerance/2;  // Cylinder holes radius
long_tube_cylinder_h = 4;  //                height


module long_tube() {
    translate([long_tube_x,0,long_tube_z / 2])
    cylinder(r=long_tube_r+tolerance*2, h=long_tube_z, center=true);  // The tube
    // Connector to motor-hole
    // Tube
    translate([11,0,main_z/2])
    cube(size=[10, long_tube_r*2-0.3, main_z], center=true);
    // difference(){

    // }

}

module long_tube_hole() {
    // body...
    translate([long_tube_x,0,long_tube_z / 2]){
        cylinder(r=long_tube_hole_r, h=long_tube_z+1, center=true);

        //Upper cylinder hole
        translate([0,0,long_tube_z - long_tube_cylinder_h])
        cylinder(r=long_tube_cylinder_r, h=long_tube_z+1, center=true);
        //Lower cylinder hole
        translate([0,0,-long_tube_z + long_tube_cylinder_h])
        cylinder(r=long_tube_cylinder_r, h=long_tube_z+1, center=true);
    }
}


small_tube_r = long_tube_r;
small_tube_h = 15;
module small_tube() {
    translate([-small_tube_h+1.5,0,small_tube_r]) rotate([0, 90, 0]) {
        cylinder(r=small_tube_r, h=small_tube_h, center=true);  // attachment
    }

        translate([-15,0,main_z-0.5])
    difference(){
        cylinder(r=2.65, h=2, center=true);
        cylinder(r=1, h=3, center=true);
    }


}


module small_tube_holes() {
    translate([-small_tube_h+1.5,0,small_tube_r]) rotate([0, 90, 0])
    cylinder(r=5/2, h=small_tube_h+2, center=true); // Inner hole

    translate([-12.5,0,0])
    cube(size=[8, 2.4, 16.1], center=true); // Upper and lower holes
}


module side_tube(){
    translate([-18.7, -6, main_z / 2]){
        rotate([90, 0, 0])
        cylinder(r1=2.3, r2=1.75, h=5.6, center=true);

        //side support
        translate([2, 0.8, 0]) rotate([0, 0, 45])
        cube(size=[6, 3, 1], center=true);

    }
}


// ### MAIN ###

difference(){
    long_tube();
    long_tube_hole();
}
difference(){
    union(){
        motor_hole();
        small_tube();
    }
    small_tube_holes();
}

//side_tube();
