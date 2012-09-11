width = 39.4;	// actual is 1.550"
height = 25.4;	// actual is 1"
depth = 3;
wall_thickness = 5;
pcb_z_offset = 11;
pcb_pad_width = 9;
pcb_pad_height = 10;

term_mnt_5mm_2hole(width, height, depth, wall_thickness, pcb_z_offset, pcb_pad_width, pcb_pad_height);

module term_mnt_5mm_2hole(w, h, d, wt, pcbz, ppw, pph) {
difference() {
  union() {
	// pcb mount pads
    minkowski() {
      union() {
    translate([0, 0, d]) cube([ppw, pph, pcbz + 0.1]);
    translate([w - ppw, h - pph, d]) cube([ppw, pph, pcbz + 0.1]);
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
    // M5 mount screw hole
    translate([w / 2, h / 2, 0]) cylinder(r = 2.51, h = d * 2 + 0.1, center = true, $fn = 24);
    // M5 mount countersink
    translate([w / 2, h / 2, 4]) cylinder(r = 3.1, h = d + 0.1, center = true, $fn = 24);
    // pcb mount hls
    translate([ppw / 2, pph / 2, 0]) cylinder(r1 = 0.5, r2 = 2, h = d * 4 + pcbz * 2 + 0.1, center = true, $fn = 24);
    translate([w - (ppw / 2), h - (pph / 2), 0]) cylinder(r1 = 0.5, r2 = 2, h = d * 4 + pcbz * 2 + 0.1, center = true, $fn = 24);
}
}