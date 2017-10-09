

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
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

/**
 * Servlet implementation class subjectWise
 */
@WebServlet("/subjectWise")
public class subjectWise extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public subjectWise() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String departmentName = request.getParameter("departmentName").toUpperCase();
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


