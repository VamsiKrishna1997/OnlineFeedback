import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet("/FeedbackDetails")
public class FeedbackDetails extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public FeedbackDetails() {
        super();
        // TODO Auto-generated constructor stub
    }


	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		HttpSession aSession = req.getSession();
		String user = (String) aSession.getAttribute("user");
		String section=(String)aSession.getAttribute("section");
		Integer nof=new Integer((int) aSession.getAttribute("nof"));
		String comment=req.getParameter("message");
		String faculty[]=new String[nof];
		String subject[]=new String[nof];
		Float score[]=new Float[nof];
		String noc=new String("0");
		noc=(String) aSession.getAttribute("noc");
		int nocc=Integer.parseInt(noc);
		
		int total=0;
		int i=0;
		for(i=0;i<nof;i++)
		{
			total=0;
			faculty[i]=req.getParameter(Integer.toString(i+1));
			subject[i]=req.getParameter(Integer.toString((i+1)*3000));
			for(int j=1;j<8;j++)
			{
				total=total+Integer.valueOf(req.getParameter(Integer.toString((j*20)+i)));
			}
			score[i]=(float) (total/nocc);
			
		}
		PrintWriter pw=res.getWriter();
		/*for(i=0;i<nof;i++)
		{
			pw.println(faculty[i]);
			pw.println(score[i]);
		}*/
		try{
			String dept=null;
			String semester=null;
			int k=0;
			Class.forName("com.mysql.jdbc.Driver");
			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/OnlineFeedback","root","root");
			Statement s=con.createStatement();
			ResultSet r=s.executeQuery("select * from login where username='"+user+"'");
			if(r.next())
			{
				 dept=r.getString("department");
				 semester=r.getString("semester");
				
			}
				
			
			for(i=0;i<nof;i++)
			{
				PreparedStatement ps=con.prepareStatement("insert into facultyscore values(?,?,?,?,?,?,?,?,?)");
			ps.setString(1, faculty[i]);
			ps.setFloat(2, score[i]);
			ps.setString(3, user);
			ps.setString(4, dept);
			ps.setString(5, section);
			ps.setString(6, semester);
			ps.setString(7, subject[i]);
			ps.setString(8, "yes");
			ps.setString(9, comment);
			
			 k=ps.executeUpdate();
			}
			
			if(k>=1)
			{
			doGet(req,res);
			}
			else
			{
				pw.println("<script type=\"text/javascript\">");
			       pw.println("alert('Add UnSuccessfull');");
			       
			       pw.println("</script>");
			}
		}catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}
		
		}


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter pw=response.getWriter();
		HttpSession aSession=request.getSession();
		aSession.invalidate();
		pw.println("<script type=\"text/javascript\">");
	       pw.println("alert('Submitted Successfully');");
	       pw.println("location='index.html'");
	       pw.println("</script>");
	}

}
