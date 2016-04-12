package com.ifilmo.servlet;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.Properties;
import java.util.UUID;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ifilmo.dao.UserDAO;
import com.ifilmo.dao.impl.UserDAOImpl;
import com.ifilmo.domain.User;
import com.ifilmo.util.GenerateLinkUtils;

public class EmailServlet extends HttpServlet {


	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setCharacterEncoding("utf-8"); 
		request.setCharacterEncoding("utf-8");
		
		//String user_name = request.getParameter("user_name");
		String email = request.getParameter("email");
		UserDAO userdao = new UserDAOImpl();
		User user = userdao.findUserByEmail(email);
		String msg = ""; 
		if(user==null){
			 msg = "邮箱不存在,你不会忘记邮箱了吧?";
			 System.out.println(msg);
		}
		
		try{
			String secretKey = UUID.randomUUID().toString();//密钥
			Timestamp outDate = new Timestamp(System.currentTimeMillis()+30*60*1000);//30分钟后过期
			//long date = outDate.getTime()/1000*1000;  //忽略毫秒数
			userdao.UpdateCodeByUserId(secretKey, outDate, user.getUser_id());
			String key = user.getUser_name()+"$"+outDate+"$"+secretKey;
			String digitalSignature = GenerateLinkUtils.md5(key);//数字签名
			
			String emailTitle = "密码找回";  
	        String path = request.getContextPath();
	        String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";  
	        String resetPassHref =  basePath+"ResetPasswordServlet?s_id="+digitalSignature+"&email="+user.getEmail();
	        String emailContent = "请勿回复本邮件.点击下面的链接,重设密码<br/><a href="+resetPassHref +" target='_BLANK'>点击我重新设置密码</a>"; 
		
			Properties props = new Properties();
			props.put("mail.debug", "true");
			props.put("mail.smtp.host", "smtp.exmail.qq.com");
			props.put("mail.smtp.socketFactory.port", "465");
			props.put("mail.smtp.socketFactory.class",
					"javax.net.ssl.SSLSocketFactory");
			props.put("mail.smtp.auth", "true");
			props.put("mail.smtp.port", "465");
			
			Session session = Session.getDefaultInstance(props,
				new javax.mail.Authenticator() {
					protected PasswordAuthentication getPasswordAuthentication() {
						return new PasswordAuthentication("services@ifilmo.com","1234Qwer!");
					}
				});
			try {
				Multipart mp = new MimeMultipart();
				MimeBodyPart mbp = new MimeBodyPart();
				Message message = new MimeMessage(session);
				message.setFrom(new InternetAddress("services@ifilmo.com"));
				message.setRecipients(Message.RecipientType.TO,
						InternetAddress.parse(email));
				message.setSubject(emailTitle);
				message.setText(emailContent);
				mbp.setContent(emailContent, "text/html;charset=utf-8");
				mp.addBodyPart(mbp);
				message.setContent(mp);

				Transport.send(message);

				System.out.println("Done");

			} catch (MessagingException e) {
				throw new RuntimeException(e);
			}
	
        System.out.print("resetPassHref的值是：" + resetPassHref);
		}catch(Exception e){
			e.printStackTrace();  
	        msg="邮箱不存在？未知错误,联系管理员吧。";
	        System.out.println(msg);
		}
		request.getRequestDispatcher("/UI/main.jsp").forward(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
