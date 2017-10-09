<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Report</title>
<link rel="stylesheet" type="text/css" href="mystyle.css">
<script type="text/javascript">
	function printresult(elem,elem1,elem2)
	{
		var restore=document.body.innerHTML;
		var print=document.getElementById(elem).innerHTML;
		var print1=document.getElementById(elem1).innerHTML;
		var print2=document.getElementById(elem2).innerHTML;
		var printpage=print1+print2+print;
		document.body.innerHTML=printpage;
		window.print();
		document.body.innerHTML=restore;
		
		
	}
</script>
</head>
<body>
<body>
<%HttpSession aSession=request.getSession();
if(aSession.getAttribute("logedin")==null)
{
	PrintWriter pw=response.getWriter();
	pw.println("<script type=\"text/javascript\">");
       pw.println("alert('Session Expired');");
       
       pw.println("location='index.html'");
       pw.println("</script>");
}
%>
<div id="title">
 	<img src="C:\Users\Vamsi Krishna\Desktop\logo.jpg">
 </div>
 <%
 	String home;
 	if(aSession.getAttribute("department1")==null)
 	{
 		home="adminlogin.jsp";
 	}
 	else
 	{
 		home="userlogin.jsp";
 	}
 %>
<div id=menu>
 	<ul>
 		<li><a href="<%=home%>">Home</a>
 		<li><a href="#admin">Admin</a>
 		
 		
 	</ul>
 </div>

 <div id="middle">
 	<h1>Faculty Wise Feedback</h1>
 	
 	
 </div>
  <div id="print">
 <div id="report">
 <form>
 <table>
<tr>
	<th>DEPARTMENT</th>
	<th>SUBJECT</th>
	<th>SECTION</th>
	<th>SEMESTER</th>
	<th>SCORE</th>
</tr>
 <%
 
 	try{
					int i=0;
					String fact=request.getParameter("factname");
					String sub[]=new String[10];
				Class.forName("com.mysql.jdbc.Driver");
				Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/OnlineFeedback","root","root");
				Statement st=con.createStatement();
				Statement st1=con.createStatement();
				ResultSet rs1=st.executeQuery("select facultyname,subject from faculty group by facultyname,subject having facultyname='"+fact+"'");
				PrintWriter pw=response.getWriter();
				String count=null;
				while(rs1.next())
				{
					
					sub[i]=rs1.getString("subject");
					i++;
					
					
				}//while
			int j=0;
				ResultSet rs;
				for(j=0;j<i;j++)
				{
					rs=st1.executeQuery("select department,subject,section,semester,avg(score) from facultyscore group by facultyname,section,semester,department,subject,over having subject='"+sub[j]+"' and over='yes'");	
					while(rs.next())
					{
						%>
						<tr>
							<td><%=rs.getString("department").toUpperCase() %></td>
							<td><%=rs.getString("subject").toUpperCase() %></td>
							<td><%=rs.getString("section").toUpperCase() %></td>
							<td><%=rs.getString("semester").toUpperCase() %></td>
							<td><%=rs.getString("avg(score)").toUpperCase() %></td>
							
						</tr>
					<% }
				
				}
				%>
				</table><% 
				
				
			
		}catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}
		
		
		
		%>
		</div>
 
 </div>
 <div id="printresult">
 <br>

 	<input type="submit" value="PRINT" onclick="printresult('print','title','middle')">
 </div>
 
</body>
</html>