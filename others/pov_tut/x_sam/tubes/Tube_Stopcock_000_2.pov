// POV-Ray 3.6 / 3.7 Scene File "Tube_Stopcock_000_00c.pov"
// author: Friedrich A. Lohmueller, June-2009/Aug-2009/Jan-2011
// email:  Friedrich.Lohmueller_at_t-online.de
// homepage: http://www.f-lohmueller.de
//--------------------------------------------------------------------------
#version 3.6; // 3.7;
global_settings{ assumed_gamma 1.0 }
#default{ finish{ ambient 0.05 diffuse 0.9 }}
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
#declare Camera_0 = camera {/*ultra_wide_angle*/ angle 15      // front view
                            location  <0.0 , 1.0 ,-40.0>
                            right     x*image_width/image_height
                            look_at   <0.0 , 1.0 , 0.0>}
#declare Camera_1 = camera {/*ultra_wide_angle*/ angle  50   // diagonal view
                            location  < 3.50, 4.00,-4.00>
                            right     x*image_width/image_height
                            look_at   < 0.15, 0.550, 0.00> }
#declare Camera_2 = camera {/*ultra_wide_angle*/ angle 90  //right side view
                            location  <3.0 , 1.0 , 0.0>
                            right     x*image_width/image_height
                            look_at   <0.0 , 1.0 , 0.0>}
#declare Camera_3 = camera {/*ultra_wide_angle*/ angle 90        // top view
                            location  <0.0 , 3.0 ,-0.001>
                            right     x*image_width/image_height
                            look_at   <0.0 , 1.0 , 0.0>}
camera{Camera_1}
//------------------------------------------------------------------------
// sun -------------------------------------------------------------------
light_source{<1000,1500,-2500> color White*0.9}           // sun light
light_source{<3.50,4.00,-4.00> color rgb<0.9,0.9,1>*0.05} // flash light
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
          scale 0.5 translate <AxisLenX+0.05,0.4,-0.10>}
#end // of #if
#if (AxisLenY != 0)
 object { Axis_(AxisLenY, Tex_Dark, Tex_Light)   rotate< 0,0,  0>}// y-Axis
 text   { ttf "arial.ttf",  "y",  0.15,  0  texture{Tex_Dark}
           scale 0.5 translate <-0.75,AxisLenY+0.50,-0.10>}
#end // of #if
#if (AxisLenZ != 0)
 object { Axis_(AxisLenZ, Tex_Dark, Tex_Light)   rotate<90,0,  0>}// z-Axis
 text   { ttf "arial.ttf",  "z",  0.15,  0  texture{Tex_Dark}
               scale 0.5 translate <-0.75,0.2,AxisLenZ+0.10>}
#end // of #if
} // end of union
#end// of macro "AxisXYZ( ... )"
//------------------------------------------------------------------------

#declare Texture_A_Dark  = texture {
                               pigment{ color rgb<1,0.45,0>}
                               finish { phong 1}
                             }
#declare Texture_A_Light = texture {
                               pigment{ color rgb<1,1,1>}
                               finish { phong 1}
                             }

object{ AxisXYZ( 3.5, 2.5, 7, Texture_A_Dark, Texture_A_Light) scale 0.5   no_shadow}
//-------------------------------------------------- end of coordinate axes


// ground -----------------------------------------------------------------
//---------------------------------<<< settings of squared plane dimensions
#declare RasterScale = 0.1;
#declare RasterHalfLine  = 0.025;
#declare RasterHalfLineZ = 0.025;
//-------------------------------------------------------------------------
#macro Raster(RScale, HLine)
       pigment{ gradient x scale RScale
                color_map{[0.000   color rgbt<1,1,1,0>*0.6]
                          [0+HLine color rgbt<1,1,1,0>*0.6]
                          [0+HLine color rgbt<1,1,1,1>]
                          [1-HLine color rgbt<1,1,1,1>]
                          [1-HLine color rgbt<1,1,1,0>*0.6]
                          [1.000   color rgbt<1,1,1,0>*0.6]} }
 #end// of Raster(RScale, HLine)-macro
//-------------------------------------------------------------------------


plane { <0,1,0>, 0    // plane with layered textures
        texture { Raster(RasterScale,RasterHalfLine ) rotate<0,0,0> }
        texture { Raster(RasterScale,RasterHalfLineZ) rotate<0,90,0>}
        no_shadow
      }
plane { <0,1,0>, 0    // plane with layered textures
        texture { pigment{color White*1.1}
                  finish {ambient 0.45 diffuse 0.85}}
        translate<0,-1,0>
      }
//------------------------------------------------ end of squared plane XZ

//--------------------------------------------------------------------------
//---------------------------- objects in scene ----------------------------
//--------------------------------------------------------------------------
#ifndef ( Tube_Fork_000_Inc_Temp)
#include "Tube_Fork_000.inc"
#end
//--------------------------------------------------------------------------
#macro Tube_Stopcock_000(  R1, // ~0.50
                           R2, // ~0.35 ~0.65
                           Tube_D, // ~0.05; // tube material thickness
                           Blobfactor, // 0.1~0.002
                           R_Correction, //   ~  Blobfactor/5
                           Test_End_Cylinders_ON, // on = 1; off = 0

                           F_Add, // flange radius add
                           F_D, // flange thickness
                           FB_R, // Flange_Border_Radius
                           Nuts_ON, // 0 = no nuts but holes; 1 = nuts - no holes
                           Nut_Scale, // ~0.035
                           Number_of_Nuts, // ~ 16,

                           Side_End_Cover_ON,
                           Stopcock_Wheel_ON, // 0 or 1
                           Stopcock_Wheel_Rotation_Angle,

                           Wheel_Rmin,
                           Wheel_Rmaj,
                           Wheel_Axis_Len,
                        ) // ------------------------------------------------
//-------------------------------------------------------- dimensions
#local D = 0.0001; // just a little bit !!!
#local Box_L = 4*R1;
#if (F_Add <=0 ) #local F_Add  = Tube_D+D; #end
//-------------------------------------------------------- default textures
#ifndef (Tube_Body_Texture)
#declare Tube_Body_Texture =
  texture{ pigment{ color rgb<1,1,1>*0.95}
           normal { bumps 0.05 scale 0.3005}
           finish { phong 0.7 reflection 0.05}}
#end
#ifndef (Tube_Inside_Texture)
#declare Tube_Inside_Texture =
  texture{ pigment{ color rgb<1,1,1>*0.7}
           finish { phong 0}}

#end
#ifndef (Test_Tube_Texture)
#declare Test_Tube_Texture =
           texture { pigment { color rgb<0.7,0.3,1>}
                   //normal  { bumps 0.5 scale <0.25, 0.005,0.005>}
                     finish  {  phong 0.5 reflection 0.00 }
                   } // end of texture
#end
//---------------------------------------------------------
#ifndef( Flange_Texture_1 )
#declare Flange_Texture_1 =
          texture { pigment{ color rgb< 1, 1, 1>*0.75 }
                    normal { bumps 0.015 scale 0.005 }
                    finish { phong 1 reflection 0.00}
                 } // end of texture
#end
#ifndef( Flange_Texture_2 )
#declare Flange_Texture_2 =
          texture { pigment{ color rgb< 1, 1, 1>*0.65 }
                    normal { bumps 0.015 scale 0.005 }
                    finish { phong 1 reflection 0.00}
                 } // end of texture
#end
#ifndef( Flange_Hole_Texture )
#declare Flange_Hole_Texture =
          texture { pigment{ color rgb< 1, 1, 1>*0.55 }
                    normal { bumps 0.015 scale 0.005 }
                    finish { phong 1 reflection 0.00}
                 } // end of texture
#end
#ifndef( Nut_Texture_1 )
#declare Nut_Texture_1 =
          texture { pigment{ color rgb< 1, 1, 1>*0.75 }
                    normal { bumps 0.015 scale 0.005 }
                    finish { phong 1 reflection 0.00}
                 } // end of texture
#end
#ifndef( Nut_Texture_2 )
#declare Nut_Texture_2 =
          texture { pigment{ color rgb< 1, 1, 1>*0.55 }
                    normal { bumps 0.015 scale 0.005 }
                    finish { phong 1 reflection 0.00}
                 } // end of texture
#end
#ifndef( Wheel_Texture_1 )
#declare Wheel_Texture_1 =
          texture { pigment{ color rgb< 1, 1, 1>*0.85 }
                    normal { bumps 0.015 scale 0.005 }
                    finish { phong 1 reflection 0.00}
                 } // end of texture
#end
//---------------------------------------------------------
//---------------------------------------------------------
#local Nut =
union{
object{ Hexagon
        texture { Nut_Texture_2 }
        scale <0.4,1,1>*Nut_Scale/2 translate<Nut_Scale/2*0.4,0,0>
       } // end of object Hexagon
cylinder{ <0,0,0>, <Nut_Scale*1.15/2,0,0>, Nut_Scale/2*0.5
         texture { Nut_Texture_1 }
       } // end of cylinder
}// end uni
//---------------------------------------------------------
//---------------------------------------------------------
#macro Flange ( Tube_Rad, Flange_Add ) // ---------------------- submacro
#local Flange_Base =
difference{  // (point A, point B, Radius, EdgeRadius, UseMerge)
   object{ Round_Cylinder(<0,0,0>, <F_D  ,0,0>,Tube_Rad+Flange_Add, FB_R, 0)
           texture{Flange_Texture_1}}
   cylinder{ <-D,0,0>,<F_D+D,0,0>,Tube_Rad-Tube_D/2 texture{Tube_Inside_Texture} }
 #local Nr = 0;     // start
 #local EndNr = Number_of_Nuts; // end
 #while (Nr< EndNr)
 cylinder{<-D,0,0>,<F_D+D,0,0>,Nut_Scale/2*0.5
           texture{ Flange_Hole_Texture }
           translate<0,0,-Tube_Rad-(Flange_Add)/2>
           rotate<Nr * 360/EndNr,0,0>}
  #local Nr = Nr + 1;    // next Nr
  #end // ---------------  end of loop
} // end of diff
// ------------------------------------
union{
 object{ Flange_Base}
#if (Nuts_ON = 1)
 union{
  #local Nr = 0;     // start
  #local EndNr = Number_of_Nuts; // end
  #while (Nr< EndNr)
   object{ Nut
           translate<F_D,0,-Tube_Rad-(Flange_Add)/2>
           rotate<Nr * 360/EndNr,0,0>}
  #local Nr = Nr + 1;    // next Nr
  #end // ---------------  end of loop
  }
#end //'#if (Nuts_ON = 1) '

} // end of union
#end //-------------------------------- end submacro ------------
//---------------------------------------------------------------
//---------------------------------------------------------------
#declare Side_Cover =
union{ // flange + cover plate
 object{ Flange( R2, F_Add ) }
 object{ Round_Cylinder(<0,0,0>, <F_D/2,0,0>,R2+F_Add, FB_R,0)
          texture{Flange_Texture_1}}
} // ------------------------------------------------------------
//---------------------------------------------------------------
#declare Wheel =
union{
 // axis holder
 object{ Round_Cylinder(<-FB_R,0,0>, <Wheel_Axis_Len/2,0,0>,2*Wheel_Rmin, FB_R, 0)
         texture{Flange_Texture_1}}
 object{ Round_Cylinder(<-FB_R,0,0>, <Wheel_Axis_Len/5,0,0>,2.5*Wheel_Rmin, FB_R, 0)
         texture{Flange_Texture_1}}
 // wheel + axis
 union{ //2
  cylinder{ <0,0,0>,<Wheel_Axis_Len,0,0>,Wheel_Rmin}
   union{ //3
    torus{ Wheel_Rmaj, Wheel_Rmin  rotate<0,0,90> }
    cylinder{ <0,0,-Wheel_Rmaj>,<0,0,Wheel_Rmaj>,Wheel_Rmin*2/3 }
    cylinder{ <0,0,-Wheel_Rmaj>,<0,0,Wheel_Rmaj>,Wheel_Rmin*2/3 rotate<90,0,0>}
    sphere{ <0,0,0>,Wheel_Rmin*1.75 scale<0.67,1,1> }
    scale<0.8,1,1>
    translate<Wheel_Axis_Len,0,0>
   } // uni3
  texture{Wheel_Texture_1}
 } // uni2
} // end of union Wheel
//--------------------------------------------------------------
//-------------------------------------------------------------- all together now!

union{
// add the flanges
 object{ Flange( R1, F_Add )
         scale <-1,1,1>
         rotate<0,90,0>
         translate<0,0,-Box_L>
       }
 object{ Flange( R1, F_Add )
         scale < 1,1,1>
         rotate<0,90,0>
         translate<0,0, Box_L>
       }
 object{ Flange( R2, F_Add )
         scale <-1,1,1>
         rotate<0,0,0>
         translate<Box_L,0, 0>
       }
//------------------------------
#if ( Side_End_Cover_ON = 1 | Stopcock_Wheel_ON = 1 )
 // Cover with wheel - Deckel mit Rad
 object{  Side_Cover
          translate<Box_L,0, 0> }
#end
//------------------------------
#if ( Stopcock_Wheel_ON = 1 )
 object{  Wheel  rotate<Stopcock_Wheel_Rotation_Angle,0,0>
          translate<Box_L,0, 0> }
#end
//---------------------------------------------------------------------------
// needs: #include "Tube_Fork_000.inc"
object{ Tube_Fork_000 ( // total container box length =   4*R1
                          R1, // R1, // main tube radius:  1 ~ 0.25
                          R2, // R2, // side tube radius:  1.5 ~ 0.20
                          Tube_D, // Tube_D, // tube material thickness
                          Blobfactor, // Blobfactor; // 0.1~0.002 ; maximum ~ 0.20 !!
                          R_Correction, // radius correction, ~ 0.06
                          Test_End_Cylinders_ON, // Test_cylinders_ON;  on = 1; off = 0
                        ) // -------------------------------------------------
      } // end of object -----------------------------------------------------
//------------------------------
} // end union with flanches
#end // --------------------------------------------------- end of macro
//--------------------------------------------------------------------------
//--------------------------------------------------------------------------


//--------------------------------------------------------------------------
//--------------------------------------------------------------------------
// ------------------------ optional textures
/*
#declare Tube_Body_Texture =
  texture{ pigment{ color rgb<0.3,0.7,0>*1.3}
           finish { phong 1 reflection 0.10}}
#declare Tube_Inside_Texture =
  texture{ pigment{ color rgb<0.3,0.7,0>*1.1}
           finish { phong 1}}
#declare Test_Tube_Texture =
           texture { pigment { color rgb<1,0.7,0>}
                   //normal  { bumps 0.5 scale <0.25, 0.005,0.005>}
                     finish  {  phong 0.5 reflection 0.00 }
                   } // end of texture
//--------------------------------------------------------------------------
*/
//--------------------------------------------------------------------------
object{ Tube_Stopcock_000( // total length in z: 4*R1 / in x+: 2*R1
                           0.50, // R1, // main tube radius:  1 ~ 0.25
                           0.35, // R2, // side tube radius:  1.5 ~ 0.20
                           0.05, // Tube_D, // tube material thickness
                           0.15, // Blobfactor; // 0.1~0.002 ; maximum = 0.20 !!
                           0.05, //R_Correction, //   ~  Blobfactor/5
                           0, // Test_End_Cylinders_ON=1; off=0

                           0.14, // F_Add, // flanch radius add
                           0.05, // F_D, // flanch thickness
                           0.01, // FB_R, // Flanch_Border_Radius
                           1, // Nuts_ON, // 0 = no nuts but holes; 1 = nuts - no holes
                           0.085, // Nut_Scale, // ~0.035
                           12, // Number_of_Nuts, // ~ 16,

                           1,// Side_End_Cover_ON,

                           1,// Stopcock_wheel_ON
                           20,// Stopcock_wheel_Rotation_Angle
                           // wheel sitzes
                           0.05, //  Wheel_Rmin,
                           0.45, //  Wheel_Rmaj,
                           0.35, //  Wheel_Axis_Len,

                        ) // -----------------------------------------------
         rotate <0,0,90>
      } // -----------------------------------------------------------------
//--------------------------------------------------------------------------
//--------------------------------------------------------------------------



