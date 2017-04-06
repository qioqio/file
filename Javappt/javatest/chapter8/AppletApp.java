import java.applet.*;
import java.awt.*;
import java.awt.event.*;

public class AppletApp extends Applet
{
    public String s;

    public void init()
    {
          s = new String("Hello World!");
    }

    public void paint(Graphics g) 
    {
          g.drawString(s,25,25);
    }

	public static void main( String args[] )
	{
		Frame f = new Frame("Applet-App");

	    AppletApp app = new AppletApp();
		
		f.add(app, "Center");
		f.setSize(200, 200);
		f.setVisible(true);
		
		f.addWindowListener( new WindowAdapter(){
			public void windowClosing(WindowEvent e){
                   System.exit(0);
			}
		});

		app.init(); 
		app.start();
	}
}
