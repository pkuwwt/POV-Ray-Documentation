#declare usehdr = 1;

#if (usehdr = 0)
	#version unofficial MegaPov 1.21;
	global_settings {
	   max_trace_level 15
	   radiosity {
	      pretrace_start 0.08
	      pretrace_end   0.01
	      count 100 // was 800
	      nearest_count 8
	      error_bound 0.5 // was 0.07
	      recursion_limit 3 // was 2, default 3
	      brightness 1
	      normal on
	      randomize on
	      //show_samples 0.01, <0,0,1>
	      //show_low_count 10, <1,1,0>
	   }
	}  
#else 
	light_source {
		<0,10,-10>
		color rgb <1,1,1>
	}
#end

#declare RR = 7;
#declare myclock = 0;
camera { 
   //location <RR*cos(clock*2*pi-pi/2),5,RR*sin(clock*2*pi-pi/2)> 
	location <RR*cos(myclock*2*pi-pi/2),5,RR*sin(myclock*2*pi-pi/2)>
   right (image_width/image_height)*x 
   up y 
   look_at <0,-0.75,0> 
}

background {
   color rgb <0,0,0>
}

// HDR sphere
sphere {
   <0,0,0>, 1
	#if (usehdr = 0)
	   pigment { 
			image_map { 
				hdr "single.hdr" 
				once 
				interpolate 2 
				map_type 0
			} 
	      translate <-0.5,0,0>
	      scale <2,1,1>
		}
	#else 
		pigment { color <0,0,1> }
	#end
   finish {
      ambient 0.7
      diffuse 0
   }
   hollow
	scale 200
	rotate <0,110+clock*360,0>
}

// Paper
polygon {
	5, <0,0,0>, <1,0,0>, <1,0,1>, <0,0,1>, <0,0,0>
	texture {
   	pigment {
   	   image_map {
   	      tga "paper.tga"
   	      once
   	      interpolate 2
   	      map_type 0
   	   }
   	 	rotate <90,0,0>  
   	}
      finish {
         ambient 0
         diffuse 0.5
      }
	}
	scale 4*<1,1,sqrt(2)>
	rotate <0,-30,0>
   translate <-2.5,0.11,-3.5>
}

// Ground plane
plane {
	<0,-1,0>, 0.2
   texture {
      pigment { color rgb <1,1,1> }
      finish {
         ambient 0
         diffuse 0.7
      }
   }
}

// Table top
cylinder {
   <0,0,0>, <0,0.1,0>, 4.5
   texture {
      pigment { color rgb 0.3*<1,1,1> }
      finish {
         ambient 0
         diffuse 0.3
      	reflection { 0.2 }
		}
   }
}

#declare thefinish1 = finish {
   ambient 0
   diffuse 0.4
   reflection { 0.1 }
}
#declare thefinish2 = finish {
   ambient 0
   diffuse 0.4
	reflection { 0.02 }
}

#declare tubeframetexture = texture {
   pigment { color rgb <0.4,0.4,0.4> }
   finish { thefinish1 }
}

// Left diagram - band
#declare tubeframeradius = 0.025;
#declare showbandframe = 0; // 1 == don't show, 0 == show
union {
   #include "band.inc"
	rotate <90,0,0>
   scale 0.4 * 3
   translate <-2.5,0.18,0.5>
}

// Center diagram
#declare tubeframeradius = 0.02;
union {
   #include "mobius.inc"
   scale 0.45 * 4
	rotate <0,0,90>
	rotate <0,20,0>
   translate <1,1.3,0>
}

// Right diagram
#declare ringradius = 0.3;
union {
   #include "rings.inc"
	rotate <90,0,0>
   scale 0.041 * 3
   translate <2.5,0.3,0>
	rotate <0,80,0>
}

