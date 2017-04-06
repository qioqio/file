/**
 * @version 1.20 1999-04-23
 * @author Cay Horstmann
 */

import java.awt.*;
import java.awt.image.*;
import java.awt.event.*;
import javax.swing.*;
import java.net.*;
import java.applet.*;
public class Animation extends Applet
   implements Runnable
{  public void init()
   {  addMouseListener(new MouseAdapter()
         {  public void mousePressed(MouseEvent evt)
            {  if (runner == null)
                  start();
               else
                  stop();
            }
         });

      try
      {  imageName = getParameter("imagename");
         if (imageName == null) imageName = "";

         imageCount = 1;
         String param = getParameter("imagecount");
         if (param != null)
            imageCount = Integer.parseInt(param);
      }
      catch (Exception e)
      { 
      }

      current = 0;
      image = null;
      loadImage();
   }

   public void loadImage()
   {  try
      {  URL url = new URL(getDocumentBase(), imageName);
         image = getImage(url);
         MediaTracker tracker = new MediaTracker(this);
         tracker.addImage(image, 0);
         tracker.waitForID(0);
         imageWidth = image.getWidth(null);
         imageHeight = image.getHeight(null);
         setSize(imageWidth, imageHeight / imageCount);
      }
      catch (InterruptedException e)
         // thrown by MediaTracker.waitFor
      { }
      catch(MalformedURLException e)
      { }
      
   }

   public void paint(Graphics g)
   {  if (image == null) return;
      g.drawImage(image, 0, - (imageHeight / imageCount)
         * current, null);
   }

   public void start()
   { 
       runner = new Thread(this);
        runner.start();
      
   }

   public void stop()
   {  runner.interrupt();
      runner = null;
      
   }

   public void run()
   {  try
      {  while (!Thread.interrupted())
         { for(int i=0;i<imageCount;i++)  repaint();
           { current = (current + 1) % imageCount;
            Thread.sleep(200);}
         }
      }
      catch(InterruptedException e) {}
   }

   private Image image;
   private int current;
   private int imageCount;
   private int imageWidth;
   private int imageHeight;
   private String imageName;
   private Thread runner;
}