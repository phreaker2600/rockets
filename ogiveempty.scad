
bodyid=13/2;
bodyod=16.5;
noseconeheight=30;
wallt=1.5;
bottomt=2;
//pitch=5;
//holed=3;
//reinforced=3;
//threadd=32;
//noser=1;
lugdi=2.5;
lugw=1;
lugvw=2;
ventd=1;
ogivenosecone();


function ogiverho(r,l) = (r*r+l*l)/(2*r);
function ogivey(rho,x,r,l) = sqrt(rho*rho-pow(l-x,2))+r-rho;
function nosex0(r,l,rho,rn) = l-sqrt(pow(rho-rn,2)-pow(rho-r,2));
function noseyt(rn,rho,r) = rn*(rho-r)/(rho-rn);
function nosext(x0,rn,yt) = x0-sqrt(rn*rn-yt*yt);
module vents()
{
	translate([0,bodyid*20,4])
	rotate([90,0,0])
	cylinder(r=ventd,h=bodyid*40);
	rotate([0,0,90])
	translate([0,bodyid*20,4])
	rotate([90,0,0])
	cylinder(r=ventd,h=bodyid*40);
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

module ogive(d=bodyod,l=noseconeheight,fnl=180,fnr=24,rn=noser){
	r = d/2;
	rho = ogiverho(r,l);
	x0 = nosex0(r,l,rho,rn);
	yt = noseyt(rn,rho,r);
	xt = nosext(x0,rn,yt);
	union(){
		rotate_extrude($fn=fnr){
			intersection(){
				translate([r-rho,0]) circle(r=rho,$fn=fnl);
				square([r,l]);
			}
		}
		//translate([0,0,l-x0]) sphere(r=rn,$fn=fnr);
	}
}

module ogivenosecone(diameter=bodyod,height=noseconeheight,wallt=wallt){
	factor=(diameter-2*wallt)/diameter;
	difference(){
		ogive(diameter,height);
		difference(){
			translate([0,0,factor/2]){
				ogive(factor*diameter,factor*height);
				translate([0,0,-(bodyid/4)])
				cylinder(r=bodyod/2-wallt,h=bodyid/2);
				vents();
			}
		}
	}
}
difference(){
	union(){
		rotate([0,0,90])
		translate([7.5,0,0])
		rotate([0,0,-90])
		linconn();
		rotate([0,0,-90])
		translate([7.5,0,0])
		rotate([0,0,-90])
		linconn();
	}
	translate ([0,0,-55])
	cylinder(r=13/2,h=600);
}

translate ([0,0,-55])
% cylinder(r=13/2,h=60);

