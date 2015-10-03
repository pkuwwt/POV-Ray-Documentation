#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <GL/glut.h>

/*
	OpenGL version of cuberender
*/

typedef struct {
	double x,y,z;
} XYZ;
typedef struct {
	double r,g,b;
} COLOUR;
typedef struct {
   unsigned char r,g,b,a;
} PIXELA;
typedef struct {
   XYZ vp;              /* View position           */
   XYZ vd;              /* View direction vector   */
   XYZ vu;              /* View up direction       */
   XYZ pr;              /* Point to rotate about   */
   double focallength;  /* Focal Length along vd   */
   double aperture;     /* Camera aperture         */
   double eyesep;       /* Eye separation          */
} CAMERA;

void Display(void);
void CreateEnvironment(void);
void MakeGeometry(int,int);
void MakeLighting(void);
void HandleKeyboard(unsigned char key,int x, int y);
void HandleSpecialKeyboard(int key,int x, int y);
void HandleMouse(int,int,int,int);
void HandleMainMenu(int);
void HandleSpeedMenu(int);
void HandleVisibility(int vis);
void HandleReshape(int,int);
void HandleMouseMotion(int,int);
void HandlePassiveMotion(int,int);
void HandleIdle(void);
void GiveUsage(char *);
void RotateCamera(int,int,int);
void TranslateCamera(int,int);
void CameraHome(int);
int WindowDump(void);

void Normalise(XYZ *);
XYZ CalcNormal(XYZ,XYZ,XYZ);
PIXELA *ReadRawTexture(int,int,char *);

#define ABS(x) (x < 0 ? -(x) : (x))
#define MIN(x,y) (x < y ? x : y)
#define MAX(x,y) (x > y ? x : y)
#define TRUE  1
#define FALSE 0
#define PI 3.141592653589793238462643
#define DTOR            0.0174532925
#define RTOD            57.2957795
#define CROSSPROD(p1,p2,p3) \
   p3.x = p1.y*p2.z - p1.z*p2.y; \
   p3.y = p1.z*p2.x - p1.x*p2.z; \
   p3.z = p1.x*p2.y - p1.y*p2.x

int fullscreen = FALSE;
int stereo = FALSE;
int autospin = 1;
int screenwidth=400,screenheight=300;
int currentbutton = -1;
int showconstruct = FALSE;
int width=-1,height=-1;
double dtheta = 1;
CAMERA camera;
XYZ origin = {0.0,0.0,0.0};

PIXELA *left,*right,*top,*bottom,*front,*back;

int main(int argc,char **argv)
{
   int i,j,depth;
   int mainmenu,speedmenu;
	FILE *fptr;

   for (i=1;i<argc;i++) {
      if (strstr(argv[i],"-h") != NULL) 
         GiveUsage(argv[0]);
      if (strstr(argv[i],"-f") != NULL)
         fullscreen = TRUE;
		if (strstr(argv[i],"-c") != NULL)
			showconstruct = TRUE;
		if (strstr(argv[i],"-x") != NULL) {
			i++;
			if (i >= argc)
				GiveUsage(argv[0]);
			width = atoi(argv[i]);
		}
      if (strstr(argv[i],"-y") != NULL) {
         i++;
         if (i >= argc)
            GiveUsage(argv[0]);
         height = atoi(argv[i]);
      }
   }
	if (width < 0 || height < 0)
		GiveUsage(argv[0]);
	if (width != 128 && width != 256 && width != 512 && width != 1024) {
		fprintf(stderr,"Width must be one of 128, 256, 512, 1024\n");
		exit(-1);
	}
   if (height != 128 && height != 256 && height != 512 && height != 1024) {
      fprintf(stderr,"Height must be one of 128, 256, 512, 1024\n");
      exit(-1);
   }

   /* Set things up and go */
   glutInit(&argc,argv);
   if (!stereo)
      glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGB | GLUT_DEPTH);
   else
      glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGB | GLUT_DEPTH | GLUT_STEREO);
   glutCreateWindow("Pulsar model");
	glutReshapeWindow(600,450);
   if (fullscreen)
      glutFullScreen();
   glutDisplayFunc(Display);
	glutReshapeFunc(HandleReshape);
   glutVisibilityFunc(HandleVisibility);
   glutKeyboardFunc(HandleKeyboard);
   glutSpecialFunc(HandleSpecialKeyboard);
   glutMouseFunc(HandleMouse);
	glutMotionFunc(HandleMouseMotion);
	glutPassiveMotionFunc(HandlePassiveMotion);
   CreateEnvironment();
	CameraHome(0);

   /* Set up some menus */
   speedmenu = glutCreateMenu(HandleSpeedMenu);
   glutAddMenuEntry("Slow",1);
   glutAddMenuEntry("Medium",2);
   glutAddMenuEntry("Fast",3);
   mainmenu = glutCreateMenu(HandleMainMenu);
	glutAddSubMenu("Rotation",speedmenu);
   glutAddMenuEntry("Toggle Spin",1);
	glutAddMenuEntry("Toggle construction lines",2);
   glutAddMenuEntry("Quit",100);
   glutAttachMenu(GLUT_RIGHT_BUTTON);

	left   = ReadRawTexture(width,height,"left");
	top    = ReadRawTexture(width,height,"top");
   front  = ReadRawTexture(width,height,"front");
   bottom = ReadRawTexture(width,height,"bottom");
   back   = ReadRawTexture(width,height,"back");
   right  = ReadRawTexture(width,height,"right");

   glutMainLoop();
   return(0);
}

/*
   This is where global settings are made, that is, 
   things that will not change in time 
*/
void CreateEnvironment(void)
{
   glEnable(GL_DEPTH_TEST);
   glDisable(GL_LINE_SMOOTH);
   glDisable(GL_POINT_SMOOTH);
   glEnable(GL_POLYGON_SMOOTH); 
   glShadeModel(GL_SMOOTH);    
   glDisable(GL_DITHER);

/*
	glutSetCursor(GLUT_CURSOR_CROSSHAIR); 
	glutSetCursor(GLUT_CURSOR_NONE);
*/
   glLineWidth(1.0);
   glPointSize(1.0);

   glPolygonMode(GL_FRONT_AND_BACK,GL_FILL);
   glFrontFace(GL_CW);
   glDisable(GL_CULL_FACE);
   glClearColor(0.0,0.0,0.0,0.0);         /* Background colour */
	glColorMaterial(GL_FRONT_AND_BACK,GL_AMBIENT_AND_DIFFUSE);
   glEnable(GL_COLOR_MATERIAL);
	glPixelStorei(GL_UNPACK_ALIGNMENT,1);
	glColorMaterial(GL_FRONT_AND_BACK,GL_AMBIENT_AND_DIFFUSE); 
}

/*
   This is the basic display callback routine
   It creates the geometry, lighting, and viewing position
   In this case it rotates the camera around the scene
*/
void Display(void)
{
	XYZ right,focus;

	/* Clear the buffers */
   glDrawBuffer(GL_BACK_LEFT);
   glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
   if (stereo) {
      glDrawBuffer(GL_BACK_RIGHT);
      glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
   }

   /* Determine the focal point */
   Normalise(&camera.vd);
   focus.x = camera.vp.x + camera.focallength * camera.vd.x;
   focus.y = camera.vp.y + camera.focallength * camera.vd.y;
   focus.z = camera.vp.z + camera.focallength * camera.vd.z;

   glMatrixMode(GL_PROJECTION);
   glLoadIdentity();
   gluPerspective(camera.aperture,screenwidth/(double)screenheight,0.1,10000.0);

	if (stereo) {

      /* Derive the two eye positions */
      CROSSPROD(camera.vd,camera.vu,right);
      Normalise(&right);
      right.x *= camera.eyesep / 2.0;
      right.y *= camera.eyesep / 2.0;
      right.z *= camera.eyesep / 2.0;

      glMatrixMode(GL_MODELVIEW);
      glDrawBuffer(GL_BACK_RIGHT);
      glLoadIdentity();
      gluLookAt(camera.vp.x + right.x,
                camera.vp.y + right.y,
                camera.vp.z + right.z,
                focus.x,focus.y,focus.z,
                camera.vu.x,camera.vu.y,camera.vu.z);
      MakeGeometry(width,height);
		MakeLighting();

      glMatrixMode(GL_MODELVIEW);
      glDrawBuffer(GL_BACK_LEFT);
      glLoadIdentity();
      gluLookAt(camera.vp.x - right.x,
                camera.vp.y - right.y,
                camera.vp.z - right.z,
                focus.x,focus.y,focus.z,
                camera.vu.x,camera.vu.y,camera.vu.z);
      MakeGeometry(width,height);
		MakeLighting();
	} else {
      glMatrixMode(GL_MODELVIEW);
      glDrawBuffer(GL_BACK_LEFT);
      glLoadIdentity();
      gluLookAt(camera.vp.x,
                camera.vp.y,
                camera.vp.z,
                focus.x,focus.y,focus.z,
                camera.vu.x,camera.vu.y,camera.vu.z);
   	MakeGeometry(width,height);
		MakeLighting();
	}

   /* glFlush(); This isn't necessary for double buffers */
   glutSwapBuffers();
}

/*
   Create the geometry for the pulsar
*/
void MakeGeometry(int w,int h)
{
	int i,j;
	double delta=0;
	XYZ normal;
	XYZ p[8] = {-1,-1,-1,   1,-1,-1,   1,-1,1,   -1,-1,1,
               -1, 1,-1,   1, 1,-1,   1, 1,1,   -1, 1,1};
	int f[24] = {0,1,2,3,   4,7,6,5,    /* Bottom, top */
                3,2,6,7,   1,0,4,5,    /* Front, back */
                2,1,5,6,   0,3,7,4};   /* Right, left */

	if (showconstruct) {
		glPushMatrix();
		glScalef(0.95,0.95,0.95);
		glLineWidth(2.0);
		glColor3f(1.0,0.0,0.0);
		glBegin(GL_LINES);
		for (i=0;i<24;i+=4) {
			for (j=0;j<4;j++) {
      		glVertex3f(p[f[i+j]].x,p[f[i+j]].y,p[f[i+j]].z);
      		glVertex3f(p[f[i+(j+1)%4]].x,p[f[i+(j+1)%4]].y,p[f[i+(j+1)%4]].z);
			}
		}
		glEnd();
		glLineWidth(1.0);
		glPopMatrix();
	}

	glEnable(GL_TEXTURE_2D);
   glTexParameterf(GL_TEXTURE_2D,GL_TEXTURE_WRAP_S,GL_CLAMP);
   glTexParameterf(GL_TEXTURE_2D,GL_TEXTURE_WRAP_T,GL_CLAMP);
   glTexParameterf(GL_TEXTURE_2D,GL_TEXTURE_MIN_FILTER,GL_NEAREST);
   glTexParameterf(GL_TEXTURE_2D,GL_TEXTURE_MAG_FILTER,GL_NEAREST);
	glTexEnvf(GL_TEXTURE_ENV,GL_TEXTURE_ENV_MODE,GL_REPLACE);
	glDisable(GL_BLEND);

	/* Bottom */
	for (i=0;i<24;i+=4) {

		switch (i/4) {
		case 0:
   		glTexImage2D(GL_TEXTURE_2D,0,4,w,h,0,GL_RGBA,GL_UNSIGNED_BYTE,bottom);
			break;
      case 1:
      	glTexImage2D(GL_TEXTURE_2D,0,4,w,h,0,GL_RGBA,GL_UNSIGNED_BYTE,top);
      	break;
      case 2:
      	glTexImage2D(GL_TEXTURE_2D,0,4,w,h,0,GL_RGBA,GL_UNSIGNED_BYTE,front);
      	break;
      case 3:
      	glTexImage2D(GL_TEXTURE_2D,0,4,w,h,0,GL_RGBA,GL_UNSIGNED_BYTE,back);
      	break;
      case 4:
      	glTexImage2D(GL_TEXTURE_2D,0,4,w,h,0,GL_RGBA,GL_UNSIGNED_BYTE,right);
      	break;
      case 5:
      	glTexImage2D(GL_TEXTURE_2D,0,4,w,h,0,GL_RGBA,GL_UNSIGNED_BYTE,left);
      	break;
		}

		glBegin(GL_POLYGON);
		glColor3f(0.0,1.0,0.0);
		normal = CalcNormal(p[f[i]],p[f[i+1]],p[f[i+2]]);
		for (j=0;j<4;j++) {
			switch (j) {
			case 0: glTexCoord2f(0.0-delta,1.0+delta); break;
			case 1: glTexCoord2f(1.0+delta,1.0+delta); break;
			case 2: glTexCoord2f(1.0+delta,0.0-delta); break;
			case 3: glTexCoord2f(0.0-delta,0.0-delta); break;
			}
			glNormal3f(normal.x,normal.y,normal.z);
         glVertex3f(p[f[i+j]].x,p[f[i+j]].y,p[f[i+j]].z);
		}
		glEnd();

	}
	glDisable(GL_TEXTURE_2D);

}

/*
   Set up the lighing environment
*/
void MakeLighting(void)
{
   GLfloat fullambient[] = {1.0,1.0,1.0,1.0};

   /* The specifications for light sources */
   GLfloat position[] = {0.0,0.0,0.0,0.0};
   GLfloat ambient[]  = {0.2,0.2,0.2,1.0};
   GLfloat diffuse[]  = {1.0,1.0,1.0,1.0};
   GLfloat specular[] = {0.0,0.0,0.0,1.0};

   /* Turn off all the lights */
   glDisable(GL_LIGHT0);
   glDisable(GL_LIGHT1);
   glDisable(GL_LIGHT2);
   glDisable(GL_LIGHT3);
   glDisable(GL_LIGHT4);
   glDisable(GL_LIGHT5);
   glDisable(GL_LIGHT6);
   glDisable(GL_LIGHT7);
   glLightModeli(GL_LIGHT_MODEL_LOCAL_VIEWER,GL_TRUE);
   glLightModeli(GL_LIGHT_MODEL_TWO_SIDE,GL_FALSE);

   /* turn on the appropriate lights */
   glLightModelfv(GL_LIGHT_MODEL_AMBIENT,fullambient);
   glLightfv(GL_LIGHT0,GL_POSITION,position);
   glLightfv(GL_LIGHT0,GL_AMBIENT,ambient);
   glLightfv(GL_LIGHT0,GL_DIFFUSE,diffuse);
   glLightfv(GL_LIGHT0,GL_SPECULAR,specular);
   glEnable(GL_LIGHT0);

   /* Sort out the shading algorithm */
   glShadeModel(GL_SMOOTH);

   glEnable(GL_LIGHTING);
}

/*
   Deal with plain key strokes
*/
void HandleKeyboard(unsigned char key,int x, int y)
{
   switch (key) {
   case 27: /* ESC */
   case 'Q':
   case 'q': 
		exit(0); 
		break;
	case 'c':
	case 'C':
		showconstruct = !showconstruct;
		break;
   case 'h':                           /* Go home     */
   case 'H':
      CameraHome(0);
      break;
   case '[':                           /* Roll anti clockwise */
      RotateCamera(0,0,-1);
      break;
   case ']':                           /* Roll clockwise */
      RotateCamera(0,0,1);
      break;
   case 'w':                           /* Write the image to disk */
      WindowDump();
      break;
	case '<':
	case ',':
		camera.aperture -= 2;
		if (camera.aperture < 10)
			camera.aperture = 10;
		break;
   case '>':
	case '.':
      camera.aperture += 2;
      if (camera.aperture > 120)
         camera.aperture = 120;
      break;
   }
}

/*
   Deal with special key strokes
*/
void HandleSpecialKeyboard(int key,int x, int y)
{
   switch (key) {
   case GLUT_KEY_LEFT:
      RotateCamera(-1,0,0);
      break;
   case GLUT_KEY_RIGHT:
      RotateCamera(1,0,0);
      break;
   case GLUT_KEY_UP:
      RotateCamera(0,1,0);
      break;
   case GLUT_KEY_DOWN:
      RotateCamera(0,-1,0);
      break;
   }
}

/*
   Rotate (ix,iy) or roll (iz) the camera about the focal point
   ix,iy,iz are flags, 0 do nothing, +- 1 rotates in opposite directions
   Correctly updating all camera attributes
*/
void RotateCamera(int ix,int iy,int iz)
{
   XYZ vp,vu,vd;
   XYZ right;
   double radius,radians;
   double dx,dy,dz;

   vu = camera.vu;
   Normalise(&vu);
   vp = camera.vp;
   vd = camera.vd;
   Normalise(&vd);
   CROSSPROD(vd,vu,right);
   Normalise(&right);
   radians = dtheta * PI / 180.0;

   /* Handle the roll */
   if (iz != 0) {
      camera.vu.x += iz * right.x * radians;
      camera.vu.y += iz * right.y * radians;
      camera.vu.z += iz * right.z * radians;
      Normalise(&camera.vu);
      return;
   }

   /* Calculate the new view direction */
   camera.vd.x += radians * ix * right.x + radians * iy * vu.x;
   camera.vd.y += radians * ix * right.y + radians * iy * vu.y;
   camera.vd.z += radians * ix * right.z + radians * iy * vu.z;
   Normalise(&camera.vd);

   /* Determine the new up vector */
   CROSSPROD(right,camera.vd,camera.vu);
   Normalise(&camera.vu);
}

/*
   Translate (pan) the camera view point
   In response to i,j,k,l keys
   Also move the camera rotate location in parallel
*/
void TranslateCamera(int ix,int iy)
{
   XYZ vp,vu,vd;
   XYZ right;
   XYZ newvp,newr;
   double radians,delta;

   vu = camera.vu;
   Normalise(&vu);
   vp = camera.vp;
   vd = camera.vd;
   Normalise(&vd);
   CROSSPROD(vd,vu,right);
   Normalise(&right);
   radians = dtheta * PI / 180.0;
   delta = dtheta * camera.focallength / 90.0;

   camera.vp.x += iy * vu.x * delta;
   camera.vp.y += iy * vu.y * delta;
   camera.vp.z += iy * vu.z * delta;
   camera.pr.x += iy * vu.x * delta;
   camera.pr.y += iy * vu.y * delta;
   camera.pr.z += iy * vu.z * delta;

   camera.vp.x += ix * right.x * delta;
   camera.vp.y += ix * right.y * delta;
   camera.vp.z += ix * right.z * delta;
   camera.pr.x += ix * right.x * delta;
   camera.pr.y += ix * right.y * delta;
   camera.pr.z += ix * right.z * delta;
}

/*
   Handle mouse events
*/
void HandleMouse(int button,int state,int x,int y)
{
   int i,id,maxselect = 100,nhits = 0;
   GLuint selectlist[100];
	GLint viewport[4];

   if (state == GLUT_DOWN) {

      if (button == GLUT_LEFT_BUTTON) {
			currentbutton = GLUT_LEFT_BUTTON;
      } else if (button == GLUT_MIDDLE_BUTTON) {
			currentbutton = GLUT_MIDDLE_BUTTON;
      } /* Right button events are passed to menu handlers */

   }
}

/*
   Handle the main menu
*/
void HandleMainMenu(int whichone)
{
   switch (whichone) {
	case 1:
		switch(autospin) {
		case 1: autospin = -1; break;
		case -1: autospin = 0; break;
		default: autospin = 1; break;
		}
		break;
	case 2:
		showconstruct = !showconstruct;
		break;
   case 100: 
		exit(0); 
		break;
   }
}

/*
   Handle the speed menu
*/
void HandleSpeedMenu(int whichone)
{
   switch (whichone) {
   case 1: dtheta = 0.3; break;
   case 2: dtheta = 1; break;
	case 3: dtheta = 3; break;
   }
}

/*
   How to handle visibility
*/
void HandleVisibility(int visible)
{
   if (visible == GLUT_VISIBLE)
      glutIdleFunc(HandleIdle);
   else
      glutIdleFunc(NULL);
}

/*
   What to do on an idle event
*/
void HandleIdle(void)
{
   /* Are we in autospin mode */
   if (autospin != 0) 
      RotateCamera(autospin,0,0);

   glutPostRedisplay();
}

/*
   Handle a window reshape/resize
*/
void HandleReshape(int w,int h)
{
   glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
   glViewport(0,0,(GLsizei)w,(GLsizei)h);
   screenwidth = w;
   screenheight = h;
}

/*
   Display the program usage information
*/
void GiveUsage(char *cmd)
{
   fprintf(stderr,"Usage:    %s -x nnn -y nnn [-h] [-f] [-c]\n",cmd);
	fprintf(stderr,"      -x nnn   width of the images, required\n");
	fprintf(stderr,"      -y nnn   height of the images, required\n");
   fprintf(stderr,"          -h   this text\n");
	fprintf(stderr,"          -f   full screen\n");
	fprintf(stderr,"          -c   show construction lines\n");
   fprintf(stderr,"Key Strokes\n");
	fprintf(stderr,"  arrow keys   rotate left/right/up/down\n");
   fprintf(stderr,"  left mouse   rotate left/right/up/down\n");
	fprintf(stderr,"middle mouse   roll\n");
	fprintf(stderr," right mouse   menus\n");
	fprintf(stderr,"         <,>   decrease, increase aperture\n");
	fprintf(stderr,"           c   toggle construction lines\n");
   fprintf(stderr,"           q   quit\n");
   exit(-1);
}

void Normalise(XYZ *p)
{
   double length;

   length = sqrt(p->x * p->x + p->y * p->y + p->z * p->z);
   if (length != 0) {
      p->x /= length;
      p->y /= length;
      p->z /= length;
   } else {
      p->x = 0;
      p->y = 0;
      p->z = 0;
   }
}

XYZ CalcNormal(XYZ p,XYZ p1,XYZ p2)
{
   XYZ n,pa,pb;

   pa.x = p1.x - p.x;
   pa.y = p1.y - p.y;
   pa.z = p1.z - p.z;
   pb.x = p2.x - p.x;
   pb.y = p2.y - p.y;
   pb.z = p2.z - p.z;
   Normalise(&pa);
   Normalise(&pb);
  
   n.x = pa.y * pb.z - pa.z * pb.y;
   n.y = pa.z * pb.x - pa.x * pb.z;
   n.z = pa.x * pb.y - pa.y * pb.x;
   Normalise(&n);

   return(n);
}

/*
   Read a RAW texture file and return a pointer to the pixelmap
*/
PIXELA *ReadRawTexture(int w,int h,char *basename)
{
   unsigned char r,g,b,a;
   int i;
   int op=0,tr=0;
   double dr,dg,db;
   FILE *fptr;
   PIXELA *ptr;
	char fname[64];

   /* Allocate memory for the texture */
   if ((ptr = malloc(w*h*sizeof(PIXELA))) == NULL) {
      fprintf(stderr,"Failed to allocate memory for texture \"%s\"\n",fname);
      exit(-1);
   }

   /* Start off with a random texture, totally opaque */
   for (i=0;i<w*h;i++) {
      ptr[i].r = rand()%256;
      ptr[i].g = rand()%256;
      ptr[i].b = rand()%256;
		ptr[i].a = 255;
   }

   /* Try to open the texture file */
	sprintf(fname,"%s.raw",basename);
   if ((fptr = fopen(fname,"r")) == NULL) {
      fprintf(stderr,"Failed to open texture file \"%s\"\n",fname);
      return(ptr);
   }

   /* Actually read the texture */
   for (i=0;i<w*h;i++) {
      if ((r = fgetc(fptr)) != EOF &&
          (g = fgetc(fptr)) != EOF &&
          (b = fgetc(fptr)) != EOF) {
         ptr[i].r = r;
         ptr[i].g = g;
         ptr[i].b = b;
      } else {
         fprintf(stderr,"Encountered short file, filling with noise\n");
         break;
      }
   }

   fclose(fptr);
   return(ptr);
}

/*
   Passive mouse events
*/
void HandlePassiveMotion(int x,int y)
{

}

/*
   Write the current view to a file
   fwrite(image,screenwidth*screenheight*3,1,fptr);
*/
int WindowDump(void)
{
   int i,j;
   FILE *fptr;
   static int counter = 0;
   char fname[32];
   unsigned char *image;

   /* Allocate our buffer for the image */
   if ((image = malloc(3*screenwidth*screenheight*sizeof(char))) == NULL) {
      fprintf(stderr,"Failed to allocate memory for image\n");
      return(FALSE);
   }

   glPixelStorei(GL_PACK_ALIGNMENT,1);

   /* Open the file */
   sprintf(fname,"L_%04d.raw",counter);
   if ((fptr = fopen(fname,"w")) == NULL) {
      fprintf(stderr,"Failed to open file for window dump\n");
      return(FALSE);
   }

   /* Copy the image into our buffer */
   glReadBuffer(GL_BACK_LEFT);
   glReadPixels(0,0,screenwidth,screenheight,GL_RGB,GL_UNSIGNED_BYTE,image);

   /* Write the raw file */
   fprintf(fptr,"P3\n%d %d\n255\n",screenwidth,screenheight);
   for (j=screenheight-1;j>=0;j--) {
      for (i=0;i<screenwidth;i++) {
         fputc(image[3*j*screenwidth+3*i+0],fptr);
         fputc(image[3*j*screenwidth+3*i+1],fptr);
         fputc(image[3*j*screenwidth+3*i+2],fptr);
      }
   }
   fclose(fptr);
   if (stereo) {
      /* Open the file */
      sprintf(fname,"R_%04d.raw",counter);
      if ((fptr = fopen(fname,"w")) == NULL) {
         fprintf(stderr,"Failed to open file for window dump\n");
         return(FALSE);
      }

      /* Copy the image into our buffer */
      glReadBuffer(GL_BACK_RIGHT);
      glReadPixels(0,0,screenwidth,screenheight,GL_RGB,GL_UNSIGNED_BYTE,image);

      /* Write the raw file */
      fprintf(fptr,"P3\n%d %d\n255\n",screenwidth,screenheight);
      for (j=screenheight-1;j>=0;j--) {
         for (i=0;i<screenwidth;i++) {
            fputc(image[3*j*screenwidth+3*i+0],fptr);
            fputc(image[3*j*screenwidth+3*i+1],fptr);
            fputc(image[3*j*screenwidth+3*i+2],fptr);
         }
      }
      fclose(fptr);
   }

   /* Clean up */
   counter++;
   free(image);
   return(TRUE);
}

/*
	Move the camera to the home position 
*/
void CameraHome(int mode)
{
	camera.aperture = 60;
	camera.focallength = 1;
	camera.eyesep = 0.01;
	camera.pr = origin;
	camera.vp = origin;
	camera.vd.x = -1; camera.vd.y = 0; camera.vd.z = 0;
	camera.vu.x = 0;  camera.vu.y = 1; camera.vu.z = 0;
}

/*
   Handle mouse motion
*/
void HandleMouseMotion(int x,int y)
{
   static int xlast=-1,ylast=-1;
   int dx,dy;

   dx = x - xlast;
   dy = y - ylast;
   if (dx < 0)      dx = -1;
   else if (dx > 0) dx =  1;
   if (dy < 0)      dy = -1;
   else if (dy > 0) dy =  1;

   if (currentbutton == GLUT_LEFT_BUTTON)
      RotateCamera(-dx,dy,0);
   else if (currentbutton == GLUT_MIDDLE_BUTTON)
      RotateCamera(0,0,dx);

   xlast = x;
   ylast = y;
}

