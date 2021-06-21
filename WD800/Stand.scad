/*
    Title: Stand.scad
    Description: Desk stand to hold the hard drive.
    Author: Matias Micheletto
    Date: 12-Jul-2019
    Email: matias.micheletto@uns.edu.ar
    Website: https://matiasmicheletto.github.io
*/

$fn = 100;

// Dimensions
L = 100; // Foot lenth
H = 50; // Height
W = 10; // Width
R = 10; // Radius of curved angle

// Screw holes
sep = 45; // Separation
db = 15; // Distance to the border of the foot


module envelope(){
    cube([L,W,H], center = true);
}

L2 = L*0.75; H2 = H-7; // Lenght and height to remove for the center hole
w = L-L2-H+H2; s = sqrt(H*H+w*w); // Dimensions of the diagonal rectangle

module rem(){
    union(){ // Interior cropping
        translate([(L-L2+R)/2,0,(H-H2)/2])
            cube([(L2-R),W,H2], center = true);
        
        translate([(L-L2)/2,0,(H-H2+R)/2])
            cube([L2,W,H2-R], center = true);
        
        translate([L/2-L2+R,0,H/2-H2+R])
        rotate([0,90,90])
            cylinder(r = R, h = W+1, center = true);
    }
    
    // Diagonal cropping
    translate([-L/2,-W/2,-H/2])
    rotate([0,-asin(H/s),0])
        cube([s,W,w*H/s]);
}

Rh1 = 3.75; // Radius for the screw's head
Rh2 = 2; // Radius for the screw's trhead
ph = 1.5; // Adjusting zone thickness
module holes(){
    
    translate([L/2-db,0,-H2/2+ph/2])
        cylinder(r = Rh1, h = H-H2-ph, center = true);
    translate([L/2-db,0,-H2/2])
        cylinder(r = Rh2, h = H-H2, center = true);
    
    translate([L/2-db-sep,0,-H2/2+ph/2])
        cylinder(r = Rh1, h = H-H2-ph, center = true);
    translate([L/2-db-sep,0,-H2/2])
        cylinder(r = Rh2, h = H-H2, center = true);
}

//rotate([0,180+asin(H/s),0]) // Vertical display (to visualize)
difference(){
    envelope();
    rem();
    holes();
}
