import processing.video.*;
Capture video;

PImage imagen;

int[] cantidadColorR = new int[256];
int[] cantidadColorG = new int[256]; 
int[] cantidadColorB = new int[256]; 

int maxR = 0, maxG = 0, maxB = 0, radio = 5;

int[] MRP = new int[5], MGP = new int[5], MBP = new int[5];

void setup()
{
  size(640, 480);
  surface.setResizable(true);
  String[] cameras = Capture.list();
  video = new Capture(this, cameras[0]);
  video.start();
}

void draw()
{
  for(int i = 0; i < 5; i++)
  {
    if(i < 3)
    {
      MRP[i] = 0;
      MGP[i] = 0;
      MBP[i] = 0;
    }
    else
    {
      MRP[i] = 255;
      MGP[i] = 255;
      MBP[i] = 255;
    }
  }
  background(0);
  fill(255);
  if (video.available()) 
  {
    video.read();
  }
  imagen = video;
  for(int i = 0; i < cantidadColorR.length; i++)
  {
    cantidadColorR[i] = 100;
    cantidadColorG[i] = 100;
    cantidadColorB[i] = 100;
  }  
  for(int i = 0; i < (imagen.width * imagen.height); i++)
  {
    cantidadColorR[int(red(imagen.pixels[i]))]++;
    cantidadColorG[int(green(imagen.pixels[i]))]++;
    cantidadColorB[int(blue(imagen.pixels[i]))]++;
  }
  for(int i = 1; i < cantidadColorR.length; i++)
  {
    if((cantidadColorR[i] > maxR))
    {
      maxR = cantidadColorR[i];
    }
    if(cantidadColorG[i] > maxG)
    {
      maxG = cantidadColorG[i];
    }
    if(cantidadColorB[i] > maxB)
    {
      maxB = cantidadColorB[i];
    }
  }
  for(int y = 0; y < imagen.height; y++)
  {
    for(int x = 0; x < imagen.width; x++)
    {
      if((MRP[0] < int(red(imagen.pixels[(imagen.width * y) + x]))) && (MRP[3] > int(green(imagen.pixels[(imagen.width * y) + x]))) && (MRP[4] > int(blue(imagen.pixels[(imagen.width * y) + x]))))
      {
        MRP[0] = int(red(imagen.pixels[(imagen.width * y) + x]));
        MRP[1] = x / 2;
        MRP[2] = y / 2;
        MRP[3] = int(green(imagen.pixels[(imagen.width * y) + x]));
        MRP[4] = int(blue(imagen.pixels[(imagen.width * y) + x]));
      }
      if((MGP[0] < int(green(imagen.pixels[(imagen.width * y) + x]))) && (MGP[3] > int(red(imagen.pixels[(imagen.width * y) + x]))) && (MGP[4] > int(blue(imagen.pixels[(imagen.width * y) + x]))))
      {
        MGP[0] = int(green(imagen.pixels[(imagen.width * y) + x]));
        MGP[1] = x / 2;
        MGP[2] = y / 2;
        MGP[3] = int(red(imagen.pixels[(imagen.width * y) + x]));
        MGP[4] = int(blue(imagen.pixels[(imagen.width * y) + x]));
      }
      if((MBP[0] < int(blue(imagen.pixels[(imagen.width * y) + x]))) && (MBP[3] > int(red(imagen.pixels[(imagen.width * y) + x]))) && (MBP[4] > int(green(imagen.pixels[(imagen.width * y) + x]))))
      {
        MBP[0] = int(blue(imagen.pixels[(imagen.width * y) + x]));
        MBP[1] = x / 2;
        MBP[2] = y / 2;
        MBP[3] = int(red(imagen.pixels[(imagen.width * y) + x]));
        MBP[4] = int(green(imagen.pixels[(imagen.width * y) + x]));
      }
    }
  }
  for(int i = 1; i < cantidadColorR.length; i++)
  {
    stroke(255, 0, 0);
    line((width - 255) + i, 125, (width - 255) + i, 125 - ((cantidadColorR[i] * 100) / maxR));
    text(maxR, (width - 255), 10);
    stroke(0, 255, 0);
    line((width - 255) + i, 275, (width - 255) + i, 275 - ((cantidadColorG[i] * 100) / maxG));
    text(maxG, (width - 255), 135);
    stroke(0, 0, 255);
    line((width - 255) + i, 425, (width - 255) + i, 425 - ((cantidadColorB[i] * 100) / maxB));
    text(maxB, (width - 255), 285);
  }
  strokeWeight(2);
  noFill();
  image(imagen, 0, 0, width/2, height/2);  //muestro de imágen
  stroke(255, 0, 0);
  text(str(MRP[0]), MRP[1] - radio, MRP[2] - radio);
  ellipse(MRP[1], MRP[2], radio, radio);
  stroke(0, 255, 0);
  text(str(MGP[0]), MGP[1] - radio, MGP[2] - radio);
  ellipse(MGP[1], MGP[2], radio, radio);
  stroke(0, 0, 255);
  text(str(MBP[0]), MBP[1] - radio, MBP[2] - radio);
  ellipse(MBP[1], MBP[2], radio, radio);
  maxR = 0;
  maxG = 0;
  maxB = 0;
}

void mouseWheel(MouseEvent event) 
{
  float e = event.getCount();
  radio += e;
  if(radio < 2)
  {
    radio = 2;
  }
}