/*
Jarkko Saltiola
2013

*/

$fn = 300;

main_z = 8;

motor_radius = 13/2;
wall_thickness = 1.3;

module motor_hole(){
    bigger_hole_radius = 3;

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
        translate([0,4,0])
        cube(size=[3, 1, 10], center=true);
        translate([0,-4,0])
        cube(size=[3, 1, 10], center=true);
    }

}

long_tube_z = 20;
long_tube_r = 3;  // TODO check
long_tube_thickness = 1;
long_tube_x = 15;

module long_tube() {
    translate([long_tube_x,0,long_tube_z / 2])
    cylinder(r=long_tube_r, h=long_tube_z, center=true);  // The tube
    // Connector to motor-hole
    // Tube
    translate([11,0,main_z/2])
    cube(size=[10, long_tube_r*2, main_z], center=true);
    // difference(){

    // }

}

module long_tube_hole() {
    // body...
    translate([long_tube_x,0,long_tube_z / 2])
    cylinder(r=long_tube_r - wall_thickness/2, h=long_tube_z+1, center=true);
}




motor_hole();
difference(){
long_tube();
long_tube_hole();
}