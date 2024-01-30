//3D printer bed support bracket for 2020 extrusion
//2017, John Stäck (john@stack.se)
//Licensed under Creative Commons Attribution Share-Alike (CC BY-SA 3.0)

$fn=36;
e=0.01;

endplate_thickness=2;
bracket_thickness=3;

rail_height=20; //2020 rail
slot_width=6;
notch_depth=1.5;
rail_screw_diameter=5.3; //M5 + margin

slot_nut_length=10;

bed_screw_diameter=3.3; //M3

// "Big bracket" with center hole in bracket
/*
bracket_length=20;
bracket_width=20;
bed_screw_inset_y = bracket_width/2;
bed_screw_inset_x = bracket_length/2;
*/

//Smaller bracket with hole closer to corner, for thumbscrews
bracket_length=14;
bracket_width=16;
bed_screw_inset_y = 5;
bed_screw_inset_x = 5;


difference() {
    union() {
        
       //Base parts of bracket
       translate([-bracket_length/2,0,0]) {
           cube([bracket_length, bracket_width, bracket_thickness]); 
           cube([bracket_length, bracket_thickness, rail_height]);

       }
       
       //Endplate
           translate([bracket_length/2-e, 0, 0]) hull() {
               cube([endplate_thickness, bracket_width, bracket_thickness]);
               cube([endplate_thickness, bracket_thickness, rail_height]);
       }       
       
       //Notch into rail
       notch_points=[[0,-slot_width/2],[notch_depth,-slot_width/2+notch_depth],[notch_depth,slot_width/2],[0,slot_width/2]];
       notch_path=[[0,1,2,3,0]];
       
       translate([bracket_length/2+endplate_thickness,0,rail_height/2]) rotate([90,0,-90])  linear_extrude(height=bracket_length+endplate_thickness) polygon(points=notch_points, paths=notch_path, convexity=2);
       
    }
    
    union() {
        //Holes for mounting bolts to rail
            translate([0, -e, rail_height/2]) rotate([-90,0,0]) cylinder(d=rail_screw_diameter, h=bracket_thickness+2*e);
        
        //Cutout in notch for slot nuts
            translate([-slot_nut_length/2,-notch_depth-e,0]) cube([slot_nut_length,notch_depth+e,rail_height]);
        
        
        //Bed screw hole
        translate([bed_screw_inset_x-bracket_length/2,bracket_width-bed_screw_inset_y, -e]) cylinder(d=bed_screw_diameter, h=bracket_thickness+2*e);
        
    }
}