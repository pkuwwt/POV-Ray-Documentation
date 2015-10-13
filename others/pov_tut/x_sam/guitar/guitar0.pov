// POV-Ray 3.6 / 3.7 Scene File "guitar0.pov"
// author: Friedrich A. Lohmueller, 2005/Aug-2009/Jan-2011   
// email:  Friedrich.Lohmueller_at_t-online.de
// homepage: http://www.f-lohmueller.de
//
// POV-Ray example: Guitar Body by Prism with Cubic Spline
//
//------------------------------------------------------------------------
#version 3.6; // 3.7;
global_settings{ assumed_gamma 1.0 }
#default{ finish{ ambient 0.1 diffuse 0.9 }} 
//------------------------------------------------------------------------
#include "colors.inc"
#include "textures.inc"
//------------------------------------------------------------------------
#declare Camera_1 = camera { perspective
                             angle 25
                             location  <0.00, 0.30, -3.00>
                             right     x*image_width/image_height
                             look_at   <0.00, 0.30,   0.00>
                           }
camera{Camera_1}
//------------------------------------------------------------------------
// sun -------------------------------------------------------------------
light_source{<1500,2500,-2500> color White}
// sky -------------------------------------------------------------------
sky_sphere{ pigment{ gradient <0,1,0>
                     color_map{ [0   color rgb<1,1,1>         ]//White
                                [0.4 color rgb<0.14,0.14,0.56>]//~Navy
                                [0.6 color rgb<0.14,0.14,0.56>]//~Navy
                                [1.0 color rgb<1,1,1>         ]//White
                              }
                     scale 2 }
           } // end of sky_sphere 
//------------------------------------------------------------------------

//------------------------------ the Axes --------------------------------
//------------------------------------------------------------------------
#macro Axis_( AxisLen, Dark_Texture,Light_Texture) 
 union{
    cylinder { <0,-AxisLen,0>,<0,AxisLen,0>,0.05
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
          scale 0.5 translate <AxisLenX+0.15,0.2,-0.05>}
#end // of #if 
#if (AxisLenY != 0)
 object { Axis_(AxisLenY, Tex_Dark, Tex_Light)   rotate< 0,0,  0>}// y-Axis
 text   { ttf "arial.ttf",  "y",  0.15,  0  texture{Tex_Dark}    
           scale 0.5 translate <-0.35,AxisLenY+0.20,-0.05>}
#end // of #if 
#if (AxisLenZ != 0)
 object { Axis_(AxisLenZ, Tex_Dark, Tex_Light)   rotate<90,0,  0>}// z-Axis
 text   { ttf "arial.ttf",  "z",  0.15,  0  texture{Tex_Dark}
               scale 0.5 translate <-0.75,0.2,AxisLenZ+0.10>}
#end // of #if 
} // end of union
#end// of macro "AxisXYZ( ... )"
//-------------------------------------------------------------------------

#declare Texture_A_Dark  = texture { 
                               pigment{ color rgb<1,0.55,0>}
                               finish { phong 1}
                             }
#declare Texture_A_Light = texture { 
                               pigment{ color rgb<1,1,1>}
                               finish { phong 1}
                             }

object{ AxisXYZ( 3.0, 7.0, 2.0, Texture_A_Dark, Texture_A_Light) 
        scale 0.1 } //!!!!
//-------------------------------------------------- end of coordinate axes


// ground -----------------------------------------------------------------
//---------------------------------<<< settings of squered plane dimensions
#declare RasterScale = 0.5;
#declare RasterHalfLine  = 0.04;  
#declare RasterHalfLineZ = 0.04; 
//-------------------------------------------------------------------------
#macro Raster(RScale, HLine) 
       pigment{ gradient x scale RScale
                color_map{[0.000   color rgbt<1,1,1,0>*0.6]
                          [0+HLine color rgbt<1,1,1,0>*0.6]
                          [0+HLine color rgbt<1,1,1,1>]
                          [1-HLine color rgbt<1,1,1,1>]
                          [1-HLine color rgbt<1,1,1,0>*0.6]
                          [1.000   color rgbt<1,1,1,0>*0.6]} }
       finish { ambient 0.15 diffuse 0.85}
 #end// of Raster(RScale, HLine)-macro    
//-------------------------------------------------------------------------
    

plane { <0,1,0>, 0    // plane with layered textures
        texture { pigment{ color White*1.1}
                  finish { phong 0.1}}
        texture { Raster(RasterScale,RasterHalfLine ) rotate<0,0,0> }
        texture { Raster(RasterScale,RasterHalfLineZ) rotate<0,90,0>}
        rotate<-90,0,0>
        translate<0,0,0.001>
        scale 0.1 // !!!
      }
//------------------------------------------------ end of squered plane XY

//--------------------------------------------------------------------------
//---------------------------- objects in scene ----------------------------
//--------------------------------------------------------------------------



// ------------------------------------------------ Dimensions of the guitar
// ------------------------------------------------- Abmessungen der Gitarre
#declare G_z = 0.15;    // Guitare deepth in -z direction 
                        // Gitarren-Dicke in -z Richtung
// Silhouette    right:  <x,y> values
//               rechts: <x,y>-Werte  
#local S0 = < 0.00, 0.00>;   
#local S1 = < 0.16, 0.05>; 
#local S2 = < 0.22, 0.20>; 
#local S3 = < 0.15, 0.35>; 
#local S4 = < 0.17, 0.48>; 
#local S5 = < 0.12, 0.56>; 
#local S6 = < 0.00, 0.60>; 
                          // vectors with 2 components: S(u,v).
                          // Here: If S = S(Xs,Ys), 
                          //       then S.u = Xs and X.v = Ys !
                          // Vektoren mit 2 Komponenten: S(u,v). 
                          // Hier gilt: wenn S = S(Xs,Yx), 
                          //   dann ist S.u = Xs und X.v = Ys ! 

// automatisch spiegelbildliche linke Seite:
#local S7 = <-S5.u, S5.v>;
#local S8 = <-S4.u, S4.v>;                                                   
#local S9 = <-S3.u, S3.v>; 
#local S10 = <-S2.u, S2.v>; 
#local S11 = <-S1.u, S1.v>; 
//-----------------------------------------------------------------------

// linear prism in y direction: from / to / number of points (first=last)
// lineares Prisma in y-Richtung: 
prism { linear_sweep
        cubic_spline
        G_z, 0.00, 15  // start ; End in z direction ; number of points
                       // Start und Ende in z-Richtung; Anzahl der Punkte
        S0, 
        S1, 
        S2, 
        S3, 
        S4, 
        S5, 
        S6, 
        S7, 
        S8, 
        S9, 
        S10, 
        S11, 
        
        S0, // first point = last point
            // letzter Punkt = erster Punkt
        
        S1, // 2 more !  - 2 dr�ber hinaus!
        S2
         
        texture {pigment{ color White} 
                 finish { phong 1.0}}
        rotate<-90,0,0> 
        translate<0.0,0,0> 
      } // end of prism --------------------------------------------------
//------------------------------------------------------------------------

//------------------------------------------------------------ Base points
//------------------------------------------------------------ St�tzpunkte
#declare Point = sphere { <0,0,0>, 0.01  
         texture { pigment{ color Red } // rgb< 1, 0.0, 0.0>}
                   finish { phong 1}
                 } // end of texture 
          scale<1,1,1>  rotate<0,0,0>  translate<0,0,-G_z,>  
       }  // end of sphere ----------------------------------- 
#declare Point_ = sphere { <0,0,0>, 0.01  
         texture { pigment{ color YellowGreen } // rgb< 1, 0.0, 0.0>}
                   finish { phong 1}
                 } // end of texture 
          scale<1,1,1>  rotate<0,0,0>  translate<0,0,-G_z,>  
       }  // end of sphere ----------------------------------- 

object{ Point translate < S0.u, S0.v, 0>}
object{ Point translate < S1.u, S1.v, 0>}
object{ Point translate < S2.u, S2.v, 0>}
object{ Point translate < S3.u, S3.v, 0>}
object{ Point translate < S4.u, S4.v, 0>}
object{ Point translate < S5.u, S5.v, 0>}
object{ Point translate < S6.u, S6.v, 0>}

object{ Point_ translate < S7.u, S7.v, 0>}
object{ Point_ translate < S8.u, S8.v, 0>}
object{ Point_ translate < S9.u, S9.v, 0>}
object{ Point_ translate < S10.u, S10.v, 0>}
object{ Point_ translate < S11.u, S11.v, 0>}
//--------------------------------------------------------------------- end                                                                                 
