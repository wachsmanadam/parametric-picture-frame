function calc_inner_edge(outer_edge_length, front_width) = outer_edge_length - front_width;

module frame_corner(outer_edge_length, front_width, shelf_width, thickness, connector_length) {
    inner_edge_length = outer_edge_length - front_width;
    connector_offset = (front_width - shelf_width) * 0.5;
    //connector_radius = (thickness / 2) * 0.75;
    connector_width = (front_width - shelf_width) * 0.5;
    connector_height = thickness * 0.7;
    male_connector_width = connector_width * 0.8;
    male_connector_height = connector_height * 0.6;
    
    union () {
    // Carve shelf for picture corner, carve connector hole
        difference () {
            // Form corner
            union(){
                cube([outer_edge_length, front_width, thickness]);

                translate([front_width, 0, 0])
                    rotate([0, 0, 90])
                        cube([outer_edge_length, front_width, thickness]);
            };
            // First shelf part
            translate([outer_edge_length - inner_edge_length, front_width - shelf_width, 0])
            cube([inner_edge_length, shelf_width, thickness / 2]);
            
            // Second shelf part
            translate([front_width - shelf_width, outer_edge_length - inner_edge_length, 0])
            cube([shelf_width, inner_edge_length, thickness / 2]);       
     
            
            // Corner between shelves
            translate([front_width - shelf_width, front_width - shelf_width, 0])
            cube([shelf_width, shelf_width, thickness / 2]);
            
            // Connector recess
            translate([(front_width - shelf_width - connector_width) / 2, outer_edge_length - connector_length, (thickness-connector_height)/ 2])
            cube([connector_width, connector_length, connector_height]);
            //cylinder(connector_length, connector_radius, connector_radius);
        }
        
        // Connector peg
        translate([outer_edge_length,(front_width - shelf_width - male_connector_width) / 2, (thickness-connector_height)/ 2])
        cube([connector_length, male_connector_width, male_connector_height]);
        //cylinder(connector_length, connector_radius*.8, connector_radius*.8);
    }
}

//frame_corner(40, 20, 10, 8, 3);

/*LEN_WID = 40; // Length of each outer edge
OUTER_WIDTH = 20; // Width of ends
INNER_WIDTH = 10; // Widtb of shelf ends
FRAME_THICKNESS = 8;
INNER_LEN_WID = LEN_WID - OUTER_WIDTH; // Length of each inside edge
CONNECTOR_DEPTH = 3;
CONNECTOR_RADIUS = (OUTER_WIDTH - INNER_WIDTH) * 0.5 * 0.75;
CONNECTOR_OFFSET = (OUTER_WIDTH - INNER_WIDTH) * 0.5;

// Add connector peg
union () {
    // Carve shelf for picture corner, carve connector hole
    difference () {
        // Form corner
        union(){
            cube([LEN_WID, OUTER_WIDTH, FRAME_THICKNESS]);

            translate([OUTER_WIDTH, 0, 0])
                rotate([0, 0, 90])
                    cube([LEN_WID, OUTER_WIDTH, FRAME_THICKNESS]);
        };
        // First shelf part
        translate([LEN_WID / 2, OUTER_WIDTH / 2, 0])
        cube([INNER_LEN_WID, INNER_WIDTH, FRAME_THICKNESS / 2]);
        
        // Second shelf part
        translate([OUTER_WIDTH, LEN_WID / 2, 0])
        rotate([0, 0, 90])
        cube([INNER_LEN_WID, INNER_WIDTH, FRAME_THICKNESS / 2]);
        
        // Corner between shelves
        translate([OUTER_WIDTH / 2, OUTER_WIDTH / 2, 0])
        cube([INNER_WIDTH, INNER_WIDTH, FRAME_THICKNESS / 2]);
        
        // Connector recess
        translate([CONNECTOR_OFFSET, LEN_WID - CONNECTOR_DEPTH, FRAME_THICKNESS / 2])
        rotate([-90, 0, 0])
        cylinder(CONNECTOR_DEPTH, CONNECTOR_RADIUS, CONNECTOR_RADIUS);
    }
    
    // Connector peg
    translate([LEN_WID + CONNECTOR_DEPTH, CONNECTOR_OFFSET, FRAME_THICKNESS / 2])
        rotate([0, -90, 0])
        cylinder(CONNECTOR_DEPTH, CONNECTOR_RADIUS, CONNECTOR_RADIUS);
}
*/