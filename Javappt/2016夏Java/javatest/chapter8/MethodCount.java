import java.applet.*;
import java.awt.*;
public class MethodCount extends Applet
{int initcount=0,startcount=0,stopcount=0,destroycount=0,paintcount=0;
 
public void init()
{initcount=initcount+1;}
public void start()
{startcount=startcount+1;}
public void stop()
{stopcount++;}
public void destroy()
{destroycount++;}
public void paint(Graphics g)
{
g.setColor(Color.red);
 g.setFont(new Font("SansSerif",Font.BOLD,24));
	 paintcount++;
  g.drawString("initcount  ="+initcount,50,60);
 g.drawString("startcount ="+startcount,50,100);
  g.drawString("stopcount ="+stopcount,50,140);
  g.drawString("destroycount="+destroycount,50,180);
  g.drawString("paintcount ="+paintcount,50,220);
  }
 }

