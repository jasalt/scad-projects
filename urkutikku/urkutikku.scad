
old();

module old(){

width = 05.85;
length = 62.15;
thickness = 2.1;

hole_fromtop = 3.6;
hole_halkaisija = 2.9;

cut_height = 0.7;
cut_distance = 2.3;
cuts_frombottom = 14.4;
cuts = 10;

$fn = 100;


difference(){
    cube(size=[width, length, thickness], center=true);

    // Hole to the upper end
    translate([0,length/2 - hole_fromtop])
    cylinder(r=hole_halkaisija/2, h=10, center=true);

    // Cuts
    for (i = [0 : cuts - 1]){
        translate([-width/4, - length/2 + cuts_frombottom + i * (cut_height + cut_distance) ,0])
        cube(size=[width / 2 + 0.1, 0.8, thickness+1], center=true);

        }
    }
}