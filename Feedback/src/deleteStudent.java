

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/deleteStudent")
public class deleteStudent extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
  
    public deleteStudent() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		String studentroll=req.getParameter("studentid").toUpperCase();
		String dept=req.getParameter("studentdept").toUpperCase();
		String section=req.getParameter("sectionselect").toUpperCase();
		PrintWriter pw=res.getWriter();
		try
		{
		Class.forName("com.mysql.jdbc.Driver");
		Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/OnlineFeedback","root","root");
		
		PreparedStatement ps=con.prepareStatement("delete from login where username=? and section=? and department=?");
		ps.setString(1, studentroll);
		ps.setString(2, section);
		ps.setString(3, dept);
		int i=ps.executeUpdate();
		if(i>=1)
		{
			
		pw.println("<script type=\"text/javascript\">");
		
	       pw.println("alert('Delete Successfull');");
	       pw.println("location='DeleteStudent.jsp'");
	       pw.println("</script>");
		}
		else
		{
			pw.println("<script type=\"text/javascript\">");
		       pw.println("alert('Delete UnSuccessfull');");
		       pw.println("location='DeleteStudent.jsp'");
		       
		       pw.println("</script>");
		     
		          
		}
	}catch (Exception e) {
		e.printStackTrace();
		// TODO: handle exception
	
	}
	}

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request, response);
	}

}
