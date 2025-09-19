module frame_segment(segment_length, front_width, shelf_width, thickness, connector_length) {
    connector_offset = (front_width - shelf_width) * 0.5;
    //connector_radius = (thickness / 2) * 0.75;
    connector_width = (front_width - shelf_width) * 0.5;
    connector_height = thickness * 0.7;
    male_connector_width = connector_width * 0.8;
    male_connector_height = connector_height * 0.6;
    
    union () {
        difference() {
            cube([segment_length, front_width, thickness]);
            
            translate([0, front_width - shelf_width, 0])
            cube([segment_length, shelf_width, thickness / 2]);
            
            translate([0, (front_width - shelf_width - connector_width) / 2, (thickness-connector_height)/ 2])
            cube([connector_length, connector_width, connector_height]);
            //cylinder(connector_length, connector_radius, connector_radius);
        }
        
        translate([segment_length, (front_width - shelf_width - male_connector_width) / 2, (thickness-connector_height) * 0.8])
        cube([connector_length, male_connector_width, male_connector_height]);
        //cylinder(connector_length, connector_width, connector_height);
    }
}

//frame_segment(21, 8, 1, 8, 3);
/*
PART_LENGTH = 100;
OUTER_WIDTH = 20;
INNER_WIDTH = 10;
FRAME_THICKNESS = 8;
CONNECTOR_DEPTH = 3;
CONNECTOR_RADIUS = (OUTER_WIDTH - INNER_WIDTH) * 0.5 * 0.75;
CONNECTOR_OFFSET = (OUTER_WIDTH - INNER_WIDTH) * 0.5;

union () {
    difference() {
        cube([PART_LENGTH, OUTER_WIDTH, FRAME_THICKNESS]);
        
        translate([0, OUTER_WIDTH / 2, 0])
        cube([PART_LENGTH, INNER_WIDTH, FRAME_THICKNESS / 2]);
        
        translate([CONNECTOR_DEPTH, CONNECTOR_OFFSET, FRAME_THICKNESS / 2])
        rotate([0, -90, 0])
        cylinder(CONNECTOR_DEPTH, CONNECTOR_RADIUS, CONNECTOR_RADIUS);
    }
    
    translate([PART_LENGTH, CONNECTOR_OFFSET, FRAME_THICKNESS / 2])
    rotate([0, 90, 0])
    cylinder(CONNECTOR_DEPTH, CONNECTOR_RADIUS, CONNECTOR_RADIUS);
}
*/