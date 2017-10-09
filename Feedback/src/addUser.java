

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

/**
 * Servlet implementation class addUser
 */
@WebServlet("/addUser")
public class addUser extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public addUser() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		String user=req.getParameter("user");
		String password=req.getParameter("userpassword");
		String dept=req.getParameter("userdept").toUpperCase();
		PrintWriter pw=res.getWriter();
		try{
			Class.forName("com.mysql.jdbc.Driver");
			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/OnlineFeedback","root","root");
			PreparedStatement ps=con.prepareStatement("insert into admin values(?,?,?,?,?) ");
			ps.setString(1, user);
			ps.setString(2, password);
			ps.setString(3, "user");
			ps.setString(4, dept);
			ps.setString(5, "");
			int k=ps.executeUpdate();
			if(k>=1)
			{
				con.close();
				pw.println("<script type=\"text/javascript\">");
			       pw.println("alert('Add Successfull');");
			       pw.println("location='adminlogin.jsp'");
			       pw.println("</script>");
			}else{
				pw.println("<script type=\"text/javascript\">");
			       pw.println("alert('There Was A Problem Creating The User! Please Try After Some Time.');");
			       pw.println("location='adminlogin.jsp'");
			       pw.println("</script>");
			}
			
		}catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}
	}

}
