

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;


@WebServlet("/deleteFaculty")
public class deleteFaculty extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
    public deleteFaculty() {
        super();
        // TODO Auto-generated constructor stub
    }

	
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		String semester=req.getParameter("semester");
		String department=req.getParameter("studentdept").toUpperCase();
		String subject=req.getParameter("facultysub").toUpperCase();
		String facultyname=req.getParameter("facultyname").toUpperCase();
		String section=req.getParameter("sectionselect").toUpperCase();
		String facultyid=req.getParameter("facultyid");
		PrintWriter pw=res.getWriter();
		try{
			Class.forName("com.mysql.jdbc.Driver");
			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/OnlineFeedback","root","root");
			
			PreparedStatement ps=con.prepareStatement("delete from faculty where facultyid=? and facultyname=? and department=? and subject=? and section=? and semester=?");
			ps.setString(1, facultyid);
			ps.setString(2, facultyname);
			ps.setString(3, department);
			ps.setString(4, subject);
			ps.setString(5, section);
			ps.setString(6, semester);
			int i=ps.executeUpdate();
			if(i>=1)
			{
			pw.println("<script type=\"text/javascript\">");
		       pw.println("alert('Delete Successfull');");
		       pw.println("location='DeleteFaculty.jsp'");
		       pw.println("</script>");
			}
			else
			{
				pw.println("<script type=\"text/javascript\">");
			       pw.println("alert('Delete UnSuccessfull');");
			       pw.println("location='DeleteFaculty.jsp'");
			       pw.println("</script>");
			}
		}catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}
		
	}

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String departmentName = request.getParameter("departmentName");
		String semester=request.getParameter("semester");
		 List<String> list = new ArrayList<String>();
	        String json = null;
	        try{
	        	Class.forName("com.mysql.jdbc.Driver");
				Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/OnlineFeedback","root","root");
				Statement st=con.createStatement();
				ResultSet rs=st.executeQuery("select subject from subject where department='"+departmentName+"'and semester='"+semester+"'");
				while(rs.next())
				{
					list.add(rs.getString("subject"));
				}
						
	        	
	        }catch (Exception e) {
	        	e.printStackTrace();
				// TODO: handle exception
			}
	      /*  if (departmentName.equals("cse")) {
	                list.add("English");
	                
	        } else if (departmentName.equals("Mech")) {
	                list.add("Sourav Ganguly");
	                list.add("Sachin Tendulkar");
	                list.add("Lance Klusener");
	                list.add("Michael Bevan");
	        } else if (departmentName.equals("Select Department")) {
	                list.add("Select Subject");
	        }*/

	        json = new Gson().toJson(list);
	        response.setContentType("application/json");
	        response.getWriter().write(json);
	}

	}


