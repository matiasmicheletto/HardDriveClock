/*
    Title: Motor.scad
    Description: Replacement piece for the HDD motor with a center hole to passing the shaft
        of the clock machine.
    Author: Matias Micheletto
    Date: 12-Jul-2019
    Email: matias.micheletto@uns.edu.ar
    Website: https://matiasmicheletto.github.io
*/


$fn = 100; // Model resolution

// Base piece envelope
Hb = 1.6; // Thickness
Rb = 26; // Radius
module base(){ // Envelope
    cylinder(r = Rb, h = Hb, center = true);
}

// Hard drive seat
Ha = 7; // Height
Ra = 16.5; // Radius
module as_shaft(){
    translate([0, 0, Ha/2-Hb/2])
        cylinder(r = Ra, h = Ha, center = true);
}

// HDD shaft
Rds = 12.5; // Radius
Hds = 8; // Height from floor
module d_shaft(){ // Central hole
    translate([0, 0, Hds/2-Hb/2])
        cylinder(r = Rds, h = Hds, center = true);
}

// Disk adjustment shaft
Ras = 7.5; // Radius
Has = 12; // Height from floor
module ad_shaft(){ // Central hole
    translate([0, 0, Has/2-Hb/2])
        cylinder(r = Ras, h = Has, center = true);
}

// Piece supporting holes
dshb = 1.5; // Distance from hole to base border
Rshb = 1.75; // Hole radius
module scr_holes_b(){ // Base adjustment holes
    for(angle = [0 : 120 : 360])
        rotate([0, 0, angle])     
        translate([Rb-Rshb-dshb, 0, 0])
            cylinder(r = Rshb, h = Hb, center = true);
}

// HDD adjustment holes
dsha = 1.7; // Distance from hole to HDD shaft
psha = 4; // Hole depth
Rsha = 1.5/2; // Radius
module scr_holes_a(){ 
    for(angle = [0 : 60 : 360])
        rotate([0,0,angle])     
        translate([Rds-Rsha-dsha, 0, Hds-Hb/2-psha/2])
            cylinder(r = Rsha, h = psha, center = true);
}

// Clock shaft hole
Rmh = 3.25; // Radius
module clock_hole(){
    translate([0, 0, Has/2-Hb/2])
        cylinder(r = Rmh, h = Has, center = true);
}


// Draw everything
difference(){
    union(){
        base(); // Base
        as_shaft(); // HDD seat
        d_shaft(); // HDD shaft
        ad_shaft(); // HDD adjustment shaft
    }
    scr_holes_b(); // Base holes
    scr_holes_a(); // HDD adjustment holes
    clock_hole(); // Clock shaft hole
}

