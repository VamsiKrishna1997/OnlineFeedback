<%@page import="java.sql.*"%>
<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Grant Permissions</title>
<link rel="stylesheet" type="text/css" href="mystyle.css">
<script type="text/javascript">
window.history.forward();
</script>
</head>
<script src="js/jquery-1.11.1.js" type="text/javascript"></script>
<script >
$(document).ready(function() {

	$('#studentdept').change(function(event) {
	        var department = $("select#studentdept").val();
	        
	        $.get('showuser', {
	        	departmentName : department,
	        	
	        }, function(response) {

	        var select = $('#user');
	        select.find('option').remove();
	          $.each(response, function(index, value) {
	          $('<option>').val(value).text(value).appendTo(select);
	      });
	        });
	        });
	});
</script>
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
<div id="grantpermission">
 		<form action="grantpermission" method="post">
 			<table align="center" >
 		<tr>
 			<th colspan="2" style="text-align: center">Grant Permission</th>
 		</tr>
 		<tr>
 			<td>Select Department:</td>
 			<td>
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
 		</tr>
 		<tr>
 					<td>Select User:</td>
 					<td>
 						<select id="user" name="user">
 							<option>Select User</option>
 						</select>
 					</td>
 				</tr>
 		<tr>
 			<td>Grant Permissions:</td>
 			<td>
 			<input type="checkbox" name="checkbox" value="as">Add Student
 			<input type="checkbox" name="checkbox" value="ds">Delete Student
		<input type="checkbox" name="checkbox" value="asj">Add Subject<br>
		
		<input type="checkbox" name="checkbox" value="dsj">Delete Subject
		<input type="checkbox" name="checkbox" value="af">Add Faculty
		<input type="checkbox" name="checkbox" value="df">Delete Faculty<br>
		<input type="checkbox" name="checkbox" value="sf">Show Faculty
		<input type="checkbox" name="checkbox" value="sr">Show Report
		
		
 			</td>
 		</tr>
 		<tr>
 			<th colspan="2" style="text-align: center;">
 				<input type="submit" value="Grant Permissions" style="width: 150px;text-align: center">
 			</th>
 		</tr>
 			</table>
 			</form>
 			</div>
 			
</body>
</html>