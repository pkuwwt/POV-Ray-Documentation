// PoVRay 3.7 Scene File "a_geo_s10.pov"
// Author: Friedrich A. Lohmueller, 2008/2009/2011
// email: Friedrich.Lohmueller@t-online.de
// homepage: http://wwww.f-lohmueller.de
//
//------------------------------------------------------------------------
#version 3.7; 
global_settings{ assumed_gamma 1.0 } 
//------------------------------------------------------------------------
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
//------------------------------------------------------------------------
#declare Camera_0 = camera {                                 // xy-view
                             angle 20
                             location  <0.0 , 0.0 ,-38.0>
                             right     x*image_width/image_height
                             look_at   <0.0, 0.0 , 0.0>
                           }

#declare Camera_1 = camera {                                // diagonal view
                             angle 9
                             location  <40.0 ,40.5 ,-40.0>
                             right     x*image_width/image_height
                             look_at   <0.3 , 1.0 ,-0.2>
                           }
#declare Camera_2 = camera {                               // yz-view
                             angle 20          
                             location  <31.0 , 7.0 ,1.0>
                             right     x*image_width/image_height
                             look_at   <1.5 , 1.4 , 1.0>
                           }
#declare Camera_3 = camera { 
                             angle 20
                             location  < 0.0 , 37.5 ,-0.0001>
                             right     x*image_width/image_height
                             look_at   <0 , 0 , 2.0>
                           }

camera{Camera_1}

//------------------------------------------------------------------------
// sun -------------------------------------------------------------------
light_source{<2500,2500,-1500> color White}
// sky -------------------------------------------------------------------
sky_sphere{ pigment{ gradient <0,1,0>
                     color_map{ [0   color rgb<1,1,1>         ]//White
                                [0.4 color rgb<1,1,1>]//~Navy
                                [0.6 color rgb<1,1,1>]//<0.14,0.14,0.56>]//~Navy
                                [1.0 color rgb<1,1,1>         ]//White
                              }
                     scale 2 }
           } // end of sky_sphere 
//------------------------------------------------------------------------

//------------------------------ the Axes --------------------------------
//------------------------------------------------------------------------
#macro Axis_( AxisLen, Dark_Texture,Light_Texture) 
 union{
    cylinder { <0,-AxisLen-3,0>,<0,AxisLen,0>,0.05
               texture{checker texture{Dark_Texture } 
                               texture{Light_Texture}
                       translate<0.1,0,0.1>}
             }
    cone{<0,AxisLen,0>,0.2,<0,AxisLen+0.7,0>,0
          texture{Dark_Texture}
         }
     } // end of union                   
#end // of macro "Axis()"
//------------------------------------------------------------------------
#macro AxisXYZ( AxisLenX, AxisLenY, AxisLenZ, Tex_Dark, Tex_Light)
//--------------------- drawing of 3 Axes --------------------------------
union{
#if (AxisLenX != 0)
 object { Axis_(AxisLenX, Tex_Dark, Tex_Light)   rotate< 0,0,-90>}// x-Axis
 text   { ttf "arial.ttf",  "x",  0.15,  0  texture{Tex_Dark} 
          scale 0.5 translate <AxisLenX+0.05,0.4,-0.10>}
#end // of #if 
#if (AxisLenY != 0)
 object { Axis_(AxisLenY, Tex_Dark, Tex_Light)   rotate< 0,0,  0>}// y-Axis
 text   { ttf "arial.ttf",  "y",  0.15,  0  texture{Tex_Dark}    
           scale 0.5 translate <-0.55,AxisLenY+0.20,-0.10>}
#end // of #if 
#if (AxisLenZ != 0)
 object { Axis_(AxisLenZ, Tex_Dark, Tex_Light)   rotate<90,0,  0>}// z-Axis
 text   { ttf "arial.ttf",  "z",  0.15,  0  texture{Tex_Dark}
               scale 0.5 translate <-0.55,0.1,AxisLenZ+0.10>}
#end // of #if 
} // end of union
#end// of macro "AxisXYZ( ... )"
//------------------------------------------------------------------------

#declare Texture_A_Dark  = texture {
                               pigment{color rgb<1,0.55,0>}
                               finish {ambient 0.15 diffuse 0.85 phong 1}
                             }
#declare Texture_A_Light = texture { 
                               pigment{color rgb<1,1,1>}
                               finish {ambient 0.15 diffuse 0.85 phong 1}
                             }

object{ AxisXYZ( 6.0, 4.5, 7.0, Texture_A_Dark, Texture_A_Light)} // <<<<<<<<<<<<<<<<< adapt the axes here !!!
//-------------------------------------------------- end of coordinate axes


// ground -----------------------------------------------------------------
//---------------------------------<<< settings of squered plane dimensions
#declare RasterScale = 1.0/2;
#declare RasterHalfLine  = 0.035/2;  
#declare RasterHalfLineZ = 0.035/2; 
//-------------------------------------------------------------------------
#macro Raster(RScale, HLine) 
       pigment{ gradient x scale RScale
                color_map{[0.000   color rgbt<1,1,1,1>*0.2]
                          [0+HLine color rgbt<1,1,1,1>*0.2]
                          [0+HLine color rgbt<1,1,1,1>]
                          [1-HLine color rgbt<1,1,1,1>]
                          [1-HLine color rgbt<1,1,1,1>*0.2]
                          [1.000   color rgbt<1,1,1,1>*0.2]} }
       finish { ambient 0.15 diffuse 0.85}
 #end// of Raster(RScale, HLine)-macro    
//-------------------------------------------------------------------------
    

plane { <0,1,0>, 0    // plane with layered textures
        texture { pigment{color rgbt<1,1,1,0.7>*1.1}
                  finish {ambient 0.45 diffuse 0.85}}
        texture { Raster(RasterScale,RasterHalfLine ) rotate<0,0,0> }
        texture { Raster(RasterScale,RasterHalfLineZ) rotate<0,90,0>}
        rotate<0,0,0>
        no_shadow
      }
//------------------------------------------------ end of squered plane XZ

//--------------------------------------------------------------------------
//---------------------------- objects in scene ----------------------------
//--------------------------------------------------------------------------


#default{ finish {ambient 0.15 diffuse 0.85} } // 

/* Some Sample rgb colors - Einige Beispiele für rgb Farben
                          - Qualche esempio per colori rgb     
//===========================================================================
               pigment { color Green } 
Black  rgb<0,0,0>  ;  Gray  rgb<1,1,1>*0.5 ; White rgb<1,1,1> ; 
Red    rgb<1,0,0>  ;  Green rgb<0,1,0>     ; Blue rgb<0,0,1>  ;  Yellow rgb<1,1,0> ;
Orange rgb<1,0.5,0>;  Cyan rgb<0,1,1>      ; Magenta<1,0,1,>  ;
orange yellow  rgba<1,0.65,0> ;  YellowGreen rgb<0.5,1,0> ; 
Dark Red rgb<0.5,0,0> ; dark green rgb<0,0.5,0> ; dark blue rgb<0,0,0.5>

transparent colors - halbtransparente Farben - colori semi trasparenti: 
Red  semi transparent:          
                pigment{ color Red transmit 0.5 } = pigment { color rgbt<1,0,0,0.5>}
*/


//-----------------------------------------------------------------------------------
#declare Rl  = 0.055; // radius of lines  - Radius der Strecken 
#declare Rp  = 0.105; // radius of points - Radius der Punkte 

// 
//------------------------------------------------------------------------------------
#include "analytical_g.inc" 
//------------------------------------------------------------------------------------
// ----------------------------------------------------------------------------------- 

// ----------------------------------------------------------------------------------- 
// ---------------------  Punti e Vettori  - Punkte und Vektoren -  Points and Vectors
//------------------------------------------------------------------------------------

#declare A  = < 3.0, 0.0,-4.0>;  
#declare B  = < 4.0, 3.0, 2.0>;  
#declare C  = <-1.0, 2.0,-3.0>;
#declare AB = B-A;
#declare AC = C-A;
#declare BC = AC-AB;
//#declare D = A + AB + AC;

#declare N = vcross(AB, AC);

//------------------------------------------------------------------------------------
// --------------------------------------------------------------- Zeichnen ---------- 
// ---------------------------------------------------------------- Drawing ---------- 
sphere{ A, Rp              pigment{ color Green*0.5 } }
object{ Show_Yxz( A, Rl/2) pigment{ color Yellow }}

sphere{ B, Rp              pigment{ color Orange } }
object{ Show_Yxz( B, Rl/2) pigment{ color Yellow }}

sphere{ C, Rp              pigment{ color Orange } }
object{ Show_Yxz( C, Rl/2) pigment{ color Yellow }}


text { ttf "arial.ttf", "A",0.1,0 
       scale 0.5 rotate<20,-45,0> translate A+<-0.2,0.0,-0.7> pigment{ color Orange } no_shadow}


text { ttf "arial.ttf", "B",0.1,0 
       scale 0.5 rotate<20,-45,0> translate B+<-0.2,0.1, 0.3> pigment{ color Orange } no_shadow }

text { ttf "arial.ttf", "C",0.1,0 
       scale 0.5 rotate<20,-45,0> translate C+<-0.2,0.3,-0.3> pigment{ color Orange } no_shadow }

//------------------------------------------------------------------------------------

 

// object{ Vector( o,A, Rl) pigment{ color rgb<0.6,1,0> }  }

 object{ Vector( A,B, Rl) pigment{ color rgb<0.6,1,0> }  }
 object{ Vector( A,C, Rl) pigment{ color rgb<0.6,1,0> }  }

 cylinder{ B, C  Rl/2  pigment{ color Green*0.5 }}




 triangle { A, B, C    pigment{ color Green transmit 0.5 }}


// calculation: 
union{ 


text{ ttf "ARIAL.TTF"  concat( "AB=<",vstr(3, AB,",",4, 1 ),">") , 0.1, 0       
       scale 0.3 rotate<20,-44,0> translate <0, 0.2,0>
        }
text{ ttf "ARIAL.TTF"  concat( "AC=<",vstr(3, AC,",",4, 1 ),">") , 0.1, 0       
       scale 0.3 rotate<20,-44,0> translate <0,-0.2,0>
        }

text{ ttf "ARIAL.TTF"  concat( "BC=<",vstr(3, BC,",",4, 1 ),">") , 0.1, 0       
       scale 0.3 rotate<20,-44,0> translate <0,-0.6,0>
        }

text{ ttf "ARIAL.TTF"  concat( "ABxAC=N=<",vstr(3, N,",",4, 1 ),">") , 0.1, 0       
       scale 0.3 rotate<20,-44,0> translate <0,-1.0,0>
       }

text{ ttf "ARIAL.TTF"  concat( "Area(ABC)=|N|/2= ",str( vlength(N)/2, 6, 3 )) , 0.1, 0       
       scale 0.3 rotate<20,-44,0> translate < 0,-1.4,0>
     }


text{ ttf "ARIAL.TTF"  concat( "Angle(CAB)= ",str( VAngleD(AC,AB), 7, 2 ),"°") , 0.1, 0       
       scale 0.3 rotate<20,-44,0> translate < 0,-1.8,0>
     }

text{ ttf "ARIAL.TTF"  concat( "Angle(ABC)= ",str( VAngleD(-AB,BC), 7, 2 ),"°") , 0.1, 0       
       scale 0.3 rotate<20,-44,0> translate < 0,-2.2,0>
     }

text{ ttf "ARIAL.TTF"  concat( "Angle(BCA)= ",str( VAngleD(BC,AC), 7, 2 ),"°") , 0.1, 0       
       scale 0.3 rotate<20,-44,0> translate < 0,-2.6,0>
     }


 
 pigment{ color rgb<1.0,0.0,0.25>*0.8}  no_shadow 
translate C+<-1.2, 3.7, -1.5>}
//------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------
//-------------------------------------------------------------------------------- end
