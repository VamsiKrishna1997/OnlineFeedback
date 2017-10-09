

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Properties;
import java.util.Random;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.mail.*;
import javax.mail.internet.*;
import javax.activation.*;


/**
 * Servlet implementation class forgotPassword
 */
@WebServlet("/forgotPassword")
public class forgotPassword extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public forgotPassword() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		String email=req.getParameter("email");
		String username="kalvamsi997@gmail.com";
		String password="Vamsikrishna!234";
		String host="localhost";
		String user=null;
		PrintWriter pw=res.getWriter();
		try{
			 Class.forName("com.mysql.jdbc.Driver");
			    Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/OnlineFeedback","root","root");
			    Statement st=con.createStatement();
			    ResultSet rs=st.executeQuery("select * from login where email='"+email+"'");
			    if(rs.next())
			    {
			    	user=rs.getString("username");
			    	Random r=new Random();
					String list="abc0def14ghij2klm3no5pq97rst6u8vwxyz";
					
					final int length=8;
					StringBuffer randstr= new StringBuffer();
					for(int i=0;i<length;i++)
					{
						int rand=r.nextInt(list.length())+0;
						randstr.append(list.charAt(rand));
						
					}
					
			    	Properties props = new Properties();    
			          props.put("mail.smtp.host", "smtp.gmail.com");    
			          props.put("mail.smtp.socketFactory.port", "465");    
			          props.put("mail.smtp.socketFactory.class",    
			                    "javax.net.ssl.SSLSocketFactory");    
			          props.put("mail.smtp.auth", "true");    
			          props.put("mail.smtp.port", "465");    
			         
			          Session session = Session.getDefaultInstance(props,    
			           new javax.mail.Authenticator() {    
			           protected PasswordAuthentication getPasswordAuthentication() {    
			           return new PasswordAuthentication(username,password);  
			           }    
			          });    
			          //compose message    
			          try {    
			           MimeMessage message = new MimeMessage(session);    
			           message.addRecipient(Message.RecipientType.TO,new InternetAddress(email));    
			           message.setSubject("Forgot Password");    
			           message.setText("Your New Password: "+randstr);    
			           //send message  
			           Transport.send(message);
			           PreparedStatement ps=con.prepareStatement("update login set password=? where email=? and username=?");
			           ps.setString(1,randstr.toString());
			           ps.setString(2, email);
			           ps.setString(3, user);
			           ps.executeUpdate();
			           System.out.println("message sent successfully"); 
			           pw.println("<script type=\"text/javascript\">");
				       pw.println("alert('Check Your Registered E-mail!');");
				       pw.println("location='index.html'");
				       pw.println("</script>");	
			          } catch (MessagingException e) {
			        	  pw.println("<script type=\"text/javascript\">");
					       pw.println("alert('You Are Not Connected To The Internet');");
					       pw.println("location='ForgotPassword.jsp'");
					       pw.println("</script>");		
			          }    
			        
			    }
			    else
			    {
			    	pw.println("<script type=\"text/javascript\">");
				       pw.println("alert('Please Enter Registered E-Mail Address');");
				       pw.println("location='ForgotPassword.jsp'");
				       pw.println("</script>");	
			    }
			   
		}catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}
	}

}
