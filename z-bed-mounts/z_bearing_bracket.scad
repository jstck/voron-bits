//3D printer LM8LUU bracket for 2020 extrusion
//2017, John Stäck (john@stack.se)
//Licensed under Creative Commons Attribution Share-Alike (CC BY-SA 3.0)

$fn=180;

rail_height=20; //2020 rail
slot_width=6;
notch_depth=1.5;
rail_screw_diameter=5.2; //M5 + margin

slot_nut_length=10;

//LM8LUU linear bearing
bearing_diameter=15;
//bearing_height=45; //Full LM8LUU bearing
bearing_height=33; //Only covers part between "notches". Make as long as you wish.

bearing_margin=0.1; //Increase in diameter depending on printer behaviour. Make test pieces for a snug fit.

bearing_hole_sides=6;

bearing_hole_inscribed=(bearing_diameter+bearing_margin)/cos(180/bearing_hole_sides);

echo(bearing_hole_inscribed);

bearing_holder_diameter=bearing_hole_inscribed+4;
axle_offset=15; //Distance from face of bracket to center of bearing/axle. Needs to match z-nut bracket


bracket_width=26;
endplate_thickness=0;
bracket_thickness=4;
e=0.01;
hole_inset=8; //distance from edge of bracket to mounting hole
bracket_length=bearing_holder_diameter+hole_inset*4;

difference() {
    union() {
        
       //Base parts of bracket
       translate([-bracket_length/2,0,0]) {
           cube([bracket_length, bracket_thickness, rail_height]);

       }
       
       
       //Notch into rail
       notch_points=[[0,-slot_width/2],[notch_depth,-slot_width/2+notch_depth],[notch_depth,slot_width/2],[0,slot_width/2]];
       notch_path=[[0,1,2,3,0]];
       
       translate([bracket_length/2+endplate_thickness,0,rail_height/2]) rotate([90,0,-90])  linear_extrude(height=bracket_length+endplate_thickness*2) polygon(points=notch_points, paths=notch_path, convexity=2);
       
       //Linear bearing holder
       hull() {
       translate([0,axle_offset,0]) {
            cylinder(d=bearing_holder_diameter,h=bearing_height);
       }
       
       //Make it beefier
       translate([-bearing_holder_diameter/2,0,0]) cube([bearing_holder_diameter, axle_offset, rail_height]);
       }
    }
    
    union() {
        //Holes for mounting bolts to rail
        for(i=[-1,1])
            translate([i*(bracket_length/2-hole_inset), -e, rail_height/2]) rotate([-90,0,0]) cylinder(d=rail_screw_diameter, h=bracket_thickness+2*e);
        
        //Cutout in notch for slot nuts
         for(i=[-1,1])
            translate([i*(bracket_length/2-hole_inset)-slot_nut_length/2,-notch_depth-e,0]) cube([slot_nut_length,notch_depth+e,rail_height]);
        
        //Linear bearing holder
        translate([0,axle_offset,-e]) {
            rotate([0,0,30]) cylinder(d=bearing_hole_inscribed, $fn=bearing_hole_sides, h=bearing_height+2*e);
        }
        
    }
}