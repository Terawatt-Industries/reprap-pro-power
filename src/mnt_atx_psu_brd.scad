use <tools/MCAD/metric_fasteners.scad>

width = 57.75;	// actual is 1.550"
height = 75;	// actual is 1"
depth = 3;
wall_thickness = 5;
pcb_z_offset = 11;
slot_dist_from_edge = 5;
clip = false;		// false for t-slot holes
clip_width = 23.1;
clip_height = 7.1;

term_mnt_atx_psubrd(width, height, depth, wall_thickness, pcb_z_offset, slot_dist_from_edge, 
	pcb_pad_width, pcb_pad_height, clip, clip_width, clip_height);

module term_mnt_atx_psubrd(w, h, d, wt, pcbz, sdfe, ppw, pph, c, cw, ch) {
difference() {
  union() {
	// pcb mount pads
    minkowski() {
      union() {
    translate([w - 9, 0, d]) cube([9, 10, pcbz + 0.1]);
    translate([0, h - 10, d]) cube([9, 10, pcbz + 0.1]);
    translate([0, 0, d]) cube([9, 10, pcbz + 0.1]);
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
  if (c) {
    // extrusion clip mount hole
    translate([w / 2 - 12 / 2, sdfe, -0.01]) cube([cw, ch, d + 3]);
    // extrusion clip mount hole 2
    translate([sdfe, h / 2 - 10 / 2, -0.01]) cube([ch, cw, d + 3]);
  } else {
    for(x = [w - sdfe, w - sdfe * 6]) {
    // M5 mount screw hole
    translate([x, h - sdfe, 0]) cylinder(r = 2.51, h = d * 2 + 0.1, center = true, $fn = 24);
    // M5 mount countersink
    translate([x, h - sdfe, 4]) cylinder(r = 3.6, h = d + 0.1, center = true, $fn = 24);
  }
}
    // pcb mount hls
    translate([5.1, 69.6, 0]) cylinder(r1 = 0.5, r2 = 2, h = d * 4 + pcbz * 2 + 0.1, center = true, $fn = 24);
    translate([52.2, 5.1, 0]) cylinder(r1 = 0.5, r2 = 2, h = d * 4 + pcbz * 2 + 0.1, center = true, $fn = 24);
    translate([5.1, 5.1, 0]) cylinder(r1 = 0.5, r2 = 2, h = d * 4 + pcbz * 2 + 0.1, center = true, $fn = 24);
}
}