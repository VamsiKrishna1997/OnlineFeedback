<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Change Password</title>
<link rel="stylesheet" type="text/css" href="mystyle.css">
<script>
	window.history.forward();
</script>
</head>
<body>


<div id="title">
 	<img src="C:\Users\Vamsi Krishna\Desktop\logo.jpg">
 </div>
  <div id=menu>
 	<ul>
 		<li><a href="index.html">Home</a>

 	</ul>
 </div>
 <div id="middle">
 	<h1>Online Feedback</h1> 	
 </div>

<div>
<form action="changepassword" method="post">
	<table align="center">
		<tr>
			<th colspan="2">Change Password</th>
		</tr>
		<tr>
			<td>Student Id:</td>
			<td>
				<input type="text" name="username" id="username" required>
			</td>
		</tr>
				<tr>
			<td>
				Old Password:
			</td>
			<td>
				<input type="password" name="oldpassword" id="oldpassword" required>
			</td>
		</tr>
			<tr>
			<td>
				New Password:
			</td>
			<td>
				<input type="password" name="newpassword" id="newpassword" required>
			</td>
		</tr>
			<tr>
			<td>
				Re-Type Password:
			</td>
			<td>
				<input type="password" name="repassword" id="repassword" required>
			</td>
			</tr>
			<tr>
				<th colspan="2">
				<center>
					<input type="submit" value="Change" id="btn" >
				
				</center>
				</th>
			</tr>
	</table>
	
</form>
</div>
</body>
</html>