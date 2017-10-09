

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

import com.google.gson.Gson;


@WebServlet("/deleteSubject")
public class deleteSubject extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
    public deleteSubject() {
        super();
        // TODO Auto-generated constructor stub
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		String department=req.getParameter("studentdept").toUpperCase();
		String semester=req.getParameter("semester");
		String sub=req.getParameter("subject").toUpperCase();
		PrintWriter pw=res.getWriter();
		try{
			Class.forName("com.mysql.jdbc.Driver");
			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/OnlineFeedback","root","root");
			PreparedStatement ps=con.prepareStatement("delete from subject where department=?and subject=?and semester=?");
			ps.setString(1, department);
			ps.setString(2, sub);
			ps.setString(3, semester);
			int k=ps.executeUpdate();
			if(k>=1)
			{
				con.close();
				pw.println("<script type=\"text/javascript\">");
			       pw.println("alert('Delete Successfull');");
			       pw.println("location='DeleteSubject.jsp'");
			       pw.println("</script>");
			}else{
				pw.println("<script type=\"text/javascript\">");
			       pw.println("alert('Delete Unsuccessfull');");
			       pw.println("location='DeleteSubject.jsp'");
			       pw.println("</script>");
			}
		}catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}
	}


	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		String department=req.getParameter("departmentName");
		String semester=req.getParameter("semester");
		 List<String> list = new ArrayList<String>();
	        String json = null;
	        try{
	        	Class.forName("com.mysql.jdbc.Driver");
				Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/OnlineFeedback","root","root");
				Statement st=con.createStatement();
				
				ResultSet rs=st.executeQuery("select subject from subject where department='"+department+"'and semester='"+semester+"'");
				
				while(rs.next())
				{
					list.add(rs.getString("subject"));
				}
						
	        	
	        }catch (Exception e) {
	        	e.printStackTrace();
				// TODO: handle exception
			}
	        json=new Gson().toJson(list);
	        res.setContentType("application/json");
	        res.getWriter().write(json);
	}

	
}