<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<div id="result" style="display: none;">
 	<% String section[]={"a","b","c","d"};
	String semester[]={"1","2","3","4","5","6","7","8"};
					String dept[]=new String[20];
				int i=0;
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

</body>
</html>