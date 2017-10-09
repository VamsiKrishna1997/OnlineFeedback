<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>User</title>
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
 	<h3 style="text-decoration: underline">Admin</h3>
 	</div>
 	
 	
<div id="options" >

 <ul>
 <li><a href="AddUser.jsp">Add User</a></li>
 	<li><a href="DeleteUser.jsp">Delete User</a></li>
 	<li><a href="ShowUser.jsp">Show User</a></li>
 	<li><a href="GrantPermissions.jsp">Grant User Permissions</a></li>
 </ul>
 	
</div>

</body>
</html>