// POV-Ray 3.6/3.7 include file "Winding_Stair_0.inc" 
// author: Friedrich A, Lohmueller, Jan-2006, May-2014
// homepage: http://www.f-lohmueller.de/
// email: Friedrich.Lohmueller_aT_t-online.de
//------------------------------------------------------------------------
#ifndef( Winding_Stair_0_Inc_Temp)
#declare Winding_Stair_0_Inc_Temp = version;
#version 3.6;

//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//------------------------------------------------------------------------------ /////////  
#macro Winding_Stair_0 (   Step___H, // step height                            
                           Step___D, // deepth of a step - maximum at the outline
                           Step___Ra, // outer radius of the steps
                           N_o_Steps, // total number of steps per revolution
                           N_o_Rev,  //  Number_of_Revolutions
                           Railing___R, // radius of Railing tubes
                           Railing___Rv // radius of vertical tubes
                           Railing___H, // heigth of spiral Railing 
                           Railing___Texture, // 
                           Step___Texture,  // 
                        ) //------------------------------------------------------------- 
//--------------------------------------------------------------------------------------- 
#local D = 0.00001;
//---------------------------------------------------------------------------------------
//-------------------------------------------------------------------
#local Step_Angle = 360/N_o_Steps;
#local Step___Ri = 0; 
//-----------------------------------------------------

#local Step = //--------------------- one single step
union{
 intersection{

  box { <Step___Ri, 0, -Step___D>,<Step___Ra, Step___H+D, Step___D> 
        texture{Step___Texture}
  }
 
  box { <0, -D, 0>, <Step___Ra*1.4, Step___H+2*D, Step___Ra*1.4> 
        translate< 0, 0,-0.01> 
        rotate<0, Step_Angle/2,0> 
        texture{Step___Texture}
  }

  box { <0, -D, -Step___Ra*1.4>, <Step___Ra*1.4, Step___H+2*D, 0> 
        translate< 0, 0, 0.01> 
        rotate<0,-Step_Angle/2,0> 
        texture{Step___Texture}
  }
 }// end of intersection ------------------- end of one step

  cylinder { <0,Step___H,0>,<0,Step___H+Railing___H,0>,Railing___Rv 
        translate<Step___Ra - Railing___R,0,0>
        texture {Railing___Texture}

  }

}// end of union -------------------------------------------- 
#local Single_Tube = 
  cylinder { <0,Step___H,0>,<0,Step___H+Railing___H,0>,Railing___Rv 
        texture {Railing___Texture}
        }
#local Tube_Element  = // one element of the spiral Railing
 sphere { <0,0,0>, Railing___Rv 
          texture {Railing___Texture}
	}      

// ---------------------- drawing the stair -----------------
union{
//----------------------------------  while loop steps ------
 
 #local Nr = 0;          // start winding steps
 #while (Nr < N_o_Rev * N_o_Steps)  
   object{Step          
          translate<0,Nr*Step___H,0>
          rotate <0,-Nr*360/N_o_Steps,0>}
 #local Nr = Nr+1;  
 #end //----------------------------- end of while loop steps
 // end steps


 
 #local Nr = -10;       // start spiral Railing
 #local N_per_Rev = 1000;    
 #while (Nr< N_per_Rev*N_o_Rev-(N_per_Rev/N_o_Steps) ) 
          object{ Tube_Element
                  translate< Step___Ra - Railing___R,  Step___H+Railing___H,0>

          translate< 0, Nr * (Step___H*N_o_Steps)/N_per_Rev, 0>
          rotate< 0, -Nr * 360/N_per_Rev, 0>} 

 #local Nr = Nr + 1;    // next Nr
 #end // ------------------  end of while loop spiral Railing

cylinder{ <0,0,0>,<0,Step___H*N_o_Rev * N_o_Steps,0>, 0.15  texture{Step___Texture}}
// --------------------------------------------------------------------------------------
}// end of union

// --------------------------------------------------------------------------------------
#end// of macro ------------------------------------------------------// end of macro




//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
// sample: 
/*
//----------------------------------------------------------------------------- textures
#declare Railing_Texture = 
   texture { Chrome_Metal  
             //pigment{ color rgb<1,1,1> } 
             finish { phong 0.1} 
           } // end of texture
#declare Step_Texture = 
   texture { pigment{ color rgb<1,1,1>*0.9 } 
             finish { phong 0.1} 
           } // end of texture
//---------------------------------------------------------------------------------------
#include "Winding_Stair_0.inc" 
//-------------------------------------------------------------------------------------// 
object{ Winding_Stair_0( 0.10, //Step___H, // step height                            
                           0.50, //Step___D, // deepth of a step - maximum at the outline
                           1.60, //Step___Ra, // outer radius of the steps
                           21, // N_o_Steps, // total number of steps per revolution
                           2, // N_o_Rev,  //  Number_of_Revolutions
                           0.03, // Railing___R, // radius of Railing tubes
                           0.02, // Railing___Rv // radius of vertical tubes
                           0.75, // Railing___H, // heigth of spiral Railing 
                           Railing_Texture, // 
                           Step_Texture     // 
                        ) //-----------------------------------------------------------//
        scale <1,1,1>*1
        rotate<0,0,0> 
        translate<0.00,0.00, 0.00>}
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
*/


#version Winding_Stair_0_Inc_Temp;
#end
//------------------------------------- end of include file

