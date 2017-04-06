/**************************************
*       Class TryCatchFinally1
***************************************/

public class TryCatchFinally1{
	public static void main( String args[] )
	{
		try
		{
			Proc( 0 );
			Proc( 1 );
			Proc( 2 );
		}catch( ArithmeticException e ){
			System.out.println("Catch: " + e + "; Reason: " + e.getMessage());
		}catch( ArrayIndexOutOfBoundsException e ){
			System.out.println("Catch: " + e + "; Reason: " + e.getMessage());
		}catch( Exception e ){
			System.out.println("Will not be executed");
		}finally{
			System.out.println("in Proc finally");
		}
	}

	static void Proc( int sel ) throws ArithmeticException, ArrayIndexOutOfBoundsException
	{
		System.out.println("----- In Situation " + sel + " -----");
		if( sel==0 )
		{
			System.out.println("no Exception caught");
			return;
		}
		else if( sel==1 )
		{
			int i=0;
			int j=4/i;
		}
		else if( sel==2 )
		{
			int iArray[]=new int[4];
			iArray[10]=3;
		}
	}
}
