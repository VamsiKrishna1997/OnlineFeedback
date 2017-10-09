<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>AdminLogin</title>
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
 	<h1>Online Feedback</h1>
 	
 	
 </div>
 
 <div id="result">
 <form action="report.jsp"  >
<table align="center">
	<tr>
		<th colspan="2" style="text-align: center">
			Report Class Wise
		</th>
	</tr>
	<tr>
	<td>	
		Select Department:
	</td>
		<td>
 						<%if(aSession.getAttribute("department1")!=null)
 					{
 						String dept=(String)aSession.getAttribute("department1");
 					%>
 					
 					<input type="text"  id="studentdept" name="studentdept" value="<%=dept.toUpperCase()%>" readonly>
 					<%
 					}else if(aSession.getAttribute("department1")==null){%>
 						<select id="studentdept" name="studentdept" required>
 							<option value="">Select Department</option>
 							<option value="ce">CIVIL ENGINEERING</option>
 							<option value="eee">ELECTRICAL AND ELECTRONIC ENGINEERING</option>
 							<option value="me">MECHANICAL ENGINNERING</option>
 							<option value="ece">ELECTRONICS AND COMMUNICATION ENGINNERING</option>
 							<option value="cse">COMPUTER SCIENCE AND ENGINNERING</option>
 							<option value="mine">MINING ENGINNERING</option>
 						</select>
 					</td>
 					<%} %>
	</tr>
	<tr>
 					<td> Section:</td>
 					<td>
 					
 						<select id="sectionselect" name="sectionselect" required>
 							<option value="">Select Section</option>
 							<option value="a">A</option>
 							<option value="b">B</option>
 							<option value="c">C</option>
 							<option value="d">D</option>
 						</select>
 					
 					</td>
 				</tr>	
 						<tr>
 					<td> Semester:</td>
 					<td>
 					
 						<select id="semester" name="semester" required>
 							<option value="">Select Semester</option>
 							<option value="1">I/I</option>
 							<option value="2">I/II</option>
 							<option value="3">II/I</option>
 							<option value="4">II/II</option>
 							<option value="5">III/I</option>
 							<option value="6">III/II</option>
 							<option value="7">IV/I</option>
 							<option value="8">IV/II</option>
 						</select>
 					
 					</td>
 				</tr>
 				<tr>
 					<th colspan="2">
 						<center><input type="submit" value="Show" id="button" ></center>
 					</th>
 				</tr>
</table>
 </form>
 </div>
</body>
</html>