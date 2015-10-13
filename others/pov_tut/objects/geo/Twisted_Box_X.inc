// POV-Ray 3.6 / 3.7 include file "Twisted_Box_X.inc"
// author: Friedrich A, Lohmueller, 29-Sept-2012, Nov-2012
// homepage: http://www.f-lohmueller.de/
// email: Friedrich.Lohmueller_aT_t-online.de
//--------------------------------------------------------------------------------------
#ifndef( Twisted_Box_X_Inc_Temp)
#declare Twisted_Box_X_Inc_Temp = version;
#version 3.6;

//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//----------------------------------------------------------------------------- /////////  

#macro Twisted_Box_X (     Start_Heigth_y_, //start height in y, // ~ 1.0,  
                           Start_Width_z_,  // start width in z, // ~ 0.1;
                           N_, // number of turns  ~  90/360,  // i.e. 0.25 = 45° 
                           Twist_Length_, // length of twisted part // ~3 
                           Start_Length_, // length of linear start; >=0, 0 =non
                           End_Length_  , // length of linear end;   >=0, 0 =non
                           Max_Gradient, // ~ 2 or higher(=slower!), increase it, to avoid holes!  
                        ) //---------------------------------------------------------------------
//----------------------------------------------------------------------------------
#local D= 0.000001; 
//----------------------------------------------------------------------------------
#local Start_Heigth_y = Start_Heigth_y_; 
#local Start_Width_z = Start_Width_z_; 
#local N = N_; 
#local Twist_Length = Twist_Length_; 
#local Start_Length = Start_Length_;
#local End_Length = End_Length_;


//----------------------------------------------------------------------------------
#if(Start_Heigth_y<0)  
 #warning "start height in y was < 0, should be >0, converted to abs(start height in y)\n" 
 #local Start_Heigth_y = abs(Start_Heigth_y); 
#end
#if(Start_Width_z<0)   
 #warning "start width in z was < 0, should be >0, converted to abs(start width in z)\n" 
 #local Start_Width_z  = abs(Start_Width_z); 
#end

#if(Start_Heigth_y=0)  
 #warning "start height in y was = 0, should be >0, set to 0.000001\n" 
 #local Start_Heigth_y = D; 
#end
#if(Start_Width_z=0)   
 #warning "start width in z was = 0, should be >0, set to 0.000001\n" 
 #local Start_Width_z  = D;
#end


#if(Start_Length<0)  
 #warning "start length was < 0, should be >=0, converted to abs(start length)\n" 
 #local Start_Length = abs(Start_Length); 
#end
#if(End_Length<0)   
 #warning "  end length was < 0, should be >=0, converted to abs(end length)\n" 
 #local End_Length   = abs(End_Length); 
#end

#if(Start_Heigth_y >= Start_Width_z)
 #local Scale = Start_Heigth_y/2;   

 #local Start_y = 1;  
 #local Start_z = Start_Width_z/2*1/Scale ;  
 #local Start_By = Start_Heigth_y/2  ;
 #local Start_Bz = Start_Width_z/2  ;  

 #local Turnfag = 0;
#else 
 #local Scale = Start_Width_z/2;   
 #local Start_y = 1;  
 #local Start_z = Start_Heigth_y/2*1/Scale ;

 #local Start_By = Start_Width_z/2 ;
 #local Start_Bz = Start_Heigth_y/2 ;
 #local Turnfag = 1;
#end 

#local CBox_Max = max(Start_y,Start_z)*1.42; 
//----------------------------------------------------------------------------------
//----------------------------------------------------------------------------------
#local fn_A=function{abs(x)-Start_y};
#local fn_B=function{abs(z)-Start_z};
#local fn_C=function{abs(y)-Start_y};

#local fn_Smooth = function(x) {x*x*x*(10+x*(6*x-15))}
#local fn_Twist_y= function{z*sin(fn_Smooth(x)*2*pi*N) + y*cos(fn_Smooth(x)*2*pi*N)};
#local fn_Twist_z= function{z*cos(fn_Smooth(x)*2*pi*N) - y*sin(fn_Smooth(x)*2*pi*N)};
//-----------------------------------------------------------------------------------
union{  // final union
 isosurface {
   function {
   max(
     fn_A(x-0.5 ,y,z),
     fn_B(x,fn_Twist_y(x,y,z),fn_Twist_z(x,y,z)),
     fn_C(x,fn_Twist_y(x,y,z),fn_Twist_z(x,y,z))
     )
   } //-------------------------------------------------------------------
   contained_by {box{< 0, -CBox_Max,-CBox_Max>,< 1, CBox_Max, CBox_Max>}}
   threshold 0
   accuracy 0.0000001
   max_gradient abs(Max_Gradient)
  //  max_trace 5
scale<Twist_Length,Scale,Scale> translate< Start_Length,0,0> 
}
 box{ < 0,-Start_By,-Start_Bz>,< Start_Length+D,Start_By,Start_Bz> } 
 box{ <-D,-Start_By,-Start_Bz>,< End_Length    ,Start_By,Start_Bz>  
      rotate<N*360,0,0> translate<Twist_Length+Start_Length,0,0>} 
 
 #if(Turnfag = 1)
 rotate<90,0,0>
 #end 
} // end of final union
// -------------------------------------------------------------------------------------- 
#end// of macro ----------------------------------------------------------// end of macro




//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
// sample: 
/*
//----------------------------------------------------------------------------------//
//----------------------------------------------------------------------------------//
#include "Twisted_Box_X.inc"
//------------------------------------------------------------------------------------
object{ Twisted_Box_X(     1.00, // start height in y, // ~ 1.0,  
                           0.10, // start width in z, // ~ 0.1;
                         30/360, // number of turns: Angel/360, or i.e. 0.25 = 45° 
                           3.00, // length of twisted part // ~3 // ca. >2*min( start height in y, start width in z )
                           0.50, // length of linear start; >=0, 0 =non
                           0.50, // length of linear end;   >=0, 0 =non
                           4, // Max_Gradient, // ~ 2 or higher(=slower!), increase it, to avoid holes!  
                     ) //--------------------------------------------
        texture{ pigment{ color rgb< 1, 1, 1>*0.85 } //  color Gray85
               // normal { bumps 0.5 scale 0.05 }
                 finish { phong 1 reflection 0.00}
               } // end of texture 
        scale<1,1,1>
        rotate<0,0,0>
        translate<0,0,0>
} //---------------------------------------------------------------------------------//  
//-----------------------------------------------------------------------------------//
//-----------------------------------------------------------------------------------//
*/


#version Twisted_Box_X_Inc_Temp;
#end
//------------------------------------- end of include file

