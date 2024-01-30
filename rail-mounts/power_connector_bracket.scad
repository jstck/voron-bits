$fn=36;

rail_height=20; //2020 rail
slot_width=6;
notch_depth=1.5;
rail_screw_diameter=4.3; //M4 + margin


slot_nut_length=10;

switch_height = 47.7;
switch_width = 28.3;
switch_margin = 8;

bracket_thickness=3;
bottom_thickness=1.5;

bracket_length=switch_height+2*switch_margin+2*bracket_thickness;
bracket_width=switch_width+2*switch_margin+2*bracket_thickness;

wall_height=37;

e=0.01;


difference() {
    union() {
        
       //Base parts of bracket
       translate([-bracket_length/2,0,0]) {
           cube([bracket_length, bracket_width, wall_height]); 
       }

       //Notch into rail
       notch_points=[[0,-slot_width/2],[notch_depth,-slot_width/2+notch_depth],[notch_depth,slot_width/2],[0,slot_width/2]];
       notch_path=[[0,1,2,3,0]];
       
       translate([bracket_length/2,0,rail_height/2]) rotate([90,0,-90])  linear_extrude(height=bracket_length) polygon(points=notch_points, paths=notch_path, convexity=2);

       translate([bracket_length/2,bracket_width,rail_height/2]) rotate([90,0,0])  linear_extrude(height=bracket_width) polygon(points=notch_points, paths=notch_path, convexity=2);
       
    }
    
    union() {
        //Holes for mounting bolts to rail
        translate([0, -e, rail_height/2]) rotate([-90,0,0]) cylinder(d=rail_screw_diameter, h=bracket_thickness+2*e);
        translate([bracket_length/2+e, bracket_width/2, rail_height/2]) rotate([0,-90,0]) cylinder(d=rail_screw_diameter, h=bracket_thickness+2*e);
        
        
        //Cutout in notch for slot nuts
        translate([-slot_nut_length/2,-notch_depth-e,0]) cube([slot_nut_length,notch_depth+e,rail_height]);
        
        translate([bracket_length/2,bracket_width/2-slot_nut_length/2,0]) cube([notch_depth+e,slot_nut_length,rail_height]);

        //Power switch hole
        translate([-switch_height/2,bracket_thickness+switch_margin, -e]) cube([switch_height, switch_width,wall_height+2*e]);
        translate([-switch_height/2-switch_margin,bracket_thickness, bottom_thickness]) cube([switch_height+2*switch_margin, switch_width+2*switch_margin,wall_height+e]);
    }
}