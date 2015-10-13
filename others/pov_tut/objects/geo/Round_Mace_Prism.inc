// POV-Ray 3.6/3.7 include file "Round_Mace_Prism.inc"
// author: Friedrich A, Lohmueller, Aug-2012, Nov-2012, Jan 2014
// homepage: http://www.f-lohmueller.de/
// email: Friedrich.Lohmueller_aT_t-online.de
//------------------------------------------------------------------------
#ifndef( Round_Mace_Prism_Inc_Temp)
#declare Round_Mace_Prism_Inc_Temp = version;
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
#macro Round_Mace_Prism (  R_main_,    // mace top radius  >0 ! 
                           R_border_,  // border radius    >0 ! // 0 = no rounded borders!! 
                           H_main_,    // height y of main circle center
                           R_base_,    // basic half width in x of the mace  >= border radius and < mace top radius 
                           
                           Depth_z_,   // -z depth  
                           Linear_Base_End_, // 0 = non

                           Rounded_Base_End_, // 0 = non, 1 = rounded cylinder
                           Merge_On,  // - for transparent materials
                        ) //------------------------------------------------------------- 
//--------------------------------------------------------------------------------------- 
#local D = 0.00001;
//---------------------------------------------------------------------------------------
#local R_main = R_main_ ; 
#local R_border = R_border_; 
#local H_main = H_main_; 
#local R_base = R_base_;
#local Depth_z = Depth_z_; 
#local Linear_Base_End = Linear_Base_End_; 
#local Rounded_Base_End =  Rounded_Base_End_;
//---------------------------------------------------------------------------------------
#declare Depth_z_Flag = 0;
#if( Depth_z < 0 )
 #declare Depth_z = abs(Depth_z); #declare Depth_z_Flag = 1; 
#end
//---------------------------------------------------------------------------------------
#if( R_main <  0 )
 #warning "\nRound_Mace_Torus() macro called with mace top radius < 0, mace top radius set to abs(mace top radius).\n  Results may not be as expected!\n" 
 #declare R_main = abs(R_main);
#end  
#if( R_border < 0 )
 #warning "\nRound_Mace_Torus() macro called with border radius < 0, border radius set to abs(border radius).\n  Results may not be as expected!\n" 
 #declare R_border = abs(R_border);
#end  
#if( R_main =  0 )
 #warning "\nRound_Mace_Torus() macro called with mace top radius = 0, mace top radius set to 2*R_border.\nResults may not be as expected!\n" 
 #declare R_main = 2*R_border ;
#end  

#if( abs(Depth_z) < 2*R_border)
 #warning "\nRound_Mace_Torus() macro called with abs(depth in z) < 2*border radius,\n\r  depth in z is set to 2*border radius+0.00001.\nResults may not be as expected!\n" 
 #declare Depth_z = 2*R_border+D; 
#end

#if( R_base <= R_border)
 #warning "\nRound_Mace_Torus() macro called with basic half width <= border radius,\n\r  basic half width is set to border radius + 0.00001.\nResults may not be as expected!\n" 
 #declare R_base = R_border+D; 
#end
#if( R_base >= R_main)
 #warning "\nRound_Mace_Torus() macro called with basic half width >= mace top radius,\n\r basic half width is set to top radius - 0.01.\nResults may not be as expected!\n" 
 #declare R_base = R_main - 0.01; 
#end
#if( R_main >= sqrt( pow(H_main,2) + pow(R_base,2) ) )
 #warning "\nRound_Mace_Torus() macro called with (height y of main circle center)^2 + (basic half width)^2 >= (mace top radius)^2.\n  Results may not be as expected!\n" 
#end  

#if( Linear_Base_End < 0 ) 
 #warning "\nRound_Mace_Torus() macro called with (Linear base end)< 0. (Linear base end) set to abs(Linear base end).\n  Results may not be as expected!\n" 
 #declare Linear_Base_End = abs(Linear_Base_End); 
#end
//
//
/////////////////////////////////////////////////////////////////////////////////////////
#local R_outer = ( pow(H_main,2) + pow(R_base,2) - pow(R_main,2))/(2*(R_main - R_base)) ; 
#local X_outer = R_base + R_outer; 
#local Angle_outer = degrees (atan2(  H_main , X_outer ));                                                              
#local Angle_inner = 90-Angle_outer ;                                                              //       yS = yM2 · r1/ (r1+r2).
#local Intersection_y =  H_main  * R_outer/( R_main+ R_outer); 
#local Intersection_x =  X_outer * R_main/( R_main+ R_outer); 
//inner parts
#local Intersection_yi =  H_main  * (R_outer+R_border)/( R_main+ R_outer); 
#local Intersection_xi =  X_outer * (R_main-R_border)/( R_main+ R_outer); 
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
 torus { R_major, R_minor sturm }

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
#end  // end of macro Torus_Segment( ... ) ---------------- end of macro Segment_of_Torus
// --------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////
#if( R_border > 0 )
#local Mace_Border = 

#if (Merge_On = 0 ) union{ // final union in macro
#else               merge{ //
#end //----------------------
   
  object{ Segment_of_Torus( R_main-R_border, // R_major, 
                            R_border,//  R_minor, 
                            ( #if(H_main > 0 ) 
                              360-2*(Angle_inner #if(Merge_On) -0.1 #end)  // Segment_Angle_ 
                              #else
                              2*(Angle_inner #if(Merge_On) -0.1 #end)  // Segment_Angle_ 
                              #end )
                          ) //
          #if(H_main > 0 )
          rotate<0,90+Angle_inner-0.051,0> rotate<-90,0,0> translate<0, H_main,0>
          #else
          rotate<0,90-Angle_inner+0.051,0> rotate<-90,0,0> translate<0, H_main,0>
          #end
        } 
   
  object{ Segment_of_Torus (R_outer+R_border, // R_major, 
                            R_border,//  R_minor, 
                            (Angle_outer #if(Merge_On) +0.12 #end)  // Segment_Angle_ 
                          ) //
          scale<-1,1,-1> rotate<-90,0,0 > translate<X_outer, -1.0*D,0>
        } 
  object{ Segment_of_Torus (R_outer+R_border, // R_major, 
                            R_border,//  R_minor, 
                            (Angle_outer #if(Merge_On) +0.08 #end) // Segment_Angle_ 
                          ) //
          scale<-1,1,-1> rotate<-90,0,0 > translate<X_outer, -1.5*D,0>
          scale<-1,1,1>
        } 
} // end of union
#end // of "#if( R_border > 0 )"

// --------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------
#if (Merge_On = 0 ) union{ // final union in macro
#else               merge{ //
#end //----------------------


#if( R_border > 0 )
 object{ Mace_Border translate<0,0.3*D,-R_border> } 
 object{ Mace_Border translate<0,0.8*D,-Depth_z+R_border> } 
#end // #if( R_border > 0 )
 
 // outer prism parts:
 #if (Merge_On = 0 ) union{ // union 1 in macro
 #else               merge{ //
 #end //----------------------
 // 1

  cylinder{ <0,0,0>, <0,0,-Depth_z+2*R_border>, R_main translate <0,H_main,0> }
  difference{ 
    box{ <-Intersection_x,-1.5*D,0>,<Intersection_x,Intersection_y+D ,-Depth_z+2*R_border> }  
    cylinder{ <0,0,D>, <0,0,-Depth_z+2*R_border-D>, R_outer translate < X_outer,0,0> }
    cylinder{ <0,0,D>, <0,0,-Depth_z+2*R_border-D>, R_outer translate <-X_outer,0,0> }
    } // end difference 
    translate<0,0,-R_border >
 }// end of union 1

#if( R_border > 0 )
 // inner prism parts:
 #if (Merge_On = 0 ) union{ // union 2 in macro
 #else               merge{ //
 #end //----------------------
  // 2

  cylinder{ <0,0,0>, <0,0,-Depth_z>, R_main-R_border translate <0,H_main,0> }
  difference{ 
    box{ <-Intersection_xi,-2*D,0>,<Intersection_xi,Intersection_yi+1.5*D ,-Depth_z> }  
    cylinder{ <0,0,D>, <0,0,-Depth_z-D>, R_outer+R_border translate < X_outer,0,0> }
    cylinder{ <0,0,D>, <0,0,-Depth_z-D>, R_outer+R_border translate <-X_outer,0,0> }
    } // end difference 
 }// end of union 2 
#end // #if( R_border > 0 )

#if(Linear_Base_End > 0)
  
  box{<-R_base+R_border,0,0>,<R_base-R_border,-Linear_Base_End,-Depth_z>  } //inner
  box{<-R_base,D,-R_border>,<R_base,-Linear_Base_End-D,-Depth_z+R_border>  } //outer
  cylinder{ <0,0,0>, <0,-Linear_Base_End,0>, R_border translate <-R_base+R_border,0,-R_border> } //inner
  cylinder{ <0,0,0>, <0,-Linear_Base_End,0>, R_border translate <-R_base+R_border,0,-Depth_z+R_border> } //inner
  cylinder{ <0,0,0>, <0,-Linear_Base_End,0>, R_border translate < R_base-R_border,0,-R_border> } //inner
  cylinder{ <0,0,0>, <0,-Linear_Base_End,0>, R_border translate < R_base-R_border,0,-Depth_z+R_border> } //inner
 
#end //-------  #if(Linear_Base_End > 0)

#if(Rounded_Base_End = 1 )
 #if (Merge_On = 0 ) union{ // union  
 #else               merge{ //
 #end //----------------------
 cylinder{ <0,0,0>, <0,0,-Depth_z>, R_base-R_border translate <0,0,0> } //inner
 cylinder{ <0,0,-R_border>, <0,0,-Depth_z+R_border>, R_base translate <0,0,0> } //outer
 torus{ R_base-R_border,  R_border rotate<90,0,0> translate<0,0,-R_border> sturm }
 torus{ R_base-R_border,  R_border rotate<90,0,0> translate<0,0,-Depth_z+R_border> sturm }
 translate<0,-Linear_Base_End,0> 
 }// end of union / merge 
#end // #if(Rounded_Base_End = 1)



#if(Depth_z_Flag = 0) scale<1,1,-1> #end
} // end of final union
// --------------------------------------------------------------------------------------
#end// of macro ------------------------------------------------------// end of macro




//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
// sample: 
/*
//----------------------------------------------------------------------------------//
//-------------------------------------------------------------------------------------//
#include "shapes_lo2/Round_Mace_Prism.inc"  
//-------------------------------------------------------------------------------------//
object{ Round_Mace_Prism (  0.40, // R_main,    // mace radius, >0 and > basic half width
                            0.05, // R_Border,  // border radius >= 0, 0 = nor rounded borders
                            0.70, // H_main,    // height y ( + = up ; - = down ) of main circle center
                            0.15, // R_base,    // basic half width in x of the mace > 2*border radius !
 
                           -0.45, // Depth_Z,   // z depth (+/-) > 2*border radius !  
                            0.00, // Linear_Base_End, // 0 = non 
                            0,    // Rounded_Base_End, // 0/1: 0 = non, 1 = lower end with rounded cylinder 

                            1 // Merge_On - for transparent materials

                                 
                          ) // --------------- in x+direction ----------------------//
    
        
        texture { pigment{ color  rgb< 1, 1, 1>}
                  finish { phong 1 reflection 0.00}
                } // end of texture 
          
      /* 
        material{   //-----------------------------------------------------------
          texture { pigment{ rgbf <0.98, 0.98, 0.98, 0.99> }
                    finish { diffuse 0.1 reflection 0.25  
                             specular 0.8 roughness 0.0003 phong 0.5 phong_size 400}
                  } // end of texture -------------------------------------------
          interior{ ior 1.5  caustics 0.5
                  } // end of interior ------------------------------------------
         } // end of material ----------------------------------------------------
      */  
        scale<1,1,1>   
        rotate< 0,0,0>
        translate<0,0,0>  
      } // end of object --------------------------------------------------------------// 
//-------------------------------------------------------------------------------------//
//-------------------------------------------------------------------------------------//

   */


#version Round_Mace_Prism_Inc_Temp;
#end
//------------------------------------- end of include file

