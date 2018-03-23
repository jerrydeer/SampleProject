<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*" %> 
<%@page import="java.util.Date" %>
<%@page import="java.text.SimpleDateFormat" %> 
   
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<%
	/*
	Object strUserID = session.getAttribute("sUserID");
	if(strUserID == null) // Check Login
	{
		response.sendRedirect("index.jsp");
	}			
	*/
	Class.forName("com.mysql.jdbc.Driver");
	Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/hr" +
			"?user=root&password=password");
	Statement conn = connect.createStatement();
	Connection connect2 = DriverManager.getConnection("jdbc:mysql://localhost/hr" +
			"?user=root&password=password");
	Statement conn2 = connect2.createStatement();
	%>
	<h2>Employee List</h2>
	<a href="">Add Profile</a>
	<table border="1">
	<tr>
		<th>ID</th>
		<th>FullName</th>
		<th>Rank</th>
		<th>Table / Edit / Delete</th>
	</tr>
	<%
//		String sql3 = "SELECT * FROM  employee_user WHERE ID = '" + strUserID.toString() + "' ";	
		String sql = "SELECT * FROM  employee_user";
		ResultSet rows = conn.executeQuery(sql);				
		while(rows.next()){
		%>	
	<tr>
		<td><%= rows.getString("ID") %></td>
		<td><%= rows.getString("Firstname") %></td>
		<td>
		<%   
		ResultSet rows2 = conn2.executeQuery("SELECT * FROM info_user WHERE ID = '"+rows.getString("Rank")+"' ");
		while(rows2.next()){
			out.println(rows2.getString("Rankname"));
		}
		%>
		</td>
		<td>
		<a href="">Table</a> /
		<a href="edit.jsp?ID=<%= rows.getString("ID") %>">Edit</a> /
		<a href="">Delete</a>
		</td>
	</tr>	
	<%
   	}		
	%>
	</table>
</body>
</html>