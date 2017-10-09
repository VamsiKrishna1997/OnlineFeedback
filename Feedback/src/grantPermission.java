

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
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class grantPermission
 */
@WebServlet("/grantPermission")
public class grantPermission extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public grantPermission() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		String permission[]=req.getParameterValues("checkbox");
		PrintWriter pw=res.getWriter();
		String permissionlist="";
		String user=req.getParameter("user");
	
		try{
			PreparedStatement ps = null;
			Class.forName("com.mysql.jdbc.Driver");
			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/OnlineFeedback","root","root");
			for(int i=0;i<permission.length;i++)
			{
				permissionlist+=permission[i];
				if(i!=permission.length-1)
				{
					permissionlist+=",";
				}
				
			}
			
			 ps=con.prepareStatement("update admin set permission=? where username=? ");
			
			 ps.setString(1, permissionlist);
			 ps.setString(2, user);
			int k=ps.executeUpdate();
			if(k>=1)
			{
				con.close();
				pw.println("<script type=\"text/javascript\">");
			       pw.println("alert('Grant Successfull');");
			       pw.println("location='adminlogin.jsp'");
			       pw.println("</script>");
			}else{
				pw.println("<script type=\"text/javascript\">");
			       pw.println("alert('Grant Unsuccessfull');");
			       pw.println("location='adminlogin.jsp'");
			       pw.println("</script>");
			}
		}catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}


	}

}
