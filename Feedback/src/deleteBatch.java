

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class deleteBatch
 */
@WebServlet("/deleteBatch")
public class deleteBatch extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public deleteBatch() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		String dept=req.getParameter("dept").toUpperCase();
		String semester=req.getParameter("semester");
		PrintWriter pw=res.getWriter();
		try{
			Class.forName("com.mysql.jdbc.Driver");
			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/OnlineFeedback","root","root");
			PreparedStatement ps=con.prepareStatement("delete from login where department=? and semester=?");
			ps.setString(1, dept);
			ps.setString(2, semester);
			int k=ps.executeUpdate();
			if(k>=1)
			{
				
					pw.println("<script type=\"text/javascript\">");
					pw.println("alert('Batch Deleted Successfully');");
					pw.println("location='adminlogin.jsp'");
					pw.println("</script>");
			}
			else
			{
				pw.println("<script type=\"text/javascript\">");
				pw.println("alert('Batch Deleted Unsuccessfull');");
				pw.println("location='adminlogin.jsp'");
				pw.println("</script>");
			}
	}catch (Exception e) {
		e.printStackTrace();
	}
		// TODO: handle exception
	}

}
