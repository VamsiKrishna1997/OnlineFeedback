<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Report</title>
<link rel="stylesheet" type="text/css" href="mystyle.css">
<script src="js/jquery-1.11.1.js" type="text/javascript"></script>
<script >
$(document).ready(function() {

	$('#factid').change(function(event) {
		var factid=$('#factid').val();
	        $.get('facultyWise', {
	        	factId:factid
	        }, function(response) {

	        
	          $.each(response, function(index,value) {
	          $('#factname').val(value);
	      });
	        });
	        });
	});
</script>
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
 <div id="facultywise">
 		<form action="FacultyWise1.jsp" method="post">
 			<table align="center" >
 			<tr>
 			<th colspan="2" style="text-align: center">Faculty Wise Report</th>
 		</tr>
 			<tr>
 			<td>
 				Faculty ID:
 				</td>
 				<td>
 					<input type="text" id="factid" name="factid" placeholder="Eg.123">
 				</td>
 			</tr>
 			<tr>
 				<td>
 					Faculty Name:
 				</td>
 				<td>
 					<input type="text" id="factname" name="factname" readonly>
 				</td>
 			</tr>
 				<tr>
 					
 					<td colspan="2" style="text-align: center"><center><input type="submit" value="Show" ></center></td>
 				</tr>
 				
 			</table>
 		</form>
 	</div>

</body>
</html>