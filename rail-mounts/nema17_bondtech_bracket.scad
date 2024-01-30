$fn=72;
nema17_hole_spacing = 31;
nema17_width = 44; //42.3 + some margin
nema17_hole_size = 3.3; //Through hole for M3
nema17_center_hole = 23; //22 + some margin

stepper_offset = 2;

rail_width = 20; //2020 rails
rail_hole_spacing = 75;
rail_hole_size = 5.5; //Through hole for M3


thickness = 3.5;

wall_height = 3;
wall_thickness = thickness;


difference() {
    union() {
     
        //Upper bracket part
        rail_bracket_width = rail_hole_spacing + rail_width;
        translate([-rail_bracket_width/2, 0, 0])
            cube([rail_bracket_width, rail_width, thickness]);
        
        
        //Stepper motor bracket part
        translate([-nema17_width/2-wall_thickness, -nema17_width, 0])
            cube([nema17_width+2*wall_thickness, nema17_width+1, thickness]);
        
        //Side walls
        translate([-nema17_width/2-wall_thickness, -nema17_width, 0])
            cube([wall_thickness, nema17_width+rail_width, thickness+wall_height]);

        translate([nema17_width/2, -nema17_width, 0])
            cube([wall_thickness, nema17_width+rail_width, thickness+wall_height]);

    }
    
    
    union() {
        //Bracket holes
        for (i=[-1,1])
            translate([i*rail_hole_spacing/2, rail_width/2, -0.1])
                cylinder(d=rail_hole_size, h=thickness+0.2);
        
        //Stepper motor mounting holes
        for (i=[-1,1])
            for(j=[-1,1])
                translate([i*nema17_hole_spacing/2, -nema17_width/2+j*nema17_hole_spacing/2, -0.1])
                    cylinder(d=nema17_hole_size, h=thickness+0.2);
            
        //Center hole
        translate([0, -nema17_width/2, -0.1]) cylinder(d=nema17_center_hole, h=thickness+0.2);
        
    }
}