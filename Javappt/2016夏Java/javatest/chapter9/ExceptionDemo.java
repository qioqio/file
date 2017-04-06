/**************************************
*       Class ExceptionDemo2
***************************************/

public class ExceptionDemo
{
    public static void main(String args[])
    {
         try 
         {
             Bank ba = new Bank(50);
             ba.withdrawal(100);
             System.out.println("withdrawal successful!");
         }catch(Exception e){
             System.out.println(e.toString());
         } 
    }
}
class Bank
{
    double balance;  //Óà¶î
    Bank(double b)
    {
           balance = b;
    }
    public void deposite(double dAmount)   //´æÇ®
    {
        if(dAmount>0.0)  balance += dAmount;
    }
    public void withdrawal(double dAmount) throws InsufficientFundsException
    {
         if( balance<dAmount )
         {
              throw new InsufficientFundsException(this, dAmount);
         }  
         balance = balance-dAmount;
    }
    public double getbalance()   //»ñÈ¡Óà¶î
    {
         return balance;
    }
}
 class InsufficientFundsException extends Exception
{
     private Bank  excepbank;
     private double excepAmount;
   
     InsufficientFundsException(Bank ba, double  dAmount)
     {
         excepbank = ba;
         excepAmount = dAmount;
     }
     public String  excepMesagge()
     {
          String str ="The balance" + excepbank.getbalance() +
                         "The withdrawal was"+excepAmount;
          return str;
     }
}
