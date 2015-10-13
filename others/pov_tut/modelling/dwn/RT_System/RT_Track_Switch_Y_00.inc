// POV-Ray 3.6 / 3.7 include file "RT_Track_Switch_Y_00.inc"                                                                                                                                                // PoVRay 3.6 include File "wheel_000.inc"
// author: Friedrich A, Lohmueller, Nov-2010
// homepage: http://www.f-lohmueller.de/
// email: Friedrich.Lohmueller_aT_t-online.de
//------------------------------------------------------------------------
#ifndef( RT_Track_Switch_Y_00_Inc_Temp)
#declare RT_Track_Switch_Y_00_Inc_Temp = version;
#version 3.6;

//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
#ifndef(  Colors_Inc_Temp)
#include "colors.inc"                                             
#end
#ifndef(  Textures_Inc_Temp)
#include "textures.inc"                                             
#end
#ifndef(  Shapes3_Inc_Temp)
#include "shapes3.inc"                                             
#end


//------------------------------------------------------------------------------ /////////  
//------------------------------------------------------------------------------ /////////  
//------------------------------------------------------------------------------ /////////  
#macro RT_Track_Switch_Y_00( Switch_Direction_y, // 0 right, 1 = left
                             Switch_Radius_y, // Switch_Length_, 
                             Switch_Angle_y, 
                             Ties_Per_Meter_,  // ~1.5
                         ) //--------------------------------------------------------- 
//--------------------------------------------------------------------------------
#if (Switch_Direction_y<0) #declare Switch_Direction_y = 0; #end
#if (Switch_Direction_y>2) #declare Switch_Direction_y = 1; #end

//----------------------------------------------------------------- default textures 
//--------------------------------------------------------------------------------

#ifndef( RailToptex ) 
#declare RailToptex = texture{ Polished_Chrome pigment{quick_color White} }
#end
#ifndef( Railtex1 ) 
#declare Railtex1   = texture{ //Rust scale 0.02 pigment{quick_color Tan}
                              pigment{color Tan*0.5}}
#end
#ifndef( Railtex2 ) 
#declare Railtex2   = texture{ //Rust scale 0.02 pigment{quick_color Tan}
                               pigment{color Tan*0.4}}
#end
#ifndef( Railtex3 ) 
#declare Railtex3   = texture{ //Rust scale 0.02 pigment{quick_color Tan}
                               pigment{color Tan*0.2}}
#end
#ifndef( Tietex1 ) 
#declare Tietex1    = texture{ pigment{ color DarkWood*0.95 quick_color Tan}
                               normal { bumps 0.5 scale 0.005 scale<1,10,30>}
                               finish { diffuse 0.85}}
#end
#ifndef( Tietex2 ) 
#declare Tietex2    = texture{ pigment{ color DarkWood quick_color Tan}
                               normal { bumps 0.55 scale 0.005 scale<1,1,10>}
                               finish { diffuse 0.88}}
#end
#ifndef( Tietex3 ) 
#declare Tietex3    = texture{ pigment{ color DarkWood*0.9 quick_color DarkTan}
                               normal { bumps 0.65 scale 0.005 scale<1,1,5>}}
#end


//---------------------------------------------------------------------------------------
//----------------------------------------------------------------------- Gauche & Heigth
#ifndef (           RT_System_Sizes_00_Inc_Temp )
#include "RT_System/RT_System_Sizes_00.inc"
#end 
//--------------------------------------------------------------------------------
// Switch_Direction_y, // 0 right, 1 = left
#local Left_Switch_ =   Switch_Direction_y  ; #local Right_Switch_ = abs(Switch_Direction_y-1); 
 

//------------------------------------------------------------------------ 
#local D = 0.00001;
//--------------------------------------------------------------------------------------- 
#ifndef ( Rail_Spikes_On )
#declare Rail_Spikes_On = 0; 
#end //----------------------------------------------------------------------------------
#if( Rail_Spikes_On = 1 ) 

#local Spike_Big  = 
union{                                                                                                     //pigment{Cyan}}//
  object{ Hexagon scale <0.5,1,1> translate<0.5,0,0> rotate<0,0,90> scale<1,1,1>*0.05 translate<0,0.020,0>   texture{Railtex1}} 
  cone{<0,0.020,>,0.06,<0,0.01,0>,0.085  texture{Railtex1} }
  cylinder{<0,0.01,0>,<0,0,0.00>,0.085   texture{Railtex2} }
  cylinder{<0,0.085,0>,<0,-0.035,0>,0.02 texture{Railtex2} } 
  // pigment{Cyan}
 scale <1,1,1>*0.60  
} // end uni -----------------------------------------------
#local Spike_Small  = 
union{    // in y+ !!!
  box{<-1,0,-1>,<1,1.5,1>            scale<1,1,1>*0.030  texture{Railtex1} translate<0,0.020,0> }  
  box{<-1+D,0,-1+D>,<1-D,1.5+D,1-D>  scale<1,1,1>*0.030  texture{Railtex2} translate<0,0.020,0> }  
  cone{<0,0.020,>,0.06,<0,0.01,0>,0.085  texture{Railtex1} }
  cylinder{<0,0.01,0>,<0,0,0.00>,0.085   texture{Railtex2} }
 scale <1,1,1>*0.40 
} // end uni ----------------------------------------------- 
#local Rail_Spike = 
union{                                                                
       box{<-0.10,         0,-RBaT-0.02 >,<0.10,RBaH+0.002,-RBaT-0.15> texture{Railtex2} } 
       box{<-0.06,RBaH+0.002,-RBaT+0.05 >,<0.06,RBaH+0.022,-RBaT-0.08> texture{Railtex2} }  
       object{  Spike_Big   translate<0,RBaH+0.023,-RBaT-0.035> } 
       object{  Spike_Small rotate<0, 14,0> translate< 0.05,RBaH+0.0025,-RBaT-0.12> } 
       object{  Spike_Small rotate<0,-40,0> translate<-0.05,RBaH+0.0025,-RBaT-0.12> } 
     } // end uni 

#end // of #if( Rail_Spikes_On = 1 ) 
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------- 
#declare Switch_Length_ = Switch_Radius_y * sin( radians( Switch_Angle_y) ) ;
#declare Rail_Distance_ =2*Switch_Radius_y *(1-cos( radians( Switch_Angle_y) ) ); 

// Y_Heart: 
// RB = (Switch_Radius_y + RB) *(1-cos(Gamma))
// -1 + cos(Gamma) = -RB/(Switch_Radius_y + RB) 
// cos(Gamma) =  1 - RB/(Switch_Radius_y + RB) 
// Gamma = acos(1 - RB/(Switch_Radius_y + RB) ) 
// Heart_Distance =  (R + RB) * ( sin( Gamma) ); 

#local Heart_Angle = degrees( acos( 1 - RB/( Switch_Radius_y + RB ) ) ); 
#local Heart_Distance = (Switch_Radius_y+RB) * sin (radians(Heart_Angle));  

// Second_Heart:: 
// 2*RB = (Switch_Radius_y + RB) *(1-cos(Delta))
// ( 1 - cos(Delta)) = 2*RB/(Switch_Radius_y +RB ) 
// -1 + cos(Delta) = -2*RB/(Switch_Radius_y + RB) 
// cos(Delta) =  1 - 2*RB/(Switch_Radius_y + RB) 
// Delta = acos(1 - 2*RB/(Switch_Radius_y + RB) ) 
// Heart_Distance =  (R + RB) * ( sin( Delta) ); 

// Second_Heart:
#local Second_Heart_Angle = degrees( acos( 1 - 2*RB/( Switch_Radius_y + RB ) ) ); 
#local Second_Heart_Distance = (Switch_Radius_y ) * sin (radians(Second_Heart_Angle));  
#local Linear_Ties_Start = (Switch_Radius_y+RB+0.75*SB) * sin (radians(Second_Heart_Angle+2.25));  

//----------------------------------------
#local Rail___Length_ =  Switch_Length_; 
#local RailRadius = Switch_Radius_y; 
#local Bow_Angle = Switch_Angle_y; 
//----------------------------------------

//---------------------------------------------------------------------------------------
#local Ties_Rail_Radius = (pow(Switch_Length_,2)+pow(Rail_Distance_/2,2))/(2*Rail_Distance_/2);
#local Ties_Angle_  = degrees( asin( Switch_Length_/Ties_Rail_Radius )); // declared for extern applications !!! 
//---------------------------------------------------------------------------------------
// Anzahlen und Abstand der Schwellen: // round
#local Ties_Round_Number_ = int( Ties_Rail_Radius*pi*Ties_Angle_/180*Ties_Per_Meter_) ;
#local Ties_Angle =  Ties_Angle_/Ties_Round_Number_; // Ties between angel (center to center)
// --------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//--------------------------------------------------------------- Ties - Schwellen 
#local Tie = union{
 box {<-SD/2+D,0  ,-1*SB+D>,< SD/2-D,SH  ,1.0*SB-D> texture{Tietex1}}
 box {<-SD/2  ,0+D,-1*SB+D>,< SD/2  ,SH-D,1.0*SB-D> texture{Tietex2}}
 box {<-SD/2+D,0+D,-1*SB  >,< SD/2-D,SH-D,1.0*SB  > texture{Tietex3}} 
 #if ( Rail_Spikes_On = 1 )
 object{ Rail_Spike translate<0,SH,-RB>}
// object{ Rail_Spike  scale<1,1,-1> translate<0,SH,-RB>}
// object{ Rail_Spike  translate<0,SH, RB>}
 object{ Rail_Spike  scale<1,1,-1> translate<0,SH, RB>}
 #end 

} // end of union
//--------------------------------------------------------------- Round Rails submacros

//---------------------------- macro symmetrisches Cylinder-Segment_Y: "C_Seg(Ra,Ri,H,W)"----<< 
#macro C_Segment (Radius_aussen, Radius_innen, Hoehe, Segment_Winkel)  
#local D = 0.001;
// needs: #include "shapes_lo.inc"
//#macro Segment_of_CylinderRing ( R_out, R_in, Height, Segment_Angle)
object{ Segment_of_CylinderRing ( Radius_aussen, Radius_innen, Hoehe, Segment_Winkel)
        rotate<0,-90,0> rotate<0,0,0>  
        translate<0,0,0>
} #end //----------------------------<<<<<<<<
//-------------------------------------- macro symmetrisches Torus-Segment_Y: "T_Seg(Ra,Ri,YScale,W)"----<< 
#macro T_Segment (Radius_major, Radius_minor, YScale, Segment_Winkel)  
#local D = 0.001;
// needs: #include "shapes_lo.inc"
// #macro Segment_of_Torus( R_major, R_minor, Segment_Angle)
object{ Segment_of_Torus( Radius_major, Radius_minor, Segment_Winkel) scale <1,YScale,1>
        rotate<0,-90,0> rotate<0,0,0>  
}#end //----------------------------<<<<<<<<
//-------------------------------------------------------------------------------------------------------------
//-------------------------------------------------------------------------------------------------------------
#macro Rail_Round ( Rail___R, Rail___Angle )
 union{  // 2   
    union{ // 3 // round head
             object{ T_Segment (Rail___R, RToR, RToS, Rail___Angle) texture {RailToptex  }}  
            // verical part of head - senkrechter Teil des Kopfes
             object{C_Segment (Rail___R+RToR, Rail___R-RToR, 0.02, Rail___Angle) translate<0,-0.02,0> texture {RailToptex}}
            // lower round part of head - unterer runder Kopfteil
             object{ T_Segment (Rail___R, RToR, RToS, Rail___Angle) translate<0,-0.02,0> texture {Railtex2}}  
           translate<0,RBoH,0>
         } // 3
        // vertical parts 
        object{C_Segment (Rail___R+RBoT, Rail___R-RBoT, RBoH, Rail___Angle) texture {Railtex1}}
        object{C_Segment (Rail___R+RBaT, Rail___R-RBaT, RBaH, Rail___Angle) texture {Railtex2}}
      } // 2 union without ties
#end // ----------------------------- end of submacro 


//--------------------------------------------------------------- Schiene linear
#macro Rail_line_X(Rail_Len)   //-------------------------------- 
#local D = 0.0001;
union{ 
 cylinder {< 0,0,0>,<Rail_Len  ,0,0>,RToR scale <1,RToS,1> translate<0,RBoH,0> texture{RailToptex}} //head
 cylinder {<-D,0,0>,<Rail_Len+D,0,0>,RToR scale <1,RToS,1> translate<0,RBoH-D,0> texture{Railtex2}} //below head
 cylinder {<-D,0,0>,<Rail_Len+D,0,0>,RToR scale <1,RToS,1> translate<0,RBoH-0.02,0> texture{Railtex2}} //below head
 box {<0,RBoH-0.02,-RToR>,<Rail_Len,RBoH,RToR> texture{Railtex2}} //
 box {<0,0.00,-RBoT>,<Rail_Len,RBoH,RBoT> texture{Railtex1}} // steg
 box {<0,0.00,-RBaT>,<Rail_Len,RBaH,RBaT> texture{Railtex2}} // Fuﬂ
 }#end //  end union + macro
//--------------------------------------------------------------- 
#local Rail_H = Height_Top_Edge_Rail-SH;
#local Tween  = 2*RToR;  // L¸cke dazwischen
#local Switch_Move_Angle = 4.0*10/Switch_Length_; 
#local Bend_End_Len = 0.30;
#local Bend_End_Angle = Bend_End_Len/(2*pi*RailRadius+RB)*360; 
#local Bend_Angle = 18; 

#local Cut_3Way = // von oben
object{  Segment_of_CylinderRing (  RailRadius+RB-RToR+D, RailRadius+RB-3*RToR,   0.15, -Bow_Angle )   
         texture{Railtex1} 
         //  pigment{ color rgb< 1.0, 0.0, 1.0>*1.2 } 

         scale < 1,1,1> rotate<0, 90,0> translate<0,0.01,2*RailRadius>
      }//----------------------------------------------------------
#local Cut_2Way = // von unten 
object{  Segment_of_CylinderRing (  RailRadius+RB-RToR+D, RailRadius+RB-3*RToR,   0.25, -Bow_Angle )   
         texture{Railtex1} 
         //  pigment{ color rgb< 1.0, 0.5, 0.0>*1.2 } 

         scale < 1,1,1> rotate<0, 90,0> translate<0,0.01, 0> scale<1,1,-1>
      }//----------------------------------------------------------
#local Cut_linear =
  box{ <Rail___Length_*1/3,-D,RailRadius-RB+RToR>,<Rail___Length_,Rail_H+D,RailRadius-RB+RToR+Tween> 
          texture{Railtex1} 
         // pigment{ color rgb< 1.0, 0.5, 0.0>*1.2 } 

    } 
//object{ Cut_2Way }
//object{ Cut_3Way}  
//object{ Cut_linear } 
//--------------------------------------------------------------------------------------- 
#macro Half_3Way (Switchy_Round_)

union{ // 1   // 3Ways: the -z part                                       
 
  union{ // 2                                       
 

 
 // round inner rail 
 object{  Rail_Round ( RailRadius-RB ,  Bow_Angle ) translate <0,0,0> }  // Round_Inner
 
 // fix outer rail round at heart
 difference { 
  object{  Rail_Round ( RailRadius+RB , Bow_Angle-Heart_Angle*2/3 ) rotate <0, Heart_Angle*2/3,0> } //Round_Outer
//  object{ Cut_linear }
//  box{ <Rail___Length_/3,RBaH+D, RailRadius-RB>,<Rail___Length_+D+RB/2,Rail_H+D,RailRadius-RB+RToR+Tween> texture {Railtex2}}//  pigment{ Yellow } } 
  object{ Cut_3Way}  
  object{ Cut_2Way}  
  }
 
 // Zunge heart 
 difference{     // Zunge gebogener Teil auﬂen
  object{  Rail_Round ( RailRadius+RB ,  Heart_Angle*(2/3-1/10) ) rotate <0,Heart_Angle*1/10,0> } //Round_Outer
  object{ Rail_line_X( Rail___Length_ ) scale<1,1,1> translate<0,0,RailRadius+RB>}
  box{ <-D,-D, RailRadius+RB-RToR-D>,<Rail___Length_+D,RBaH+D,RailRadius+RB+RToR-D> texture {Railtex2} } 
 rotate<0,-Heart_Angle*2/3,0> translate<0,0,-(RailRadius+RB)> 
 rotate<0,-Switch_Move_Angle*(1-Switchy_Round_),0>
 translate<0,0, (RailRadius+RB)> rotate<0,Heart_Angle*2/3,0>
 } //  

 // round inner guider 
 difference{ // outer heart     // Zunge gebogener Teil auﬂen
  object{  Rail_Round ( RailRadius+RB-Tween-2*RToR , (Second_Heart_Angle-Heart_Angle)*1.5-2*Bend_End_Angle ) 
           rotate <0,Heart_Angle*0.60,0> } //Round_Outer
//  object{ Cut_linear }
  object{ Cut_3Way   }
 } //
 // End bended right 
 object{  Rail_Round ( RailRadius+RB-Tween-2*RToR , Bend_End_Angle ) 
  translate<0,0,-(RailRadius+RB-Tween-2*RToR)-RToR> rotate<0,Bend_Angle,0>
  translate<0,0,(RailRadius+RB-Tween-2*RToR)+RToR> 
  //rotate <0,Bow_Angle-2*Bend_End_Angle,0> } //Round_Outer
  rotate <0,Heart_Angle*0.60+(Second_Heart_Angle-Heart_Angle)*1.5-2*Bend_End_Angle,0> } //Round_Outer
 // End bended at start
 object{  Rail_Round ( RailRadius+RB-Tween-2*RToR , Bend_End_Angle ) 
  translate<0,0,-(RailRadius+RB-Tween-2*RToR)-RToR> rotate<0,Bend_Angle,0>
  translate<0,0,(RailRadius+RB-Tween-2*RToR)+RToR> scale<-1,1,1>
  //rotate <0,Bow_Angle-2*Bend_End_Angle,0> } //Round_Outer
  rotate <0,Heart_Angle*0.60,0> } //Round_Outer
 //-----


 //-----
 union{ //3 round outer wheel_guider (thin inside rail)
 object{ C_Segment (RailRadius-RB+RToR+Tween,RailRadius-RB+RToR+Tween+0.015, Rail_H, Bow_Angle*1/3-3*Bend_End_Angle)  rotate<0,Bow_Angle*2/3+1.5*Bend_End_Angle,0> 
         texture {Railtex1} }  // pigment{Cyan }} 
 //links nach innen
 object{ C_Segment (RailRadius-RB+RToR+Tween,RailRadius-RB+RToR+Tween+0.015, Rail_H, Bend_End_Angle) 
  rotate<0,-Bend_End_Angle,0> translate<0,0,-(RailRadius-RB+RToR+Tween)>
  rotate<0, Bend_Angle,0> translate<0,0,(RailRadius-RB+RToR+Tween)> 
         rotate<0,Bow_Angle*2/3+1.5*Bend_End_Angle,0> 
         texture {Railtex1} } //  pigment{ Green }} 
 //rechts nach innen
 object{ C_Segment (RailRadius-RB+RToR+Tween,RailRadius-RB+RToR+Tween+0.015, Rail_H, Bend_End_Angle) 
  translate<0,0,-(RailRadius-RB+RToR+Tween)>
  rotate<0,-Bend_Angle,0> translate<0,0,(RailRadius-RB+RToR+Tween)> 
  rotate<0,Bow_Angle-1.5*Bend_End_Angle,0> 
          texture {Railtex1} }  //pigment{ Green }}
 // basis drunter:
 object{ C_Segment (RailRadius-RB+Tween,RailRadius-RB+RToR+Tween+0.10,RBaH, Bow_Angle*1/3-Bend_End_Angle)  rotate<0,Bow_Angle*2/3+0.5*Bend_End_Angle,0> 
          texture {Railtex2} } //   pigment{Yellow }}
 rotate<0,-Bow_Angle*2/3+ Heart_Angle*0.60,0>
 } //3 inner_guider


 // Connect the mobile parts
 union{ 
  cylinder{<0,0,-1.95*RB>,<0,0,0>, 0.02                                    texture{Railtex2} } //pigment{ Cyan  }}   
  object { Round_Cylinder(<0,0,-1.25*RB>,<0,0,-0.60*RB>, 0.035, 0.025,  0) texture{Railtex3} } // pigment{ Yellow }}
  translate<Rail___Length_*1/5,0,0.9*RB> // position relativ to left end 
 translate<-(Rail___Length_-Heart_Distance*2/3),0,-(RB)> 
 rotate<0, -Switch_Move_Angle/3*(1-Switchy_Round_),0>
 translate<Rail___Length_-Heart_Distance*2/3,0, (RailRadius+RB)> 
 }// end mobile connection 

 translate <0,SH,0> 
} // 2

 
// ties for switch 
intersection{ 
 union{  // Schwellen 
 #local Nr = 0;     // start
 #while (Nr< Ties_Round_Number_) 
  object{ Tie translate<0,0,Ties_Rail_Radius>  rotate<0,(Nr+0.5) * Ties_Angle,0> translate<0,0,-(Ties_Rail_Radius-RailRadius)>} 
 #local Nr = Nr + 1;  #end // ---------------  end of loop 
 }// uni  

 // limitations // Begrenzungen
 object{ C_Segment (RailRadius+Rail_Distance_+SB, RailRadius-SB, 2*SH, Bow_Angle ) translate<0,-3*D,0> texture{Tietex3} } 
 box{ <-D,-2*D, RailRadius-RB-Rail_Distance_>,<Rail___Length_+SD/2+D,2*SH+D, RailRadius>  texture{Tietex3}} //pigment{Green} } 
} // end intersection                              



#if( Rail_Spikes_On = 1 ) 
union{ 
 #local Nr = 0;     // start
 #while (Nr< Ties_Round_Number_) 
   #local DT_A =  (Nr+0.5)*Ties_Angle;   
      #if ( DT_A   < Heart_Angle*0.2 | (  (DT_A >Heart_Angle/2 & DT_A <Heart_Angle*0.8)| (DT_A>Heart_Angle*0.85 & DT_A <Heart_Angle*1.5) )  )
       // sphere{ <0,0,-0.1>,0.1  pigment  { Yellow } 
       object{ Rail_Spike   scale<1,1,1>  translate<0,0,Ties_Rail_Radius+RB -( (DT_A >Heart_Angle*0.6 & DT_A <Heart_Angle*0.8)| (DT_A>Heart_Angle*0.85 & DT_A <Heart_Angle*1.15))*(RBaT+Tween)> 
                                                                                  rotate<0,(Nr+0.5)*Ties_Angle,0>  translate<0,SH,-(Ties_Rail_Radius-RailRadius) >} 
      #end

      #if ( DT_A     >Heart_Angle/2   )
       // sphere{ <0,0,-0.1>,0.1  pigment  { Orange } 
       object{ Rail_Spike   scale<1,1,-1>  translate<0,0,Ties_Rail_Radius-RB>  rotate<0,(Nr+0.5)*Ties_Angle,0>  translate<0,SH,-(Ties_Rail_Radius-RailRadius) >} 
      #end

      #if (DT_A > Heart_Angle/2 & DT_A < Heart_Angle *0.999 )
       // sphere{ <0,0,-0.1>,0.1  pigment  { Green } 
       object{ Rail_Spike   scale<1,1,-1>  translate<0,0,Ties_Rail_Radius+RB>  rotate<0,(Nr+0.5)*Ties_Angle,0>  translate<0,SH,-(Ties_Rail_Radius-RailRadius) >} 
      #end 
 //------
 #local Nr = Nr + 1;  #end // ---------------  end of loop 
}// uni  
#end // of '#if( Rail_Spikes_On = 1 )' 

translate<0,0,-RailRadius> //Switch_Radius_y
} // 3 end of union
#end // 


union{ //--------------------------------------------------------final union
 object{  Half_3Way (Right_Switch_) } 
 object{  Half_3Way (Left_Switch_) scale<1,1,-1>} 
} // end final union
//--------------------------------------------------------------- 
//----------------------------------------------------------------------------<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<                                                                                                  
//--------------------------------------------------------------- 

// --------------------------------------------------------------------------------------
#end// of macro ------------------------------------------------------// end of macro
//---------------------------------------------------------------------------------------





//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
// sample: 
/*
//-------------------------------------------------------------------------- 
//--------------------------------------------------------------------------
//--------------------------------------------------------------------------
#include "RT_System/RT_Track_Switch_Y_00.inc"  // returns: "Switch_Length_" and "Rail_Distance_" !!!
//--------------------------------------------------------------------------
//#declare Rail_Spikes_On = 1;
object{ RT_Track_Switch_Y_00(  1, //   Switch_Direction, // 0 = right , 1 = left
                               70, //    Switch_Radius_y, // Switch_Length_, 
                               30, //    Switch_Angle_y, 
                                  1.5 // Ties_Per_Meter_  // ~1.5
                          ) //------------------------------------------------------- 
        rotate<0,0,0>  
        translate<0,0,0 >  
} //--------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
*/


#version RT_Track_Switch_Y_00_Inc_Temp;
#end
//------------------------------------- end of include file

