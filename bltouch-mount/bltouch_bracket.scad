$fn=36;

mount_hole_dist = 29;
mount_hole_d = 3.5; //M3 clearance
mount_arm_w = 6;
mount_arm_l = 11.5; //From hole center to horizontal bar
mount_arm_inset = 5; //Corner "chamfer"

mount_thickness = 3;

//Distance from bracket inner face to sensor axis (typically X as mounted on printer).
//Offset of 6mm puts the edge of the bltouch mount flange near the rear face of the bracket,
//but this may put it too close to the hotend heater block
sensor_offset_x = 8;

 //Height between carriage mount holes and sensor upper surface (Z as mounted on printer).
 //bltouch sensor is about 40mm when retracted, and the tip should in that position be about 2.3-4.3mm above the
 //hotend nozzle tip
sensor_offset_z = 21;
sensor_offset_y = 0;  //Offset between sensor axis and center of carriage (midpoint between mount holes

bltouch_hole_d = 3.5; //M3 clearance
bltouch_hole_offset = 9; //Hole distance from center axis
bltouch_w = 11.5; //Width of sensor mount plate (not including connector)
bltouch_l = 28; //Guesstimation


total_width = mount_hole_dist+mount_arm_w;
corner_inset_l = (total_width-bltouch_l)/2+sensor_offset_y;
corner_inset_r = (total_width-bltouch_l)/2-sensor_offset_y;

difference() {
    union() {
        
        //Rounded ends
        for(i=[-1,1]) {
            translate([i*mount_hole_dist/2,0,0]) {
               cylinder(d=mount_arm_w, h=mount_thickness);
            }
            
        }
        
        //Carriage mount outline (vertical part)
        arm_points = [
        
            //Upper left
            [-mount_hole_dist/2+mount_arm_w/2, 0],
            [-mount_hole_dist/2-mount_arm_w/2, 0],
        
            //Lower left
            [-mount_hole_dist/2-mount_arm_w/2, -sensor_offset_z+corner_inset_l],
            [-mount_hole_dist/2-mount_arm_w/2+corner_inset_l, -sensor_offset_z],
        
        
            //Lower right
            [+mount_hole_dist/2+mount_arm_w/2-corner_inset_r, -sensor_offset_z],
            [+mount_hole_dist/2+mount_arm_w/2, -sensor_offset_z+corner_inset_r],
        
        
            //Upper right
            [+mount_hole_dist/2+mount_arm_w/2, 0],
            [+mount_hole_dist/2-mount_arm_w/2, 0],
        
            //Middle "valley"
            [+mount_hole_dist/2-mount_arm_w/2, -mount_arm_l+mount_arm_inset],
            [+mount_hole_dist/2-mount_arm_w/2-mount_arm_inset, -mount_arm_l],
            [-mount_hole_dist/2+mount_arm_w/2+mount_arm_inset, -mount_arm_l],
            [-mount_hole_dist/2+mount_arm_w/2, -mount_arm_l+mount_arm_inset],
        ];
        
        linear_extrude(mount_thickness) polygon(points=arm_points);
        
        
        //Sensor mount (horizontal part
        translate([-bltouch_l/2+sensor_offset_y, -sensor_offset_z]) {
            cube([bltouch_l, mount_thickness, bltouch_w/2+sensor_offset_x]);
        }
    }
    
    
    
    union() {
        //Screw holes
        for(i=[-1,1]) translate([i*mount_hole_dist/2,0,-0.1]) cylinder(d=mount_hole_d, h=mount_thickness+0.2);
            
        //Holes for mounting bltouch sensor
        translate([sensor_offset_y, -sensor_offset_z, sensor_offset_x]) {
            rotate([-90,0,0])
                for(i=[-1,1]) {
                    translate([i*bltouch_hole_offset, 0, -0.1]) cylinder(d=bltouch_hole_d, h=mount_thickness+0.2);
                }
        }
    }
    
    
    
}