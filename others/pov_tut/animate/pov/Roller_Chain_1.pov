// POV-Ray 3.7 Scene File "Roller_Chain_1.pov"
// author: Friedrich A. Lohmueller, Feb-2010/Jan-2011
// email: Friedrich.Lohmueller_at_t-online.de
// homepage: http://www.f-lohmueller.de
//--------------------------------------------------------------------------
#version 3.6; // 3.7;
global_settings{ assumed_gamma 1.0 }
#default{ finish{ ambient 0.1 diffuse 0.9 conserve_energy}}
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
//--------------------------------------------------------------------------------------------------------<<<<
//------------------------------------------------------------- Camera_Pos, Camera_look_at, Camera_Angle
#declare Camera_Number = 0 ;
//--------------------------------------------------------------------------------------------------------<<<<
#switch ( Camera_Number )
#case (0)
  #declare Camera_Pos       = <-0.08, 0.02,-1.00> ;  // front view
  #declare Camera_Look_At  = <-0.08, 0.02,  0.00> ;
  #declare Camera_Angle    =   35 ;
#break
#case (1)
  #declare Camera_Pos      = < 1.00, 1.00, -1.00> ;  // diagonal view
  #declare Camera_Look_At  = < 0.00, 1.00,  0.00> ;
  #declare Camera_Angle    =  45 ;
#break
#else
  #declare Camera_Pos       = < 0.00, 1.00,-1.00> ;  // front view
  #declare Camera_Look_At  = < 0.00, 1.00,  0.00> ;
  #declare Camera_Angle    =  35 ;
#break
#end // of "#switch ( Camera_Number )" -----------------------------
//-------------------------------------------------------------------------------------------------------<<<<
camera{ location Camera_Pos
        right    x*image_width/image_height
        angle    Camera_Angle
        look_at  Camera_Look_At
      }
//------------------------------------------------------------------------------------------------------<<<<<
//------------------------------------------------------------------------
// sun -------------------------------------------------------------------
light_source{<1000,2500,-2500> color White*0.9}           // sun light
light_source{ Camera_Pos  color rgb<0.9,0.9,1>*0.1}  // flash light

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
    cylinder { <0,-AxisLen*1.5,0>,<0,AxisLen,0>,0.05
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

object{ AxisXYZ( 4.0, 3.5, 0, Texture_A_Dark, Texture_A_Light) scale 0.05}
//-------------------------------------------------- end of coordinate axes


// ground -----------------------------------------------------------------
//---------------------------------<<< settings of squared plane dimensions
#declare RasterScale = 0.05;
#declare RasterHalfLine  = 0.02;
#declare RasterHalfLineZ = 0.02;
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
        texture { pigment{color White*0.3}
                  finish {ambient 0.45 diffuse 0.85}}
        texture { Raster(RasterScale,RasterHalfLine ) rotate<0,0,0> }
        texture { Raster(RasterScale,RasterHalfLineZ) rotate<0,90,0>}
        rotate<-90,0,0>
      }
//------------------------------------------------ end of squared plane XY

//--------------------------------------------------------------------------
//---------------------------- objects in scene ----------------------------
//--------------------------------------------------------------------------


// -------------- dimensions -----------
#local R1 = 0.15;  // big wheel radius
#local R2 = 0.075; // small wheel radius
#local Dist = 0.30;// axis distance
#local Link_N = 30;// number of links
// -------------- calculations ---------
#local Ri = R1-R2;
#local C_Angle = degrees(asin(Ri/Dist));
// chain length linear
#local LLen=sqrt(pow(Dist,2)-pow(Ri,2));
// segment angles and lengths
#local Ang1 = 180+2*C_Angle;
#local Ang2 = 180-2*C_Angle;
#local Len1 = Ang1/360*2*pi*R1;
#local Len2 = Ang2/360*2*pi*R2;
// total length
#local C_Len = 2*LLen+Len1+Len2;
#local Link_L  = C_Len / Link_N;
// -------------------------------------
// -------------------------------------


#declare Link = 
sphere{ <0,0,0>,0.0075 
        texture{ Chrome_Metal 
                 pigment{ color rgb<1,0.75,0>}
                 finish { phong 1}
               } 
      }
//-------------------------------------- 
#local Ani=clock*Link_L;// animation!
union{ //-------------------------------
#local Nr = 0; // start loop
#while (Nr < Link_N)
 
 #local Pos = mod(Nr*Link_L+Ani,C_Len);
 //-------------------------------------
 #if(Pos<Len1 ) // front down
  #local Rot1 = Pos/Len1*Ang1;
  object{Link translate<0,R1,0>
         rotate<0,0,-Rot1 +C_Angle>}
 #end //--------------------------------
 #if((Pos>Len1) & (Pos<=Len1+LLen))
  #local LPos = Pos-Len1; // base side
  object{Link translate<LPos,R1,0>       
            rotate<0,0,-C_Angle-180 >}   
 #end //--------------------------------
 #if((Pos>Len1+LLen )       // back up
      & (Pos<= Len1+LLen+Len2))
  #local Rot2 =
      (Pos-Len1-LLen)/Len2*Ang2;
  object{Link translate<0, R2,0>
              rotate<0,0,-Rot2-C_Angle-180>
              translate<-Dist,0,0>}
 #end //--------------------------------
 #if((Pos > Len1+LLen+Len2) // up forward
      & (Pos <= Len1+LLen+Len2+LLen))
  #local LPos = Pos-(Len1+LLen+Len2);
  object{Link  translate<LPos, R2,0>
               rotate<0,0,C_Angle>
               translate<-Dist,0,0>}
 #end //--------------------------------
#local Nr = Nr + 1;  // next Nr
#end // --------------- end of loop
} // end of union ---------------------- 
//-------------------------------------- 

//------------------------------------------------- 
#local D = 0.0001; // just for demo circles
//------------------------------------------------- 
cylinder{ <0,0,-D>,<0,0,D>, R1 
          texture{ pigment{ color rgb<1,1,1>*0.7}   
                   finish { phong 0.5 }
                 } // end of texture
        } // end of cylinder  -------------------- 
cylinder{ <0,0,-D>,<0,0,D>, R2 
          texture{ pigment{ color rgb<1,1,1>*0.7}   
                   finish  { phong 0.5 }
                 } // end of texture
          translate<-Dist,0,0>
        } // end of cylinder  -------------------- 
//------------------------------------------------- 
cylinder{ <0,0,0>,<LLen,0,0>, 0.002 
          texture { pigment{ color rgb<1.0,0.5,1.0>}
                    finish { phong 0.5}
                  } // end of texture
          translate<0,R2,0> rotate<0,0,C_Angle> 
          translate<-Dist,0,0>
        } // end of cylinder  --------------------
cylinder{ <0,0,0>,<LLen,0,0>, 0.002 
          texture { pigment{ color rgb<0.5,0,0.2>}
                    finish  { phong 0.5 }
                  } // end of texture
          translate<0,-R2,0> rotate<0,0,-C_Angle> 
          translate<-Dist,0,0>
        } // end of cylinder  -------------------- 

//--------------------------------------------------------- 
//--------------------------------------------------------- 
#include "shapes_lo.inc"
//#macro Segment_of_Torus( R_major, R_minor, Segment_Angle)
object{ Segment_of_Torus( R1, 0.002, Ang1 )
        texture { pigment{ color rgb<0.5,0.0,0.2>}
                  finish { phong 1}
                } // end of texture
        rotate<-90,0,  Ang1/2>  
      } // end of Torus_Segment(...) ----------------------             
//--------------------------------------------------------- 
object{ Segment_of_Torus( R2, 0.002, Ang2 )
        texture { pigment{ color rgb<0.5,0.0,0.2>}
                  finish { phong 1}
                } // end of texture
        rotate< 90,0,  Ang1/2> translate<-Dist,0, 0.00>
      } // end of Torus_Segment(...) ----------------------              
//--------------------------------------------------------- 
//
//--------------------------------------------------------- macro "Vector(Start,End,Radius)"!
#macro Vector(P_start,P_end, R_Vector)  
union{
cylinder{ P_start, P_end - ( vnormalize(P_end - P_start)*9.5*R_Vector), R_Vector  }
cone    { P_end - (vnormalize(P_end - P_start)*10*R_Vector), 3*R_Vector, P_end, 0 }
}// end of union
#end //----------------------------------------------------------------------- end of macro


//------------------------------------------------------------------------------------
object{ Vector( o,<0,R1,0>,0.002) rotate<0,0,C_Angle> pigment{color rgb<0.2,0.5,0>}}
//------------------------------------------------------------------------------------
object{ Vector( o,<0,R2,0>,0.002) rotate<0,0,C_Angle> pigment{color rgb<0.2,0.5,0>} translate<-Dist,0,0>}
//------------------------------------------------------------------------------------


