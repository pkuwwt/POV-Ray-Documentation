// POV-Ray 3.6/3.7 include file "Cheese_1.inc"
// author: Friedrich A, Lohmueller, Dec-2009, May-2014
// homepage: http://www.f-lohmueller.de/
// email: Friedrich.Lohmueller_aT_t-online.de
//------------------------------------------------------------------------
#ifndef( Cheese_1_Inc_Temp)
#declare Cheese_1_Inc_Temp = version;
#version 3.6;

//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------

#ifndef(  Shapes_Inc_Temp)
#include "shapes.inc"                                             
#end

#ifndef(  Shapes_Lo_Inc_Temp)
#include "shapes_lo.inc"                                             
#end

//------------------------------------------------------------------------------ /////////  
//--------------------------------------------------------------------------
//--------------------------------------------------------------------------
#macro Cheese_1 ( Cut_Angle_, 
                  Cheese_R_, 
                  Cheese_H_,     
                  Cheese_Border_R_, 
                ) //---------------------------------------------------- 
//----------------------------------------------------- default textures                                       
#ifndef( Cheese_Texture ) 
#declare Cheese_Texture =  
         texture { pigment{ color rgb< 1.0, 0.85, 0.35> } //  light orange
                   normal { bumps 0.15 scale 0.025 }
                   finish { phong 1 reflection 0.05}
                 } // end of texture 
#end 
#ifndef( Cheese_Skin_Texture ) 
         texture { pigment{ color rgb< 1.0, 0.55, 0.3> } //  red orange
                   normal { bumps 0.25 scale 0.025 }
                   finish { phong 1 reflection 0.00}
                 } // end of texture 
#end 
//----------------------------------------------------------------------                                          
#ifndef( Rnd_ ) // Random_Seed_ 
#declare Rnd_ = seed( 18426 );
#end 
//----------------------------------------------------------------------                                          
#macro Cutter( Cut_Angle, R, H ) //----------------- helper macro
intersection{ 
   box{<0,0,-R>, <R,H,0> }  
   box{<0,0, 0>, <R,H,R> rotate<0,Cut_Angle,0> }  
 } // ----------------------------------------------
#end // ------------------------------- end of macro
//-----------------------------------------------------------------------------------------------                                          
//-----------------------------------------------------------------------------------------------                                          
//-----------------------------------------------------------------------------------------------                                          
#local D = 0.0001; // just a little bit 
#local BD = 0.003; // cheese border D 
//----------------------------------------
#local Max_D =  Cheese_H_/4; // distance
#local Max_Num_X = int(Cheese_R_/Max_D)-0.5;
#local Max_Num_Y = max(1,int(Cheese_H_/Max_D)-0.5);
//-----------------------------------------------------------------------------------
//----------------------------------------
#local Cheese_Kernel = 
  object{ Round_Cylinder(<0,BD,0>, <0,Cheese_H_-2*BD,0>, Cheese_R_-BD , Cheese_Border_R_-BD, 0)  
          translate<0, BD,0> //inverse
        } // -----------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------
#local Cheese_Skin = 
 difference{ // 1 
  object{ Round_Cylinder(<0, 0,0>, <0,Cheese_H_,0>, Cheese_R_ ,       Cheese_Border_R_,   0) }
  object{ Cheese_Kernel }  
  }//-------------------------------------
//----------------------------------------------------------------------------------------------


 
//----------------------------------------
union{ 
 object{  Segment_of_Object (Cheese_Skin, Cut_Angle_) texture{ Cheese_Skin_Texture } }
 
 
 difference{ // d 
  object{  Segment_of_Object (Cheese_Kernel, Cut_Angle_) }

  #local NrX = 1; #local EndNrX = Max_Num_X; // outer loop   x
  #while (NrX< EndNrX) 
    #local NrY = 0.35; #local EndNrY =  Max_Num_Y; // inner loop  y
    #while (NrY< EndNrY) 
     sphere{ <0,0,0>,Max_D*0.37  
       scale< 1+0.65*(rand(Rnd_)),
              1-0.25*(rand(Rnd_)),
              1+0.5*(0.5-rand(Rnd_))>
       translate<(NrX-0.25)+0.85*(0.5-rand(Rnd_)), (NrY+0.45)*0.9+0.35*(0.5-rand(Rnd_)),0.25*(0.5-rand(Rnd_))>*Max_D
       rotate<0, Cut_Angle_,0>
     } 
     sphere{ <0,0,0>,Max_D*0.37 
       scale< 1+0.5*(rand(Rnd_)),
              1-0.25*(rand(Rnd_)),
              1+0.5*(0.5-rand(Rnd_))>
       translate<(NrX-0.25)+0.85*(0.5-rand(Rnd_)), (NrY+0.45)*0.9+0.35*(0.5-rand(Rnd_)),0.25*(0.5-rand(Rnd_))>*Max_D
     } 
    #local NrY = NrY + 1; #end // --------------- end of loop z   // end inner loop
  #local NrX = NrX + 1; #end // --------------- end of loop x  // end of outer loop
  
  texture{ Cheese_Texture } 
 }// end d
   
} // end of union 
#end // --------------------------------------------------------------------------- end of macro 
//----------------------------------------------------------------------------------------------





//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
// sample: 
/*
//----------------------------------------------------------------------------- textures

//------------------------------------------------------------------------------
//----------------------------------------------------------- optional textures
#declare Cheese_Texture =  
         texture { pigment{ color rgb< 1.0, 0.85, 0.35> } //  light orange
                   normal { bumps 0.15 scale 0.025 }
                   finish { phong 1 reflection 0.05}
                 } // end of texture 
#declare Cheese_Skin_Texture =  
         texture { pigment{ color rgb< 1.0, 0.55, 0.3> } //  red orange
                   normal { bumps 0.25 scale 0.025 }
                   finish { phong 1 reflection 0.00}
                 } // end of texture 
//--------------------------------------- optional random seed number 0~32000
#declare Rnd_ = seed( 18426);  // 18426
//------------------------------------------------------------------------------
#include "pov_objects3/Cheese_1.inc"
//------------------------------------------------------------------------------
object{ Cheese_1( 30,   // Cut_Angle_, 
                  0.30, // Cheese_R_, 
                  0.15, // Cheese_H_,     
                  0.05, // Cheese_Border_R_, 
                 )// --------------------------
// rotate<0,180,0>

 translate<0.0,0, 0.0>  // rotate<0,-30,0>
} // ---------------------------------------------------------
//------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
*/


#version Cheese_1_Inc_Temp;
#end
//------------------------------------- end of include file

