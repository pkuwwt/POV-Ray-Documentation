// POV-Ray 3.6 / 3.7 include file "Caterpillar_Crane_01.inc"
// author: Friedrich A, Lohmueller, Jan-2006 / May-2014
// homepage: http://www.f-lohmueller.de/
// email: Friedrich.Lohmueller_aT_t-online.de
//------------------------------------------------------------------------
#ifndef( Caterpillar_Crane_01_Inc_Temp)
#declare Caterpillar_Crane_01_Inc_Temp = version;
#version 3.6;

//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
#ifndef(  Shapes_Inc_Temp)
#include "shapes.inc"                                             
#end
#ifndef(  Shapes3_Inc_Temp)
#include "shapes3.inc"                                             
#end
#ifndef(  Track_Chain_0_Inc_Temp)
#include "Track_Chain_0.inc"                                             
#end
#ifndef(  Mast_1_Inc_Temp)
#include "Mast_1.inc" 
#end
//------------------------------------------------------------------------------ /////////  
//------------------------------------------------------------------------------ /////////  
//-----------------------------------------------------------------------------
#macro Caterpillar_Crane_01 (  Crane_Head_Rotation_, // degrees
                               Jib_Angle_,  // 0~70 degrees   winkel des Auslegers !!!
                               Scoop_Open_Angle_, // 0 ~80 degrees
                               Vertical_Cable_Length_, // for scoop at jib
                               
                               Body_Texture_,  // 
                               Body_Inside_Texture_,  // 
                               Chassis_Texture_,  // 
                               Scoop_Texture_,  // 
                               Cable_Texture_,  // 
                               Chain_Color_,  // base color of the chains  
                               Wheel_Texture_, //  texture of the wheels  
                               Mast_Texture_
                            )  //------------------------------------------
//----------------------------------------------
#local D = 0.0001;
//----------------------------------------------
#if (Scoop_Open_Angle_ >65) #local Scoop_Open_Angle_ = 65; #end
#if (Scoop_Open_Angle_ < 0) #local Scoop_Open_Angle_ =  0; #end
#if (Jib_Angle_ >55) #local Jib_Angle_ = 55; #end
#if (Jib_Angle_ < 0) #local Jib_Angle_ =  0; #end
#if (Vertical_Cable_Length_ < 1.00) #local Vertical_Cable_Length_ = 1.00; #end
//----------------------------------------------
#local Chain_Length =  2.35; // > 4*Chain_Radius; total legth in x
#local Chain_Radius =  0.30; // half total height in y 
#local Chain_Depth  =  0.45; // depth in z 

#local Track_Width_Z = 0.75; // half width of the tracks  (middle distance to <0,0,0>}                     
#local Crane_Z   = Track_Width_Z+Chain_Depth/2-0.05 ; // half width of the crane body                   
#local Crane_X   = (3.20/2-Chain_Radius+0.20)*0.8; // half width of the Bulldozer                      
#local Crane_Y   = 1.60; // height of the crane body                      
#local Chassis_Z = Track_Width_Z- Chain_Depth/2-0.05; // base height of chassis
#local Chassis_X = 3.20/2-Chain_Radius-0.15; // base height of chassis
#local Chassis_Y = 0.10; // base height of chassis
#local Body_Base_Y = Chain_Radius+0.05;// height over middle of track chains  

#local Cable_Y_at_Scope_ = 0.70;
#local BBR = 0.10; // Body_Border_Radius; 
//----------------------------------------------
#local Exhaust =
union{ //#macro Segment_of_Torus( R_major, R_minor, Segment_Angle)

 object{ Segment_of_Torus( 0.10, 0.03, 90)  scale <1,1,1>
         rotate<-90,0,0> translate<0,0.10,0>
       } // end of Torus_Segment(...) -----------------------              
 cylinder{ <0,0,0>,<0,0.90,0>,0.03 open translate<0.10,0.10,0>} 
 texture { Scoop_Texture }  
} // end of exhaust
//----------------------------------------------------------------------------------------// 
//--------------------------------------------------------------------- sub macro Body_Shape 
#macro Body_Shape ( Subtr_, Start_X,End_X, Start_Z, End_Z ) // 
intersection{ 
object{ // Round_Box(A, B, WireRadius, UseMerge)
        Round_Box(< Start_X+Subtr_,        +Subtr_,Start_Z+Subtr_>,
                  < End_X  -Subtr_, Crane_Y-Subtr_,  End_Z-Subtr_>, BBR-Subtr_   , 0)  
      } // ---------------------------------------------------------

object{ // Round_Box(A, B, WireRadius, UseMerge)
        Round_Box(< Start_X   +Subtr_,        -D+Subtr_,Start_Z+Subtr_+D>,
                  < End_X*1.36-Subtr_, Crane_Y+D-Subtr_,  End_Z-Subtr_-D>, BBR-Subtr_  , 0)  
        matrix<  1  , 0, 0, //  matrix-shear_y_to_x
               -0.80, 1, 0,
                 0  , 0, 1,
                 0  , 0, 0>
      } // ---------------------------------------------------------
} #end // ---------------------------------------------------------- end of sub macro  
//-------------------------------------------------------------------------------------------
#local Grill_X = 
union{ 
 #local Nr = 0;     // start
 #while (Nr< 10) 
 intersection{ 
   cylinder{<-0.25 ,0,0>,<0.25 ,0,0>,0.04}
   cylinder{<-0.245,0,0>,<0.245,0,0>,0.035 inverse}
   box{<-0.25,0,-0.05>,<0.25,0.05,0> } 
   translate<0,0.05*Nr,0> 
  }// end of inters
 #local Nr = Nr + 1;  // next Nr
 #end // --------------- end of loop 
 texture{ Body_Texture_} 
}// end Grill

//----------------------------------------------------------------------------------------// 
//----------------------------------------------------------------------------------------// 
//-------------------------------------------------------------------------- Jib positions !!!! 
#local TR_ =  0.020; // tube main radius 
#local TRd =  0.013; //  tube diagonals radius

#local Segments_Raster_ = 0.60;
#local Number_of_Segments_ = 11; // int( Number_of_Jib_Segments_); 
  #if (Number_of_Segments_<3) #local Number_of_Segments_=3 ; #end
#local Jib_Length = Number_of_Segments_*  (Segments_Raster_+1.5*TR_); //???? !


#local Jib_Start_Position = < Crane_X,Chain_Radius+Body_Base_Y,0>;  
#local Jib_End_Position =    // vrotate( V ,<Rotate_X, Rotate_Y, Rotate_Z>) 
  // = Rotate V about origin by rotation vector <Rotate_X, Rotate_Y, Rotate_Z>
  vrotate( < Jib_Length,0,0>, // vector
           < 0,0,Jib_Angle_> )  // rotation
  + Jib_Start_Position ;  
// ----------------------------------
#local Mast_Holder_Position =   vrotate(< Jib_Length-Segments_Raster_,+Segments_Raster_/2,0>, // vector
           < 0,0,Jib_Angle_> )+ Jib_Start_Position ;  // rotation 
#local Mast_Holder_Start_Position =    <-Crane_X,Crane_Y+Chain_Radius+Body_Base_Y+0.35,0>;  // backside roof of body 

#local Mast_Holder_Vector = 
 <Mast_Holder_Position.x-Mast_Holder_Start_Position.x, Mast_Holder_Position.y-Mast_Holder_Start_Position.y,0>; 

#local Mast_Holder_Angle_Z = degrees( atan2( Mast_Holder_Vector.y,  Mast_Holder_Vector.x));  



//---------------------------------------------------------------------------- submacro Jib (Ausleger)
#local Jib_ = union{ // vertically constructed in y! 

 object{ Mast_1(   Number_of_Segments_-2, // number of segments * segment height = total height 
                  Segments_Raster_+2*TR_, // segment_height
                  Segments_Raster_/2+TR_, // half width (outline!)
                  TR_,  // R1, tube main radius
                  TRd   // R2, tube diagonals radius 
                                 
                 ) //------------------------------------------------------------------//
        translate<0.00,Segments_Raster_-TR_, 0.00>}
 // base 
 cylinder{ <0,0,Segments_Raster_/2+0.02>,< 0,0, Segments_Raster_/2+0.06>, 2*TR_ }  // base end  z+
 cylinder{ <0,0,Segments_Raster_/2+0.02>,< 0,0, Segments_Raster_/2+0.06>, 2*TR_ scale<1,1,-1>}  // base end  z-
 
 // 
 cylinder{ <0,0, Segments_Raster_/2+0.07>,< 0,0,-Segments_Raster_/2-0.07>, TR_ }  // base in z
 cylinder{ <0,0, Segments_Raster_/2>,< Segments_Raster_/2,Segments_Raster_,Segments_Raster_/2>, TR_ } 
 cylinder{ <0,0, Segments_Raster_/2>,<-Segments_Raster_/2,Segments_Raster_,Segments_Raster_/2>, TR_ } 
 cylinder{ <0,0,-Segments_Raster_/2>,< Segments_Raster_/2,Segments_Raster_,-Segments_Raster_/2>, TR_ } 
 cylinder{ <0,0,-Segments_Raster_/2>,<-Segments_Raster_/2,Segments_Raster_,-Segments_Raster_/2>, TR_ } 
 union{ 
 cylinder{ <0,0, Segments_Raster_/2>,< 0,0,-Segments_Raster_/2>, TR_ }  // base in z
 cylinder{ <0,0, Segments_Raster_/2>,< Segments_Raster_/2,Segments_Raster_,Segments_Raster_/2>, TR_ } 
 cylinder{ <0,0, Segments_Raster_/2>,<-Segments_Raster_/2,Segments_Raster_,Segments_Raster_/2>, TR_ } 
 cylinder{ <0,0,-Segments_Raster_/2>,< Segments_Raster_/2,Segments_Raster_,-Segments_Raster_/2>, TR_ } 
 cylinder{ <0,0,-Segments_Raster_/2>,<-Segments_Raster_/2,Segments_Raster_,-Segments_Raster_/2>, TR_ } 
 scale<1,-1,1> translate<0, Jib_Length,0> }

 texture { Mast_Texture }
 rotate<0,0,0> 
 translate<0.00,0.00, 0.00> 
 } // end of union Jib_
//-------------------------------------------------------------------------------------//
//---------------------------------------------------------------------------------------
#macro Scoop_( Scoop_Open_Angle___ // scoop open angle
               Scoop_Z, // half width in z 
               Scoop_R, // radius xy 
               Cable_Y_at_Scope___
             ) //------------------------------------------  
#local Cable_Y = Cable_Y_at_Scope___;
#local Steal_D = 0.01; 
#local Cable_R = 0.005; 
#local Scoop_Element_X = 
union{ 
 intersection{ 
  cylinder{ <0,0,- Scoop_Z>,<0,0, Scoop_Z>,Scoop_R } 
  cylinder{ <0,0,- Scoop_Z+Steal_D>,<0,0, Scoop_Z-Steal_D>,Scoop_R-Steal_D inverse} 
  box{ <0,-1.5*Scoop_R,- Scoop_Z-Steal_D>,<Scoop_R,0, Scoop_Z+Steal_D>
     matrix<1, 0.25, 0, // matrix-shear_x_to_y
            0,  1,  0,
            0,  0,  1,
            0,  0,  0>}    
 } // end of intersection 
 // dents:
 #local Nr= -5; #while (Nr< 6)  // start loop
 sphere{<0,0,0>,0.015 scale <3,1,1> rotate<0,0,0> translate<-0.00,-Scoop_R,Nr*2*Scoop_R/11+0.02>} 
 #local Nr = Nr + 1;  #end // --------------- end of loop 

} // end of union 
//--------------------------
#local Scoop_Outer_Position = vrotate( < Scoop_R*cos(atan2(0.25,1)),Scoop_R*sin(atan2(0.25,1)),0>, // vector
                                       < 0,0,Scoop_Open_Angle___> );  // rotation
//--------------------------
union{
 union{ // scoop
 cylinder{  <0,0,- Scoop_Z-Steal_D>,<0,0, Scoop_Z+Steal_D>, 3*Steal_D } 
 object{ Scoop_Element_X rotate<0,0,Scoop_Open_Angle___>} 
 object{ Scoop_Element_X rotate<0,0,Scoop_Open_Angle___> scale<-1,1,-1>} 
 texture{  Scoop_Texture_ } 
 } //
 // connection Base to cabelcenter
 cylinder{  <0,Cable_Y,Scoop_Z/2>,<0,0,Scoop_Z*0.9>, Cable_R  texture{ Cable_Texture_ } } 
 cylinder{  <0,Cable_Y,Scoop_Z/2>,<0,0,Scoop_Z*0.9>, Cable_R  texture{ Cable_Texture_ } scale<1,1,-1>} 

 // cables: fixed in height Cable_Y
 cylinder{  <0,0,Scoop_Z>,<0,Cable_Y,Scoop_Z/2>, Cable_R  texture{ Cable_Texture_ } } 

 cylinder{  <0,0,- Scoop_Z/2-Steal_D>,<0,0, Scoop_Z/2+Steal_D>, 2*Steal_D translate<0,Cable_Y,0> texture{  Scoop_Texture_ }  } 

 cylinder{  <0,Cable_Y,Scoop_Z/2>,Scoop_Outer_Position+<0,0,Scoop_Z/2>, Cable_R  texture{ Cable_Texture_ } } 
 cylinder{  <0,Cable_Y,Scoop_Z/2>,Scoop_Outer_Position+<0,0,Scoop_Z/2>, Cable_R scale<-1,1,1>texture{ Cable_Texture_ } } 
 cylinder{  <0,Cable_Y,Scoop_Z/2>,Scoop_Outer_Position+<0,0,Scoop_Z/2>, Cable_R scale< 1,1,-1>texture{ Cable_Texture_ } } 
 cylinder{  <0,Cable_Y,Scoop_Z/2>,Scoop_Outer_Position+<0,0,Scoop_Z/2>, Cable_R scale<-1,1,-1>texture{ Cable_Texture_ } } 


} // end of union 
#end // ---------------------------- end sub macro                                       

#macro Cables_with_Pulleys ( Cable_R_ //= 0.005; 
                             Cable_Len_ 
                             Pulley_R_ 
                           ) //-----------------
union{ 
  // lower pulleys
  cylinder{ <0,0,-1.25*Cable_R_>,<0,0,1.5*Cable_R_>,Pulley_R_ translate<0,0, 14*Cable_R_> } 
  cylinder{ <0,0,-1.25*Cable_R_>,<0,0,1.5*Cable_R_>,Pulley_R_ translate<0,0,  7*Cable_R_> } 
  cylinder{ <0,0,-1.25*Cable_R_>,<0,0,1.5*Cable_R_>,Pulley_R_ translate<0,0,  0> } 
  cylinder{ <0,0,-1.25*Cable_R_>,<0,0,1.5*Cable_R_>,Pulley_R_ translate<0,0, -7*Cable_R_> } 
  cylinder{ <0,0,-1.25*Cable_R_>,<0,0,1.5*Cable_R_>,Pulley_R_ translate<0,0,-14*Cable_R_> } 
  // higher pulleys
  cylinder{ <0,0,-1.25*Cable_R_>,<0,0,1.5*Cable_R_>,Pulley_R_ translate<0,Cable_Len_ , 14*Cable_R_> } 
  cylinder{ <0,0,-1.25*Cable_R_>,<0,0,1.5*Cable_R_>,Pulley_R_ translate<0,Cable_Len_ ,  7*Cable_R_> } 
  cylinder{ <0,0,-1.25*Cable_R_>,<0,0,1.5*Cable_R_>,Pulley_R_ translate<0,Cable_Len_ ,  0> } 
  cylinder{ <0,0,-1.25*Cable_R_>,<0,0,1.5*Cable_R_>,Pulley_R_ translate<0,Cable_Len_ , -7*Cable_R_> } 
  cylinder{ <0,0,-1.25*Cable_R_>,<0,0,1.5*Cable_R_>,Pulley_R_ translate<0,Cable_Len_ ,-14*Cable_R_> } 
  // 6 cables 
  cylinder{ <0,0,0>,<0,Cable_Len_,0>,Cable_R_ translate<Pulley_R_,0, 14*Cable_R_> } 
  cylinder{ <0,0,0>,<0,Cable_Len_,0>,Cable_R_ translate<Pulley_R_,0,  7*Cable_R_> } 
  cylinder{ <0,0,0>,<0,Cable_Len_,0>,Cable_R_ translate<Pulley_R_,0,  0> } 
  cylinder{ <0,0,0>,<0,Cable_Len_,0>,Cable_R_ translate<Pulley_R_,0, -7*Cable_R_> } 
  cylinder{ <0,0,0>,<0,Cable_Len_,0>,Cable_R_ translate<Pulley_R_,0,-14*Cable_R_> } 

  cylinder{ <0,0,0>,<0,Cable_Len_,0>,Cable_R_ translate<-Pulley_R_,0, 14*Cable_R_> } 
  cylinder{ <0,0,0>,<0,Cable_Len_,0>,Cable_R_ translate<-Pulley_R_,0,  7*Cable_R_> } 
  cylinder{ <0,0,0>,<0,Cable_Len_,0>,Cable_R_ translate<-Pulley_R_,0,  0> } 
  cylinder{ <0,0,0>,<0,Cable_Len_,0>,Cable_R_ translate<-Pulley_R_,0, -7*Cable_R_> } 
  cylinder{ <0,0,0>,<0,Cable_Len_,0>,Cable_R_ translate<-Pulley_R_,0,-14*Cable_R_> } 

texture{ Cable_Texture_ }
} 
#end //-----------------------------------------


//--------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------
//-------------------------------------------------------------------------------------- construction 
union{
        //---------------------------------------------------------------------- track chains 
object{ Track_Chain_0( Chain_Length, // Chain_Length > 4*Chain_Radius; total legth in x
                       Chain_Radius, // Chain_Radius,  // half total height in y 
                       Chain_Depth, // Chain_Depth__,   // depth in z 
                       Chain_Color,   // base color of the chains  
                       Wheel_Texture   //  texture of the wheels  
                     ) //----------------------------------------- 
        scale <1,1,1> 
        rotate<0,0,0> 
        translate<0,0,-Track_Width_Z> }//---------------------------------------------------
object{ Track_Chain_0( Chain_Length, // Chain_Length > 4*Chain_Radius; total legth in x
                       Chain_Radius, // Chain_Radius,  // half total height in y 
                       Chain_Depth, // Chain_Depth__,   // depth in z 
                       Chain_Color,   // base color of the chains  
                       Wheel_Texture   //  texture of the wheels  
                     ) //----------------------------------------- 
        scale <1,1,1> 
        rotate<0,0,0> 
        translate<0,0, Track_Width_Z> }//---------------------------------------------------
//----------------------------------------------------------------------------- chassis
object{ // Round_Box(A, B, WireRadius, UseMerge)
        Round_Box(<-Chassis_X ,-Chassis_Y,-Chassis_Z>,<Chassis_X ,Chassis_Y,Chassis_Z>, 0.05   , 0)  
         
        texture{ Chassis_Texture_} 
        scale<1,1,1>  rotate<0, 0,0> translate<0,Chain_Radius,0>
      } // ---------------------------------------------------------
cylinder{ <0,0,0>,<0,Body_Base_Y,0>, Chassis_Z
          texture{ Chassis_Texture_} 
          translate<0,Chain_Radius,0>} 
//------------------------------------------------------------------------------
// Front 
union{ 

 difference{  //------------------------------------------------------ cran body !!!!!
 
   object{ Body_Shape ( 0, -Crane_X,Crane_X,-Crane_Z, Crane_Z ) 
           texture{ Body_Texture_} 
           translate<0,Chain_Radius+Body_Base_Y,0>} 
   object{ Body_Shape ( 0.01, -Crane_X,Crane_X,-Crane_Z, Crane_Z ) 
           texture{ Body_Inside_Texture_} 
           translate<0,Chain_Radius+Body_Base_Y,0>} 

intersection{  // ---------------------------------------------------- side window holes from right to left
   object{ // Round_Box(A, B, WireRadius, UseMerge)
        Round_Box(<-0.35, BBR         ,-Crane_Z-0.20>,
                  < 0.62, Crane_Y-BBR , Crane_Z+0.20>, 0.05   , 0)  
        texture{ Body_Texture_} 
      } // ---------------------------------------------------------
   object{ // Round_Box(A, B, WireRadius, UseMerge)
        Round_Box(<-0.45, BBR         ,-Crane_Z-0.20>,
                  < 1.05, Crane_Y-BBR , Crane_Z+0.20>, 0.05   , 0)  
        texture{ Body_Texture_} 
        matrix<  1  , 0, 0, //  matrix-shear_y_to_x
               -0.80, 1, 0,
                 0  , 0, 1,
                 0  , 0, 0>
      } // ---------------------------------------------------------
   box{ <-0.35,0.02,-Crane_Z-0.20>,<0.95,-0.02,Crane_Z+0.20> translate<0,Crane_Y*2/3,0> 
         texture{ Body_Texture_} 
        inverse  
      } // ---------------------------------------------------------
   box{ <-0.35,0.02,-Crane_Z-0.20>,<0.95,-0.02,Crane_Z+0.20> translate<0,Crane_Y*1/3,0> 
         texture{ Body_Texture_} 
        inverse  
      } // ---------------------------------------------------------
   box{ <-0.02, 0,-Crane_Z-0.20>,<0.02,Crane_Y,Crane_Z+0.20> translate<0.18,0,0> 
         texture{ Body_Texture_} 
        inverse  
      } // ---------------------------------------------------------

 translate< 0.50,Chain_Radius+Body_Base_Y,0>
 } // end intersection
 union{   //----------------------------------------- front glass holes
   box{ <0, Crane_Y*2/3+0.02,-Crane_Z+BBR >,<2,Crane_Y-BBR+0.03,-Crane_Z/3-0.04> 
      } // ---------------------------------------------------------
   box{ <0, Crane_Y*1/3+0.02,-Crane_Z+BBR >,<2,Crane_Y*2/3-0.02,-Crane_Z/3-0.04>  
      } // ---------------------------------------------------------
   box{ <0,         BBR+0.05,-Crane_Z+BBR >,<2,Crane_Y*1/3-0.02,-Crane_Z/3-0.04>  
      } // ---------------------------------------------------------
   box{ <0, Crane_Y*2/3+0.02,-Crane_Z/3 >,<2,Crane_Y-BBR+0.03, Crane_Z/3> 
      } // ---------------------------------------------------------
   box{ <0, Crane_Y*1/3+0.02,-Crane_Z/3 >,<2,Crane_Y*2/3-0.02, Crane_Z/3>  
      } // ---------------------------------------------------------
   box{ <0,         BBR+0.05,-Crane_Z/3 >,<2,Crane_Y*1/3-0.02, Crane_Z/3>  
      } // ---------------------------------------------------------
   box{ <0, Crane_Y*2/3+0.02,-Crane_Z+BBR >,<2,Crane_Y-BBR+0.03,-Crane_Z/3-0.04> scale<1,1,-1> 
      } // ---------------------------------------------------------
   box{ <0, Crane_Y*1/3+0.02,-Crane_Z+BBR >,<2,Crane_Y*2/3-0.02,-Crane_Z/3-0.04> scale<1,1,-1>   
      } // ---------------------------------------------------------
   box{ <0,         BBR+0.05,-Crane_Z+BBR >,<2,Crane_Y*1/3-0.02,-Crane_Z/3-0.04> scale<1,1,-1>  
      } // ---------------------------------------------------------

  translate<0,Chain_Radius+Body_Base_Y,0> 
  texture{ Body_Texture_} 
  } // end inner union
 } // end of diff
//---------------------------------------------------------  grills
 // right left
 object{ Grill_X rotate<0,0,0> translate<-Crane_X+0.37,Chain_Radius+Body_Base_Y+0.20,-Crane_Z>}
 object{ Grill_X rotate<0,0,0> translate<-Crane_X+0.37,Chain_Radius+Body_Base_Y+0.20,-Crane_Z> scale<1,1,-1>}
 // backside
 object{ Grill_X rotate<0,90,0> translate<-Crane_X,Chain_Radius+Body_Base_Y+0.20,-Crane_Z/2>}
 //object{ Grill_X rotate<0,90,0> translate<-Crane_X,Chain_Radius+Body_Base_Y+0.90,-Crane_Z/2>}
 object{ Grill_X rotate<0,90,0> translate<-Crane_X,Chain_Radius+Body_Base_Y+0.20, Crane_Z/2>}
 object{ Grill_X rotate<0,90,0> translate<-Crane_X,Chain_Radius+Body_Base_Y+0.90, Crane_Z/2>}
//-------------------------------------------------------------- Exhaust

  object{ Exhaust rotate<0,180,0> translate<-Crane_X,Chain_Radius+Body_Base_Y+0.90,-Crane_Z/2-0.10> }
  object{ Exhaust rotate<0,180,0> translate<-Crane_X,Chain_Radius+Body_Base_Y+0.90,-Crane_Z/2-0.25> }

//--------------------------------------------------------- side door

   box{ <0, BBR+0.05 ,-Crane_Z-0.02 >,<0.55,Crane_Y-BBR-0.05,-Crane_Z+0.01> scale<1,1,1> 
         texture{ Body_Texture_} 
         translate<-0.55,Chain_Radius+Body_Base_Y,0> 
      } // ---------------------------------------------------------

//--------------------------------------------------------- glass kernel 
 difference{ 
 
   object{ Body_Shape ( 0.003, -Crane_X,Crane_X,-Crane_Z, Crane_Z )  } 
   object{ Body_Shape ( 0.006, -Crane_X,Crane_X,-Crane_Z, Crane_Z ) }

   translate<0,Chain_Radius+Body_Base_Y,0> 
    texture{ pigment{ rgbf <0.98, 0.98, 0.98, 0.9>*0.85 }
             finish { diffuse 0.1 reflection 0.2  
                      specular 0.8 roughness 0.0003 phong 1 phong_size 400}
           } // end of texture -------------------------------------------
 }// end difference of glass kernel

// ------------------------------------------------------------------------ Add Jib 
 object{ Jib_  rotate<0,0,-90+Jib_Angle_> translate  Jib_Start_Position }
 object{ Scoop_( Scoop_Open_Angle_,
                 0.40,// Scoop_Z, // half width in z 
                 0.40 // Scoop_R  // radius xy 
                 Cable_Y_at_Scope_ // 
               )   
         rotate<0,0,0> translate  Jib_End_Position - <0,Vertical_Cable_Length_,0> } 
 object{ Cables_with_Pulleys ( 0.005, // Cable_R_ //= 0.005; 
                               Vertical_Cable_Length_-Cable_Y_at_Scope_, 
                               0.070 // Pulley_R_ 
                             ) //-----------------
         rotate<0,0,0> translate  Jib_End_Position - <0,Vertical_Cable_Length_-Cable_Y_at_Scope_,0> } 

 object{ Cables_with_Pulleys ( 0.005, // Cable_R_ //= 0.005; 
                               vlength(Mast_Holder_Vector) , 
                               0.070 // Pulley_R_ 
                             ) //-----------------
          rotate<0,0,90+Mast_Holder_Angle_Z> 
 translate   Mast_Holder_Position  } 
 union{ // mast holders
 cylinder{ <0,0,-0.40>,<0, 0, 0.40>, 0.025 } 
 cylinder{ <0,0,-0.35>,<0,-1,-0.35>, 0.025 rotate<0,0,05> } 
 cylinder{ <0,0, 0.35>,<0,-1, 0.35>, 0.025 rotate<0,0,05> } 
 cylinder{ <0,0,-0.35>,<0,-1,-0.35>, 0.025 rotate<0,0,40> } 
 cylinder{ <0,0, 0.35>,<0,-1, 0.35>, 0.025 rotate<0,0,40> } 
 texture {Chassis_Texture_}
 translate   Mast_Holder_Start_Position  } 



rotate<0,Crane_Head_Rotation_,0> } // end of union Crane_Head !!1


} // end of global union 
//-----------------------------------------------------------------------------
// --------------------------------------------------------------------------------------
#end// of macro ------------------------------------------------------// end of macro




//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
// sample: 
/*
//-----------------------------------------------------------------------------
//------------------------------------------------------------------------------ textures
#local Body_Texture =  
        texture { pigment{ color rgb< 1.0, 0.65, 0.0> } //  deep yellow 
               // normal { bumps 0.5 scale 0.05 }
                  finish { phong 1 reflection 0.00}
                } // end of texture 
#local Body_Inside_Texture =  
        texture { pigment{ color rgb< 1.0, 0.65, 0.0>*0.7 } //  deep yellow 
               // normal { bumps 0.5 scale 0.05 }
                  finish { phong 1 reflection 0.00}
                } // end of texture 
#local Chassis_Texture =  
        texture { pigment{ color rgb< 1.0, 1, 1>*0.35 } //  gray
                  normal { bumps 0.15 scale 0.05 }
                  finish { phong 1 reflection 0.00}
                } // end of texture 
#local Scoop_Texture = 
        texture{ //Chrome_Metal
                 pigment{ color rgb< 1.0, 1, 1>*0.35 } //  gray
                 normal { bumps 0.5 scale 0.025}
                 finish { phong 1 }
               } // end of texture  
#local Cable_Texture = 
        texture{ //Chrome_Metal
                 pigment{ color rgb< 1.0, 1, 1>*0.55 } //  gray
                 normal { bumps 0.5 scale 0.025}
                 finish { phong 1 }
               } // end of texture  
#local Chain_Color =  
        color rgb< 1, 1, 1>*0.65;     // base color of the chains

#local Wheel_Texture =  
        texture { pigment{ color rgb< 1, 0.75, 0.50>*0.5 } // brown 
                  normal { bumps 0.5 scale 0.01 }
                  finish { phong 1 reflection 0.00}
                } // end of texture 
#local Mast_Texture = 
        texture { pigment{ color rgb<1,1,1>*0.45 } 
                  finish { phong 0.1} 
                } // end of texture
//-----------------------------------------------------------------------------
//----------------------------------------------------------------------------
#include "Caterpillar_Crane_01.inc"
//-----------------------------------------------------------------------------
object{ Caterpillar_Crane_01(  38,   // Crane_Head_Rotation in degrees
                               28,   // Jib_Angle, 0~55 degrees  //   winkel des Auslegers !!!
                               55,   // Scoop_Open, // 0 ~65 degrees
                               2.00, // >= 1.20 Vertical_Cable_Length for scoop at jib

                               Body_Texture,  // 
                               Body_Inside_Texture,  // 
                               Chassis_Texture,  // 
                               Scoop_Texture,  // 
                               Cable_Texture, //
                               Chain_Color,  // base color of the chains  
                               Wheel_Texture,  //  texture of the wheels
                               Mast_Texture  
                            )  //------------------------------------------
        scale <1,1,1>  
        rotate<0,-20,0> 
        translate<0,0,0> }//---------------------------------------------------
//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------
*/


#version Caterpillar_Crane_01_Inc_Temp;
#end
//------------------------------------- end of include file

