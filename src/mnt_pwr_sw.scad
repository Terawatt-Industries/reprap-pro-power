switch_height = 30.41 + 0.1;
switch_width = 21.4 + 1.75;
switch_depth = 15.9 + 5;
wall_thickness = 2;
space_below_component = 10;
notch_height = 10;
notch_width = switch_width - 1.75;
notch_z_offset = wall_thickness + space_below_component + 7 + 2;

tolerance = 0.5;

power_switch_mount(switch_height, switch_width, switch_depth, tolerance, wall_thickness, space_below_component, notch_height, notch_width, notch_z_offset);

module power_switch_mount(h, w, d, tol, wt, sb, nh, nw, nzo) {
	difference() {
		union() {
			switch_enclosure(h, w, d, tol, wt, sb, nh, nw, nzo);
			translate([-wt, wt + 1, 0]) mount_arm_m3(h, w, d, tol, wt, sb, nh, nw, nzo);
		}
		for (z = [d - wt - 5 + 3.5]) {
			// M5 mount hole
			translate([h - 7, w * 2, z - 3.5 + 2.5]) rotate([90, 0, 0]) cylinder(r = 2.51, h = d * w, center = false, $fn = 24);
			// countersink
			translate([h - 7, w + 8 - 0.1, z - 3.5 + 2.5]) rotate([90, 0, 0]) cylinder(r = 4.95 + 0.1, h = d * h, center = false, $fn = 24);
		}
	}
	// extrusion pin
	translate([h / 6, w + wt, d - wt - 5]) rotate([0, 0, 0]) cube([5, 13, 5], center = false);
	// support material
	for (i = [h - 5]) {
		translate([w + 8.5, i, 0]) cube([1.5, 9, d - 10], center = false);
		translate([w - 8.5, i, 0]) cube([1.5, 9, d - 10], center = false);
		translate([w + 2, i, 0]) cube([1.5, 1.5, d], center = false);
		translate([w - 3, i, 0]) cube([1.5, 1.5, d], center = false);
		translate([w + 3, i + 7, 0]) cube([1.5, 2.5, d], center = false);
		translate([w - 4, i + 7, 0]) cube([1.5, 2.5, d], center = false);
		translate([w - 17, i, 0]) cube([1.5, 12.5, d - 5], center = false);
	}
	translate([w + 2, i, 0]) cube([1.5, 1.5, d], center = false);
	translate([w - 3, i, 0]) cube([1.5, 1.5, d], center = false);
	for (i = [w + 2 * wt]) {
		translate([i + 6, h / 3, 0]) cube([wt, 1, d + 11], center = false);
		translate([i + 6, 2 * h / 3, 0]) cube([wt, 1, d + 11], center = false);
	}
	translate([-wt / 3, h / 3, 0]) cube([wt, 1, d + 11], center = false);
	translate([-wt / 3, 2 * h / 3, 0]) cube([wt, 1, d + 11], center = false);
	// done support material
}

module switch_enclosure(h, w, d, tol, wt, sb, nh, nw, nzo) {
	difference() {
		minkowski() {
			translate([wt * 0.75 / 2, wt * 0.75 / 2, 0]) cube([h + wt * 2 - wt * 0.75, w + wt * 2 - wt * 0.75, d + sb + wt], center = false);
			cylinder(r = wt * 0.75, h = 0.01, center = false, $fn = 24);
		}
		translate([wt, wt, wt]) cube([h, w, d + sb + wt + tol], center = false);
		// notch for switch clip
		translate([-h / 2 + wt, (w - nw) / 2 + wt, nzo]) cube([h * 2, nw, nh], center = false);
		// wire channels
		translate([-h / 2 + wt, (w - wt - 10) / 2, wt]) cube([h * 2, 10, 3.5], center = false);
		translate([wt, wt, wt]) cube([10, w * 2, 3.5], center = false);
	}
}

module sidearm_m3(h, w, d, tol, wt, sb, nh, nw, nzo) {
	difference() {
		minkowski() {
			union() {
				translate([h - 10, w + 4, 0]) cube([10, 6 + wt * 2, 5], center = false);
				translate([h - 10, w + wt + 10, 0]) cube([10, 5, d], center = false);
				translate([h - 12, w + 4, 0]) cube([2, 6 + wt * 2 + 3, d], center = false);
			}
			cylinder(r = 0.5, h = 0.01, center = false, $fn = 24);
		}
		// M3 mount holes
		translate([h - 6, w * 2, wt + 5]) rotate([90, 0, 0]) cylinder(r = 1.5, h = d * 2, center = false, $fn = 24);
		translate([h - 6, w * 2, d - wt - 5]) rotate([90, 0, 0]) cylinder(r = 1.5, h = d * 2, center = false, $fn = 24);
		// slot mount holes
		translate([h - 9, w + 10, wt + 3.5]) cube([10, 6 + wt * 2, 3], center = false);
		translate([h - 9, w + 10, d - wt - 3.5]) cube([10, 6 + wt * 2, 3], center = false);
		// TODO countersink mount holes for this to work
	}
}

module mount_arm_m3(h, w, d, tol, wt, sb, nh, nw, nzo) {
	for (z = [d - wt - 5 + 3.5]) {
		// trapezoid block
		difference() { 
			hull() {
				hull() {
					translate([h - 10, w + 4, z - 6]) cube([10, 5, 10], center = false);
					translate([h + 5, w, z + 6.5]) rotate([0, 90, 90]) cube([15, 15 + wt * 2, 5], center = false);
				}
				// rounded block
				translate([h - 12.5, w + wt + 1.5 + 3.5, z + 2.5]) rotate([90, 0, 90]) cylinder(r = 1, h = 15, center = false, $fn = 24);
				translate([h - 12.5, w + wt + 1.5 + 3.5, z - 7 + 2.5]) rotate([90, 0, 90]) cylinder(r = 1, h = 15, center = false, $fn = 24);
			}
			// M3 mount hole
			translate([h - 5, w * 2, z - 3.5 + 2.5]) rotate([90, 0, 0]) cylinder(r = 1.6, h = d * 2, center = false, $fn = 24);
		}
	}
}