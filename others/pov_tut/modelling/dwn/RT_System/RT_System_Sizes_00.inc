// POV-Ray 3.6/3.7 include file "RT_System_Sizes_00.inc"                                                                                                                                                // PoVRay 3.6 include File "wheel_000.inc"
// author: Friedrich A, Lohmueller,  Nov-2010
// homepage: http://www.f-lohmueller.de/
// email: Friedrich.Lohmueller_aT_t-online.de
//------------------------------------------------------------------------
#ifndef( RT_System_Sizes_00_Inc_Temp)
#declare RT_System_Sizes_00_Inc_Temp = version;
#version 3.6;

//---------------------------------------------------------------------------------------
// Declarations of basic railroad sizes in meters
// Deklarationen von Eisenbahn Grundgroessen in Meter
// Dichiarazioni di misure di base della ferrovia 
// Déclarations des mesures fondamentaux de chemins de fer
//---------------------------------------------------------------------------------------
#ifndef( Gauge )                      // Spurweite, scartamento, ecartement, ancho
#declare Gauge = 1.435; // inner distance of rails
#end 
//#ifndef( Spurweite )
//#declare Spurweite = 1.435; //
//#end 
//---------------------------------------------------------------------------------------



//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------- european buffers
#ifndef( Buffer_Center_Height )
#declare Buffer_Center_Height = 1.060;
#end 
#ifndef( Buffer_Half_Distance )
#declare Buffer_Half_Distance = 1.750/2;
#end 
//---------------------------------------------------------------------------------------
//----------------------------------------------------------------------- rail dimensions 
// rail profile -------------------------------------- Schienenprofil
#declare RBaT = 0.125;  //rail base thickness Fußbreite z
#declare RBaH = 0.012;  //rail base height    Fußhöhe y
#declare RBoT = 0.011;  //rail body thickness half !!! halbe Stegdicke
#declare RBoH = 0.150;  //rail body height    Steghöhe
#declare RToR = 0.045;  //rail top radius
#declare RToS = 0.3;    //rail top scale y
// ------------------------------------------------------ tie dimensions - Schwellenprofil
#declare RB  = (Gauge/2) + RToR; // rails half center distance 
                                 // halber Abstand der Schienen(mittig!)
#declare SB = Gauge/2*1.75;   // half tie/sleeper length - halbe Schwellenlänge
#declare Tie_Length = 2*SB;   // full tie/sleeper length - volle Schwellenlänge

#declare SD = 0.26;   // tie/sleeper thickness - Schwellendicke
#declare SH = 0.16;   // tie/sleeper height - Schwellenhöhe
//----------- Height_Of_Rail_Top ---------- Höhe Oberkante Schiene -----------------------
//  top edge of rail, Schienenoberkante,  bord supérieur du rail, spigolo superiore di rotaia
// ---<<<<<< SchienenOberkante 0-Level für Lokomotiven, Wagons etc
#declare  Height_Rail_Top =  RToR*RToS  + RBoH + SH /*+RBaH*/; 
// =0.0135 +0.110 +0.160 +0.012 = 0.00135 +0.270 +0.012 = 0.27135 +0.012 = 0.28335 (meter)
//#declare HOKS = Height_Rail_Top;
//#declare HSOK = Height_Rail_Top;
//#declare HoeheOberkanteSchiene = Height_Rail_Top;
//--------------------------------------------------------------------------------------- 



//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------

#version RT_System_Sizes_00_Inc_Temp;
#end
//------------------------------------- end of include file

