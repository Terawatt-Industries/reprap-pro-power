/*Parametric X carriage for self-aligning bronze bushings, V1.0
By David Orgeman
Released under the terms of the GNU GPL v3.0 

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program. If not, see <http://www.gnu.org/licenses/>.
*/
/*
	3D Power Supply Mount
	by Free Beachler of Terawatt Industries

This work is licensed under the Creative Commons Attribution-ShareAlike 3.0 Unported License. To view a copy of this license, visit http://creativecommons.org/licenses/by-sa/3.0/.
*/

//Round corner diameter
round_corner_diameter = 8;

m5_diameter = 5.5;
m5_nut_diameter = 9.5;
m5_cap_diameter = 8.5;
m4_diameter = 4.5;
m4_nut_diameter = 7.5;
m3_diameter = 3.2;
m3_nut_diameter = 5.3;

power_mount();
// power supply
% color([0.1, 0.9, 0]) translate([0, 2.5, 10]) cube([85, 175, 70]);

module power_mount() {
	difference() {
		platform();
		translate([0, 2.5, 0]) mount_holes();
	}
}

module platform() {
	difference() {
		// round some corners
		translate([0, 0, 5]) minkowski() {
			difference() {
				cube([85, 180, 25]);
				translate([10, -5.1, 10]) cube([65, 205.2, 70]);
			}
			cylinder(r=2.5, h=0.01, center=false, $fn=12);
			//	rotate([0, 90, 0]) cylinder(r=2.5, h=0.01, center=false, $fn=12);
		}
		translate([0, 2.5, 10]) cube([85 + 0.2, 175 + 0.2, 75]);
	}
	// square mount area
	translate([-9.5, -2.5, 5]) cube([9.5, 185, 25]);
	//	translate([-9.5, 5, 0]) cube([97.5, 185, 5]);
}

module mount_holes() {
	for (i = [25, 150]) {
		rotate([0, 90, 0]) translate([-10, i, -20]) cylinder(r=m5_diameter / 2, h=150, center = false, $fn=12);
		rotate([0, 90, 0]) translate([-10, i, -4.9]) cylinder(r=m5_cap_diameter / 2, h=10, center = false, $fn=12);
	}
}

