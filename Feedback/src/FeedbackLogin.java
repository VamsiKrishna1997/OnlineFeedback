

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;



import java.sql.*;




@WebServlet("/FeedbackLogin")
public class FeedbackLogin extends HttpServlet {
	private static final long serialVersionUID = 1L;
	String faculty[]=new String[20];
	String subject[]=new String[20];
	 
	int length;// length of faculty array
	
	int i=0;// to count the number of faculties
    
    public FeedbackLogin() {
    	
        super();
        // TODO Auto-generated constructor stub
    }
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
    	String user=req.getParameter("username").toUpperCase();
		String password=req.getParameter("password");
	    i=0;
	  
		PrintWriter pw=res.getWriter();
	/*	try
		{
			
			Class.forName("com.mysql.jdbc.Driver");
			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/OnlineFeedback","root","root");
			Statement st=con.createStatement();
			
			ResultSet rs=st.executeQuery("select * from faculty");
			while(rs.next())
			{
				i++;
				faculty[i]=rs.getString("facultyname");
			}
			length=faculty.length;
		}catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}*/
	
		try{
			HttpSession aSession = req.getSession();
			int j=0;
			Class.forName("com.mysql.jdbc.Driver");
			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/OnlineFeedback","root","root");
			Statement st=con.createStatement();
			Statement st1=con.createStatement();
			ResultSet rs=st.executeQuery("select * from login where username=+'"+user+"'and password=+'"+password+"'");
			
			if(rs.next())
			{
				ResultSet rs2=st1.executeQuery("select * from facultyscore where username='"+user+"' and over='yes'");
				if(rs2.next())
				{
					 pw.println("<script type=\"text/javascript\">");
				       pw.println("alert('Already Submitted The Feedback!');");
				       pw.println("location='index.html'");
				       pw.println("</script>");
				}
				else
				{
					aSession.setAttribute("studentname", rs.getString("studentname"));
				String section=rs.getString("section");
				String department=rs.getString("department");
				String semester=rs.getString("semester");
				ResultSet rs1=st.executeQuery("select facultyname,subject from faculty where section='"+section+"'and department='"+department+"'and semester='"+semester+"'");
				while(rs1.next())
				{
					i++;
					faculty[i]=rs1.getString("facultyname").toUpperCase();
					subject[i]=rs1.getString("subject").toUpperCase();
				}
				length=faculty.length;

				
				aSession.setAttribute("user", user);
					aSession.setAttribute("section", section);
					aSession.setAttribute("department", department);
					aSession.setAttribute("numberOfFaculty", i);
					aSession.setAttribute("pass", password);
					

					int k=1;
				for(j=0;j<length;j++)
				{
					aSession.setAttribute(Integer.toString(j), faculty[j]);
					aSession.setAttribute(Integer.toString((k*20)+j), subject[j]);
					
					k++;
				}
				/*for(j=0;j<subject.length;j++)
				{
					
					
				}*/
				
				
				aSession.setAttribute("numberOfFaculty", i);
				RequestDispatcher rs3=req.getRequestDispatcher("/login.jsp");
				
				rs3.forward(req, res);
				
				}
			}
			
			else
			{
				   pw.println("<script type=\"text/javascript\">");
			       pw.println("alert('User or password incorrect');");
			       pw.println("location='index.html'");
			       pw.println("</script>");
			       
			}
		

			
		}catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}
}
		
	

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
    	HttpSession aSession=request.getSession();
    	aSession.setAttribute("user", null);
    	aSession.setAttribute("department", null);
		aSession.invalidate();
		PrintWriter pw=response.getWriter();
		pw.println("<script type=\"text/javascript\">");
	       pw.println("alert('Succesfully Signed Out');");
	       
	       pw.println("location='index.html'");
	       pw.println("</script>");
	}

}
