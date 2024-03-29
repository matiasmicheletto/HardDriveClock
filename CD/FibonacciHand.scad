/*
    Title: FibonacciHand.scad
    Description: Spiral shaped clock hand.
    Author: Matias Micheletto
    Date: 21-Jun-2021
    Email: matias.micheletto@uns.edu.ar
    Website: https://matiasmicheletto.github.io
*/

$fn = 100; // Model resolution

x = 55; // Spiral length from center to border
sections = 7; // Spiral sections
width = 4; // Width of hand
height = 2; // Thickness of the hand
shaft_r = 3.1; // Shaft inner radius
shaft_h = 3; // Shaft height

// Compact disc dimensions
cd_outer_r = 60;
cd_leadout_r = 58; // not used
cd_leadin_r = 12.5;
cd_inner_r = 7.5;
cd_h = 1.2;


// Fibonacci function
function fibonacci(n) = 
    n < 2 ? n : fibonacci(n - 1) + fibonacci(n - 2);

// This function calculates the value of 
// the scaler so that the spiral of "n" sections 
// have a desired total length of "x" mm.
function get_scale(x, n) =
    let (k = n+3) // Span 3 first elements
    let (r = k%2==0 ? 
        fibonacci(k/2) * fibonacci(k/2-1)
        : 
        pow(fibonacci((k-1)/2),2)
    )
    x/r;
    
// Then we use it here to obtain the correct scale:
scale = get_scale(x, sections);
echo("Scale",scale);
    
// Draw a quarter circle spiral section of radius fibonacci(n)
module section(n) {
    rotate_extrude(angle = 90, convexity = 10)
    translate([scale*fibonacci(n), 0, 0])
    square(size = [width, height]);
}

// X and Y translations for make continuous sections
// These are empirical, no clue where do they come from but works fine.
function translate_y(n) =
    ((n-1) % 4 < 2 ? -1:1) * pow(fibonacci(floor((n-1)/2)),2);
    
function translate_x(n) =   
    (n % 4 < 2 ? -1:1) * fibonacci(floor(n/2)) * fibonacci(floor(n/2)-1);

// Draw spiral positioning the sections correctly
module spiral(){
    color([.2,.2,.2])
    for(n=[1:sections]){
        translate(scale*[translate_x(n), translate_y(n), 0])
        rotate((n % 4) * 90)
            section(n);
    }
}

// This is the center cylinder of the hand that is mounted to
// the hour shaft of the clock. The outer radius should be corrected
module shaft() {
    color([.2,.2,.2])
    difference(){
        cylinder(r = shaft_r + width + 1, h = shaft_h);
        cylinder(r = shaft_r, h = shaft_h);
    }
}

// Compact disc (to put hand into perspective)
module CD() {
    color([1,1,1])
    difference() {
        cylinder(r = cd_outer_r, h = cd_h);
        cylinder(r = cd_leadin_r, h = cd_h);
    }
    color([.8,.8,.8])
    difference() {
        cylinder(r = cd_leadin_r, h = cd_h);
        cylinder(r = cd_inner_r, h = cd_h);
    }
}

// Draw everything

spiral();
shaft();
translate([0,0,-4])
    CD();
