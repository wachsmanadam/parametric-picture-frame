use <frame_corner.scad>
use <frame_segment.scad>

FRAME_LENGTH = 158.4;
FRAME_WIDTH = 107.6;

N_LEN_PARTS = 2;
N_WID_PARTS = 2;

CORNER_LENGTH = 15;
FACE_WIDTH = 6;
INNER_MARGIN_WIDTH = 2;
THICKNESS = 4;
CONNECTOR_LENGTH = 3;

function segment_distance(dimension_length, corner_length) = dimension_length - (corner_length * 2);

inner_corner_length = calc_inner_edge(CORNER_LENGTH, FACE_WIDTH);
max_picture_width = (INNER_MARGIN_WIDTH * 2) + segment_distance(FRAME_WIDTH, CORNER_LENGTH) + (inner_corner_length * 2);
max_picture_length = (INNER_MARGIN_WIDTH * 2) + segment_distance(FRAME_LENGTH, CORNER_LENGTH) + (inner_corner_length * 2);

echo(str("Actual supported picture dimensions are: ", max_picture_length, " mm x ", max_picture_width, " mm"));

module generate_frame(frame_length, 
                      frame_width, 
                      n_length_segments = 2, 
                      n_width_segments = 1, 
                      corner_length = 15, 
                      face_width = 8, 
                      inner_margin_width = 1, 
                      thickness = 8, 
                      connector_length = 3) {
                          corner_inner_edge_length = calc_inner_edge(corner_length, face_width);
                          
                          // Calc actual distance to be covered by straight segments
                          width_distance = frame_width - (corner_length * 2) + connector_length;
                          length_distance = frame_length - (corner_length * 2) + connector_length ;
                          
                          // Calc size of segments to cover distance given n_segments
                          width_seg_size = width_distance / n_width_segments;
                          length_seg_size = length_distance / n_length_segments;
                          
                          //echo("width seg size: ", width_seg_size);
                          //echo("length seg size: ", length_seg_size);
                          // Gen corners
                          frame_corner(corner_length, face_width, inner_margin_width, thickness, connector_length);
                          
                          translate([connector_length*(1+n_width_segments), 0, 0])//DEBUG
                          translate([frame_width+connector_length, 0, 0])
                          rotate([0, 0, 90])
                          frame_corner(corner_length, face_width, inner_margin_width, thickness, connector_length);
                          
                          translate([connector_length*(1+n_width_segments), connector_length*(1+n_length_segments), 0])//DEBUG
                          translate([frame_width+connector_length, frame_length+connector_length, 0])
                          rotate([0, 0, 180])
                          frame_corner(corner_length, face_width, inner_margin_width, thickness, connector_length);
                          
                          translate([0, connector_length*(1+n_length_segments), 0])//DEBUG
                          translate([0, frame_length+connector_length, 0])
                          rotate([0, 0, 270])
                          frame_corner(corner_length, face_width, inner_margin_width, thickness, connector_length);
                          
                          
                          // Gen width segments
                          for (i = [1:n_width_segments]) {
                              x_offset = corner_length + ((i-1) * width_seg_size);
                              y_offset = 0;
                              
                              translate([i*connector_length, 0, 0])//DEBUG
                              translate([x_offset, y_offset, 0])
                              frame_segment(segment_length = width_seg_size,
                              front_width = face_width,
                              shelf_width = inner_margin_width,
                              thickness = thickness,
                              connector_length = connector_length);
                          }
                          
                          for (i = [1:n_width_segments]) {
                              x_offset = (frame_width - corner_length + connector_length) - ((i-1) * width_seg_size);
                              y_offset = frame_length + connector_length;
                              
                              translate([connector_length*((n_length_segments+1)-i), connector_length * (1+n_length_segments), 0])//DEBUG
                              translate([x_offset, y_offset, 0])
                              // Rotate can be thought of as pivoting by SW corner
                              // therefore offset to put flush with N face of corner
                              rotate([0, 0, 180])
                              frame_segment(segment_length = width_seg_size,
                              front_width = face_width,
                              shelf_width = inner_margin_width,
                              thickness = thickness,
                              connector_length = connector_length);
                          }
                          
                          // Gen length segments
                          for (i = [1:n_length_segments]) {
                              x_offset = frame_width + connector_length;
                              y_offset = corner_length + ((i-1) * length_seg_size);
                              
                              translate([connector_length * (1 + n_width_segments), connector_length * i, 0])//DEBUG
                              translate([x_offset, y_offset, 0])
                              rotate([0, 0, 90])
                              frame_segment(segment_length = length_seg_size,
                              front_width = face_width, 
                              shelf_width = inner_margin_width, 
                              thickness = thickness, 
                              connector_length = connector_length);
                          }
                          
                          for (i = [1:n_length_segments]) {
                              x_offset = 0;
                              y_offset = (frame_length - corner_length + connector_length) - ((i-1) *length_seg_size);
                              
                              translate([0, connector_length*((n_length_segments+1)-i), 0])//DEBUG
                              translate([x_offset, y_offset, 0])
                              rotate([0, 0, 270])
                              frame_segment(segment_length = length_seg_size,
                              front_width = face_width, 
                              shelf_width = inner_margin_width, 
                              thickness = thickness, 
                              connector_length = connector_length);
                          }
                      }
                      
module generate_individual_frame_parts(
                      frame_length, 
                      frame_width, 
                      n_length_segments = 2, 
                      n_width_segments = 1, 
                      corner_length = 15, 
                      face_width = 8, 
                      inner_margin_width = 1, 
                      thickness = 8, 
                      connector_length = 3
                      ) {
                          corner_inner_edge_length = calc_inner_edge(corner_length, face_width);
                          
                          // Calc actual distance to be covered by straight segments
                          width_distance = frame_width - (corner_length * 2) + connector_length;
                          length_distance = frame_length - (corner_length * 2) + connector_length ;
                          
                          // Calc size of segments to cover distance given n_segments
                          width_seg_size = width_distance / n_width_segments;
                          length_seg_size = length_distance / n_length_segments;
                          
                          //echo("width seg size: ", width_seg_size);
                          //echo("length seg size: ", length_seg_size);
                          // Gen corner
                          frame_corner(corner_length, face_width, inner_margin_width, thickness, connector_length);
                          
                          // Gen width piece
                          translate([0, corner_length*2, 0])
                          frame_segment(segment_length = width_seg_size,
                              front_width = face_width,
                              shelf_width = inner_margin_width,
                              thickness = thickness,
                              connector_length = connector_length);
                              
                          // Gen length piece
                          translate([0, (corner_length*2)+(face_width * 2), 0])
                          rotate([0, 0, 0])
                          frame_segment(segment_length = length_seg_size,
                              front_width = face_width, 
                              shelf_width = inner_margin_width, 
                              thickness = thickness, 
                              connector_length = connector_length);
                          
}

generate_individual_frame_parts(frame_length = FRAME_LENGTH, frame_width = FRAME_WIDTH,
                      n_length_segments = N_LEN_PARTS,
                      n_width_segments = N_WID_PARTS,
                      corner_length = CORNER_LENGTH,
                      face_width = FACE_WIDTH,
                      inner_margin_width = INNER_MARGIN_WIDTH,
                      thickness = THICKNESS,
                      connector_length = CONNECTOR_LENGTH);

/*                  
generate_frame(frame_length = FRAME_LENGTH, frame_width = FRAME_WIDTH,
                      n_length_segments = N_LEN_PARTS,
                      n_width_segments = N_WID_PARTS,
                      corner_length = 15,
                      face_width = 6,
                      inner_margin_width = 2,
                      thickness = 4,
                      connector_length = 3);
*/
                      