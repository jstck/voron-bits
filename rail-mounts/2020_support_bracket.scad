$fn=72;

bracket_width=20;   //For 2020 rails
hole_d = 5.3;       //M5 + some margin
bracket_length=50;  //Could be 40 for symmetry, but add some margin
bracket_thickness=4;


difference() {
    cube([bracket_length, bracket_width, bracket_thickness]);

    translate([bracket_width/2, bracket_width/2, -1]) cylinder(d=hole_d, h=bracket_thickness+2);
    translate([bracket_length-bracket_width/2, bracket_width/2, -1]) cylinder(d=hole_d, h=bracket_thickness+2);
}