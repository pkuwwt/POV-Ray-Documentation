// POV-Ray 3.6/3.7 include file "Mast_1.inc"
// author: Friedrich A, Lohmueller, Jan-2006, May-2014
// homepage: http://www.f-lohmueller.de/
// email: Friedrich.Lohmueller_aT_t-online.de
//------------------------------------------------------------------------
#ifndef( Mast_1_Inc_Temp)
#declare Mast_1_Inc_Temp = version;
#version 3.6;

//----------------------------------------------------------------------------------------- /////////  
//------------------------- a mast made of round tubes ------------------------------------
//----------------------------------------------------------------------------------------- /////////  
#macro Mast_1 (   Number_of___Segments,//number of segments * segment height = total height 
                  Segment___Height,    // = 2.00,   // segment_height
                  Half_Outline___Width, // = 1.00, // half width (outline!)
                  Main___Radius,       // = 0.050, // R1, main radius
                  Diagonals___Radius  // = 0.025, // R2, diagonals radius 
                                 
                ) //----------------------------------------------------------------------- 
//----------------------------------------------------------------------------------------- 
//----------------------------------------------------------------
#local R1 = Main___Radius; // main radius - tube center to center
#local R2 = Diagonals___Radius; // diagonals radius 
#local W = Half_Outline___Width-R1;// half width (outline!)
#local H = Segment___Height;   // height
//----------------------------------------------------------------
//----------------------------------------------------------------
#macro Square_Quart (R1_, W_ ) 
union{ 
    cylinder {<-W_,0,0>,<W_,0,0>,R1_ translate<0,0,-W_>}
    sphere   {<0,0,0>,R1_   translate<W,0,-W_>} 

      } 
#end //-----------------

#macro Square (R10, R20, W0, Diag_On_0) 
union{  
   object{ Square_Quart(R10, W0) rotate<0,0*90,0>}
   object{ Square_Quart(R10, W0) rotate<0,1*90,0>}
   object{ Square_Quart(R10, W0) rotate<0,2*90,0>}
   object{ Square_Quart(R10, W0) rotate<0,3*90,0>}
   #if (Diag_On_0 = 1)
   cylinder {<-W0,0,W0>,<W0,0,-W0>,R20 translate<0,0,0> }
   #end   
  }
#end //-----------------

#macro Vertical_Element (R10, R20, W0, H0) 
union{ 
   cylinder {<0,0,0>,<0,H0,0>,R10 translate<-W0,0,-W0>}
   // diagonal:
   cylinder{<-W0,0,0>,<W0,H0,0>,R20 translate<0,0,-W0+R20> }
   cylinder{<W0,0,0>,<-W0,H0,0>,R20 translate<0,0,-W0-R20> }
   }
#end //-----------------

#macro Element_4 (R11, R21, W1, H1, Diag_On)
union{ 
   object{ Square (R11, R21, W1, Diag_On)}
   //vertical:
   object{ Vertical_Element(R11,R21,W1,H1) rotate<0,0*90,0>}
   object{ Vertical_Element(R11,R21,W1,H1) rotate<0,1*90,0>}
   object{ Vertical_Element(R11,R21,W1,H1) rotate<0,2*90,0>}
   object{ Vertical_Element(R11,R21,W1,H1) rotate<0,3*90,0>}
   translate<0,R1,0>}
#end //-------------------

//--------------------------------------------------------------------
//--------------------------------------------------------------------

// building the tower 

#local Nr = 0;     // start
#local EndNr = Number_of___Segments; // end

union{
#while (Nr< EndNr) 
  #if (Nr > 0)  
   object{ Element_4(R1, R2, W, H,  1  )  
           translate<0,Nr*H,0> 
           rotate <0, mod(Nr, 2)*90,0> } 
  #else  
   object{ Element_4(R1, R2, W, H,  0  )  
           translate<0,Nr*H,0>
           rotate <0, mod(Nr, 2)*90,0> } 
  #end
 #local Nr = Nr + 1;  // next Nr
  
#end // --------------- end of loop 
object{ Square (R1, R2, W, 1)   
        translate<0,Nr*H+R1,0>} 
} // end of union 
// --------------------------------------------------------------------------------------
#end// of macro ------------------------------------------------------// end of macro
// --------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------




//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
// sample: 
/*
//---------------------------------------------------------------------------------------
//------------------------------------------------------------------------------ textures
#declare Mast_Texture = 
 texture { //Chrome_Metal}  
           pigment{ color rgb<1,1,1> } 
           finish { phong 0.1} 
         } // end of texture
#declare Base_Texture =
 texture{ pigment{ color rgb<1,1,1>*0.7}
          finish { phong 1}
        } // end of texture
//-------------------------------------------------------------------------------------//
#include "Mast_1.inc" 
//-------------------------------------------------------------------------------------// 
object{ Mast_1(   8, // number of segments * segment height = total height 
                  2.00, // segment_height
                  1.00, // half width (outline!)
                  0.050,  // R1, tube main radius
                  0.025   // R2, tube diagonals radius 
                                 
                 ) //------------------------------------------------------------------//
        texture { Mast_Texture }
        scale <1,1,1>*1
        rotate<0,0,0> 
        translate<0.00,0.05, 0.00>}
//-------------------------------------------------------------------------------------//
//---------------------------------------------------------------------------------------
// base:   
box {<-1,0,-1>,< 1,0.05,1> scale <W+0.1,1,W+0.1> texture{Base_Texture}}
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
*/


#version Mast_1_Inc_Temp;
#end
//------------------------------------- end of include file

