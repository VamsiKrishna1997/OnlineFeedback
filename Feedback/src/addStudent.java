

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


@WebServlet("/addStudent")
public class addStudent extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public addStudent() {
        super();
        // TODO Auto-generated constructor stub
    }

	
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		String studentname=req.getParameter("studentname").toUpperCase();
		String studentdept=req.getParameter("studentdept").toUpperCase();
		String studentroll=req.getParameter("studentroll").toUpperCase();
		String semester=req.getParameter("semester");
		String section=req.getParameter("sectionselect").toUpperCase();
		String studentmail=req.getParameter("studentmail");
		PrintWriter pw=res.getWriter();
	
	
		try
		{
			
			Class.forName("com.mysql.jdbc.Driver");
			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/OnlineFeedback","root","root");
			Statement st=con.createStatement();
			ResultSet rs=st.executeQuery("select * from login where username='"+studentroll+"'");
			if(rs.next())
			{
				pw.println("<script type=\"text/javascript\">");
			       pw.println("alert('Student Already Added!');");
			       pw.println("location='AddStudent.jsp'");
			       pw.println("</script>");	
			}
			else
			{
			PreparedStatement ps=con.prepareStatement("insert into login values(?,?,?,?,?,?,?)");
			ps.setString(1, studentname);
			ps.setString(2, studentroll);
			ps.setString(3, studentroll);
			ps.setString(4, studentdept);
			ps.setString(5, section);
			ps.setString(6, semester);
			ps.setString(7, studentmail);
			int i=ps.executeUpdate();
			if(i>=1)
			{
			pw.println("<script type=\"text/javascript\">");
		       pw.println("alert('Add Successfull');");
		       pw.println("location='AddStudent.jsp'");
		       pw.println("</script>");
			}
			else
			{
				pw.println("<script type=\"text/javascript\">");
			       pw.println("alert('Add UnSuccessfull');");
			       pw.println("location='AddStudent.jsp'");
			       pw.println("</script>");
			}
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
