use <tools/MCAD/metric_fasteners.scad>

width = 25.4;	// actual is 1"
height = 39.4;	// actual is 1.550"
depth = 3;
wall_thickness = 5;
pcb_z_offset = 7;
slot_dist_from_edge = 5;
pcb_pad_width = 9;
pcb_pad_height = 10;
clip_width = 13.1;
clip_height = 10.1;

term_mnt_5mm_2hole(width, height, depth, wall_thickness);

module term_mnt_5mm_2hole(w, h, d, wt) {
difference() {
  union() {
	// pcb mount pads
    minkowski() {
      union() {
    translate([w - pcb_pad_width, 0, d]) cube([pcb_pad_width, pcb_pad_height, pcb_z_offset + 0.1]);
    translate([0, h - pcb_pad_height, d]) cube([pcb_pad_width, pcb_pad_height, pcb_z_offset + 0.1]);
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
    // extrusion clip mount hole
    translate([w / 2 - 20.1 / 2, slot_dist_from_edge, -0.01]) cube([clip_height, clip_width, d + 3]);
    // pcb mount hls
    translate([w - (pcb_pad_width / 2), pcb_pad_height / 2, 0]) cylinder(r1 = 0.5, r2 = 2, h = d * 4 + pcb_z_offset * 2 + 0.1, center = true, $fn = 24);
    translate([pcb_pad_width / 2, h - (pcb_pad_height / 2), 0]) cylinder(r1 = 0.5, r2 = 2, h = d * 4+ pcb_z_offset * 2 + 0.1, center = true, $fn = 24);
}
}