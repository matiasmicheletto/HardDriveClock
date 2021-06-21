/*
    Title: Stand.scad
    Description: Stand for the clock machine and CD.
    Author: Matias Micheletto
    Date: 21-Jun-2021
    Email: matias.micheletto@uns.edu.ar
    Website: https://matiasmicheletto.github.io
*/

$fn = 100;

// Stand base
SW = 15; // Width
SL = 70; // Length
St = 2; // Thickness

// Foot
FW = SW/2;
FL = 30;

// Circular fit
Fr = 3.5; // Fit radius
Fh = 15; // Fit length


// Base
cube([SL, SW, St], center = true);
// Foot
translate([FW/2-SL/2 ,0, 0])
cube([FW, FL, St], center = true);
// Fit
translate([SL/2-Fh, 0, Fr-St/2])
rotate([0, 90, 0])
cylinder(r = Fr, h = Fh);