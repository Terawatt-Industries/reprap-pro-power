width = 58;	
height = 92.5;	
depth = 3.25;
wall_thickness = 5;
pcb_z_offset = 8;
slot_dist_from_edge = 5;
pcb_pad_width = 9;
pcb_pad_height = 9;
clip = false;		// false for t-slot holes
clip_width = 23.7;
clip_height = 6.5;

term_mnt_ramps14(width, height, depth, wall_thickness, pcb_z_offset, slot_dist_from_edge, pcb_pad_width, pcb_pad_height, clip, clip_width, clip_height);

module term_mnt_ramps14(w = width, h = height, d = depth, wt = wall_thickness, pcbz = pcb_z_offset, sdfe = slot_dist_from_edge, ppw = pcb_pad_width, pph = pcb_pad_height, c = clip, cw = clip_width, ch = clip_height) {
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
    // M5 mount screw hole
    translate([sdfe, y, 0]) cylinder(r = 2.51, h = d * 2 + 0.1, center = true, $fn = 24);
    // M5 mount countersink
    translate([sdfe, y, 6.5]) cylinder(r = 3.6, h = d + 0.1, center = true, $fn = 24);
    }
  }
    // pcb mount hls
    translate([5, 85, 0]) cylinder(r1 = 0.5, r2 = 2, h = d * 4 + pcbz * 2 + 0.1, center = true, $fn = 24);
    translate([53, 87.5, 0]) cylinder(r1 = 0.5, r2 = 2, h = d * 4 + pcbz * 2 + 0.1, center = true, $fn = 24);
    translate([53, 5, 0]) cylinder(r1 = 0.5, r2 = 2, h = d * 4+ pcbz * 2 + 0.1, center = true, $fn = 24);
}
}