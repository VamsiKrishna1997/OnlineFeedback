

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.io.Reader;
import java.io.StringReader;
import java.net.URL;
import java.net.URLConnection;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.text.DateFormatSymbols;
import java.util.Calendar;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lowagie.text.Document;
import com.lowagie.text.DocumentException;
import com.lowagie.text.PageSize;
import com.lowagie.text.html.simpleparser.HTMLWorker;
import com.lowagie.text.pdf.PdfWriter;

/**
 * Servlet implementation class changeSemester
 */
@WebServlet("/changeSemester")
public class changeSemester extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public changeSemester() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		PrintWriter pw=res.getWriter();
		String action=req.getParameter("change");
		if(action.equals("changesemester"))
		{
		try
		{
		Class.forName("com.mysql.jdbc.Driver");
		Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/OnlineFeedback","root","root");
		
		PreparedStatement ps=con.prepareStatement("update login set semester=semester+1");
		int i=ps.executeUpdate();
		PreparedStatement ps1=con.prepareStatement("update facultyscore set over='no' where over='yes'");
		int k=ps1.executeUpdate();
		if(i>=1 && k>=1)
		{
			
		pw.println("<script type=\"text/javascript\">");
		
	       pw.println("alert('Updated Successfully');");
	       pw.println("location='adminlogin.jsp'");
	       pw.println("</script>");
		}
		else
		{
			pw.println("<script type=\"text/javascript\">");
		       pw.println("alert('Update UnSuccessfull');");
		       pw.println("location='adminlogin.jsp'");
		       
		       pw.println("</script>");
		     
		          
		}
	}catch (Exception e) {
		e.printStackTrace();
		// TODO: handle exception
	
	}
	}
		else if(action.equals("delete"))
		{
			try{
			Class.forName("com.mysql.jdbc.Driver");
			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/OnlineFeedback","root","root");
			
			PreparedStatement ps1=con.prepareStatement("delete from facultyscore where over='no'");
			int i=ps1.executeUpdate();
		
			if(i>=1 )
			{
				pw.println("<script type=\"text/javascript\">");
			       pw.println("alert('Delete Successfull');");
			       pw.println("location='adminlogin.jsp'");
			       
			       pw.println("</script>");
			}
			else{
				pw.println("<script type=\"text/javascript\">");
			       pw.println("alert('Delete UnSuccessfull');");
			       pw.println("location='adminlogin.jsp'");
			       
			       pw.println("</script>");
			}
			}catch (Exception e) {
				e.printStackTrace();
				// TODO: handle exception
			}
		}


}
}