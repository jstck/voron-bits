//3D printer z-nut bracket for 2020 extrusion
//2017, John Stäck (john@stack.se)
//Licensed under Creative Commons Attribution Share-Alike (CC BY-SA 3.0)


$fn=72;

rail_height=20; //2020 rail
slot_width=6;
notch_depth=1.5;
rail_screw_diameter=5.3; //M5 + margin

nut_diameter=22;
axle_hole = 10.4; //Just 8mm axle, but nut has 10mm collar, some margin for it.
nut_screw_diameter=3.3; //M3 + margin
nut_screw_distance=16;

slot_nut_length=10;

bracket_length=40;
bracket_width=26;
endplate_thickness=2;
bracket_thickness=4;
e=0.01;



difference() {
    union() {
        
       //Base parts of bracket
       translate([-bracket_length/2,0,0]) {
           cube([bracket_length, bracket_width, bracket_thickness]); 
           cube([bracket_length, bracket_thickness, rail_height]);

       }
       
       //Endplates
       for(i=[-1,1]) {
           translate([i*(bracket_length/2-e), 0, 0]) hull() {
               cube([endplate_thickness, bracket_width, bracket_thickness]);
               scale([i,1,1]) cube([endplate_thickness, bracket_thickness, rail_height]);
           }
       }       
       
       //Notch into rail
       notch_points=[[0,-slot_width/2],[notch_depth,-slot_width/2+notch_depth],[notch_depth,slot_width/2],[0,slot_width/2]];
       notch_path=[[0,1,2,3,0]];
       
       translate([bracket_length/2+endplate_thickness,0,rail_height/2]) rotate([90,0,-90])  linear_extrude(height=bracket_length+endplate_thickness*2) polygon(points=notch_points, paths=notch_path, convexity=2);
       
    }
    
    union() {
        //Holes for mounting bolts to rail
        for(i=[-1,1])
            translate([i*bracket_length/4, -e, rail_height/2]) rotate([-90,0,0]) cylinder(d=rail_screw_diameter, h=bracket_thickness+2*e);
        
        //Cutout in notch for slot nuts
         for(i=[-1,1])
            translate([i*bracket_length/4-slot_nut_length/2,-notch_depth-e,0]) cube([slot_nut_length,notch_depth+e,rail_height]);
        
        translate([0,bracket_width-nut_diameter/2, -e]) {
            
            //Axle hole
            cylinder(d=axle_hole, h=bracket_thickness+2*e);
            
            //Mounting screws
            for(v=[0:90:270]) {
                rotate([0,0,v]) translate([nut_screw_distance/2,0,0]) cylinder(d=nut_screw_diameter, h=bracket_thickness+2*e);
            }
        }
        
    }
}