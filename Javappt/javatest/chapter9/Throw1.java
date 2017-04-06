/**************************************
*       Class ExceptionDemo1
***************************************/
class Throw1{
	  public static void main(String args[]) {
		  int a[]=new int[4];
		  System.out.println("Before exception!");
		  a[8]=12;             //产生一个数组下标越界异常
		  System.out.println("After exception!");
	  }
}
