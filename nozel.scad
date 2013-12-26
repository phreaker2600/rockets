atd=13;
ath=60;
lfs=0.5;

wall=2.5;
bh=10;
finwall=1.5;
fh=10;
lugdi=2.5;
lugw=1;
lugvw=2;
module estesa103t()
{
	 cylinder(r=atd/2,h=ath);
}
module linconn()
{
	//translate([0,0,lugvw/2])
	//scale([1,1,lugvw])
	linear_extrude(height = lugvw)
	difference(){
		hull(){
			translate([0,lugdi+lugw,0]) circle(lugdi+lugw);
			circle(lugdi+lugw);
		}
		translate([0,lugdi,0]) circle(lugdi);

	}

}
module fin()
{
	//translate([0,0,finwall/2])
	//scale([1,finwall,1])
	translate([0,0,1])
	rotate([80,0,0])
	linear_extrude(height = finwall)
	union(){
		hull(){
			translate([(fh*3-2)/2,0,0]) circle(1);
			translate([0,fh-2,0]) circle(1);
			translate([(fh*2-2)/16,fh-2,0]) circle(1);
			circle(1);
		}
	}
}
module craftbase()
{
	difference(){
		union(){
			cylinder(r=(atd+lfs+wall)/2,h=bh);

			translate([(atd+lfs+wall)/2,0,0])
			fin();
			rotate([0,0,360/3])
			translate([(atd+lfs+wall)/2,0,0])
			fin();
			rotate([0,0,(360/3)*2])
			translate([(atd+lfs+wall)/2,0,0])
			fin();
			rotate([0,0,90])
			translate([7.5,0,0])
			rotate([0,0,-90])
			linconn();
			rotate([0,0,-90])
			translate([7.5,0,0])
			rotate([0,0,-90])
			linconn();
		}

		translate([0,0,-1])
		cylinder(r=(atd+lfs)/2,h=bh+2);
	}//difference

}
translate ([0,0,+5])
% estesa103t();
craftbase();