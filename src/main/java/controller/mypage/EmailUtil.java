package controller.mypage;

import java.util.Properties;
import java.util.Random;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class EmailUtil {

	//회원가입 성공 시 아이디와 이름을 보내주는 메서드
	public static void sendIdEmail(String toEmail, String userName, String id) {
        String host = "smtp.gmail.com";
        String from = "ddkk8525@gmail.com"; // 실제 Gmail 주소
        String password = "muef nfld rbql bfez"; // Gmail 앱 비밀번호

        // SMTP 서버 속성 설정
        Properties props = new Properties();
        props.put("mail.smtp.host", host);
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.starttls.required", "true");
        props.put("mail.smtp.ssl.trust", "smtp.gmail.com");
        props.put("mail.transport.protocol", "smtp");
        props.put("mail.debug", "true"); // 디버깅 활성화

        // SSL/TLS 디버깅 (선택 사항)
        System.setProperty("javax.net.debug", "all");

        // 세션 생성
        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(from, password);
            }
        });

        try {
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(from));
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(toEmail));
            message.setSubject("ID 안내(LDB학사관리부)");
            message.setText(userName + "님, \n\n  ID: " + id + "\n\n로그인 페이지에서 사용하세요.\n \n "
            		+ "-LDB 학사관리부	-");
            

            Transport.send(message);
            System.out.println("이메일 전송 성공: " + toEmail);
           

        } catch (MessagingException e) {
            e.printStackTrace();
            System.out.println("이메일 전송 실패: " + e.getMessage());
        }
       
    }
	
	//registerUser 시 인증번호를 이메일로보내는메서드
	public static String sendNum(String toEmail, String userName, String id) {
        String host = "smtp.gmail.com";
        String from = "ddkk8525@gmail.com"; // 실제 Gmail 주소
        String password = "muef nfld rbql bfez"; // Gmail 앱 비밀번호
        String tempNum="";
        for (int i = 0; i < 4; i++) {
        	 int num = new Random().nextInt(9)+1;
        	 tempNum += num;
		}

        // SMTP 서버 속성 설정
        Properties props = new Properties();
        props.put("mail.smtp.host", host);
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.starttls.required", "true");
        props.put("mail.smtp.ssl.trust", "smtp.gmail.com");
        props.put("mail.transport.protocol", "smtp");
        props.put("mail.debug", "true"); // 디버깅 활성화


        // 세션 생성
        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(from, password);
            }
        });

        try {
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(from));
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(toEmail));
            message.setSubject("인증번호 안내(LDB학사관리부)");
            message.setText(userName+"님의 인증번호 : "+tempNum+"\n\n -LDB 학사관리부-");
            

            Transport.send(message);
            System.out.println("이메일 전송 성공: " + toEmail);
            return tempNum;
           

        } catch (MessagingException e) {
            e.printStackTrace();
            System.out.println("이메일 전송 실패: " + e.getMessage());
        }
        return null;
       
    }
	
	//임시비밀번호를 보내는메서드
	public static String sendTempPw(String toEmail, String userName, String tempPw) {
        String host = "smtp.gmail.com";
        String from = "ddkk8525@gmail.com"; // 실제 Gmail 주소
        String password = "muef nfld rbql bfez"; // Gmail 앱 비밀번호
        

        // SMTP 서버 속성 설정
        Properties props = new Properties();
        props.put("mail.smtp.host", host);
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.starttls.required", "true");
        props.put("mail.smtp.ssl.trust", "smtp.gmail.com");
        props.put("mail.transport.protocol", "smtp");
        props.put("mail.debug", "true"); // 디버깅 활성화


        // 세션 생성
        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(from, password);
            }
        });

        try {
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(from));
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(toEmail));
            message.setSubject("임시비밀번호 안내(LDB학사관리부)");
            message.setText(userName+"님의 임시비밀번호 : "+tempPw+"\n\n -LDB학사관리부-");
            

            Transport.send(message);
            System.out.println("이메일 전송 성공: " + toEmail);
            return tempPw;
           

        } catch (MessagingException e) {
            e.printStackTrace();
            System.out.println("이메일 전송 실패: " + e.getMessage());
        }
        return null;
       
    }
	
	
	//자퇴 시 문자를 보내주는메서드
		public static void sendDeleteMsg (String toEmail, String userName ) {
	        String host = "smtp.gmail.com";
	        String from = "ddkk8525@gmail.com"; // 실제 Gmail 주소
	        String password = "muef nfld rbql bfez"; // Gmail 앱 비밀번호
	        

	        // SMTP 서버 속성 설정
	        Properties props = new Properties();
	        props.put("mail.smtp.host", host);
	        props.put("mail.smtp.port", "587");
	        props.put("mail.smtp.auth", "true");
	        props.put("mail.smtp.starttls.enable", "true");
	        props.put("mail.smtp.starttls.required", "true");
	        props.put("mail.smtp.ssl.trust", "smtp.gmail.com");
	        props.put("mail.transport.protocol", "smtp");
	        props.put("mail.debug", "true"); // 디버깅 활성화


	        // 세션 생성
	        Session session = Session.getInstance(props, new Authenticator() {
	            @Override
	            protected PasswordAuthentication getPasswordAuthentication() {
	                return new PasswordAuthentication(from, password);
	            }
	        });

	        try {
	            MimeMessage message = new MimeMessage(session);
	            message.setFrom(new InternetAddress(from));
	            message.addRecipient(Message.RecipientType.TO, new InternetAddress(toEmail));
	            message.setSubject("자퇴 안내 메시지(LDB-학사관리부)");
	            message.setText(userName+"님이 자퇴를 하셨습니다 : \n 자퇴 시  해당페이지에 로그인이 제한됩니다"
	            		+ "	\n\n -LDB학사관리부-");
	            

	            Transport.send(message);
	            System.out.println("이메일 전송 성공: " + toEmail+"\n\n -LDB학사관리부-");
	        
	           

	        } catch (MessagingException e) {
	            e.printStackTrace();
	            System.out.println("이메일 전송 실패: " + e.getMessage());
	        }
	    
	       
	    }
	
	
}
