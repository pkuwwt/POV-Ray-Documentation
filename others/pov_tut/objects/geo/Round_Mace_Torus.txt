// POV-Ray 3.6/3.7 include file "Round_Mace_Torus.inc"
// author: Friedrich A, Lohmueller, Aug-2012, April-2013, Jan 2014
// homepage: http://www.f-lohmueller.de/
// email: Friedrich.Lohmueller_aT_t-online.de
//------------------------------------------------------------------------
#ifndef( Round_Mace_Torus_Inc_Temp)
#declare Round_Mace_Torus_Inc_Temp = version;
#version 3.6;

//-------------------------------------------
#ifndef(  Strings_Inc_Temp)
#include "strings.inc"
#end
#ifndef(  SHAPES3_Inc_TEMP)
#include "shapes3.inc"
#end
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//------------------------------------------------------------------------------ ////////  
#macro Round_Mace_Torus (  R_main_,    // mace top radius (r_major) >0 
                           R_border_,  // border radius (r_minor)   >0
                           H_main_,    // height y of main circle center
                           R_base_,    // basic half width in x of the mace  >= border radius and < mace top radius 

                           Shape_filled_On, // 0 = non, 1 = filled 
                           Merge_On,  // - for transparent materials
                        ) //------------------------------------------------------------- 
//--------------------------------------------------------------------------------------- 
#local D = 0.00001;
//---------------------------------------------------------------------------------------
#local R_main = R_main_ ; 
#local R_border = R_border_; 
#local H_main = H_main_; 
#local R_base = R_base_;
//---------------------------------------------------------------------------------------
#if( R_main <= 0 )
 #warning "\nRound_Mace_Torus() macro called with mace top radius < 0, mace top radius set to abs(mace top radius).\n  Results may not be as expected!\n" 
 #declare R_main = abs(R_main);
#end  
#if( R_border <0 )
 #warning "\nRound_Mace_Torus() macro called with border radius < 0, border radius set to abs(border radius).\n  Results may not be as expected!\n" 
 #declare R_border = abs(R_border);
#end  
#if( R_border = 0 )
 #warning "\nRound_Mace_Torus() macro called with border radius = 0, border radius set to 0.001.\n  Results may not be as expected!\n" 
 #declare R_border = 0.001;
#end  

#if( R_base < R_border)
 #warning "\nRound_Mace_Torus() macro called with basic half width < border radius,\n\r  basic half width set to border radius.\nResults may not be as expected!\n" 
 #declare R_base = R_border; 
#end
#if( R_base >= R_main)
 #warning "\nRound_Mace_Torus() macro called with basic half width >= mace top radius,\n\r  basic half width set to mace top radius + 0.00001.\nResults may not be as expected!\n" 
 #declare R_base = R_main - D; 
#end
#if( R_main >= sqrt( pow(H_main,2) + pow(R_base,2) ) )
 #warning "\nRound_Mace_Torus() macro called with (height y of main circle center)^2 + (basic half width)^2 >= (mace top radius)^2.\n  Results may not be as expected!\n" 
#end  


//


/////////////////////////////////////////////////////////////////////////////////////////
#local R_outer = ( pow(H_main,2) + pow(R_base,2) - pow(R_main,2))/(2*(R_main - R_base)) ; 
#local X_outer = R_base + R_outer; 
#local Angle_outer = degrees (atan2(  H_main , X_outer ));                                                              
#local Angle_inner = 90-Angle_outer ;                                                              
#local Intersection_y =  H_main  * R_outer/( R_main+ R_outer); 
#local Intersection_x =  X_outer * R_main/( R_main+ R_outer); 
/////////////////////////////////////////////////////////////////////////////////////////
// --------------------------------------------------------------------------------------
//--------------------------------------------------------Segment_of_Torus macro
#macro Segment_of_Torus ( R_major, R_minor, Segment_Angle_)
//---------------------------------------------------------------------------
 #local D =  0.00001;
 #local Segment_Angle = Segment_Angle_;

 #if (Segment_Angle < 0) 
      #local Negativ_Flag = 1; 
      #local Segment_Angle = -Segment_Angle; 
 #else 
      #local Negativ_Flag = 0;
 #end

#if (Segment_Angle > 360) #local Segment_Angle = mod(Segment_Angle,360); #end
intersection{
 torus { R_major, R_minor  sturm }

#if (Segment_Angle > 180)
 #if (Merge_On = 0 ) union{ // final union in macro
 #else               merge{ //
 #end //----------------------
#end // use union!

 box   { <-1,-1,0>,<1,1,1>
         scale < R_major+R_minor+D, R_minor+D, R_major+R_minor+D>
       }// end of box
 box   { <-1,-1,-1>,<1,1,0>
         scale < R_major+R_minor+D, R_minor+D, R_major+R_minor+D>
         rotate < 0,-Segment_Angle,0 >
       }// end of box

#if (Segment_Angle > 180)
 }
#end // end of union, if union is used!

 #if (Negativ_Flag = 0)  rotate<0,Segment_Angle,0>   #end 

 } // end of intersection
#end  // ---------------- end of macro Segment_of_Torus
// --------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////

// --------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------
#if (Merge_On = 0 ) union{ // final union in macro
#else               merge{ //
#end //----------------------

  object{ Segment_of_Torus( R_main,  // R_major, 
                            R_border,// R_minor, 
                            ( #if(H_main > 0 ) 
                              360-2*(Angle_inner #if(Merge_On) -0.1 #end)  // Segment_Angle_ 
                              #else
                              2*(Angle_inner #if(Merge_On) -0.1 #end)  // Segment_Angle_ 
                              #end )
                          ) //
          #if(H_main > 0 )
          rotate<0,90+Angle_inner-0.05,0> rotate<-90,0,0> translate<0, H_main,0>
          #else
          rotate<0,90-Angle_inner+0.05,0> rotate<-90,0,0> translate<0, H_main,0>
          #end
        } 
    
  object{ Segment_of_Torus (R_outer, // R_major, 
                            R_border,// R_minor, 
                            (Angle_outer #if(Merge_On) +0.1 #end)  // Segment_Angle_ 
                          ) //
          scale<-1,1,-1> rotate<-90+0.05,0,0> translate<X_outer, 0,0>
        } 
  object{ Segment_of_Torus (R_outer, // R_major, 
                            R_border,// R_minor, 
                            (Angle_outer #if(Merge_On) +0.1 #end) // Segment_Angle_ 
                          ) //
          scale<-1,1,-1> rotate<-90+0.05,0,0> translate<X_outer, 0,0>
          scale<-1,1,1>
        } 
 
#if(Shape_filled_On = 1)
  cylinder{ <0,0,-R_border>,<0,0,R_border>,R_main translate<0,H_main,0> } 
  difference{ 
      box{<-Intersection_x,0,-R_border>,<Intersection_x,Intersection_y,R_border>}
      cylinder{ <0,0,-R_border-D>,<0,0,R_border+D>,R_outer translate< X_outer,0,0> } 
      cylinder{ <0,0,-R_border-D>,<0,0,R_border+D>,R_outer translate<-X_outer,0,0> } 
   } // end difference 
                                   

#end // (Shape_filled_On = 1)
 
} // end of union or merge
// --------------------------------------------------------------------------------------
#end// of macro ------------------------------------------------------// end of macro




//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
// sample: 
/*
//-------------------------------------------------------------------------------------//
//-------------------------------------------------------------------------------------//
#include "Round_Mace_Torus.inc"  
//-------------------------------------------------------------------------------------//
object{ Round_Mace_Torus (  0.50, // mace top radius
                            
                            0.05, // border radius
                            0.70, // height y of main circle center
                            0.20, // basic half width in x of the mace
                            0 // Merge_On // 1 for transparent materials
                          ) // --------------------------------------------------------//

 
         texture { pigment{ color  rgb< 1, 1, 1>}
                   finish { phong 1 reflection 0.00}
                 } // end of texture 


          scale<1,1,1>  rotate<0,0,0>  translate<0,0,0>  
       }  // end of object ----------------------------------- 
//-------------------------------------------------------------------------------------//
//-------------------------------------------------------------------------------------//
*/
/*
      // optional with "  1 // Merge_On for transparent materials": 
      material{   //-----------------------------------------------------------
        texture { pigment{ rgbf <0.98, 0.98, 0.98, 0.79> }
                  finish { diffuse 0.1 reflection 0.2  
                          specular 0.8 roughness 0.0003 phong 0.5 phong_size 400}
                } // end of texture -------------------------------------------
        interior{ ior 1.5 caustics 0.5
                } // end of interior ------------------------------------------
      } // end of material ----------------------------------------------------

*/
// ------------------------------------------------------------------------------------//

#version Round_Mace_Torus_Inc_Temp;
#end
//------------------------------------- end of include file

