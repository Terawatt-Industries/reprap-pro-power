width = 57.75;	// actual is 1.550"
height = 75;	// actual is 1"
depth = 3;
wall_thickness = 5;
pcb_z_offset = 10;
slot_dist_from_edge = 5;
clip = true;		// false for t-slot holes
clip_width = 13.1;
clip_height = 10.1;

term_mnt_5mm_2hole(width, height, depth, wall_thickness, clip);

module term_mnt_5mm_2hole(w, h, d, wt, clip = true) {
difference() {
  union() {
	// pcb mount pads
    minkowski() {
      union() {
    translate([w - 9, 0, d]) cube([9, 10, pcb_z_offset + 0.1]);
    translate([0, h - 10, d]) cube([9, 10, pcb_z_offset + 0.1]);
    translate([w - 9, h - 13.5, d]) cube([9, 10, pcb_z_offset + 0.1]);
    }
    translate([0, 0, 0]) cylinder(r = 1, h = 0.1, center = true, $fn = 12);
  }
	// base support
    minkowski() { 
      union() {
        translate([0, 0, 0]) cube([w, h, d]);
    }
    translate([0, 0, 0]) cylinder(r = 1, h = 0.01, center = true, $fn = 12);
  }
}
  if (clip) {
    // extrusion clip mount hole
    translate([w / 2 - 20 / 2, slot_dist_from_edge, -0.01]) cube([clip_width, clip_height, d + 3]);
    // extrusion clip mount hole 2
    translate([slot_dist_from_edge, h / 2 - 10 / 2, -0.01]) cube([clip_height, clip_width, d + 3]);
  } else {
    for(y = [slot_dist_from_edge, slot_dist_from_edge * 6]) {
    // M4 mount screw hole
    translate([slot_dist_from_edge, y, 0]) cylinder(r = 2, h = d * 2 + 0.1, center = true, $fn = 24);
    // M4 mount countersink
    translate([slot_dist_from_edge, y, 4]) cylinder(r = 3.2, h = d + 0.1, center = true, $fn = 24);
    }
  }
    // pcb mount hls
    translate([5, 70, 0]) cylinder(r1 = 0.5, r2 = 2, h = d * 4 + pcb_z_offset * 2 + 0.1, center = true, $fn = 24);
    translate([52.75, 66.5, 0]) cylinder(r1 = 0.5, r2 = 2, h = d * 4 + pcb_z_offset * 2 + 0.1, center = true, $fn = 24);
    translate([52.75, 5, 0]) cylinder(r1 = 0.5, r2 = 2, h = d * 4+ pcb_z_offset * 2 + 0.1, center = true, $fn = 24);
}
}