/*
    Titulo: Pie.scad
    Descripcion: Pie de soporte para sujetar al chasis del disco.
    Autor: Matias Micheletto
    Fecha: 12-Jul-2019
    Email: matias.micheletto@uns.edu.ar
    Website: http://www.diec.uns.edu.ar/rts/#/group
*/

$fn=100;

// Dimensiones
L = 100; // Largo del pie
H = 50; // Altura
W = 10; // Ancho
R = 10; // Radio curvatura angulo

// Orificios para tornillos
sep = 45; // Separacion
db = 15; // Distancia al borde del pie


module envolvente(){
    cube([L,W,H], center = true);
}

L2 = L*0.75; H2 = H-7; // Largo y alto a quitar para el ahuecamiento central
w = L-L2-H+H2; s = sqrt(H*H+w*w); // Dimensiones rectangulo diagonal
module rem(){
    union(){ // Recorte interior
        translate([(L-L2+R)/2,0,(H-H2)/2])
            cube([(L2-R),W,H2], center = true);
        
        translate([(L-L2)/2,0,(H-H2+R)/2])
            cube([L2,W,H2-R], center = true);
        
        translate([L/2-L2+R,0,H/2-H2+R])
        rotate([0,90,90])
            cylinder(r = R, h = W+1, center = true);
    }
    
    // Recorte diagonal
    translate([-L/2,-W/2,-H/2])
    rotate([0,-asin(H/s),0])
        cube([s,W,w*H/s]);
}

Rh1 = 3.75; // Radio para cabeza del tornillo
Rh2 = 2; // Radio para rosca del tornillo
ph = 1.5; // Espesor de la zona de ajuste
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

//rotate([0,180+asin(H/s),0]) // Posicionar verticalmente (para visualizar)
difference(){
    envolvente();
    rem();
    holes();
}
