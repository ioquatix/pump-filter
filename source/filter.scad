
thickness = 6;
diameter = 155;
height = 36;

bottom_inset = 15;
side_inset = 14;

hole = height/6;
gap = 2;

//a=77.5 b=94 C=74.667
angle = 75;
$fn = 360/2;

module arc(a, id, od, h) {
	// Outer ring
	rotate_extrude(angle=a) translate([id/2, 0, 0]) square([(od-id)/2, h]);
}

module clip() {
	translate([-side_inset, 0, 0]) {
		cube([side_inset-2, 2, height]);
		translate([0, -2, 0]) cube([2, 4, height]);
	}
}

module grid() {
	difference() {
		arc(a=angle, od=diameter, id=diameter-thickness, h=height);
		
		for (z = [hole:hole+2:height-hole]) {
			translate([0, 0, z])
			for (r = [0+5:(angle-10)/10:angle-5]) {
				rotate([0, 0, r])
				cube([diameter, hole, hole], center=true);
			}
		}
	}
	
	arc(a=angle, od=diameter, id=diameter-bottom_inset, h=2);
	
	translate([0, 0, height]) {
		difference() {
			arc(a=angle, od=diameter-3, id=diameter-thickness, h=1);
			rotate([0, 0, angle/2]) translate([diameter/2, 0, 1]) cube([15, 15, 2], center=true);
		}
	}
	
	translate([diameter/2, 0, 0]) clip();
	
	rotate([0, 0, angle]) mirror([0, 1, 0])
	translate([diameter/2, 0, 0]) clip();
}

render() grid();
