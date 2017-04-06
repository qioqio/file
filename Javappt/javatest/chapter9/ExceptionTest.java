/**************************************
*       Class ExceptionTest
***************************************/

public class ExceptionTest
{
	public static void main(String args[])
	{
		ExceptionThrow test = new ExceptionThrow();
		
		try
		{
			test.throwMyException2();
		}
		catch(MyException2 e)
		{
			System.out.println(e);
		}
		finally
		{
			System.out.println("Test of my own exception");
		}
		
		test.throwMyException1();
	}
}

class ExceptionThrow
{
	public void throwMyException1() throws MyException1
	{
		MyException1 e = new MyException1();
		throw e;
	}

	public void throwMyException2() throws MyException2
	{
		MyException2 e = new MyException2();
		throw e;
	}
}

class MyException1 extends RuntimeException
{
	MyException1()
	{
		super("My Own Runtime Exception");
	}
}

class MyException2 extends Exception
{
	MyException2()
	{
		super("My Own not-Runtime Exception");
	}
}