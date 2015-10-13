// POV-Ray 3.7 Scene File "hole1.pov"
// author:  Friedrich A. Lohmueller
// Date:   Aug. 2003 / Aug-2009
// email: Friedrich.Lohmueller_at_t-online.de
// homepage: http://www.f-lohmueller.de
//--------------------------------------------------------------------------
#if (version < 3.7) global_settings{ assumed_gamma 1.0 } #end
//--------------------------------------------------------------------------
#include "colors.inc"
#include "textures.inc"
//--------------------------------------------------------------------------
// camera ------------------------------------------------------------------
#declare Camera_0 = camera {ultra_wide_angle angle 135          // front view
                            location  <0.0 , 1.0 ,-3.5>
                            right     x*image_width/image_height
                            look_at   <0.0 ,-0.5 , 0.0>}
camera{Camera_0}
// sun ---------------------------------------------------------------------
light_source{<1500,2500,-2500> color White}
// sky ---------------------------------------------------------------------
plane{<0,1,0>,1 hollow no_shadow 
       texture{ pigment{ Bright_Blue_Sky scale 2
                        }
                finish {ambient 1 diffuse 0} }      
       scale 10000}
// fog ---------------------------------------------------------------------

fog{fog_type   2
    distance   30
    color      rgb<1,0.98,0.9>
    fog_offset 0.1
    fog_alt   1
    turbulence 0.8}
  
    
// ground ------------------------------------------------------------------
// the dimensions of the hole:
#declare HoleInnerR = 1.25;
#declare HoleScale  = 1.50;
#declare HoleR      = 1.00;
//-------------------------
// the plane with a hole:
union{
difference{

plane{<0,1,0>, 0 }
cylinder{<0,-HoleR,0>, <0,0.0001,0>,HoleInnerR+HoleR scale HoleScale}
cylinder{<0,  -100,0>, <0,0.0001,0>,HoleInnerR scale HoleScale}
          } // end of difference
          
torus{ HoleInnerR+HoleR, HoleR 
       translate<0,-HoleR,0>scale HoleScale}

 texture{Polished_Chrome //Glass3 
         normal {spiral1  20  0.25  sine_wave    
                 turbulence 0.1 rotate<90,0,0> scale <0.25,0.5,0.25> }
         finish {ambient 0.15 diffuse 0.85 reflection 0.35}}
 } // end of union

//-----------------------------------------------------------------------end







