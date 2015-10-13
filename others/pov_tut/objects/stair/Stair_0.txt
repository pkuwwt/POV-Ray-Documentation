// POV-Ray 3.6/3.7 include file "Stair_0.inc" 
// author: Friedrich A, Lohmueller, Jan-2006, May-2014
// homepage: http://www.f-lohmueller.de/
// email: Friedrich.Lohmueller_aT_t-online.de
//------------------------------------------------------------------------
#ifndef( Stair_0_Inc_Temp)
#declare Stair_0_Inc_Temp = version;
#version 3.6;

//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//------------------------------------------------------------------------------ /////////  
#macro Stair_0 (     Stair___H, // stair total height
                     Stair___X, // length of stair in x direction    
                     Step___H_, // ca. single step height - adapted to fit the height                           
                     Step___Z, // width  of a step in z direction
                     Banisters_On, // 1=right; 2 = left; 3= both ; 0= off;
                     Railing___R, // radius of railing linear tubes
                     Railing___Rv // radius of vertical tubes
                     Railing___H, // railing heigth 
                     Railing___Texture, // 
                     Step___Texture   // 
                   ) //------------------------------------------------------------------ 
//--------------------------------------------------------------------------------------- 
#local D = 0.00001;
//---------------------------------------------------------------------------------------
                  
#local N_o_Steps = int(Stair___H/Step___H_);// total number of steps
#local Step___H = Stair___H/N_o_Steps; 

#local Step___X = Stair___X /N_o_Steps;  // deepth of one step in x direction    

#local Railing___Length = sqrt( pow((N_o_Steps-1)*Step___X,2)+ pow(Stair___H-Step___H,2));
#local Railing___Angle  = degrees(atan2( Stair___H, ((N_o_Steps )*Step___X)  ));
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------

#local Step = //--------------------- one single step
  box { <0, 0,  0>,<Step___X, Step___H, Step___Z> 
        texture{Step___Texture}
  }
 
#local Single_Tube = // railing verticals
  cylinder { <0,Step___H,0>,<0,Step___H+Railing___H,0>,Railing___Rv 
        texture {Railing___Texture}
        }
#local Railing_Handle  = // 
union{ 
 cylinder { <0,0,0>,<Railing___Length,0,0>, Railing___R }
 sphere{<0,0,0>, Railing___R } 
 sphere{<0,0,0>, Railing___R translate<Railing___Length,0,0>} 
 texture {Railing___Texture}
} // end of union     

// ---------------------- constructing the stair -----------------
union{
//----------------------------------  while loop steps ------
 
 #local Nr = 0;          // start winding steps
 #while (Nr <  N_o_Steps)  

   object{ Step translate<Nr*Step___X,Nr*Step___H,0> }         

   #if ( Banisters_On=1 | Banisters_On = 3 )
   object{ Single_Tube translate<Step___X/2,0, 2*Railing___R>
                translate<Nr*Step___X,Nr*Step___H,0> } //railing verticals right
   #end

   #if ( Banisters_On=2 | Banisters_On = 3 )
   object{ Single_Tube translate<Step___X/2,0, Step___Z-2*Railing___R>
                translate<Nr*Step___X,Nr*Step___H,0> } //railing verticals left 
   #end    

 #local Nr = Nr+1;  
 #end //----------------------------- end of while loop steps
 // end steps

#if ( Banisters_On=1 | Banisters_On = 3 )
object{ Railing_Handle rotate<0,0,Railing___Angle> translate<Step___X/2,Step___H+Railing___H, 2*Railing___R>}
#end
#if ( Banisters_On=2 | Banisters_On = 3 )
object{ Railing_Handle rotate<0,0,Railing___Angle> translate<Step___X/2,Step___H+Railing___H, Step___Z-2*Railing___R>}
#end

// base 
box{ <0,0,0>,<(N_o_Steps-1)*Step___X,Step___H,Step___Z> 
     matrix<1, (Step___H/Step___X), 0, // matrix-shear_x_to_y
            0,  1,  0,
            0,  0,  1,
            0,  0,  0>    

     translate<Step___X,0,0>
     texture{Step___Texture}
   }
     


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
#include "Stair_0.inc" 
//-------------------------------------------------------------------------------------// 
object{ Stair_0(  1.50, // Stair___H, // stair total height
                  2.50, // Stair___X, // length of stair in x direction    
                  0.175, // Step___H_, // ca. single step height - adapted to fit the height                           
                  1.20, // Step___Z, // width  of a step in z direction
                  1, // Banisters_On 1=right; 2 = left; 3= both ; 0= off;
                  0.03, // Railing___R, // radius of railing linear tubes
                  0.02, // Railing___Rv // radius of vertical tubes
                  0.75, // Railing___H, // railing heigth 
                  Railing_Texture, // 
                  Step_Texture   // 
                ) //-------------------------------------------------------------------//
        scale <1,1,1>*1
        rotate<0,0,0> 
        translate<0.00,0.00, 0.00>}
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
*/


#version Stair_0_Inc_Temp;
#end
//------------------------------------- end of include file

