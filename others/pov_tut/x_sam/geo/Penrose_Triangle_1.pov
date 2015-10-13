// POV-Ray 3.7 Scene File "Penrose_Triangle_1.pov"
// author: Friedrich A. Lohmueller, Oct-2009/Jan-2011
// email: Friedrich.Lohmueller_at_t-online.de
// homepage: http://www.f-lohmueller.de
//--------------------------------------------------------------------------
#version 3.6; // 3.7;
global_settings{ assumed_gamma 1.0 }
#default{ finish{ ambient 0.1 diffuse 0.9 }}
//--------------------------------------------------------------------------
#include "colors.inc"
#include "textures.inc"
#include "glass.inc"
#include "metals.inc"
#include "golds.inc"
#include "stones.inc"
#include "woods.inc"
#include "shapes.inc"
#include "shapes2.inc"
#include "functions.inc"
#include "math.inc"
#include "transforms.inc"
//-------------------------------------------------------------------------------------------------------<<<<
//-------------------------------------------------------------------------------------------------------<<<<
camera{ orthographic                                          // orthographic camera for Penrose Triangle
        location < 10, 10,-10>    // diagonal view !!!!
        right    x*image_width/image_height
        angle    5
        look_at  <  0,  0,  0>
      }
//------------------------------------------------------------------------------------------------------<<<<<
// sun ---------------------------------------------------------------------
light_source{<   0, 1500,    0> color rgb< 1,0.1,  0>*0.35}  // top light
light_source{< 500, 1500,-1000> color rgb< 1,  1,  1>*0.45}  // sun light
light_source{ < 10, 10,-10>     color rgb< 1,0.5,0.5>*0.30}  // flash light
// sky ---------------------------------------------------------------------
sky_sphere { pigment { color rgb <1,1,1>}  }
//--------------------------------------------------------------------------
//---------------------------- objects in scene ----------------------------
//--------------------------------------------------------------------------



//-------------------------------------------------------------------------- 
//-------------------------------------------------------------------------- 
// ------------------------- Penrose Triangle ------------------------------
#declare D = 0.00001; 
#declare Length   = 1; 
#declare Diameter = 0.15; 
// internals: 
#declare R = Diameter/2; 
#declare L = Length - 2*R; 
//--------------------------------------------------------------------------
#declare PT_Texture =  
      texture { pigment{ color rgb <1, 0.87, 0.15>*1.2 } 
                finish { phong 0 reflection 0.00}
              } // end of texture
//--------------------------------------------------------------------------
#declare Element = 
box { <-R,-R,-R>,< L+R, R, R>   
      texture {PT_Texture}  
      scale <1,1,1> rotate<0,0,0> translate<0,0,0> no_shadow
    } // end of box --------------------------------------
//--------------------------------------------------------------------------
#declare Element_Cut = 
difference{ 
 object{ Element scale<0.5,1,1> } 
 object{ Element scale<0.7,1,1> translate<0,-D,-D>} 
} // end difference
//--------------------------------------------------------------------------



//--------------------------------------------------------------------------
#declare Penrose_Triangle = 

union{
object{ Element_Cut rotate<-90,-90,0> translate<0,0,0>}
object{ Element rotate<0,0,90> } 
object{ Element rotate<0,0,0> translate<0,L,0>} 
object{ Element_Cut rotate<0, 90,0> translate<L,L,0>}

no_shadow
} // end of union 
//--------------------------------------------------------------------------

//--------------------------------------------------------------------------
object{ Penrose_Triangle  
        translate<-L*0.333,-L*0.666,0>
      } // end of union 
//--------------------------------------------------------------------------
//--------------------------------------------------------------------------
//-------------------------------------------------------------------------- 
//-------------------------------------------------------------------------- end 

















 