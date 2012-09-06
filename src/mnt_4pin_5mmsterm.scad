width = 39.4;	// actual is 1.550"
height = 25.4;	// actual is 1"
depth = 3;
wall_thickness = 5;
pcb_z_offset = 5;
pcb_pad_width = 9;
pcb_pad_height = 10;

term_mnt_5mm_2hole(width, height, depth, wall_thickness);

module term_mnt_5mm_2hole(w, h, d, wt) {
difference() {
  union() {
	// pcb mount pads
    minkowski() {
      union() {
    translate([0, 0, d]) cube([pcb_pad_width, pcb_pad_height, pcb_z_offset + 0.1]);
    translate([w - pcb_pad_width, h - pcb_pad_height, d]) cube([pcb_pad_width, pcb_pad_height, pcb_z_offset + 0.1]);
    }
    translate([0, 0, 0]) cylinder(r = 1, h = 0.1, center = true, $fn = 12);
  }
	// base support
    minkowski() { 
      union() {
        translate([0, 2 * h / 6, 0]) cube([w, h / 3, d]);
        translate([0, 0, 0]) cube([w * 0.4, h / 3, d]);
        translate([w - (w * 0.4), 2 * h / 3, 0]) cube([w * 0.4, h / 3, d]);
    }
    translate([0, 0, 0]) cylinder(r = 1, h = 0.1, center = true, $fn = 12);
  }
}
    // M4 mount screw hole
    translate([w / 2, h / 2, 0]) cylinder(r = 2, h = d * 2 + 0.1, center = true, $fn = 24);
    // M4 mount countersink
    translate([w / 2, h / 2, 4]) cylinder(r = 3.2, h = d + 0.1, center = true, $fn = 24);
    // pcb mount hls
    translate([pcb_pad_width / 2, pcb_pad_height / 2, 0]) cylinder(r1 = 0.5, r2 = 2, h = d * 4 + pcb_z_offset * 2 + 0.1, center = true, $fn = 24);
    translate([w - (pcb_pad_width / 2), h - (pcb_pad_height / 2), 0]) cylinder(r1 = 0.5, r2 = 2, h = d * 4+ pcb_z_offset * 2 + 0.1, center = true, $fn = 24);
}
}