width = 58;	
height = 92.5;	
depth = 3;
wall_thickness = 5;
pcb_z_offset = 11;
slot_dist_from_edge = 5;
clip = false;		// false for t-slot holes
clip_width = 29.1;
clip_height = 7.1;

term_mnt_ramps14(width, height, depth, wall_thickness, pcb_z_offset, slot_dist_from_edge, 
	pcb_pad_width, pcb_pad_height, clip, clip_width, clip_height);

module term_mnt_ramps14(w, h, d, wt, pcbz, sdfe, ppw, pph, c, cw, ch) {
difference() {
  union() {
	// pcb mount pads
    minkowski() {
      union() {
    translate([w - 9, 0, d]) cube([9, 10, pcbz + 0.1]);
    translate([0, h - 12.5, d]) cube([9, 10, pcbz + 0.1]);
    translate([w - 9, h - 10, d]) cube([9, 10, pcbz + 0.1]);
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
    translate([w / 2 - 20 / 2, sdfe, -0.01]) cube([cw, ch, d + 3]);
    // extrusion clip mount hole 2
    translate([sdfe, h / 2 - 10 / 2, -0.01]) cube([ch, cw, d + 3]);
  } else {
    for(y = [sdfe, sdfe * 6]) {
    // M4 mount screw hole
    translate([sdfe, y, 0]) cylinder(r = 2, h = d * 2 + 0.1, center = true, $fn = 24);
    // M4 mount countersink
    translate([sdfe, y, 4]) cylinder(r = 3.2, h = d + 0.1, center = true, $fn = 24);
    }
  }
    // pcb mount hls
    translate([5, 85, 0]) cylinder(r1 = 0.5, r2 = 2, h = d * 4 + pcbz * 2 + 0.1, center = true, $fn = 24);
    translate([53, 87.5, 0]) cylinder(r1 = 0.5, r2 = 2, h = d * 4 + pcbz * 2 + 0.1, center = true, $fn = 24);
    translate([53, 5, 0]) cylinder(r1 = 0.5, r2 = 2, h = d * 4+ pcbz * 2 + 0.1, center = true, $fn = 24);
}
}