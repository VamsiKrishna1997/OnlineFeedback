<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Show User</title>
<link rel="stylesheet" type="text/css" href="mystyle.css">
</head>
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
<div id=menu>
 	<ul>
 		<li><a href="adminlogin.jsp">Home</a>
 		<li><a href="#admin">Admin</a>
 	
 		
 	</ul>
 </div>
 <div id="middle">
 	<h1>Online Feedback</h1>
 	
 	</div>
 	<%
 	String dept= request.getParameter("userdept");
 	PrintWriter pw=response.getWriter();
 	try{
		Class.forName("com.mysql.jdbc.Driver");
		Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/OnlineFeedback","root","root");
		Statement st=con.createStatement();
		ResultSet rs=st.executeQuery("select username,password from admin where department='"+dept+"'");
	%>
	<table align="center">
					
					<tr>
						<th>User Name</th>
						<th>Password</th>
					</tr>
						<%
		while(rs.next())
		{
			%>
				<tr>
					<td><%=rs.getString("username") %></td>
					<td><%=rs.getString("password") %></td>
				</tr>
					
				
			
			<% 
		}
		%></table><% 
	}catch (Exception e) {
		e.printStackTrace();
		// TODO: handle exception
	}
 	
 	%>

</body>
</html>