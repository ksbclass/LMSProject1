package controller.mypage;

import java.util.Random;

import org.mindrot.jbcrypt.BCrypt;

public class AlgoTest {
	public static void main(String[] args) {
		
		String pw = "1234";
		String hashpw = BCrypt.hashpw(pw, BCrypt.gensalt());
		
		System.out.println("pw : "+pw);
		System.out.println("hashpw : "+hashpw);
		System.out.println("pw.equals(hashpw) : "+pw.equals(hashpw));
		System.out.println("pw == hashpw : "+(pw==hashpw));
		System.out.println("BCrypt.checkpw(pw, hashpw) : "+BCrypt.checkpw(pw, hashpw));
		
		for (int i = 0; i < 10; i++) {
			String tempNum="";
	        for (int j = 0; j < 4; j++) {
	        	 int num = new Random().nextInt(9)+1;
	        	 tempNum += num;
			}
	        System.out.println(i+" : "+tempNum);
		}
		
		

		
		
		
	}

}
