

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/changePassword")
public class changePassword extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public changePassword() {
        super();
        // TODO Auto-generated constructor stub
    }

	
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		String oldpass=req.getParameter("oldpassword").toUpperCase();
		String newpass=req.getParameter("newpassword");
		String repass=req.getParameter("repassword");
		String username=req.getParameter("username").toUpperCase();
		
		PrintWriter pw=res.getWriter();
		HttpSession aSession=req.getSession();
	
	
		
			if(!newpass.equals(repass))
			{
				 pw.println("<script type=\"text/javascript\">");
			       pw.println("alert('Passwords Do Not Match');");
			       pw.println("location='index.html'");
			       pw.println("</script>");
			}
			else
			{
				try{
					Class.forName("com.mysql.jdbc.Driver");
					Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/OnlineFeedback","root","root");
					PreparedStatement ps=con.prepareStatement("update login set password=? where username=? and password=? ");
					ps.setString(1, newpass);
					ps.setString(2, username);
					ps.setString(3, oldpass);
					int i=ps.executeUpdate();
					if(i>=1)
					{
						 pw.println("<script type=\"text/javascript\">");
					       pw.println("alert('Password Changed!');");
					       pw.println("location='index.html'");
					    
					       pw.println("</script>");
						
					}else
					{
						 pw.println("<script type=\"text/javascript\">");
					       pw.println("alert('There Was A Problem Changing The Password!');");
					       pw.println("location='ChangePassword.jsp'");
					       pw.println("</script>");
					}
				}catch (Exception e) {
					e.printStackTrace();
					// TODO: handle exception
				}
			}
		}
		
	

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
      /*HttpSession aSession=request.getSession();
    	
		aSession.invalidate();*/
		PrintWriter pw=response.getWriter();
		pw.println("<script type=\"text/javascript\">");
	       pw.println("alert('Succesfully Signed Out');");
	       
	       pw.println("location='index.html'");
	       pw.println("</script>");
	}

}
