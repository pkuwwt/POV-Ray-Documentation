// POV-Ray 3.6 / 3.7 include file "RT_Track_Straight_00.inc"                                                        // author: Friedrich A, Lohmueller, Feb-2011, April-2013
// homepage: http://www.f-lohmueller.de/
// email: Friedrich.Lohmueller_aT_t-online.de
//------------------------------------------------------------------------
#ifndef( RT_Track_Straight_00_Inc_Temp)
#declare RT_Track_Straight_00_Inc_Temp = version;
#version 3.6;

//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
#ifndef(  Colors_Inc_Temp)
#include "colors.inc"                                             
#end
#ifndef(  Textures_Inc_Temp)
#include "textures.inc"                                             
#end

//------------------------------------------------------------------------------ /////////
//------------------------------------------------------------------------------ /////////
//------------------------------------------------------------------------------ /////////  
#macro RT_Track_Straight_00(  Rail___Length_,  // in x+ in meter
                              Ties_Per_Meter_  // ~1.5 number per meter
                           ) //------------------------------------------------- 
//------------------------------------------------------------- default textures 
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
                               normal { bumps 0.75 scale 0.005 scale<1,1,10>}}
#end
//---------------------------------------------------------------------------------------
//----------------------------------------------------------------------- Gauche & Heigth
#ifndef (           RR_System_Sizes_00_Inc_Temp )
#include "RR_System/RR_System_Sizes_00.inc"
#end 
//--------------------------------------------------------------------------------------- 
#local D = 0.00001;
//--------------------------------------------------------------------------------------- 
#ifndef ( Rail_Spikes_On )
#declare Rail_Spikes_On = 0; 
#end //----------------------------------------------------------------------------------
#if( Rail_Spikes_On = 1 ) 

#local Spike_Big  = 
union{ 
  object{ Hexagon scale <0.5,1,1> translate<0.5,0,0> rotate<0,0,90> scale<1,1,1>*0.05 texture{Railtex1} translate<0,0.020,0>} 
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
//---------------------------------------------------------------------------------------
// Number and distance of ties/sleepers - Anzahlen und Abstand der Schwellen:
#local Ties_Number = int(abs(Rail___Length_)*Ties_Per_Meter_);
#local Ties_New_Per_Meter__ = Ties_Number/(Rail___Length_+0.0000001); 
#local Ties_Distance = 1/(Ties_New_Per_Meter__)+0.0000001; // equidistant distribution !!! 
                                 // Verteilt Schwellen gleichmäßig über Länge!!!
// --------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//--------------------------------------------------------------- Ties/Sleepers - Schwellen 
#local Tie = union{
 box {<-SD/2+D,0  ,-SB+D>,< SD/2-D,SH  ,SB-D> texture{Tietex1}}
 box {<-SD/2  ,0+D,-SB+D>,< SD/2  ,SH-D,SB-D> texture{Tietex2}}
 box {<-SD/2+D,0+D,-SB  >,< SD/2-D,SH-D,SB  > texture{Tietex3}}
 #if ( Rail_Spikes_On = 1 )
 object{ Rail_Spike translate<0,SH,-RB>}
 object{ Rail_Spike  scale<1,1,-1> translate<0,SH,-RB>}
 object{ Rail_Spike  translate<0,SH, RB>}
 object{ Rail_Spike  scale<1,1,-1> translate<0,SH, RB>}
 #end 
}
//--------------------------------------------------------------- Linear Rail - Gerade Schiene 
#macro Rail_line_X(Rail_Len)   //-------------------------------- 
#local D = 0.0001;
union{ 
 cylinder {< 0,0,0>,<Rail_Len  ,0,0>,RToR scale <1,RToS,1> translate<0,RBoH,0> texture{RailToptex}} //head - Kopf
 cylinder {<-D,0,0>,<Rail_Len+D,0,0>,RToR scale <1,RToS,1> translate<0,RBoH-D,0> texture{Railtex2}} //below head
 cylinder {<-D,0,0>,<Rail_Len+D,0,0>,RToR scale <1,RToS,1> translate<0,RBoH-0.02,0> texture{Railtex2}} //below head
 box {<0,RBoH-0.02,-RToR>,<Rail_Len,RBoH,RToR> texture{Railtex2}} // head - Kopf
 box {<0,0.00,-RBoT>,<Rail_Len,RBoH,RBoT> texture{Railtex1}} // web - Steg
 box {<0,0.00,-RBaT>,<Rail_Len,RBaH,RBaT> texture{Railtex2}} // foot - Fuß
 } // union
#end // end sub macro
//---------------------------------------------------------------------------------------------------------------
//-------------------------------------------------------------------------<<<<<<<<<<<<<<                                                                                               
//-------------------------------------------------------------------------- final union
union{ 
       object{ Rail_line_X( Rail___Length_ ) translate<0.00,SH,-RB>}
       object{ Rail_line_X( Rail___Length_ ) translate<0.00,SH,-RB> scale<1,1,-1>}

       #local Nr = 0;     // start
       #local EndNr = Ties_Number; // end value
       #while (Nr< EndNr) 
        object{ Tie translate<(Nr+0.5)*Ties_Distance,0,0>}
       #local Nr = Nr + 1; 
       #end // end of loop 
// --------------------------------------------------------------------------------------
} // end of union -----------------------------------------------------------------------
#end// of macro ----------------------------------------------------------// end of macro
//---------------------------------------------------------------------------------------





//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
// sample: 
/*
//---------------------------------------------------------------------------------------
//-------------------------------------------------------------------------------------//
#include "RT_System/RT_Track_Straight_00.inc"  // straight track in x
//-------------------------------------------------------------------------------------// 
//#declare Rail_Spikes_On = 1;
object{ RT_Track_Straight_00( 10.00, // Rail___Length_,  // in x+ in meter
                               1.5, // Ties_Per_Meter_  // ~1.5 number per meter
                   ) //----------------------------------------------------------------//
        scale <1,1,1>*1
        rotate<0,0,0> 
        translate<0.00,0.00, 0.00>
      } //-----------------------------------------------------------------------------//
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
*/


#version RT_Track_Straight_00_Inc_Temp;
#end
//------------------------------------- end of include file

