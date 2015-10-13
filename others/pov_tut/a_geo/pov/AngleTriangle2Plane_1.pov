// POV-Ray 3.6 / 3.7 Scene File "Angle2Plane_01c_forHP01.pov"
// author: Friedrich A. Lohmueller, Sept/Oct-2011
// email: Friedrich.Lohmueller_at_t-online.de
// homepage: http://www.f-lohmueller.de
//--------------------------------------------------------------------------
#version 3.6; // or: 3.7; 
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
//--------------------------------------------------------------------------------------------------------<<<<
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
  #declare Camera_Position = < -2 , 4 ,-5> ;  // diagonal view
  #declare Camera_Look_At  = < 3, 0 ,2> ;
  #declare Camera_Angle    =  45 ;
#break
#case (2)   
  #declare Camera_Position =  < 1 , 10, 0> ;  // top view
  #declare Camera_Look_At  =  < 1 , 0, 0.001> ;
  #declare Camera_Angle    =   46 ;
#break
#case (3)   
  #declare Camera_Position =  <-5.5 , 6.50 ,-15.0> ;  // front view from upper  
  #declare Camera_Look_At  = < 0.5, 1.5 ,-1.8> ;
  #declare Camera_Angle    =   14 ;
#break
#else
  #declare Camera_Position = < 0.00, 1.00, -5.00> ;  // front view
  #declare Camera_Look_At  = < 0.00, 1.00,  0.00> ;
  #declare Camera_Angle    =  65 ;
#break
#end // of "#switch ( Camera_Number )" -----------------------------
//------------------------------------------------------------------------------------------------------<<<<
camera{ location Camera_Position
        right    x*image_width/image_height
        angle    Camera_Angle
        look_at  Camera_Look_At
      }
//------------------------------------------------------------------------------------------------------<<<<<
//------------------------------------------------------------------------
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
#declare RasterHalfLine  = 0.015*0.7;  
#declare RasterHalfLineZ = 0.025*0.7; 
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
// ------------------------------------------------------------ textures 
#declare T_Yellow =      // texture{ T_Yellow } 
         texture { pigment{ color rgb< 1.0, 0.55, 0.0> } 
                   finish { phong 1 reflection 0.00}
                 } // end of texture 

#declare T_Orange =      // texture{ T_Orange } 
         texture { pigment{ color rgb< 1.0, 0.25, 0.0> }  
                   finish { phong 1 reflection 0.00}
                 } // end of texture 

#declare T_Red =        // texture{ T_Red } 
         texture { pigment{ color rgb< 0.75, 0.0, 0.10> }  
                   finish { phong 1 reflection 0.00}
                 } // end of texture 

#declare T_YellowGreen =  // texture{ T_YellowGreen } 
         texture { pigment{ color rgb< 0.3, 0.7, 0.0> } 
                   finish { phong 1 reflection 0.00}
                 } // end of texture 

#declare T_Lila  =  // texture{ T_Lila } 
         texture { pigment{ color rgb<0.65,0.45,1> } 
                   finish { phong 1 reflection 0.00}
                 } // end of texture 

#declare T_Cyan =   // texture{ T_Cyan }
         texture { pigment{ rgb<0,0.5,1> }
                   finish { phong 1  }
                 } // end of texture 
//.............................................................................................................
//.............................................................................................................
// 
#declare A = <-0.00,1.20,-1.00>;
#declare B = < 2.00,1.50, 1.50>;
#declare C = < 2.00,0.00,-1.00>;

sphere{ <0,0,0>, 0.075  texture{ T_YellowGreen }  translate A }
sphere{ <0,0,0>, 0.075  texture{ T_Yellow }       translate B }
sphere{ <0,0,0>, 0.075  texture{ T_Orange }       translate C }

text { ttf "arialbd.ttf", "A", 0.02, 0.0 // thickness, offset
       texture{ T_YellowGreen } 
       scale<1,1.25,1>*0.30
       translate <-0.3,0.00,0>  rotate< 0, 30,0> 
       translate A  no_shadow
      } // end of text object ---------------------------------------------
text { ttf "arialbd.ttf", "B", 0.02, 0.0 // thickness, offset
        texture{ T_Yellow } 
       scale<1,1.25,1>*0.30
       translate <-0.3, 0.1,0>  rotate<-5, 30,0> 
       translate B    no_shadow
      } // end of text object ---------------------------------------------
 
text { ttf "arialbd.ttf", "C", 0.02, 0.0 // thickness, offset
       texture{ T_Orange } 
       scale<1,1.25,1>*0.3
       translate <-0.2, 0.01,-0.9>  rotate<0, 30,0> 
       translate C  no_shadow
      } // end of text object ---------------------------------------------
//////////////////////////////////////////////////////////////////////// 
// traces to xz plane
cylinder{ <A.x,0,A.z>, A,  0.01  texture{ T_YellowGreen }  } 
cylinder{ <B.x,0,B.z>, B,  0.01  texture{ T_Yellow }  } 
////////////////////////////////////////////////////////////////////////
// vectors
object{  Vector( A,B, 0.023)    texture{ T_YellowGreen }  } 
object{  Vector( C,B, 0.023)   texture{ T_Yellow }       }
object{  Vector( C,A, 0.023)   texture{ T_Orange }       }
triangle{ A,B,C  pigment{ color rgbt<1,1,0.5,0.5> } } 
////////////////////////////////////////////////////////////////////////
// plane x=2 : 
box { <0.00, 0.00,-1>,< 0.005, 5.00, 4.80>   
      texture { pigment{ color rgb<1.00, 1.00, 1.00>}  
                finish { phong 1 } 
              } // end of texture
      translate C
    } // end of box --------------------------------- 
 
////////////////////////////////////////////////////////////////////////
// Calculation of the base point P of a line 
// perpendicular to the line CB:


// Angle between AC and BC at point C: 
#declare Angle_C =  (VAngle(B-C,A-C));                   
// Distance of base point of line from A perpendicular on CB: 
#declare Len_CP = vlength(A-C)*cos((Angle_C));  

// Base point P on line CB:   
#declare P = C + (B-C)*Len_CP/vlength( B-C );



// Show P (red) 
sphere{ <0,0,0>, 0.075  translate P 
        texture{ T_Red }
      }
text { ttf "arialbd.ttf", "P", 0.02, 0.0 // thickness, offset
       texture{ T_Red } 
       scale<1,1.25,1>*0.3
       translate < 0.4, 0.6, -1.9>  rotate<0, 30,0> 
       translate P no_shadow
      } // end of text object -----------------------

/////////////////////////////////////////////////////
// Calculation of the angle between the triangle ABC
// and a plane parallel to the yz-plane:
 
#declare PA_Vector = A-P ; 
object{  Vector( <0,0,0>,PA_Vector, 0.025) translate P 
         texture{ T_Lila }
      }

// vertical to CL on plane X=2
#declare PB_Vector = B-P; 
object{  Vector( <0,0,0>,PB_Vector, 0.025) translate P 
         texture{ T_Cyan }
      }

// Vertical to PB in plane x=2:  
#declare Vertical_to_PB = <0,PB_Vector.z,-PB_Vector.y> ;
object{  Vector(<0,0,0>,Vertical_to_PB, 0.025) translate P 
         pigment{ rgb<1,0,0.5> }  // pigment{ rgb<0.2,1,0.5> }  
      }


// Angle between vector PA (violett) and  
// vector perpenticular to PB in plane x=2 (bright blue)   
#declare Angle_ABC_to_Plane = degrees(VAngle(Vertical_to_PB,PA_Vector)); 


// CB gegen z-Achse : 
#declare Angle_PB_to_Z = degrees(atan((B.y-C.y)/(B.z-C.z))); 

///////////////////////////////////////////////////////////////////////////
// showing the angle between triangle and plane x = 2: 

#include "shapes_lo.inc"

//#macro Segment_of_CylinderRing ( R_out, R_in, Height, Segment_Angle)
object{ Segment_of_CylinderRing (1,0.0001,0.002,-Angle_ABC_to_Plane )   
        texture {  T_Lila  } 
        rotate<0,-90,0> rotate<-90,0,0>
        rotate<-Angle_PB_to_Z,0,0>
        translate P
      } //----------------------------------------------------------
//#macro Segment_of_Torus( R_major, R_minor, Segment_Angle)
object{ Segment_of_Torus ( 1 , 0.02,-Angle_ABC_to_Plane ) 
        texture {  T_Lila  } 
        rotate<0,-90,0> rotate<-90,0,0>
        rotate<-Angle_PB_to_Z,0,0>
        translate P
      } // end of Torus_Segment(...) -----------------------              

////////////////////////////////////////////////////////////////////////////

   
// rectangle symbol macro -----------------------------------------------///
#macro Rectangle_Symbol ( R_Size, R_R, Base_Color )// size, border radius 
union{
box{<0,0,0>,<R_Size,0.01,R_Size>
 
        texture { pigment{ color rgb Base_Color*1.2 transmit 0.3  }      
                  finish { phong 1 }
                } // end of texture 
   }// end box
cylinder{<R_Size,0,0>,<R_Size,0.01,R_Size>, R_R 
           texture { pigment{ color rgb Base_Color*1.3 }      
                     finish { phong 1 }
                   } // end of texture 
        }
cylinder{<0,0,R_Size>,<R_Size,0.01,R_Size>, R_R 
           texture { pigment{ color rgb Base_Color*1.3 }      
                     finish { phong 1 }
                   } // end of texture 
        }

sphere{<R_Size,0.01,R_Size>, R_R 
           texture { pigment{ color rgb Base_Color*1.3 }      
                     finish { phong 1 }
                   } // end of texture 
        }
}//
#end // end of macro
//---------------------------------------------------------------------////
object{ Rectangle_Symbol ( 0.4, 0.01, < 0.2, 0.7, 0> )// size, border radius 
                                      // green
        rotate<0,-90,0> rotate< 0,0,0>  scale <1,1,-1>
        rotate<0,0,-(90-Angle_ABC_to_Plane)>
        rotate<-Angle_PB_to_Z,0,0>
        translate P+<0,0.001,0>
      } //

object{ Rectangle_Symbol ( 0.4, 0.01, < 0.7, 0.3, 0> )// size, border radius 
                                      // orange_yellow
        rotate<0,-90,0> rotate< 0,0,-90>  scale <1,1,-1>
        rotate<-Angle_PB_to_Z,0,0>
        translate P+<-0.001,0,0>
      } //

////////////////////////////////////////////////////////////////////////////// end of scene
