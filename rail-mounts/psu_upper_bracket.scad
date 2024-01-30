$fn=36;

rail_height=20; //2020 rail
slot_width=6;
notch_depth=1.5;
rail_screw_diameter=4.3; //M4 + margin

psu_screw_diameter = rail_screw_diameter;
psu_screw_slot_length = 6;
psu_screw_offset = 32;
slot_nut_length=10;

bracket_length=20;
bracket_width=psu_screw_offset+psu_screw_slot_length/2+4;
endplate_thickness=3;
bracket_thickness=3;
e=0.01;



difference() {
    union() {
        
       //Base parts of bracket
       translate([-bracket_length/2,0,0]) {
           cube([bracket_thickness, bracket_width, rail_height]); 
           cube([bracket_length, bracket_thickness, rail_height]);

       }
       
       //Endplate
       translate([-bracket_length/2, 0, 0]) hull() {
           cube([bracket_length, bracket_thickness, bracket_thickness]);
           cube([bracket_thickness, bracket_width, bracket_thickness]);
       }
    
       
       //Notch into rail
       notch_points=[[0,-slot_width/2],[notch_depth,-slot_width/2+notch_depth],[notch_depth,slot_width/2],[0,slot_width/2]];
       notch_path=[[0,1,2,3,0]];
       
       translate([bracket_length/2,0,rail_height/2]) rotate([90,0,-90])  linear_extrude(height=bracket_length) polygon(points=notch_points, paths=notch_path, convexity=2);
       
    }
    
    union() {
        //Holes for mounting bolts to rail
            translate([0, -e, rail_height/2]) rotate([-90,0,0]) cylinder(d=rail_screw_diameter, h=bracket_thickness+2*e);
        
        //Cutout in notch for slot nuts
            translate([-slot_nut_length/2,-notch_depth-e,0]) cube([slot_nut_length,notch_depth+e,rail_height]);
        
        //PSU screw hole
        translate([-bracket_length/2,psu_screw_offset, rail_height/2]) rotate([0,90,0]) hull() {
            translate([0,psu_screw_slot_length/2, -e]) cylinder(d=psu_screw_diameter, h=bracket_thickness+2*e);
            translate([0,-psu_screw_slot_length/2, -e]) cylinder(d=psu_screw_diameter, h=bracket_thickness+2*e);
        }
        
    }
}