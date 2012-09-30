use <tools/MCAD/metric_fasteners.scad>

width = 25.4;	// actual is 1"
height = 44.4;	// actual is 1.550"
depth = 3;
wall_thickness = 5;
pcb_z_offset = 11;
slot_dist_from_edge = 5;
pcb_pad_width = 9;
pcb_pad_height = 10;
clip_width = 29.1;
clip_height = 7.1;

term_mnt_5mm_clip(width, height, depth, wall_thickness, pcb_z_offset, slot_dist_from_edge, 
	pcb_pad_width, pcb_pad_height, clip_width, clip_height);

module term_mnt_5mm_clip(w, h, d, wt, pcbz, sdfe, ppw, pph, cw, ch) {
difference() {
  union() {
	// pcb mount pads
    minkowski() {
      union() {
    translate([w - ppw, 5, d]) cube([ppw, pph, pcbz + 0.1]);
    translate([0, h - pph + 5, d]) cube([ppw, pph, pcbz + 0.1]);
    }
    translate([0, 0, 0]) cylinder(r = 1, h = 0.1, center = true, $fn = 12);
  }
	// base support
    minkowski() { 
      union() {
        translate([0, 0, 0]) cube([w, h + 5, d]);
    }
    translate([0, 0, 0]) cylinder(r = 1, h = 0.01, center = true, $fn = 12);
  }
}
    // extrusion clip mount hole
    translate([w / 2 - 20.1 / 2, sdfe, -0.01]) cube([ch, cw, d + 3]);
    // pcb mount hls
    translate([w - (ppw / 2), pph / 2 + 5, 0]) cylinder(r1 = 0.5, r2 = 2, h = d * 4 + pcbz * 2 + 0.1, center = true, $fn = 24);
    translate([ppw / 2, h - (pph / 2) + 5, 0]) cylinder(r1 = 0.5, r2 = 2, h = d * 4+ pcbz * 2 + 0.1, center = true, $fn = 24);
}
}