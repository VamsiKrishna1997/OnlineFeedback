<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>UserLogin</title>
<link rel="stylesheet" type="text/css" href="mystyle.css">
<script>
window.history.forward();
function printresult(elem,elem1,elem2)
{
	var restore=document.body.innerHTML;
	var print=document.getElementById(elem).innerHTML;
	var print1=document.getElementById(elem1).innerHTML;
	var print2=document.getElementById(elem2).innerHTML;
	var printpage=print+print1+print2;
	document.body.innerHTML=printpage;
	window.print();
	document.body.innerHTML=restore;
	
	
}
function signout(){
	document.getElementById("button").click();
}
function pdf(){
	document.getElementById("pdfbutton").click();
}
</script>
</head>
<body>
<%HttpSession aSession=request.getSession();
if(aSession.getAttribute("userlogedin")==null)
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
 <div id="hidden" hidden>
 <form action="adminsignout" method="get">
 <input type="submit" id="button" hidden >
 </form>
 </div>
 
<div id="menu">


 	<ul >
 		<li><a href="#home">Home</a></li>
 		<li><a href="#admin">Admin</a>
        <li><a href="#" onclick="pdf()" id="backup">Backup Data</a></li>
        <li ><a href="#" onclick="signout()" >SignOut</a></li>
 	</ul>
 	
 </div>
 <%String department=(String)aSession.getAttribute("department"); %>
 <div id="middle">
 	<h1>Online Feedback</h1>
 	<h3 style="text-decoration: underline">User</h3>
 	<input type="text" value="<%=department%>" style="display: none;" name="department" id="department">
 </div>
 <div>
 <form action="ReportServlet" hidden>

<input type="submit" value="Generate PDF report" id="pdfbutton" name="pdfbutton" hidden>
</form>
  </div>
  <div id="result" style="display: none;">
 	<% String section[]={"a","b","c","d"};
					String semester[]={"1","2","3","4","5","6","7","8"};
				
				int i=0;
				
				try{
					
				Class.forName("com.mysql.jdbc.Driver");
				Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/OnlineFeedback","root","root");
				Statement st=con.createStatement();
				Statement st1=con.createStatement();
				PrintWriter pw=response.getWriter();
			int j=0;
				ResultSet rs;
				for(j=0;j<1;j++)
				{
					%>
					<hr />
				<h1 >Department:<strong><%=department%></strong></h1>
					
					
					
				
				<% 
				for(int k=0;k<semester.length;k++)//semester
					{
						
						%><hr />
						<h2 style="text-decoration: underline"><strong>Semester:</strong><%=semester[k]%></h2>
						
					<% 
						for(int z=0;z<section.length;z++)//section
						{
							
							%><h3>Section:
							<%=section[z]%>
							</h3>
							<table ><tr><th><strong>Faculty</strong></th><th><strong>Score</strong></th></tr>
				<% rs=st1.executeQuery("select semester,section,department,facultyname,avg(score) from facultyscore group by facultyname,section,semester,over having department='"+department+"' and section='"+section[z]+"' and semester='"+semester[k]+"' and over='yes'");
				while(rs.next())
				{
					%>
					<tr>
						<td>
					<%=rs.getString("facultyname")%>
						</td>
					<td>
					<%=rs.getString("avg(score)")%>
					</td>
				</tr>
				<% }//while%>
				</table>
				<% 
						}//inner second for
						
				}//inner for
					
			
			}//outer for
		}catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}
		
		
		
		%>
		</div>
		
	<%

int length1=0;
String permissionlist="";
String permission[]=new String[10];
String username=(String)aSession.getAttribute("username");
try{
	
	
	Class.forName("com.mysql.jdbc.Driver");
	Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/OnlineFeedback","root","root");
	Statement st=con.createStatement();
	ResultSet rs=st.executeQuery("select permission from admin where username='"+username+"'");
	if(rs.next())
	{
		 permissionlist=rs.getString(1);
	}
 String permissions[]=permissionlist.split("\\s*,\\s*");
 int p=0;
 for(String string:permissions){
	 permission[p]=string;
	 p++;
	 
 }
	 length1=permissions.length;
}catch(Exception ex){
	ex.printStackTrace();

}
%> <div id="options">
<ul><%		
for(int k=0;k<length1;k++)
{

	if(permission[k].equals("as"))
	{
		
		%><li><a href="AddStudent.jsp">Add Student</a></li><% 
	}
	if(permission[k].equals("ds"))
	{
		%><li><a href="DeleteStudent.jsp">Delete Student</a></li> <% 
	}
	if(permission[k].equals("asj"))
	{
		%><li><a href="AddSubject.jsp">Add Subject</a></li><% 
	}
	if(permission[k].equals("dsj"))
	{
		%><li><a href="DeleteSubject.jsp">Delete Subject</a></li><% 
	}
	if(permission[k].equals("af"))
	{
		%><li><a href="AddFaculty.jsp">Add Faculty</a></li><% 
	}
	if(permission[k].equals("df"))
	{
		%><li><a href="DeleteFaculty.jsp">Delete Faculty</a></li><% 
	}
	if(permission[k].equals("sf"))
	{
		%><li><a href="showfacultysection.jsp">Show Faculty</a></li><% 
	}
	if(permission[k].equals("sr"))
	{
		%><li><a href="reportmenu.jsp">Show Report</a></li><% 
	}
	
}
%>	
</ul>
</div>
</body>
</html>