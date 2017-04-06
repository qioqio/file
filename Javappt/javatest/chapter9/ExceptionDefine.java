/**************************************
*       Class ExceptionDemo1
***************************************/
import java.io.*;

public class ExceptionDefine
{
	public static void main(String args[])
	{
		ExceptionDefine.getAnswer("12","55");}
		

public static void getAnswer(String str1, String str2)
{
    String answerStr;
    try
    {
         int answer = ExceptionDefine.CalcAnswer(str1, str2);
         answerStr = String.valueOf(answer);
    }catch (NumberRangeException e){
         answerStr = e.getMessage();
    }
    System.out.println(answerStr);
}

public static int CalcAnswer(String str1, String str2) throws NumberRangeException
{
     int int1, int2;
     int answer = -1;
     try
     {
          int1 = Integer.parseInt(str1);
          int2 = Integer.parseInt(str2);
          if( (int1 < 10) || (int1 > 20) || (int2 < 10) || (int2 > 20) )
          {
                NumberRangeException e = new NumberRangeException
                    ("Numbers not within the specified range.");
                throw e;
          }
          answer = int1 + int2;
     }catch (NumberFormatException e){
          System.out.println( e.toString() );
     }
     return answer;
}
}
class NumberRangeException extends Exception
{
     public NumberRangeException(String msg)
     {
           super(msg);
     }
}
