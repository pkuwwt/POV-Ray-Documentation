// POV-Ray 3.6 / 3.7 Scene File "guitar1.pov"
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



// ------------------------------------------------ dimensions of the guitar
// ------------------------------------------------- Abmessungen der Gitarre
#declare G_z = 0.15;    // guitar deepth in -z direction 
                        // Gitarren-Dicke in -z Richtung
#declare G_y = 0.60;    // guitar height in y direction 
                        // Gitarren-Höhe in y Richtung

#declare G_Hole_y = 0.35; // guitar hole y  - Gitarrenlochmitte y-Wert
#declare G_Hole_R = 0.07; // guitar hole radius -  Gitarrenloch-Radius

//------------------------------------------------------- guitar textures
#declare Pine_Woodx =
       texture{ // layer 1   
            pigment{ wood turbulence 0.02 octaves 4 lambda 3
                     scale 0.175  rotate <2, 2, 0> 
                     color_map {
                       [0.0 color rgb <1.00, 0.99, 0.74>]
                       [0.45 color rgb <0.75, 0.39, 0.17>]
                       [0.75 color rgb <0.75, 0.39, 0.17>]
                       [1.0 color rgb <1.00, 0.99, 0.74>]
                     }// end of color_map
                   } // end of pigment
            finish { ambient 0.1  diffuse 0.9 phong 1 } 
            rotate <0,0, 0>  scale 0.5  translate <0,0,0>
        } // end of texture ------------------------------
       texture{ // layer 2    
            pigment{ wood turbulence 0.015 octaves 4 lambda 2.8
                     scale 0.2 rotate <2, 2, 0> 
                     translate <0.0175, 0.0175, 0.0175>
                     color_map {
                       [0.00 color rgbt <1.00, 0.97, 0.95, 1.00>]
                       [0.45 color rgbt <0.85, 0.75, 0.40, 0.70>]
                       [0.75 color rgbt <0.85, 0.75, 0.40, 0.70>]
                       [1.00 color rgbt <1.00, 0.97, 0.95, 1.00>]
                     }// end of color_map
                   } // end of pigment
            finish { ambient 0.1  diffuse 0.9 phong 1 } 
            rotate <0,0, 0>  scale 0.5  translate <0,0,0>
        } // end of texture ------------------------------



#declare G_Texture_outside= 
     texture{ Pine_Woodx scale 12 translate< 0,2.2,0> 
             // pigment{color rgb<1.00,0.35,0.05>}
               finish {ambient 0.15 diffuse 0.85 phong 1 reflection 0.1}
            } // end of texture
#declare G_Texture_outside1= 
     texture{ pigment{color rgb<0.90,0.55,0.20>}
              finish {ambient 0.15 diffuse 0.85 phong 1 reflection 0.1}
            } // end of texture
#declare G_Texture_outside2= 
     texture{ pigment{color rgb<1,0.85,0.65>*1.0}
              finish {ambient 0.15 diffuse 0.85 phong 1 reflection 0.1}
            } // end of texture

#declare G_Texture_outside3= 
     texture{ pigment{color rgb<1,0.75,0.45>}
                finish {ambient 0.15 diffuse 0.85 phong 1 reflection 0.1}
             } // end of texture

#declare G_Texture_outside4= 
     texture{ pigment{color rgb<0.90,0.55,0.20>*0.25}
               finish {ambient 0.15 diffuse 0.85 phong 1 reflection 0.1}
             } // end of texture
 
#declare G_Texture_inside= 
     texture{ pigment{color rgb<1,0.85,0.65>}
               finish {ambient 0.25 diffuse 0.75 phong 1 reflection 0.1}
             } // end of texture


//------------------------------------------------------------------------- 
//------------------------------------------------------------------------- 
// Silhouette    right:  <x,y> values
//               rechts: <x,y>-Werte  
#local S0 = < 0.00, 0.00>;   
#local S1 = < 0.17, 0.05>; 
#local S2 = < 0.22, 0.19>; 
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

#declare Body_Shape =

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
        
        S1, // 2 more !  - 2 drüber hinaus!
        S2
         
        texture {pigment{color White} 
                 finish {ambient 0.15 diffuse 0.85 phong 1.0}}
        rotate<-90,0,0> 
        translate<0.0,0,0> 
      } // end of prism --------------------------------------------------
//------------------------------------------------------------------------

#declare Guitar_Body = //------------------------------------------------- the Guitar_Body 
union{  
difference{
 union { // three shapes positive
  object{Body_Shape scale< 1.010,     1.010,  0.95> 
               translate<     0,-0.005*G_y, -0.05*G_z/2> texture{ G_Texture_outside1} }

  object{Body_Shape scale<1.001,1.001,0.999> 
               translate<0,-0.0005*G_y,-(1-0.999)*G_z/2> texture{ G_Texture_outside2} }

  object{Body_Shape  texture{ G_Texture_outside   } }
 }// ------------------------------- end of the union of the positiv parts of the Body               
        
 // caving out the inside - Aushöhlen der Innenseite
 object{Body_Shape scale<0.99,0.99,1-0.01*(1/G_z)> 
               translate<0,0.005,-0.005>  texture{ G_Texture_inside}}

 // the hole - das Loch
 cylinder { <0,0,-0.1>,<0,0,0.1>, G_Hole_R  translate<0,G_Hole_y,-G_z>
           texture{ G_Texture_outside}   } // end of cylinder  ----------------------------
 }// end of difference  -------------------------------------------------------------------

 // rings around the hole
torus    { G_Hole_R+0.005 ,0.002 rotate<90,0,0> scale <1,1,0.2>  translate<0,G_Hole_y,-G_z>
           texture{ G_Texture_outside2   }
         } // end of cylinder  ------------------------------------
torus    { G_Hole_R+0.020 ,0.002 rotate<90,0,0> scale <1,1,0.2>  translate<0,G_Hole_y,-G_z>
           texture{ G_Texture_outside2   }
         } // end of cylinder  ------------------------------------

}// -------------------------------------------------------------------- end of Guitar_Body                                                                      



//-----------------------------------------------------------------------------------------
object{ Guitar_Body rotate<0,-37,0> translate<-0.05,0 ,-0.30>}

// ------------------------------------------------------------------------------------ end                                                          
 
