

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




@WebServlet("/addSubject")
public class addSubject extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public addSubject() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}


	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		String department=req.getParameter("studentdept").toUpperCase();
		String semester=req.getParameter("semester");
		String newsub=req.getParameter("newsub").toUpperCase();
		PrintWriter pw=res.getWriter();
		try{
			Class.forName("com.mysql.jdbc.Driver");
			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/OnlineFeedback","root","root");
			Statement st=con.createStatement();
			ResultSet rs=st.executeQuery("select * from subject where department='"+department+"'and subject='"+newsub+"'and semester='"+semester+"'");
			if(rs.next())
			{
				
					pw.println("<script type=\"text/javascript\">");
					pw.println("alert('Subject Already Added');");
					pw.println("location='AddSubject.jsp'");
					pw.println("</script>");
			}
			else
			{
			PreparedStatement ps=con.prepareStatement("insert into subject values(?,?,?)");
			ps.setString(1, department);
			ps.setString(2, newsub);
			ps.setString(3, semester);
			int k=ps.executeUpdate();
				if(k>=1)
					{
					pw.println("<script type=\"text/javascript\">");
					pw.println("alert('Subject Added Successfully');");
					pw.println("location='AddSubject.jsp'");
					pw.println("</script>");	
				
						}else{
							pw.println("<script type=\"text/javascript\">");
							pw.println("alert('Student Add Unsuccessfull');");
							pw.println("location='AddSubject.jsp'");
							pw.println("</script>");	
						}
			}
		}catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}
	}

}
