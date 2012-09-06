use <tools/MCAD/metric_fasteners.scad>

width = 39.5;	// actual is 1.550"
height = 35.5;	// actual is 1"
depth = 3;
wall_thickness = 5;
pcb_z_offset = 7;
slot_dist_from_edge = 5;

term_mnt_5mm_2hole(width, height, depth, wall_thickness);

module term_mnt_5mm_2hole(w, h, d, wt) {
difference() {
  union() {
	// pcb mount pads
    minkowski() {
      union() {
    translate([h - (10 / 2), 0, d]) cube([9, 10, pcb_z_offset + 0.1]);
    translate([0, h - 10, d]) cube([9, 10, pcb_z_offset + 0.1]);
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
    translate([w / 2 - 12 /2, slot_dist_from_edge, -0.01]) cube([12.1, 10.1, d + 3]);
    // pcb mount hls
    translate([w - 4.5, 3.9, 0]) cylinder(r1 = 0.5, r2 = 2, h = d * 4 + pcb_z_offset * 2 + 0.1, center = true, $fn = 24);
    translate([3.9, h - 4.5, 0]) cylinder(r1 = 0.5, r2 = 2, h = d * 4+ pcb_z_offset * 2 + 0.1, center = true, $fn = 24);
}
}