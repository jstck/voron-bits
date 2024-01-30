$fn=36;

rail_height=20; //2020 rail
slot_width=6;
notch_depth=1.5;
rail_screw_diameter=4.3; //M4 + margin

psu_screw_diameter = rail_screw_diameter;
psu_screw_slot_length = 6;
slot_nut_length=10;

bracket_length=20;
bracket_width=30;
endplate_thickness=2;
bracket_thickness=3;
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
            translate([0, -e, rail_height/2]) rotate([-90,0,0]) cylinder(d=rail_screw_diameter, h=bracket_thickness+2*e);
        
        //Cutout in notch for slot nuts
            translate([-slot_nut_length/2,-notch_depth-e,0]) cube([slot_nut_length,notch_depth+e,rail_height]);
        
        
        //PSU screw hole
        hull() {
            translate([0,(bracket_width+psu_screw_slot_length)/2, -e]) cylinder(d=psu_screw_diameter, h=bracket_thickness+2*e);
            translate([0,(bracket_width-psu_screw_slot_length)/2, -e]) cylinder(d=psu_screw_diameter, h=bracket_thickness+2*e);
        }
        
    }
}