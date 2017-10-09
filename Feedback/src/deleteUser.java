

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


@WebServlet("/deleteUser")
public class deleteUser extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
    public deleteUser() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest req,HttpServletResponse res) throws ServletException,IOException{
String dept=req.getParameter("departmentName").toUpperCase();
		
		List<String> list = new ArrayList<String>();
        String json = null;
     
		try{
			Class.forName("com.mysql.jdbc.Driver");
			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/OnlineFeedback","root","root");
			Statement st=con.createStatement();
			ResultSet rs=st.executeQuery("select username from admin where department='"+dept+"'");
			while(rs.next())
			{
				list.add(rs.getString("username"));
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		 json = new Gson().toJson(list);
	        res.setContentType("application/json");
	        res.getWriter().write(json);
	}
	
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		String user=req.getParameter("user");
	
		String dept=req.getParameter("userdept").toUpperCase();
		PrintWriter pw=res.getWriter();
		try{
			Class.forName("com.mysql.jdbc.Driver");
			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/OnlineFeedback","root","root");
			PreparedStatement ps=con.prepareStatement("delete from admin where department='"+dept+"' and username='"+user+"'");
			
			int k=ps.executeUpdate();
			if(k>=1)
			{
				con.close();
				pw.println("<script type=\"text/javascript\">");
			       pw.println("alert('Delete Successfull');");
			       pw.println("location='adminlogin.jsp'");
			       pw.println("</script>");
			}else{
				pw.println("<script type=\"text/javascript\">");
			       pw.println("alert('There Was A Problem Deleting The User! Please Try After Some Time.');");
			       pw.println("location='adminlogin.jsp'");
			       pw.println("</script>");
			}
			
		}catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}
	}

	}


