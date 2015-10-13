// POV-Ray 3.6 / 3.7 include file "RT_Track_Switch_A_00.inc"                                                                                                                                                // PoVRay 3.6 include File "wheel_000.inc"
// author: Friedrich A, Lohmueller, Nov-2010
// homepage: http://www.f-lohmueller.de/
// email: Friedrich.Lohmueller_aT_t-online.de
//------------------------------------------------------------------------
#ifndef( RT_Track_Switch_A_00_Inc_Temp)
#declare RT_Track_Switch_A_00_Inc_Temp = version;
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
//------------------------------------------------------------------------------------
#macro RT_Track_Switch_A_00 ( Switch_Direction_, // 0 straight ~ 1 round
                              Switch_Length_, 
                              Switch_Angle_,   // degrees 
                          //  Switch_Radius_,// here automatically calculated !!! 
                          //  Rail_Distance_,// here automatically calculated !!!
                              Ties_Per_Meter_  // ~1.5
                         ) //--------------------------------------------------------- 
#if (Switch_Direction_<0) #declare Switch_Direction_ = 0; #end
#if (Switch_Direction_>1) #declare Switch_Direction_ = 1; #end

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
//------------------------------------------------------------------------ 
#local D = 0.00001;
//--------------------------------------------------------------------------------------- 
#ifndef ( Rail_Spikes_On )
#declare Rail_Spikes_On = 0; 
#end //----------------------------------------------------------------------------------
#if( Rail_Spikes_On = 1 ) 

#local Spike_Big  = 
union{                                                                                                     //pigment{Cyan}}//
  object{ Hexagon scale <0.5,1,1> translate<0.5,0,0> rotate<0,0,90> scale<1,1,1>*0.05 translate<0,0.020,0>  texture{Railtex1}} 
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
#declare Switch_Radius_ = Switch_Length_  / (sin(radians( Switch_Angle_))); // declared for extern applications !!! 
#declare Rail_Distance_ = 2*Switch_Radius_*(1-cos(radians(Switch_Angle_))); // declared for extern applications !!! 

#local Heart_Angle = degrees( acos( (Switch_Radius_-2*RB) / Switch_Radius_ ));
#local Heart_Distance = Switch_Radius_ * sin (radians(Heart_Angle));  


#local DTies_Len_ = Heart_Distance+(Switch_Length_-Heart_Distance)*0.75;// reduced for DTies 
#local DTies_Rail_Radius =  Switch_Radius_ ; 
#local DTies_Angle_  =Heart_Angle+(Switch_Angle_ -Heart_Angle)*0.75  ;  

//----------------------------------------
#local Rail___Length_ =  Switch_Length_; 
#local RailRadius = Switch_Radius_; 
#local Bow_Angle = Switch_Angle_; 
//---------------------------------------------------------------------------------------
// Anzahlen und Abstand der Schwellen: // round
#local DTies_Round_Number_ = int( DTies_Rail_Radius*DTies_Angle_*pi/180*(Ties_Per_Meter_))  ;
#local DTies_Angle =  DTies_Angle_/(DTies_Round_Number_); // Ties between angel (center to center)

// --------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//  Number and distance of the ties/sleepers on straight branch - Anzahlen und Abstand der Schwellen: gerader Zweig
#local LTies_Linear_Number_ = int(Rail___Length_*Ties_Per_Meter_);
#local Ties_New_Per_Meter__ = LTies_Linear_Number_/Rail___Length_; 
#if ( Ties_New_Per_Meter__ != 0)
#local LTies_Distance = 1/(Ties_New_Per_Meter__);  // equidistant distribution!
#else #local LTies_Distance = 0;                   // Verteilt Schwellen gleichmäßig über Länge!!!
#end
// --------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//--------------------------------------------------------------- Ties - Schwellen 
#local DTie = union{
 box {<-SD/2+D,0  ,-3*SB+D>,< SD/2-D,SH  ,3*SB-D> texture{Tietex1}}
 box {<-SD/2  ,0+D,-3*SB+D>,< SD/2  ,SH-D,3*SB-D> texture{Tietex2}}
 box {<-SD/2+D,0+D,-3*SB  >,< SD/2-D,SH-D,3*SB  > texture{Tietex3}} 
} // end of union
//--------------------------------------------------------------- Round Rails submacros

//---------------------------------------------------------------------------------------
// Number and distance of the ties/sleepers on round way-  Anzahlen und Abstand der Schwellen:
#local RTies_Number_ = int(Switch_Radius_*pi*Switch_Angle_/180*Ties_Per_Meter_);
#if (RTies_Number_ != 0 )
#local RTies_Angle = Switch_Angle_/RTies_Number_; // Ties between angel (center to center)
#else #local RTies_Angle = 0; 
#end
// --------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//--------------------------------------------------------------- Ties - Schwellen 
#local RTie = union{
 box {<-SD/2+D,0  ,-SB+D>,< SD/2-D,SH  ,SB-D> texture{Tietex1}}
 box {<-SD/2  ,0+D,-SB+D>,< SD/2  ,SH-D,SB-D> texture{Tietex2}}
 box {<-SD/2+D,0+D,-SB  >,< SD/2-D,SH-D,SB  > texture{Tietex3}} 
 #if ( Rail_Spikes_On = 1 )
 object{ Rail_Spike translate<0,SH,-RB>}
 object{ Rail_Spike  scale<1,1,-1> translate<0,SH,-RB>}
 object{ Rail_Spike  translate<0,SH, RB>}
 object{ Rail_Spike  scale<1,1,-1> translate<0,SH, RB>}
 #end 
} // end of union
//--------------------------------------------------------------- Round Rails submacros




//---------------------------- macro symmetrisches Cylinder-Segment_Y: "C_Seg(Ra,Ri,H,W)"----<< 
#macro C_Segment (Radius_aussen, Radius_innen, Hoehe, Segment_Winkel)  
#local D = 0.001;
//#include "shapes_lo.inc"
//#macro Segment_of_CylinderRing ( R_out, R_in, Height, Segment_Angle)
object{ Segment_of_CylinderRing ( Radius_aussen, Radius_innen, Hoehe, Segment_Winkel)
        rotate<0,-90,0> rotate<0,0,0>  
        translate<0,0,0>
} #end //----------------------------<<<<<<<<
//-------------------------------------- macro symmetrisches Torus-Segment_Y: "T_Seg(Ra,Ri,YScale,W)"----<< 
#macro T_Segment (Radius_major, Radius_minor, YScale, Segment_Winkel)  
#local D = 0.001;
// #include "shapes_lo.inc"
// #macro Segment_of_Torus( R_major, R_minor, Segment_Angle)
object{ Segment_of_Torus( Radius_major, Radius_minor, Segment_Winkel) scale <1,YScale,1>
        rotate<0,-90,0> rotate<0,0,0>  
}#end //----------------------------<<<<<<<<
//-------------------------------------------------------------------------------------------------------------
//-------------------------------------------------------------------------------------------------------------
#macro Rail_Round ( Rail___R, Rail___Angle )
 union{  // 2  //inner 
    union{ // 3
             object{ T_Segment (Rail___R, RToR, RToS, Rail___Angle) texture {RailToptex pigment{quick_color Red}}}  
            // verical part of head - senkrechter Teil des Kopfes
             object{C_Segment (Rail___R+RToR, Rail___R-RToR, 0.02, Rail___Angle) translate<0,-0.02,0> texture {Railtex2}}
            // lower round part of head - unterer runder Kopfteil
             object{ T_Segment (Rail___R, RToR, RToS, Rail___Angle) translate<0,-0.02,0> texture {Railtex2}}  
           translate<0,RBoH,0>} // 3
      
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
 box {<0,0.00,-RBaT>,<Rail_Len,RBaH,RBaT> texture{Railtex2}} // Fuß
 }#end
//--------------------------------------------------------------- 
#local Height_Top_Edge_Rail =  Height_Rail_Top;
#local Rail_H = Height_Top_Edge_Rail-SH;
#local Tween  = 2*RToR;  // Lücke dazwischen
#local Switch_Move_Angle = 4.0*10/Switch_Length_; 
#local Switch_Connect_R = Rail___Length_*(1/3-1/10); 
#local Bend_End_Len = 0.30;
#local Bend_End_Angle = Bend_End_Len/(2*pi*RailRadius+RB)*360; 
#local Bend_Angle = 15; 

//---------------------------------------------------------------------------------------
union{ // 1                                        
 union{ // 2                                       
 // round inner 
 object{  Rail_Round ( RailRadius-RB ,  Bow_Angle ) translate <0,0,0> }  // Round_Inner
 // linear outer
 object{ Rail_line_X( Rail___Length_ ) translate<0,0,RailRadius+RB>}
 //---------------------------

 difference { // fix outer round at heart
  object{  Rail_Round ( RailRadius+RB , Bow_Angle-Heart_Angle*1/3 ) rotate <0, Heart_Angle*1/3,0> } //Round_Outer
  box{ <Rail___Length_/2,RBaH+D, RailRadius-RB>,<Rail___Length_+D+RB/2,Rail_H+D,RailRadius-RB+RToR+Tween> texture {Railtex2}}//  pigment{ Yellow } } 
  }
 
 difference{ // outer heart     // Zunge gebogener Teil außen
  object{  Rail_Round ( RailRadius+RB ,  Heart_Angle*(2/3-1/10) ) rotate <0,Heart_Angle*1/10,0> } //Round_Outer
  object{ Rail_line_X( Rail___Length_ ) scale<1,1,1> translate<0,0,RailRadius+RB>}
  box{ <-D,-D, RailRadius+RB-RToR-D>,<Rail___Length_+D,RBaH+D,RailRadius+RB+RToR-D> texture {Railtex2} } 
 rotate<0,-Heart_Angle*2/3,0> translate<0,0,-(RailRadius+RB)> 
 rotate<0,-Switch_Move_Angle*(1-Switch_Direction_),0>
 translate<0,0, (RailRadius+RB)> rotate<0,Heart_Angle*2/3,0>
 } //  

 // round inner wheel_guider 
 difference{ // outer heart     // innerer guider gebogener Teil außen
  object{  Rail_Round ( RailRadius+RB-Tween-2*RToR ,  Bow_Angle*(1/3)-2*Bend_End_Angle ) rotate <0,Heart_Angle*3/4,0> } //Round_Outer
  box{ <Rail___Length_*1/3,-D,RailRadius>,<Rail___Length_,Rail_H+D,RailRadius-RB-RToR> texture {Railtex2} } 
 } //
 object{  Rail_Round ( RailRadius+RB-Tween-2*RToR , Bend_End_Angle )  
  translate<0,0,-(RailRadius+RB-Tween-2*RToR)-RToR> rotate<0,Bend_Angle,0>
  translate<0,0,(RailRadius+RB-Tween-2*RToR)+RToR> 
  rotate <0,  Bow_Angle*(1/3)+Heart_Angle*3/4-2*Bend_End_Angle,0> } //Round_Outer
 //-----
 

 // round outer wheel_guider flat
 
 union{
  object{ C_Segment (RailRadius-RB+RToR+Tween,RailRadius-RB+RToR+Tween+0.015, Rail_H, Bow_Angle*1/3-2*Bend_End_Angle)  rotate<0,Bow_Angle*2/3+Bend_End_Angle,0> 
         texture {Railtex1} }  // pigment{Cyan }} 
  //links nach innen 
  object{ C_Segment (RailRadius-RB+RToR+Tween,RailRadius-RB+RToR+Tween+0.015, Rail_H, Bend_End_Angle) 
   rotate<0,-Bend_End_Angle,0> translate<0,0,-(RailRadius-RB+RToR+Tween)>
   rotate<0, Bend_Angle,0> translate<0,0,(RailRadius-RB+RToR+Tween)> 
         rotate<0,Bow_Angle*2/3+Bend_End_Angle,0> 
         texture {Railtex1} } //  pigment{ Green }} 
  //rechts nach innen
   object{ C_Segment (RailRadius-RB+RToR+Tween,RailRadius-RB+RToR+Tween+0.015, Rail_H, Bend_End_Angle) 
   translate<0,0,-(RailRadius-RB+RToR+Tween)>
   rotate<0,-Bend_Angle,0> translate<0,0,(RailRadius-RB+RToR+Tween)> 
   rotate<0,Bow_Angle-Bend_End_Angle,0> 
          texture {Railtex1} }  //pigment{ Green }}
  // basis drunter:
  object{ C_Segment (RailRadius-RB+Tween,RailRadius-RB+RToR+Tween+0.10,RBaH, Bow_Angle*1/3-Bend_End_Angle)  rotate<0,Bow_Angle*2/3+0.5*Bend_End_Angle,0> 
          texture {Railtex2} } //   pigment{Yellow }}
  rotate<0,-(Bow_Angle -  Heart_Angle )/2 ,0>
  } // end oúter thin wheel_guider

 

 //-------- linear parts of the rails
 difference{ // fix linear inner at heart
  object{ Rail_line_X( Rail___Length_-Heart_Distance*2/3 ) translate<Heart_Distance*2/3,0,RailRadius-RB>} // inner
  object{ C_Segment ( RailRadius+RB-RToR, RailRadius+RB-RToR-Tween,Rail_H+D,Bow_Angle*(2/3) ) rotate<0, Bow_Angle*1/3,0> texture {Railtex2}} 
 } // 

 difference{  // rest = linear   Zunge gerader Teil innen   Heart_Distance*2/3
  object{ Rail_line_X( Heart_Distance*(2/3-1/10) ) translate<Heart_Distance*1/10,0,RailRadius-RB>}   // inner
  object{ Rail_Round ( RailRadius-RB ,  Bow_Angle*(2/3) ) rotate <0,0,0> } //Round_Outer
 translate<-( Heart_Distance*2/3 ),0,-(RailRadius-RB)> 
 rotate<0, (Switch_Direction_)*Switch_Move_Angle,0>
 translate<( Heart_Distance*2/3 ),0, (RailRadius-RB)> 
 } //
 // Connect the mobile parts
 union{ 
  cylinder{<0,0,-1.85*RB>,<0,0,0>, 0.02                                    texture{Railtex2} } //pigment{ Cyan  }}   
  object { Round_Cylinder(<0,0,-1.25*RB>,<0,0,-0.60*RB>, 0.035, 0.025,  0) texture{Railtex3} } // pigment{ Yellow }}
          
  translate<Rail___Length_*1/5,0,0.9*RB> // position relativ to left end 
 translate<-( Rail___Length_-Heart_Distance*2/3 ),0,-(RB)> 
 rotate<0, (Switch_Direction_)*Switch_Move_Angle,0>
 translate<( Rail___Length_-Heart_Distance*2/3 ),0, (RailRadius+RB)> 
 }// end mobile connection 

 
 // linear inner wheel_guider 
 difference{  // rest = linear   behind heart  - gerader Teil innen  
 object{ Rail_line_X(  Rail___Length_-(Rail___Length_-Heart_Distance)*0.5-Bend_End_Len ) translate<0,0,RailRadius-RB+Tween+2*RToR>} // inner
 cylinder{<0,-D,0>,<0, Rail_H+D,0>, RailRadius+RB texture {Railtex2} } 
 } 
 
 object{ Rail_line_X( 0.30 ) translate<0,0,RToR> rotate<0,-Bend_Angle,0> translate< Rail___Length_-(Rail___Length_-Heart_Distance)*0.5-Bend_End_Len,0,RailRadius-RB+Tween+1*RToR>} // inner
 //-----------
 // linear outer wheel_guider
 union{ // outer thin
  box{ <Rail___Length_*1/2+Bend_End_Len,-D,RailRadius+RB-RToR-Tween>,<Rail___Length_-Bend_End_Len,Rail_H+D,RailRadius+RB-RToR-Tween-0.015> texture{Railtex1} } // pigment{ Cyan}}
  // rechtes Ende  
  box{ <-Bend_End_Len,-D,0>,<0,Rail_H+D,-0.015>  rotate<0,-Bend_Angle,0> 
       translate<Rail___Length_*1/2+Bend_End_Len,0,RailRadius+RB-RToR-Tween> texture {Railtex1}} // pigment{ Yellow}} 
  // linkes Ende 
  box{ < Bend_End_Len,-D,0>,<0,Rail_H+D,-0.015>  rotate<0, Bend_Angle,0> 
       translate<Rail___Length_-Bend_End_Len,0,RailRadius+RB-RToR-Tween> texture {Railtex1}} //  pigment{ Yellow}} 

  // basis darunter 
  box{ <Rail___Length_*2/3+Bend_End_Len/2,-D,RailRadius+RB-RToR-Tween+0.02>,<Rail___Length_-Bend_End_Len/2,RBaH,RailRadius+RB-RToR-Tween-0.12> texture{Railtex2}} 
 translate<-(Rail___Length_-Heart_Distance)/2,0,0>
 }// outer thin 
 // ---------------------

 translate <0,SH,0> 
 } // 2



//-------------------------------------------------------------------
// ties/sleepers for switch 
intersection{ 
 union{  // ties / sleepers - Schwellen 
 #local Nr = 0;     // start
 #while (Nr< DTies_Round_Number_-1) 
   object{ DTie translate<0,0,DTies_Rail_Radius*2>  rotate<0,(Nr+0.5) * DTies_Angle/2,0> translate<0,0,-(DTies_Rail_Radius*2-RailRadius)>} 
 #local Nr = Nr + 1;  #end // ---------------  end of loop 
 } 
 // limitations / Begrenzungsformen
 object{ C_Segment (RailRadius+Rail_Distance_+SB, RailRadius-SB, 2*SH, Bow_Angle ) translate<0,-3*D,0> texture{Tietex3} } 
 box{ <-D,-2*D, RailRadius-RB-Rail_Distance_>,<Rail___Length_+SD/2+D,2*SH, RailRadius+SB>  texture{Tietex3}} //pigment{Green} } 
} // end intersection                   
 #local D_Ties_End =  (DTies_Rail_Radius)*sin(radians( (DTies_Round_Number_-1)* DTies_Angle/1.0) );
 #local R_Ties_Start_Angle= degrees ( asin(D_Ties_End/Switch_Radius_)); 
 #local Rest_Round_Ties_Angle = Switch_Angle_- R_Ties_Start_Angle; 
 #local Rest_Bow_Len =   Switch_Radius_*(2*pi) *Rest_Round_Ties_Angle/360;
 #local Rest_R_Number = int(Rest_Bow_Len * Ties_Per_Meter_ +0.5) ;
 #if (Rest_R_Number !=0)
   #local RTies_Angle_2 = Rest_Round_Ties_Angle/Rest_R_Number; 
 #else #local  RTies_Angle_2 = 0; 
 #end 

#if( Rail_Spikes_On = 1 ) 
 #local Nr = 0 ;     // start
 #while (Nr< DTies_Round_Number_-1 ) 
     #local DT_X =  (-1.00*RB +DTies_Rail_Radius*2)*tan(radians((Nr+0.5)* DTies_Angle/2)); 
       // aussen gerade
       object{ Rail_Spike scale<1,1,-1> translate< DT_X*1.01,SH, RB +Switch_Radius_>}
        #if ( ( DT_X   > Heart_Distance/2  ) ) 
      // sphere{ <0,0,-0.15>,0.1 pigment{YellowGreen} 
        object{ Rail_Spike scale<1,1, 1> translate< DT_X*1.02,SH, RB +Switch_Radius_>}
        #end   

     // linear
     #if ( ( DT_X   > Heart_Distance/2 ) &  (  (DT_X      < Heart_Distance-0.50) | (DT_X  > Heart_Distance+0.30) )      )
     
       // inside
       object{ Rail_Spike scale<1,1,-1> translate< DT_X,SH,-RB +Switch_Radius_+ ( DT_X > Heart_Distance+0.30 &  DT_X < Rail___Length_-(Rail___Length_-Heart_Distance)*0.3) *(RBaT+Tween)>}
       // to round part
       object{ Rail_Spike scale<1,1, 1> translate< DT_X,SH,-RB +Switch_Radius_>}
      
      #end   
     // round parts
    // object{ Rail_Spike
     // sphere{ <0,0.1,0>,0.2 pigment{Yellow} 
       object{ Rail_Spike scale<1,1, 1> translate<(DTies_Rail_Radius-RB/2)*sin(radians((Nr+0.5)* DTies_Angle)),SH,(-RB*1 +RailRadius)*cos(radians( (Nr+0.5)*DTies_Angle ))>} 
      #if (DT_X < 1.50 | (DT_X > Heart_Distance/2 ) )
      // sphere{ <0,0.1,0>,0.2 pigment  { Orange } 
      object{ Rail_Spike   scale<1,1,-1> translate<(DTies_Rail_Radius-RB/2)*sin(radians((Nr+0.5)* DTies_Angle)),SH,(-RB*1 +RailRadius)*cos(radians( (Nr+0.5)*DTies_Angle ))>} 
      #end
 
     #if ( ( DT_X   > Heart_Distance/2 ) &  (DT_X < Heart_Distance-1.50) | ( DT_X   > Heart_Distance+0.3 ) ) 
     // sphere{ <0,0.1,0>,0.2 pigment  { Blue } 
       object{ Rail_Spike scale<1,1, 1> translate<(DTies_Rail_Radius+RB/2) *sin(radians((Nr+0.5)*DTies_Angle))*0.999,SH,( RB*1 +RailRadius)*cos(radians( (Nr+0.5)*DTies_Angle )) -( DT_X   > Heart_Distance+0.1 & DT_X <Heart_Distance*1.2 )*(RBaT+Tween)>} 
     //sphere{ <0,0.1,0>,0.2 pigment  { Green } 
     object{ Rail_Spike 
        scale<1,1,-1> translate<(DTies_Rail_Radius+RB/2)*sin(radians((Nr+0.5)* DTies_Angle)),SH,( RB*1 +RailRadius)*cos(radians( (Nr+0.5)*DTies_Angle ))>} 

     #end 

     #if ( ( DT_X   < Heart_Distance/10) ) 
     // sphere{ <0,0.1,0>,0.2 pigment  { Blue } 
        object{ Rail_Spike scale<1,1, 1> translate<(DTies_Rail_Radius+RB/2)*sin(radians((Nr+0.5)* DTies_Angle)),SH,( RB*1 +RailRadius)*cos(radians( (Nr+0.5)*DTies_Angle ))>} 
     #end 


 #local Nr = Nr + 1;  #end // ---------------  end of loop 
#end // of '#if( Rail_Spikes_On = 1 )' 

 // ties on round track //new
 #local Nr = 0 ;     // start
 #while (Nr< Rest_R_Number) 
  object{ RTie translate<0,0,RailRadius>  rotate<0,R_Ties_Start_Angle+ (Nr+0.5)* RTies_Angle_2,0>} 
 #local Nr = Nr + 1;  #end // ---------------  end of loop 

 // ties on straight track
 #local Nr = DTies_Round_Number_ -(Rail___Length_>22.3);     // start
 #local EndNr = LTies_Linear_Number_+1 ; // end value
 #while (Nr< EndNr) 
  object{ RTie translate<(Nr-0.5)*LTies_Distance,0,RailRadius>}
 #local Nr = Nr + 1; #end // end of loop 


translate<0,0,-Switch_Radius_>
} // 3 end of union

//--------------------------------------------------------------- Linear Rails
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
#include "RT_System/RT_Track_Switch_A_00.inc"  // returns: "Switch_Radius_" and "Rail_Distance_"
//--------------------------------------------------------------------------
//#declare Rail_Spikes_On = 1;
object{ RT_Track_Switch_A_00( 1,  // direction:   0 straight ~ 1 round (save for 0< x <1)
                              15, // Switch_Length, // Rail___Length_,
                              20, // Switch_Angle_, 
                              1.5 // Ties_Per_Meter_  // ~1.5
                          ) //------------------------------------------------------- 
        rotate<0,0,0>  
        translate<0,0,0 >  
} //--------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
*/


#version RT_Track_Switch_A_00_Inc_Temp;
#end
//------------------------------------- end of include file

