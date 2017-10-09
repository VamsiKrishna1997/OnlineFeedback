

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.DriverManager;
import java.sql.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.sql.Connection;

@WebServlet("/AdminLogin")
public class AdminLogin extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
 
    public AdminLogin() {
        super();
        // TODO Auto-generated constructor stub
    }

	
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		String admin=req.getParameter("adminname");
		String password=req.getParameter("password");
		PrintWriter pw=res.getWriter();
		HttpSession aSession=req.getSession();
		aSession.setAttribute("logedin", "logedin");
		try
		{
		    Class.forName("com.mysql.jdbc.Driver");
		    Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/OnlineFeedback","root","root");
		    Statement st=con.createStatement();
		    ResultSet rs=st.executeQuery("select * from admin where username='"+admin+"' and password='"+password+"'");
		    if(rs.next())
		    {
		    	if(rs.getString("role").equals("admin"))
		    	{
		    	
		    	req.setAttribute("adminname", admin);
		    	RequestDispatcher rd=req.getRequestDispatcher("/adminlogin.jsp");
		    	rd.forward(req, res);
		    	}
		    	else if(rs.getString("role").equals("user"))
		    	{
		    		aSession.setAttribute("username", rs.getString("username"));
		    		aSession.setAttribute("userlogedin", "logedin");
		    		aSession.setAttribute("department1", rs.getString("department"));
		    		aSession.setAttribute("department", rs.getString("department"));
		    		RequestDispatcher rd1=req.getRequestDispatcher("/userlogin.jsp");
		    		rd1.forward(req, res);
		    	}
		    }
		    else
		    {
		    	pw.println("<script type=\"text/javascript\">");
				pw.println("alert('Invalid Username Or Password');");
				pw.println("location='admin.html'");
				pw.println("</script>");
		    }
		   }catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
   
	}

}
