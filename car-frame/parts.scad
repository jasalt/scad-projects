// Parts for prototyping body
$fn = 80;


// Brushless DC Motor from Canon printer + toy car wheels
module motor(){
    base_length = 37.3;
    base_radius = 27.6 / 2;
    reinforcement_length = 20;
    reinformement_fromfront = 4.3;
    reinforcement_radius = (29.7 / 2);
    shaft_base_radius = 10 / 2;
    shaft_base_length = 3;

    shaft_radius = 1;
    shaft_length = 2;
    wheel_radius = 42 / 2;
    wheel_thickness = 20;

    // Base
    cylinder(r=base_radius, h=base_length, center=true);

    // Reinforcement
    translate([0, 0, reinformement_fromfront]){
    cylinder(r=reinforcement_radius, h=reinforcement_length, center=true);

    translate([0,0,base_length])
    cylinder(r=shaft_radius, h=shaft_length, center=true);

    }
}

// Arduino + motorshield + protoshield
module brains(){
    brain_x = 56.7;
    brain_y = 75.0;
    brain_z = 37.0;
//TODO

}

// Turnigy 7.4V 5Ah 2C
module battery(){
    batt_x = 135.0; // Length
    batt_y = 44.6;  // Width
    batt_z = 23.5;  // Height
//TODO
}




color("lightgray")
motor();