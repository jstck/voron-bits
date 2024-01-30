$fn=90;
length = 80; //Hole c-c distance, not overall length

width = 20;

hole_d = 5.4; //Clearance for M5 screws

thickness = 4;

difference() {
    union() {
        cube([length, width, thickness]);
        
        for(i=[0,1])
            translate([i*length, width/2, 0]) cylinder(d=width, h=thickness);
    }
    
    
    union() {
        for(i=[0,1])
            translate([i*length, width/2, -1]) cylinder(d=hole_d, h=thickness+2);
    }
}
    