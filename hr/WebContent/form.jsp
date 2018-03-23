<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*" %>
<%@page import="java.util.Date" %> 
<%@page import="java.text.DateFormat" %>
<%@page import="java.text.SimpleDateFormat" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<form method="POST" action="table.jsp" >

	<select name="name">
		<option value="">--Select--</option>
		<%
		Class.forName("com.mysql.jdbc.Driver");
		Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/hr" +
				"?user=root&password=password");
		Statement s = connect.createStatement();
		ResultSet row = s.executeQuery("SELECT ID, Firstname FROM employee_user");
		while(row.next()){
			out.println(row.getString("Firstname"));					
		%>			  
		<option value='<%= row.getString("ID") %>'><%= row.getString("Firstname") %></option>
		<% 
		}
		%>
	</select>
	
	Income per Hour:
	<input name="sal" type="text" value="100" size="4">&nbsp;
	Month:
	<select name="month">
		  <option value="01">Jan</option>
		  <option value="02">Feb</option>
		  <option value="03">Mar</option>
		  <option value="04">Apr</option>
		  <option value="05">May</option>
		  <option value="06">Jun</option>
		  <option value="07">Jul</option>
		  <option value="08">Aug</option>
		  <option value="09">Sep</option>
		  <option value="10">Oct</option>
		  <option value="11">Nov</option>
		  <option value="12">Dec</option>
	</select>&nbsp;
	Year:
	<input name="year" type="number" min="1111" max="9999" step="1" value="2561">&nbsp;
	<input type="submit" name="submit" value="Cal.">
</form>

</body>
</html>