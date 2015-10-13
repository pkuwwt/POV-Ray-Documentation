// POV-Ray 3.6 include file "Mast_2.inc" 
// author: Friedrich A, Lohmueller, Jan-2006, May-2014
// homepage: http://www.f-lohmueller.de/
// email: Friedrich.Lohmueller_aT_t-online.de
//------------------------------------------------------------------------
#ifndef( Mast_2_Inc_Temp)
#declare Mast_2_Inc_Temp = version;
#version 3.6;

//----------------------------------------------------------------------------------------- /////////  
//------------------ triangular mast made of round tubes ----------------------------------
//----------------------------------------------------------------------------------------- /////////  
#macro Mast_2 (   Number_of___Segments,//number of segments * segment height = total height 
                  Segment___Height,    // = 2.00,   // segment_height
                  Half_Outline___Width, // = 1.00, // half width (outline!)
                  Main___Radius,       // = 0.050, // R1, main radius
                  Diagonals___Radius,  // = 0.025, // R2, diagonals radius 
                  End___Type // 0 = both complete triangular,
                             // 1 = upper end incomplete (sharp)            
                             // 2 = both  end incomplete (sharp)            
                ) //----------------------------------------------------------------------- 
//----------------------------------------------------------------------------------------- 
//----------------------------------------------------------------
#local R1 = Main___Radius; // main radius - tube center to center
#local R2 = Diagonals___Radius; // diagonals radius 
#local W = Half_Outline___Width-R1;// half width (outline!)
#local H = Segment___Height;   // height
#local WH = W *sqrt(3);  
//----------------------------------------------------------------
//----------------------------------------------------------------

#macro Triangle_Segment (R10, R20, W0, H0) 
#local WH0 = W0 *sqrt(3);  
union{  

    sphere   {<0,0,0>,R10   translate< W0,0,0>} 
    sphere   {<0,0,0>,R10   translate<-W0,0,0>} 
    sphere   {<0,0,0>,R10   translate< 0,0,-WH0>} 

    cylinder {<-W0,0,0>,<W0,0,0>,R10  translate<0,0,0> rotate<0,0*60,0>}
    cylinder {<0,0,0>,<2*W0,0,0>,R10 rotate<0,120,0> translate<W0,0,0> }
    cylinder {<0,0,0>,<2*W0,0,0>,R10 rotate<0,120,0> translate<W0,0,0> scale<-1,1,1> }

   //vertical Segments 
   cylinder {<0,0,0>,<0,H0,0>,R10 translate< W0,0,0>}
   cylinder {<0,0,0>,<0,H0,0>,R10 translate<-W0,0,0>}
   cylinder {<0,0,0>,<0,H,0>,R1 translate< 0,0,-WH>}

   // diagonal:
   cylinder{<-W0, 0,0>,< W0,H0,   0>,R20 translate<0,0,0> }
   cylinder{<-W0,H0,0>,<  0, 0,-WH0>,R20 translate<0,0,0> }
   cylinder{< W0, 0,0>,<  0,H0,-WH0>,R20 translate<0,0,0> }

  }
#end //-----------------

#macro End_Triangle (R1_, R2_, W_, H_) 
#local WH_ = W_ *sqrt(3);  
union{ 
    sphere   {<0,0,0>,R1_   translate< W_,0,0>} 
    sphere   {<0,0,0>,R1_   translate<-W_,0,0>} 
    sphere   {<0,0,0>,R1_   translate< 0,0,-WH_>} 

    cylinder {<-W_,0,0>,< W_,0,0>,R1_ }
    cylinder {<0,0,0>,<2*W_,0,0>,R1_ rotate<0,120,0> translate<W_,0,0> }
    cylinder {<0,0,0>,<2*W_,0,0>,R1_ rotate<0,120,0> translate<W_,0,0> scale<-1,1,1> }
   }
#end //-----------------


#macro End_Up_Element (R10, R20, W0, H0) 
#local WH0 = W0 *sqrt(3);  
union{ 

    object{ End_Triangle (R10, R20, W0, H0) }
 
    // sharp triangular end:
    sphere   {<0,0,0>,R10   translate< W0,H0,0>} 
    sphere   {<0,0,0>,R10   translate<-W0,H0,0>} 
    cylinder {<-W0,0,0>,< W0,0,0>,R10  translate<0,H0,0>}
        // vertical
    cylinder {<0,0,0>,<0,H0,0>,R10 translate< W0,0,0>}
    cylinder {<0,0,0>,<0,H0,0>,R10 translate<-W0,0,0>}
        // end diags
    cylinder {<0,0,-WH0>,< W0,H0,0>,R10 }
    cylinder {<0,0,-WH0>,<-W0,H0,0>,R10 }

    cylinder{<-W0, 0,0>,< W0,H0,   0>,R20}
   }
#end //-----------------


//--------------------------------------------------------------------
//--------------------------------------------------------------------

// building the tower 

#local Nr = 0;     // start
#local EndNr = Number_of___Segments; // end

union{
#while (Nr< EndNr) 
  
  #if ( (Nr = 0)  & (End___Type = 2) )
   // lower end sharp
    object{ End_Up_Element (R1, R2, W, H)
            scale <1,-1,1> translate <0,H,0>
          } 
  
  #else // if not Type 2 or if not at Start (Nr=0):


    #if ((Nr = EndNr-1) & (End___Type > 0) )  
     // upper end sharp
     object{ End_Up_Element (R1, R2, W, H)
            scale <mod(Nr, 2)*(-1),1,1>
            translate<0,Nr*H,0>} 

    #else  
    // not end or not Type > 0

      // no normal segment at start if type = 2      
     object{ Triangle_Segment (R1, R2, W, H) translate<0,Nr*H,0>
             scale <mod(Nr, 2)*(-1),1,1>
           } // normal segment
     #end
   #end
 #local Nr = Nr + 1;  // next Nr 
  
#end // --------------- end of loop 

#if ( End___Type = 0 ) // end Triangle!   
object{ End_Triangle (R1, R2, W, H) translate<0,Nr*H,0>}
#end 

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
#include "Mast_2.inc" 
//-------------------------------------------------------------------------------------// 
object{ Mast_2(   8, // number of segments * segment height = total height 
                  2.00, // segment_height
                  1.00, // half width (outline!)
                  0.050,  // R1, tube main radius
                  0.025,  // R2, tube diagonals radius 
                  0       // End___Type  0 = both complete triangular,
                          //             1 = upper end incomplete (sharp)            
                          //             2 = both  end incomplete (sharp)            
                                 
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


#version Mast_2_Inc_Temp;
#end
//------------------------------------- end of include file

