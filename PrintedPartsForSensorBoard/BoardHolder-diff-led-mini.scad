// Holder for Ormerod prototype differential IR sensor board
// Choose layer height to be a submultiple of the thickness

thickness=1.1;	// board is 1.2mm but this part comes out slightly too thick
xborder=30;
yborder=30;
yrepeat=50;
height=24.0;
width=18.6;
clearance=0.35;
cornerRadius=4;
cornerOffset=1;
overlap=1;

module wedge(x,y,z)
{
	polyhedron(
		points=[[0,0,0],[x,0,0],[0,y,0],[0,0,z],[x,0,z],[0,y,z]],
		faces=[[0,2,1],[3,4,5],[0,1,3],[1,4,3],[1,2,4],[2,5,4],[0,3,2],[5,2,3]]
	);
}

module boardCutout()
{
	translate([0,0,-overlap])
		cube([height+clearance,width+clearance,thickness+2*overlap]);
	translate([height+clearance-cornerOffset,width+clearance-cornerOffset,-overlap])
		cylinder(r=cornerRadius,h=thickness+2*overlap,$fn=12);
	translate([-cornerOffset,-cornerOffset,-overlap])
		cylinder(r=cornerRadius,h=thickness+2*overlap,$fn=12);
	translate([height+clearance-cornerOffset,-cornerOffset,-overlap])
		cylinder(r=cornerRadius,h=thickness+2*overlap,$fn=12);
	translate([-cornerOffset,width+clearance-cornerOffset,-overlap])
		cylinder(r=cornerRadius,h=thickness+2*overlap,$fn=12);
}


difference()
{
	cube([height+2*xborder+clearance,width+2*yborder+clearance+yrepeat,thickness]);
	translate([xborder,yborder,0]) boardCutout();
	translate([xborder,yborder+yrepeat,0]) boardCutout();
}

translate([12-overlap,16-overlap,0]) wedge(10+2*overlap,10+2*overlap,thickness);

