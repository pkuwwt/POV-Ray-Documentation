// POV-Ray 3.6/3.7 Scene File "Cable_Harness_1.pov"
// author: Friedrich A. Lohmueller, Aug-2013
// email: Friedrich.Lohmueller_at_t-online.de
// homepage: http://www.f-lohmueller.de
//--------------------------------------------------------------------------
#version 3.7;
global_settings{ assumed_gamma 1.2 } 
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
//--------------------------------------------------------------------------------------------------------<<<<
//------------------------------------------------------------- Camera_Location, Camera_look_at, Camera_Angle
#declare Camera_Number = 1 ;
//--------------------------------------------------------------------------------------------------------<<<<
//--------------------------------------------------------------------------------------------------------<<<<
#switch ( Camera_Number )
#case (0)
  #declare Camera_Location = < 0.00, 0.50, -5.00> ;  // front view
  #declare Camera_Look_At  = < 0.00, 0.50,  0.00> ;
  #declare Camera_Angle    =   65 ;
#break
#case (1)
  #declare Camera_Location = < 4.00, 1.50, -3.00> ;  // diagonal view
  #declare Camera_Look_At  = < 1.55, 0.70,  0.00> ;
  #declare Camera_Angle    =  35 ;
#break
#case (2)
  #declare Camera_Location = < 0.00,10.00,  0+0.000> ;  // top view
  #declare Camera_Look_At  = < 0.00, 0.00,  0+0.001> ;
  #declare Camera_Angle    =  65 ;
#break
#else
  #declare Camera_Location = < 0.00, 1.00, -5.00> ;  // front view
  #declare Camera_Look_At  = < 0.00, 1.00,  0.00> ;
  #declare Camera_Angle    =  65 ;
#break
#end // of "#switch ( Camera_Number )" -----------------------------
//-------------------------------------------------------------------------------------------------------<<<<
//-------------------------------------------------------------------------------------------------------<<<<
camera{ location Camera_Location
        right    x*image_width/image_height
        angle    Camera_Angle
        look_at  Camera_Look_At
      } 
//-------------------------------------------------------------------------------------------------------<<<<
//-------------------------------------------------------------------------------------------------------<<<<

//------------------------------------------------------------------------
//------------------------------------------------------------------------
// sun -------------------------------------------------------------------
light_source{<1500,2500,-2500> color White*0.9}           // sun light
light_source{ Camera_Location  color rgb<0.9,0.9,1>*0.1}  // flash light

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
fog{ fog_type   2
     distance   100
     color      White *0.8 
     fog_offset 0.1
     fog_alt    3.5
     turbulence 1.8
   } //----------------

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
#declare Text_Rotate = <10,-45,0>;
union{
#if (AxisLenX != 0)
 object { Axis_(AxisLenX, Tex_Dark, Tex_Light)   rotate< 0,0,-90>}// x-Axis
 text   { ttf "arialbd.ttf",  "x",  0.15,  0  texture{Tex_Dark}
          rotate Text_Rotate scale 0.5 translate <AxisLenX+0.65,0.15,0> no_shadow }
#end // of #if
#if (AxisLenY != 0)
 object { Axis_(AxisLenY, Tex_Dark, Tex_Light)   rotate< 0,0,  0>}// y-Axis
 text   { ttf "arialbd.ttf",  "y",  0.15,  0  texture{Tex_Dark}
          rotate <Text_Rotate.x,0,0> scale 0.75 translate <-0.55,AxisLenY+0.20,-0.05> rotate <0,Text_Rotate.y,0> no_shadow }
#end // of #if
#if (AxisLenZ != 0)
 object { Axis_(AxisLenZ, Tex_Dark, Tex_Light)   rotate<90,0,  0>}// z-Axis
 text   { ttf "arialbd.ttf",  "z",  0.15,  0  texture{Tex_Dark}
          rotate Text_Rotate scale 0.75 translate <-0.55,0.15,AxisLenZ+0.10> no_shadow }
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
object{ AxisXYZ( 8.5, 3.0, 5, Texture_A_Dark, Texture_A_Light) scale 0.25   }
//-------------------------------------------------- end of coordinate axes


// ground -----------------------------------------------------------------
//---------------------------------<<< settings of squared plane dimensions
#declare RasterScale = 1.0;
#declare RasterHalfLine  = 0.055;
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
        texture { pigment{color White*1.1}
                  finish {ambient 0.45 diffuse 0.85}}
        texture { Raster(RasterScale,RasterHalfLine*0.2 ) rotate<0,0,0> }
        texture { Raster(RasterScale,RasterHalfLineZ*0.2) rotate<0,90,0>}
        texture { Raster(RasterScale,RasterHalfLine ) rotate<0,0,0>  scale 0.1}
        texture { Raster(RasterScale,RasterHalfLineZ) rotate<0,90,0> scale 0.1}
        rotate<0,0,0>
        translate<0,-0.1,0>

      }
//------------------------------------------------ end of squared plane XZ

//--------------------------------------------------------------------------
//---------------------------- objects in scene ----------------------------
//--------------------------------------------------------------------------


// the following needs:
// #include "transforms.inc" // for Spline_Trans()
#include "rand.inc"          // for color variation


//===============================================================
// Enumerate the capacity of each valence ( sort of like the periodic chart of elements )
//===============================================================
#declare ClosePackedArray = 
array[ 7 ] {    // max wires per layer:
     1,         // One center wire
     2*(0+1+2), // 2nd layer, max.+ 6 wires surround the core
     2*(1+2+3), // 3rd layer, max.+12 wires. Totally: 19 wires
     2*(2+3+4), // 4th layer, max.+18 wires. Totally: 37 wires
     2*(3+4+5), // 5th layer, max.+24 wires. Totally: 61 wires
     2*(4+5+6), // 7th layer, max.+30 wires. Totally: 91 wires
     2*(5+6+7), // 8th layer, max.+36 wires, Totally:127 wires
};// ---------------------------------------------------------
//===============================================================


//===============================================================
//	Place wire in bundle
//	FIXME: There must be a more elegant algorithm
//===============================================================
#macro ClosePackedArrayTransform( wireNumber, Layer, WireR )

#if( Layer > 1 )
    #local K = wireNumber - ClosePackedArray[Layer-1];
#end

#switch ( Layer )
#range( 0, 1 )  #local Offset = 4*cosd(60); #local Rotate = 30*z;
#break
#case( 2 ) #if ( mod( K, Layer ) ) #local Offset = 4*cosd(60); 
           #else                   #local Offset = 2*sind(60); #end
           #local Rotate = 0*z;
#break
#case( 3 ) #if ( mod ( K, Layer ) ) #local Offset = 3.50*cosd(60);
           #else                    #local Offset = 2.25*sind(60); #end
           #local Rotate = 30*z;
#break
#case( 4 ) #if ( mod ( K, Layer ) ) #local Offset = 3.50*cosd(60);
           #else                    #local Offset = 2.25*sind(60); #end
           #local Rotate = 0*z;
#break
#case( 5 ) #if ( mod ( K, Layer ) ) #local Offset = 3.625*cosd(60);
           #else                    #local Offset = 2.250*sind(60); #end
           #local Rotate = 18*z;
#break
#else // 
  #debug "Haven't got here, yet.\n"

#end //---------------------------------------------------------

#local Translate = WireR*Offset*Layer*
                   <sind(360*(wireNumber/ClosePackedArray[Layer])), 
                    cosd(360*(wireNumber/ClosePackedArray[Layer])), 
                    0>;
//	#debug concat( VStr( Translate ) )
translate Translate
rotate Rotate
#end // end of macro "ClosePackedArrayTransform( )" -------------
//===============================================================


//===================================================================================================
// A single cross section of the harness
//===================================================================================================
#macro HarnessSegment( Conductors, WireR, NrSamples,NrTwist, Spline,  Color, VaryColor, Begin, End )
#if (  End < 1 )	#debug concat( "HarnessSegment(..,", str(Begin,3,3), ", ", str(End,3,3), ")\n" ) #end
#if ( (Begin < 0) | (End < 0) ) #error "HarnessSegment()\tEndpoint < 0\n" #end
#if ( (Begin > 1) | (End > 1) ) #error "HarnessSegment()\tEndpoint > 1\n" #end
#if (  Begin > End )            #error "HarnessSegment()\tBegin > End\n"  #end


#declare T_Cable = array[ Conductors ]//  textures of the wire strands 
#local Nr = 0;
 #while  (Nr < Conductors)
 #declare T_Cable [Nr] = 
    texture{ 
      pigment{ color ((Color+VRand_In_Box(<0,0,0>,(<1,1,1>-Color)*VaryColor,RdmB) )) }
      finish { phong 0.5 phong_size 10 reflection 0 } 
     } // end texture
  #local Nr = Nr +1; 
  #end // of loop -------------------------------------------------


#if( Conductors = 1 )
   sphere{ 0, WireR  texture {   T_Cable[ 0] } }
#else
 // Determine how many layers to make a bundle with wireCount
  #declare Iter = Conductors;
  #declare wireCount = 0;
  #declare Layer = 0;
  #declare AccumMaxLayers = 0;
  #for ( i, 0, dimension_size( ClosePackedArray, 1 ) - 1)
    #declare AccumMaxLayers = AccumMaxLayers + ClosePackedArray[i];
    #if ( AccumMaxLayers > Conductors ) #break  #end
  #end
 //----------------------------------------------------------------

#local HarnessSilhouette =
union {

 #while( (Iter) & (wireCount < ClosePackedArray[ Layer ]) )

  sphere{ 0, WireR
          scale < 1 , 1, 1.75>
          transform{ ClosePackedArrayTransform( Iter, Layer,  WireR ) }
          texture {   T_Cable[ wireCount ] }
        }  

 #declare wireCount = wireCount + 1;
 #if( wireCount = ClosePackedArray[ Layer ] )
  #declare wireCount = 0;
  #declare Layer = Layer + 1;
 #end //#if
 
 #declare Iter = Iter - 1;
 #end //#while
}// union "HarnessSilhouette"
////////////////////////////////////////////////////////////////////////////

#local HarnessTwist = 360*NrTwist; //+NrSamples;
#local Foresight = 0.1;
#local Banking = 0.5;
 #if ( End <= Begin + 1/NrSamples )
  object{ HarnessSilhouette
          Spline_Trans( Spline, Begin, y, Foresight, Banking ) 
        }
 #else
  union {
   #for ( Nr, Begin, End, 1/NrSamples )
   object{ HarnessSilhouette
           rotate Nr*HarnessTwist*z
           Spline_Trans( Spline, Nr, y, Foresight, Banking ) 
         }
   #end //#for
  } // union 
 #end// #if(End > Begin + 1/NrSamples )

#end // #if( Conductors > 1 )
#end // end of macro "HarnessSegment( )" ========================================
//===============================================================================



//===============================================================================
// Add start and end objects ---------------------------------------------///
//------------------------------------------------------------------------///
#macro CableHarness    ( Conductors, // # of wire strands in wire bundle
                    WireR,          // >0 // radius of wire
                    NrSamples,       // # of samples in spline
                    NrTwist,         // # of 360 degress turns of the bundle 

                    Spline,          // Spline name,
                    Color,           // base color of the wire
                    VaryColor,       // Vary the colors of the wire strands
                    Start,           //  Start point on spline 
                    End,             //  End point on spline

                    BeginObject,     // Object to put on beginning of spline
                    EndObject        // Object to put on end of spline
                  ) //----------
 #local Foresight = 0.001;
 #local Banking = 0.001;

union{
 object{ HarnessSegment( Conductors, WireR, NrSamples,NrTwist, Spline, Color, VaryColor, Start, End)} 

 object { BeginObject  Spline_Trans( Spline, Start, y, Foresight, Banking ) }
 object { EndObject    Spline_Trans( Spline, End, y, Foresight, Banking ) }
} 
#end //==========================================================================
//===============================================================================
//------------------------------------------------------------------------///
//------------------------------------------------------------------------///



//------------------------------------------------------------------------///



#declare Test_Spline =
  spline {
    natural_spline
   -0.25, <-1.0, 0.0, 0>,
    0.00, <-0.0, 0.0, 0>,
    0.25, < 1.7, 0.05, 0.1>,
    0.35, < 2.0, 0.15, 0.25>,
    0.60, < 2.0, 0.65, 1.2>,
    0.80, < 0.5, 0.90, 2.0>,
    1.00, < 0.2, 1.50, 2>
    1.25, < 0.3, 3.50, 1.5>
  } //----------------- 
/* 
// test spline -----  deactivate the final harness macro while testing! 
union{
 #local Nr = 0;     // start
 #local EndNr = 1; // end
 #while (Nr< EndNr) 

 sphere{ <0,0,0>,0.05
         scale<1,1,1>
     
  texture{ pigment{ color rgb <1-Nr/2,0.75+Nr/4,0>}
           finish { phong 1 }
                }
                
         translate Test_Spline(Nr)
       } // end of sphere

 #local Nr = Nr + 0.02;  // next Nr
 #end // --------------- end of loop 

translate<0,0,0>
} // end of union  --------------------------end spline test
*/



//=================================================================================
object{ HarnessSegment( 37 ,// Conductors, max. 61// # of wire strands in wire bundle, 
                      0.020, // WireR,  // >0 // radius of wire
                      800, // NrSamples,  // # of samples in spline
                      0, // NrTwist,  // # of 360 degress turns of the bundle 
                      Test_Spline, // Spline name, 
                      <0.5, 0, 0 >,// Color, // base color of the wire
                      0.25 , // VaryColor,   // 
                      0, // Start,//  Start point on spline 
                      1, // End,  //  End point on spline
                     
                   ) //----------
       rotate<0,0,0> 
       translate<0,0,0>    no_shadow 
      } //
// ================================================================================


/*
#declare BeginObject =  // in z-direction
cylinder{ <0.00, 0.00, -0.80>,<0.00,0.00, 0.80>,1 
      texture { pigment{ color rgb<1.00, 1.00, 1.00>*0.05}  
                finish { phong 1 reflection{ 0.00 metallic 0.00} } 
              } // end of texture
      scale <1,1,1>*0.11 rotate<0,0,0> translate<0 ,0.005 ,0> 
    } // end of box --------------------------------------
#declare EndObject = object{BeginObject }  

//=================================================================================
object{ CableHarness( 12,// Conductors,// # of wire strands in wire bundle, max. 61
                      0.020 // WireR,  // >0 // radius of wire
                      800, // NrSamples,  // # of samples in spline
                      0, // NrTwist,  // # of 360 degress turns of the bundle 
                      Test_Spline, // Spline name, 
                      <0.7, 0, 0 >,// Color, // base color of the wire
                      0.25 , // VaryColor,   // 
                      0, // Start,//  Start point on spline 
                      1, // End,  //  End point on spline
                     
                      BeginObject,// Object to put on beginning of spline
                      EndObject,  // Object to put on end of spline
                   ) //----------
       rotate<0,0,0> 
       translate<0,0,0>
      } //
// ================================================================================

*/
 









