
public class ThrowableTest
{
    public static void main(String[] args)
    {
       try
       {
         testThrowable();
       }
       catch (Throwable t)
       {
         System.err.println(t.toString());
         System.err.println(t.getMessage());
         System.err.println(t.getLocalizedMessage());
         t.printStackTrace();
       }
    }

    static void testThrowable() throws Throwable {
       throw new Throwable("≤‚ ‘ Throwable µƒ”√∑®°£");
    }
}
