<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>AdminLogin</title>
<link rel="stylesheet" type="text/css" href="mystyle.css">
<script>
window.history.forward();
	function change(){
		var c=confirm('Do You Want To Back-up The Data?')
		if(c==false){
		
	}
		else{
			
			
			document.getElementById("backup").click();
			var msg=confirm('Are You Sure To Update The Semester! Once Updated Cannot Be Reversed!')
			if(msg==true)
				{
				document.getElementById("buttonpress").click();
				}
		}
		}
	function signout(){
		document.getElementById("button").click();
	}
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
	
	function deleter()
	{
		var msg=confirm('1) Perform This Feature To Delete Previous Records.\n2) Ensure That You Have Backed Up The Data.\n3) Perform This Feature Only After Updating The Semester.\n4) Press "Cancel" To Go Back.');
		if(msg==true)
			{
				var msg1=confirm('Are You Sure To Delete Them Permanently?')
				if(msg1==true)
					{
						document.getElementById('deletebtn').click();
					}
				else
					{
						
					}
			}
		else
			{
				
			}
	}
	function pdf(){
		document.getElementById("pdfbutton").click();
	}

</script>
<style type="text/css">
#main  ul {
	
  list-style: none;
  padding: 0;
  margin: 0;
  background: #08ad70;
}

#main ul li {

  display: block;
  position: relative;
  float: left;
  background: #08ad70;
}
#main li ul { display: none; }

#main ul li a {
	text-align:center;
	width:120px;
	border-radius:20px;
  display: block;
  padding: 1em;
  text-decoration: none;
  white-space: nowrap;
  color: white;
}

#main ul li a:hover { background:#08ad70 ; }
#main li:hover > ul {

  display: block;
  position: absolute;
  
}

#main li:hover li { float: none; }

#main  li:hover a { background: #08ad70; border: 1px medium grey ; }

#main  li:hover li a:hover { background: #3fbd8e; }

#main  .main-navigation li ul li { border-top: 0; }
#main  ul ul ul {
  left: 100%;
  top: 0;
}
#main  ul:before,
#main  ul:after {
  content: " "; /* 1 */
  display: table; /* 2 */
}

#main ul:after { clear: both; }
</style>
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
 <div id="hidden" hidden>
 <form action="adminsignout" method="get">
 <input type="submit" id="button" hidden >
 </form>
 </div>
 
<div id="main">


 	<ul class="main-navigation">
 		<li><a href="#home">Home</a></li>
 		<li><a href="#admin">Admin</a>
 			<ul>
                <li><a href="#" onclick="change()">Update Semester</a></li>
                <li><a href="#" onclick="<%aSession.setAttribute("department", "all");%>;pdf()" id="backup">Backup Data</a>
                	<!-- <ul>
                		<li><a href="#" onclick="printresult('title','middle','civil')">CIVIL</a></li>
                	    <li><a href="#" onclick="printresult('title','middle','ece')">ECE</a></li>
                	    <li><a href="#" onclick="printresult('title','middle','mech')">ME</a></li>
                	    <li><a href="#" onclick="printresult('title','middle','eee')">EEE</a></li>
                	    <li><a href="#" onclick="printresult('title','middle','cse')">CSE</a></li>
                	    <li><a href="#" onclick="printresult('title','middle','mine')">MINE</a></li>
                	
                	
                	</ul>	 -->
                </li>
                <li><a href="DeleteBatch.jsp">Delete Batch</a></li>
                  <li><a href="#" onclick="deleter()">Delete Records</a></li>
            </ul>
 		</li>

 
 		<li ><a href="#" onclick="signout()" >SignOut</a></li>
 	</ul>
 	<div>
 <form action="ReportServlet" hidden>

<input type="submit" value="Generate PDF report" id="pdfbutton" name="pdfbutton" hidden>
</form>
  </div>
 </div>
 <div id="middle">
 	<h1>Online Feedback</h1>
 	<h3 style="text-decoration: underline">Admin</h3>
 	
 </div>

  <div id="civil" style="display: none;">
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
				<h1 >Department:<strong>Civil</strong></h1>
					
					
					
				
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
				<% rs=st1.executeQuery("select semester,section,department,facultyname,avg(score) from facultyscore group by facultyname,section,semester,over having department='ce' and section='"+section[z]+"' and semester='"+semester[k]+"' and over='yes'");
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


<div id="ece" style="display: none;">
 	<% 
				
				 i=0;
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
				<h1 >Department:<strong>Electronic And Communication Engineering</strong></h1>
					
					
					
				
				<% 
				for(int k=0;k<semester.length;k++)//semester
					{
						
						%><hr />
						<h3>Semester:<%=semester[k]%></h3>
						
					<% 
						for(int z=0;z<section.length;z++)//section
						{
							
							%><h2 >Section:
							<%=section[z]%>
							</h2>
							<table ><tr><th><strong>Faculty</strong></th><th><strong>Score</strong></th></tr>
				<% rs=st1.executeQuery("select semester,section,department,facultyname,avg(score) from facultyscore group by facultyname,section,semester,over having department='ece' and section='"+section[z]+"' and semester='"+semester[k]+"' and over='yes'");
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


  <div id="mech" style="display: none;">
 	<% 
				
				 i=0;
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
					%><hr />
					
				<h1 >Department:<strong>Mechanical Enginnering</strong></h1>
					
					
					
				
				<% 
				for(int k=0;k<semester.length;k++)//semester
					{
						
						%><hr />
						<h2 style="text-decoration: underline;">Semester:<%=semester[k]%></h2>
						
					<% 
						for(int z=0;z<section.length;z++)//section
						{
							
							%><h3 >Section:
							<%=section[z]%>
							</h3>
							<table ><tr><th><strong>Faculty</strong></th><th><strong>Score</strong></th></tr>
				<% rs=st1.executeQuery("select semester,section,department,facultyname,avg(score) from facultyscore group by facultyname,section,semester,over having department='me' and section='"+section[z]+"' and semester='"+semester[k]+"' and over='yes'");
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


<div id="eee" style="display: none;">
 	<% 
				
				 i=0;
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
				<h1 >Department:<strong>Electrical And Electronic Enginnering</strong></h1>
					
					
					
				
				<% 
				for(int k=0;k<semester.length;k++)//semester
					{
						
						%>
						<hr />						
						<h2 style="text-decoration: underline;">Semester:<%=semester[k]%></h2>
						
					<% 
						for(int z=0;z<section.length;z++)//section
						{
							
							%><h3 >Section:
							<%=section[z]%>
							</h3>
							<table ><tr><th><strong>Faculty</strong></th><th><strong>Score</strong></th></tr>
				<% rs=st1.executeQuery("select semester,section,department,facultyname,avg(score) from facultyscore group by facultyname,section,semester,over having department='eee' and section='"+section[z]+"' and semester='"+semester[k]+"' and over='yes'");
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

 
  <div id="cse" style="display: none;">
 	<% 
				
				 i=0;
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
				<h1 >Department:<strong>Computer Science And Enginnering</strong></h1>
					
					
					
				
				<% 
				for(int k=0;k<semester.length;k++)//semester
					{
						
						%>
						<hr />
						<h2 style="text-decoration: underline;">Semester:<%=semester[k]%></h2>
						
					<% 
						for(int z=0;z<section.length;z++)//section
						{
							
							%><h3 >Section:
							<%=section[z]%>
							</h3>
							<table ><tr><th><strong>Faculty</strong></th><th><strong>Score</strong></th></tr>
				<% rs=st1.executeQuery("select semester,section,department,facultyname,avg(score) from facultyscore group by facultyname,section,semester,over having department='cse' and section='"+section[z]+"' and semester='"+semester[k]+"' and over='yes'");
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
 
 
<div id="mine" style="display: none;">
 	<% 
				
				 i=0;
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
				<h1 >Department:<strong>Electronic And Communication Engineering</strong></h1>
					
					
					
				
				<% 
				for(int k=0;k<semester.length;k++)//semester
					{
						
						%>
						<hr />
						<h2 style="text-decoration: underline;" >Semester:<%=semester[k]%></h2>
						
					<% 
						for(int z=0;z<section.length;z++)//section
						{
							
							%><h3>Section:
							<%=section[z]%>
							</h3>
							<table ><tr><th><strong>Faculty</strong></th><th><strong>Score</strong></th></tr>
				<% rs=st1.executeQuery("select semester,section,department,facultyname,avg(score) from facultyscore group by facultyname,section,semester,over having department='mine' and section='"+section[z]+"' and semester='"+semester[k]+"' and over='yes'");
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
 
 
 
 <div id="result" style="display: none;">
 	<% 
					String dept[]=new String[20];
				 i=0;
				try{
				Class.forName("com.mysql.jdbc.Driver");
				Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/OnlineFeedback","root","root");
				Statement st=con.createStatement();
				Statement st1=con.createStatement();
				ResultSet rs1=st.executeQuery("select department from subject group by department");
				PrintWriter pw=response.getWriter();
				while(rs1.next())
				{
					
					dept[i]=rs1.getString("department");
					i++;
					
					
				}//while
			int j=0;
				ResultSet rs;
				for(j=0;j<i;j++)
				{
					%>
					<hr />
				<h1 >Department:<%=dept[j]%></h1>
					
					
					
				
				<% 
				for(int k=0;k<semester.length;k++)//semester
					{
						
						%>
						<hr />
						<h2 style="text-decoration: underline;">Semester:<%=semester[k]%></h2>
						
					<% 
						for(int z=0;z<section.length;z++)//section
						{
							
							%><h3 >Section:
							<%=section[z]%>
							</h3>
							<table ><tr><th><strong>Faculty</strong></th><th><strong>Score</strong></th></tr>
				<% rs=st1.executeQuery("select semester,section,department,facultyname,avg(score) from facultyscore group by facultyname,section,semester,over having department='"+dept[j]+"' and section='"+section[z]+"' and semester='"+semester[k]+"' and over='yes'");
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

 <div id="options" >

 <ul>
 	<li><a href="addStudentOptions.jsp">Student</a></li>
 	<li><a href="addFacultyOptions.jsp">Faculty</a></li>
 	<li><a href="addSubjectOptions.jsp">Subject</a></li>
 	
 	<li><a href="reportmenu.jsp">Show Report</a></li>
 	<li><a href="userOptions.jsp">User Functions</a></li>
 	
 </ul>
 	
</div>
 <div hidden>
 <form action="changesemester" method="post" hidden>
 	<input type="submit" name="change" id="buttonpress" value="changesemester" hidden>
 	<input type="submit" name="change" value="delete" id="deletebtn" hidden>
 	
 </form>
 </div>

</body>	
</html>