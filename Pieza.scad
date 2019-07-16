/*
    Titulo: Pieza.scad
    Descripcion: Pieza reemplazo motor stepper de disco duro con ahuecamiento 
        para pasar eje de máquina de reloj.
    Autor: Matías Micheletto
    Fecha: 12-Jul-2019
    Email: matias.micheletto@uns.edu.ar
    Website: http://www.diec.uns.edu.ar/rts/#/group
*/


$fn = 100; // Resolucion del modelo

// Envolvente pieza base
Hb = 1.6; // Espesor base
Rb = 26; // Radio base
module base(){ // Envolvente de la base
    cylinder(r = Rb, h = Hb, center = true);
}

// Asiento del disco duro
Ha = 7; // Altura asiento disco
Ra = 16.5; // Radio asiento disco
module as_shaft(){
    translate([0,0,Ha/2-Hb/2])
        cylinder(r = Ra, h = Ha, center = true);
}

// Eje del disco duro
Rds = 12.5; // Radio
Hds = 8; // Altura desde el piso
module d_shaft(){ // Orificio central    
    translate([0,0,Hds/2-Hb/2])
        cylinder(r = Rds, h = Hds, center = true);
}

// Eje del ajuste del disco
Ras = 7.5; // Radio
Has = 12; // Altura desde el piso
module ad_shaft(){ // Orificio central    
    translate([0,0,Has/2-Hb/2])
        cylinder(r = Ras, h = Has, center = true);
}

// Orificios de soporte de la pieza
dshb = 1.5; // Separacion del orificio al borde de la base
Rshb = 1.75; // Radio orificio soporte
module scr_holes_b(){ // Orificios soporte de la base
    for(angle = [0 : 120 : 360])
        rotate([0,0,angle])     
        translate([Rb-Rshb-dshb,0,0])
            cylinder(r = Rshb, h = Hb, center = true);
}

// Orificios de soporte del ajuste del disco
dsha = 1.7; // Separacion del orificio al borde del eje del disco
psha = 4; // Profundidad del orificio
Rsha = 1.5/2; // Radio orificio soporte
module scr_holes_a(){ // Orificios soporte de la base
    for(angle = [0 : 60 : 360])
        rotate([0,0,angle])     
        translate([Rds-Rsha-dsha,0,Hds-Hb/2-psha/2])
            cylinder(r = Rsha, h = psha, center = true);
}

// Orificio para eje del reloj
Rmh = 3.25; // Radio eje reloj
module clock_hole(){
    translate([0,0,Has/2-Hb/2])
        cylinder(r = Rmh, h = Has, center = true);
}


// Dibujar todo
difference(){
    union(){
        base(); // Base
        as_shaft(); // Asiento del disco duro
        d_shaft(); // Eje del disco duro
        ad_shaft(); // Eje del ajuste del disco
    }
    scr_holes_b(); // Orificios de la base
    scr_holes_a(); // Orificios para ajustar el disco
    clock_hole(); // Orificio para eje del reloj
}

