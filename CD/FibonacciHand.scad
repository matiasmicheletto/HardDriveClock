/*
    Title: FibonacciHand.scad
    Description: Spiral shaped clock hand.
    Author: Matias Micheletto
    Date: 17-Jun-2021
    Email: matias.micheletto@uns.edu.ar
    Website: https://matiasmicheletto.github.io
*/

$fn = 100; // Model resolution

x = 45; // Spiral length from center to border
sections = 7; // Spiral sections
width = 2.5; // Width
height = 2; // Thickness of the hand
shaft_r = 3; // Shaft inner radius
shaft_h = 3; // Shaft height


// This function calculates the value of 
// the scaler so that the spiral of "n" sections 
// to have a desired measurement "x"
function get_scale(x, n) =
    let (k = n+3)
    let (r = 
        k%2==0 ? 
        fibonacci(k/2) * fibonacci(k/2-1)
        : 
        pow(fibonacci((k-1)/2),2)
    )
    x/r;
    
scale = get_scale(x, sections);

module shaft() {
    difference(){
        cylinder(r = shaft_r + width, h = shaft_h);
        cylinder(r = shaft_r, h = shaft_h);
    }
}


// Fibonacci function
function fibonacci(n) = 
    n < 2 ? n : fibonacci(n - 1) + fibonacci(n - 2);
    
// Quarter circle spiral section of radius fibonacci(n)
module section(scale, n) {
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
    for(n=[1:sections]){
        translate(scale*[translate_x(n), translate_y(n), 0])
        rotate((n % 4) * 90)
            section(scale, n);
    }
}

// Draw everything
spiral();
shaft();

