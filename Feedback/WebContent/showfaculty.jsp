<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Show Faculty</title>
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

  
 <div id="showfaculty">
 	<table >
 		<h2 style="text-decoration: underline;">
 		<%String department=request.getParameter("studentdept");
 		out.println(department.toUpperCase());%>
 		</h2>
 		<h3 style="text-decoration: underline;">
 			Section : <%String section=request.getParameter("sectionselect");
 		out.println(section.toUpperCase());%>
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
 		<tr>
 			<th>Faculty ID</th>
 			
 			<th>Faculty Name</th>
 			<th>Faculty Subject</th>
 			
 			</tr>
 			<%
 				try{
 					
 					Class.forName("com.mysql.jdbc.Driver");
 					Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/OnlineFeedback","root","root");
 					Statement st=con.createStatement();
 					ResultSet rs=st.executeQuery("select facultyid,facultyname,subject from faculty where section='"+section+"' and department='"+department+"' and semester='"+semester+"'");
 					while(rs.next())
 					{
 						%>
 						<tr>
 					    <td><%=rs.getString("facultyid") %></td>
 					    <td><%=rs.getString("facultyname") %></td>
 					     <td><%=rs.getString("subject") %></td>
 					   
 					</tr>
					<%
 					}
 					%></table>
 					<%
 					st.close();
 					rs.close();
 					con.close();
 					
 					
 				}catch(Exception e){
 					e.printStackTrace();
 				}
 			
 			%>
 			
 

 </div>
</body>
</html>