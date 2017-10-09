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
 	<h1>Subject Wise Feedback</h1>
 	
 	
 </div>
  <div id="print">
 <div id="report">
 	<table >
 		<h2 style="text-decoration: underline;">
 		<%String department=request.getParameter("studentdept");
 		out.println(department.toUpperCase());%>
 		</h2>
 		<h3 style="text-decoration: underline;">
 			Subject : <%String subject=request.getParameter("facultysub");
 		out.println(subject.toUpperCase());%>
 		</h3>
 		<h3 style="text-decoration: underline;">
 			Semester : <%String semester=request.getParameter("semester");
 		String sem=null;
 		if(semester.equals("1")){
 			sem="I/I";
 		}
 		else if(semester.equals("2")){
 			sem="I/II";
 		}
 		else if(semester.equals("3")){
 			sem="II/I";
 		}
 		else if(semester.equals("4")){
 			sem="II/II";
 		}
 		else if(semester.equals("5")){
 			sem="III/I";
 		}
 		else if(semester.equals("6")){
 			sem="III/II";
 		}
 		else if(semester.equals("7")){
 			sem="IV/I";
 		}
 		else if(semester.equals("8")){
 			sem="IV/II";
 		}
 		out.println(sem.toUpperCase());%>
 		</h3>
 		<tr>
 			<th>Faculty</th>
 			
 			<th>Section</th>
 			<th>Score</th>
 			
 			</tr>
 			<%
 				try{
 					
 					Class.forName("com.mysql.jdbc.Driver");
 					Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/OnlineFeedback","root","root");
 					Statement st=con.createStatement();
 					ResultSet rs=st.executeQuery("select facultyname,semester,department,subject,section,avg(score) from facultyscore group by facultyname,section,semester,department,over having semester='"+semester+"' and department='"+department+"' and subject='"+subject+"' and over='yes'");
 					while(rs.next())
 					{	
 						%>
 						<tr>
 					    <td><%=rs.getString("facultyname") %></td>
 					    <td><%=rs.getString("section") %></td>
 					    <td><%=rs.getFloat("avg(score)") %></td>
 					   
 					</tr>
					<%
 					}
 					%></table>
 					<%
 					st.close();
 					rs.close();
 				
 					
 					
 				}catch(Exception e){
 					e.printStackTrace();
 				}
 			
 			%>
 			
 			</form>
 
 </div>
 </div>
 <div id="printresult">
 <br>

 	<input type="submit" value="PRINT" onclick="printresult('print','title','middle')">
 </div>
 
</body>
</html>