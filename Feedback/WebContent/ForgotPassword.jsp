<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Forgot Password</title>
<link rel="stylesheet" type="text/css" href="mystyle.css">
 	<script>
 	window.history.forward();
	function Myfunction(){
		document.getElementById("button").disabled = true;
		window.setTimeout(setdisable,6000);
		
	}
	function setdisable(){
		document.getElementById("button").disabled = false;
	}
</script>
</head>
<body>
<div id="title">
 	<img src="C:\Users\Vamsi Krishna\Desktop\logo.jpg">
 </div>
<div id=menu>
 	<ul>
 		<li><a href="index.html">Home</a>
 		<li><a href="#admin">Admin</a>
 	
 	
 	</ul>
 </div>
 <div id="middle">
 	<h1>Online Feedback</h1>
 </div>
 <div id="forget">
 <form action="forgotpassword" method="post">
 	<h2>Lets get you into your account</h2>
 	<p>Tell us your registered email to get started:</p>
 	<input type="text" placeholder="Email address" id="email" name="email" required>
 	<input type="submit" value="Continue" id="button" onclick="Myfunction()">

 </form>
 </div>
</body>
</html>