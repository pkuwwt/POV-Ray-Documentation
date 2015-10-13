// POV-Ray 3.7 Scene File "Straight2Plane_1.pov"
// author: Friedrich A. Lohmueller, Sept-2011
// email: Friedrich.Lohmueller_at_t-online.de
// homepage: http://www.f-lohmueller.de
//--------------------------------------------------------------------------
#version 3.6; // or 3.7; 
global_settings{ assumed_gamma 1.0 } 
#default{ finish{ ambient 0.15 diffuse 0.85 conserve_energy}}
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
//------------------------------------------------------------- Camera_Position, Camera_look_at, Camera_Angle
#declare Camera_Number = 3 ;
//--------------------------------------------------------------------------------------------------------<<<<
//--------------------------------------------------------------------------------------------------------<<<<
#switch ( Camera_Number )
#case (0)
  #declare Camera_Position = < 0.00, 1.00, -5.00> ;  // front view
  #declare Camera_Look_At  = < 0.00, 1.00,  0.00> ;
  #declare Camera_Angle    =  65 ;
#break
#case (1)
  #declare Camera_Position = <-0.7 , 0.80 ,-1.5> ;  // diagonal view
  #declare Camera_Look_At  = <0.1, 0.3 ,-0.2> ;
  #declare Camera_Angle    =  23 ;
#break
#case (2)  
  #declare Camera_Position =  <-0.7 , 0.55 ,-1.8> ;  // front view
  #declare Camera_Look_At  = <0.25, 0.2 , 0.3> ;
  #declare Camera_Angle    =   16 ;
#break
#case (3)  
  #declare Camera_Position =  <-5.5 , 6.50 ,-15.0> ;  // diagonal view
  #declare Camera_Look_At  = < 0.5, 1.3 ,-1.8> ;
  #declare Camera_Angle    =   15 ;
#break
#else
  #declare Camera_Position = < 0.00, 1.00,-20.00> ;  // front view
  #declare Camera_Look_At  = < 0.00, 1.00,  0.00> ;
  #declare Camera_Angle    =   45 ;
#break
#end // of "#switch ( Camera_Number )" -----------------------------
//------------------------------------------------------------------------------------------------------<<<<<
camera{ location Camera_Position
        right    x*image_width/image_height
        angle    Camera_Angle
        look_at  Camera_Look_At
      }
//------------------------------------------------------------------------------------------------------<<<<<

//------------------------------------------------------------------------
// sun -------------------------------------------------------------------
light_source{<-1300, 100,-2500> color White}
light_source{ Camera_Position  color rgb<0.9,0.9,1>*0.1}  // flash light

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
          rotate<30, 35,0> scale 0.75 translate <AxisLenX+0.05,0.4,-0.10> no_shadow}
#end // of #if 
#if (AxisLenY != 0)
 object { Axis_(AxisLenY, Tex_Dark, Tex_Light)   rotate< 0,0,  0>}// y-Axis
 text   { ttf "arial.ttf",  "y",  0.15,  0  texture{Tex_Dark}    
          rotate<20,0,0> scale 0.6 translate <-0.65,AxisLenY+0.50,-0.10>  rotate<0, 35,0> no_shadow}
#end // of #if 
#if (AxisLenZ != 0)
 object { Axis_(AxisLenZ, Tex_Dark, Tex_Light)   rotate<90,0,  0>}// z-Axis
 text   { ttf "arial.ttf",  "z",  0.15,  0  texture{Tex_Dark}
          rotate<30, 35,0> scale 0.75 translate <-0.75,0.2,AxisLenZ+0.10> no_shadow}
#end // of #if 
} // end of union
#end// of macro "AxisXYZ( ... )"
//------------------------------------------------------------------------

#declare Texture_A_Dark  = texture {
                               pigment{ color rgb<1,1,1>*0.15}
                               finish { phong 1}
                             }
#declare Texture_A_Light = texture { 
                               pigment{ color rgb<1,1,1>}
                               finish { phong 1}
                             }

object{ AxisXYZ( 7, 4, 3.00, Texture_A_Dark, Texture_A_Light) scale 0.5}
//-------------------------------------------------- end of coordinate axes


// ground -----------------------------------------------------------------
//---------------------------------<<< settings of squared plane dimensions
#declare RasterScale = 1;
#declare RasterHalfLine  = 0.015*0.5 ;  
#declare RasterHalfLineZ = 0.025*0.5 ; 
//-------------------------------------------------------------------------
#macro Raster(RScale, HLine)
       pigment{ gradient x scale RScale
                color_map{[0.000   color rgbt<1,1,1,0>*0.9]
                          [0+HLine color rgbt<1,1,1,0>*0.9]
                          [0+HLine color rgbt<1,1,1,1>]
                          [1-HLine color rgbt<1,1,1,1>]
                          [1-HLine color rgbt<1,1,1,0>*0.9]
                          [1.000   color rgbt<1,1,1,0>*0.9]} }
 #end// of Raster(RScale, HLine)-macro
//-------------------------------------------------------------------------


plane { <0,1,0>, 0    // plane with layered textures
        texture { pigment{color White*1.5}
                    finish {ambient 0.45 diffuse 0.55}
                }
        texture { Raster(RasterScale,RasterHalfLine ) rotate<0,0,0> }
        texture { Raster(RasterScale,RasterHalfLineZ) rotate<0,90,0>}
        rotate<0,0,0>
      }
//------------------------------------------------ end of squared plane XZ

//--------------------------------------------------------------------------
//---------------------------- objects in scene ----------------------------
//--------------------------------------------------------------------------


//.............................................................................................................
//.............................................................................................................
//----------------------------------------------------------- macro "Vector(Start,End,Radius)"!
#macro Vector(P_start,P_end, R_Vector)  
union{

cylinder{ P_start, P_end - ( vnormalize(P_end - P_start)*9.5*R_Vector), R_Vector  }
cone    { P_end - 1.5*( vnormalize(P_end - P_start)*10*R_Vector), 3*R_Vector, P_end, 0 }
}// end of union
#end //-------------------------------------------------------------------------- end of macro
// 
// ----------------------------------------------------------------- textures
#declare T_Yellow =      // texture{ T_Yellow } 
         texture { pigment{ color rgb< 1.0, 0.55, 0.0> } 
                // normal { bumps 0.5 scale 0.05 }
                   finish { phong 1 reflection 0.00}
                 } // end of texture 

#declare T_Red =        // texture{ T_Red } 
         texture { pigment{ color rgb< 0.75, 0.0, 0.10> }  
                // normal { bumps 0.5 scale 0.05 }
                   finish { phong 1 reflection 0.00}
                 } // end of texture 

#declare T_YellowGreen =  // texture{ T_YellowGreen } 
         texture { pigment{ color rgb< 0.3, 0.7, 0.0> } 
                // normal { bumps 0.5 scale 0.05 }
                   finish { phong 1 reflection 0.00}
                 } // end of texture 

//.............................................................................................................
//.............................................................................................................

#declare A = <-0.00,1.00,-2.00>;
#declare B = < 0.75,1.20,-1.50>;
#declare C = < 2.00,0.00,-2.00>;
/////////////////////////////////////////////////////////////////////////

sphere{ <0,0,0>, 0.075  texture{ T_YellowGreen }  translate A }
sphere{ <0,0,0>, 0.075  texture{ T_Yellow }       translate B }
/////////////////////////////////////////////////////////////////////////
text { ttf "arialbd.ttf", "A", 0.02, 0.0 // thickness, offset
       texture{ T_YellowGreen } 
       scale<1,1.25,1>*0.35
       translate <-0.4,0.00,0>  rotate<-5, 30,0> 
       translate A // no_shadow
      } // end of text object ---------------------------------------------
text { ttf "arialbd.ttf", "B", 0.02, 0.0 // thickness, offset
        texture{ T_Yellow } 
       scale<1,1.25,1>*0.35
       translate <-0.4,-0.02,0>  rotate<-5, 30,0> 
       translate B  // no_shadow
      } // end of text object ---------------------------------------------
/////////////////////////////////////////////////////////////////////////
// traces to xz plane:
cylinder{ <A.x,0,A.z>, A,  0.01  texture{ T_YellowGreen }  } 
cylinder{ <B.x,0,B.z>, B,  0.01  texture{ T_Yellow }  } 
/////////////////////////////////////////////////////////////////////////
// vector AB:
object{  Vector( A,B, 0.023)    texture{ T_YellowGreen }  } 
/////////////////////////////////////////////////////////////////////////
// straight line AB: 
cylinder{ A- (B-A)*4,B+ (B-A)*10, 0.010   texture{ T_Yellow }  }  
/////////////////////////////////////////////////////////////////////////
// plane through C parallel to yz-plane
box { <0.00, 0.00, 0.00>,< 0.025, 5.00, 5.50>   
      texture { pigment{ color rgb<1.00, 1.00, 1.00>}  
                finish { phong 1 } 
              } // end of texture

      translate C
    } // end of box --------------------------------- 
/////////////////////////////////////////////////////////////////////////
 

// In which point S hits the straight line the plane x = 2 ? 
// The plane x = 2 contains only points with  x-coordinate = 2 = C.x !!!   
// Equivation of the straight line BA :
/*
Vector.X = Startpunkt B + Variable m * connection vector BA 
In Components: 
   x  =  B.x  + m ( A.x - B.x )   I 
   y  =  B.y  + m ( A.y - B.y )   II
   z  =  B.z  + m ( A.z - B.z )   III

x is known:   
      x = C.x (here: x = 2)
I:    C.x = B.x + m (A.x - B.x )   | -B.x
<=>   C.x - B.x = m (A.x - B.x )   | : (A.x - B.x ) | change sides

<=>   m = ( C.x - B.x )/( A.x - B.x ) 
 
so   C.y = B.y + ( C.x - B.x )/( A.x - B.x )*( A.y - B.y ) 
and  C.z = B.z + ( C.x - B.x )/( A.x - B.x )*( A.z - B.z ) 
*/

// in POV-Ray: 
#declare  m = ( C.x - B.x )/( A.x - B.x ); 

#declare SX =  C.x;                                            
#declare SY =  B.y +  m *( A.y - B.y );
#declare SZ =  B.z +  m *( A.z - B.z ); 
#declare S = < SX, SY, SZ >;

// Punkt D (rot)
sphere{ <0,0,0>, 0.1 texture{ T_Red }  translate S }
text { ttf "arialbd.ttf", "S", 0.02, 0.0 // thickness, offset
       texture{ T_Red    } 
       scale<1,1.25,1>*0.35
       translate <-0.3,0.10,0>  rotate<0, 15,0> 
       translate S   no_shadow
      } // end of text object ---------------------------------------------
//-------------------------------------------------------------------------

 