<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Delete Student</title>
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
<div id="deletestudent">
 		<form action="deletestudent" method="post">
 			<table align="center" >
 			<tr>
 			<th colspan="2" style="text-align: center">Delete Student</th>
 		</tr>
 			
 			<tr>
 					<td>Student Id:</td>
 					<td><input type="text" name="studentid"  required></td>
 				</tr>
 				
 				
 				<tr>
 					<td>Student Department:</td>
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
 					<td>Student Section:</td>
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
 				
 					
 					<td colspan="2" style="text-align: center"><center><input type="submit" value="Delete Student" ></center></td>
 				</tr>
 				
 			</table>
 		</form>
 	</div>
</body>
</html>