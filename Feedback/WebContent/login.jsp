<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Feedback</title>
<link rel="stylesheet" type="text/css" href="mystyle.css">
<script src="js/jquery-1.11.1.js" type="text/javascript"></script>
<script >


window.history.forward();




function myFunction1(){
	document.getElementById('btn1').click();
}
	function myFunction(){
		
		var r=confirm("Are You Sure,You Want To Submit The Feedback ?");
		if(r==true)
			{
			 
				document.getElementById('button').click();
				
			}
		else
			{
				
			}
	}
	function textCounter(field,field2,maxlimit)
	{
	 var countfield = document.getElementById(field2);
	 if ( field.value.length > maxlimit ) {
	  field.value = field.value.substring( 0, maxlimit );
	  return false;
	 } else {
	  countfield.value = maxlimit - field.value.length;
	 }
	}
	

function start(){
	
	var interval=setInterval(timer1,1000);
	var counter=0;
	var timeleft=600;
	var timer=document.getElementById('timer');
	timer.innerHTML=(convertSeconds(timeleft-counter));
	function timer1(){
		counter++;
	    timer.innerHTML=(convertSeconds(timeleft-counter));
	    if((timeleft-counter)=="60")
	    {
	    
	    	alert('Only 1 Minute left');
	        timer.style.color="#ff0000";
	        
	    }
	    if(counter==timeleft)
	    {
	    	clearInterval(interval);
	        myFunction1();
	       
	    }
	}
	}
	
	function convertSeconds(s){
		var minutes=Math.floor(s/60);
	    var seconds=s%60;
	    if(minutes.toString().length==1)
	    {	
	    	minutes="0"+minutes;
	       
	    }
	    if( seconds.toString().length==1){seconds="0"+seconds}
	    return minutes+ ':'+ seconds;
	}

	
	
	
	


</script>
</head>

<body onload="start()" >

<%HttpSession aSession=request.getSession();
if(aSession.getAttribute("user")==null)
{
	PrintWriter pw=response.getWriter();
	pw.println("<script type=\"text/javascript\">");
       pw.println("alert('Successfull Signed Out');");
       
       pw.println("location='index.html'");
       pw.println("</script>");
}
%>
<div id="title">
 	<img src="C:\Users\Vamsi Krishna\Desktop\logo.jpg">
 	<strong><p id="timer" style="font-size:50px;display: inline; position: absolute;top: 0;right: 0;padding:3px;"></p></strong>
 </div>
  <div id=menu>
 	<ul>
 		<li><a href="#" id="home">Home</a></li>
 		<li><a href="#admin">Admin</a></li>
 		
 		
 		<li><a href="" onclick="myFunction1()">SignOut</a></li>
 	</ul>
 </div>
 <div id="middle">
 	<h1>Online Feedback</h1>
 	<%
 	
 	
 	out.println("<h2>Hello "+aSession.getAttribute("user")+"("+aSession.getAttribute("studentname")+") ,</h2>");	%>
 	
 </div>
 <div id="hidden">
  <form action="signout" method="get">
 	<input type="submit" id="btn1" name="btn1" hidden>
 </form>
 </div>


 <div id="options" >
 <form action="submit" method="post" >
 	<table border="1px" >
 	
 		<tr>
 		<th >
 			Faculty Name 
 			
 		</th>
 		<th >
 			Subject Name 
 			
 		</th>
 		<th>
 		Regularity In Taking Classes
 		</th>
 		<th>
 		Completes Syllabus In Time
 		</th>
 			<th>
 		Communication Skills
 		</th>
 			<th>
 		Creating Interest In The Subject
 		</th>
 			<th>
 		Using Black Board
 			</th>
 			<th>
 		Knowledge In The Subject
 		</th>
 			<th>
 		Using Presentations In Class
 		</th>
 		
 		</tr>
 	 		
 		<%
 			aSession.setAttribute("noc", "7");
 		
 			int numberOfFaculty=(int)(aSession.getAttribute("numberOfFaculty"));
 		
 			aSession.setAttribute("nof", numberOfFaculty);
 		    int i=0;
 			int j=0;
 			int k=1;
 			int temp=0;
 			for(i=0;i<numberOfFaculty;i++)
 			{
 				
 					k++;
 				%>
 				<tr>
 		          <td>
 		          <% if(i%2==0)
 		        	  {%>
 		 		    <input type="text" value="<%out.print(aSession.getAttribute(Integer.toString(i+1))); %>" readonly="readonly" name="<%out.print(i+1); %>" style="border:0px;">
 					</td>
 					<td>
 					<input type="text" value="<%out.print(aSession.getAttribute(Integer.toString((k*20)+i+1))); %>" readonly="readonly" name="<%out.print((i+1)*3000); %>" style="border:0px;width:160px;font-size: 12px;">
 					</td>
 				<%}else{ %>
 			
 				<input type="text" value="<%out.print(aSession.getAttribute(Integer.toString(i+1))); %>" readonly="readonly" name="<%out.print(i+1); %>" style="border:0px;background-color: #E5E4D7 ">
 				</td>
 				<td>
 				<input type="text" value="<%out.print(aSession.getAttribute(Integer.toString((k*20)+i+1))); %>" readonly="readonly" name="<% out.print((i+1)*3000);%>" style="border:0px;background-color: #E5E4D7;width:160px;font-size: 12px;">
 				</td>
 				<%} %>
 				</td>
 				<%
 					for(j=1;j<8;j++)
 					{
 						
 						%>
 						<td>
 		<center>
 			<select  name="<%out.print((j*20)+i);%>" required>
 				<option value="">Select...</option>
 				<option value="1">1</option>
 				<option value="2">2</option>
 				<option value="3">3</option>
 				<option value="4">4</option>
 				<option value="5">5</option>
 				<option value="6">6</option>
 				<option value="7">7</option>
 				<option value="8">8</option>
 				<option value="9">9</option>
 				<option value="10">10</option>
 			</select>
 			</center>
 		</td>
 		<%
 					}
 				%>
 				</tr>
 				<%
 				}
 	%>
 		
 		
 		
 	</table>
	<br>
 	<input type="submit" style="display:none;" id="button">
 	<br>
 	<br>
 	Comments(Optional) :<br>
 	<textarea rows="6" name="message" style="width: 400px" id="message"   onkeyup="textCounter(this,'counter',500)"></textarea>
 	Characters Remaining: <input readonly type="text"  size="3" maxlength="3" value="500" id="counter">
 	
 	</form> 
 
 	<br>
 	<br>
 	<input type="submit" value="Submit" onclick="myFunction()">
 
 </div>

</body>
</html>