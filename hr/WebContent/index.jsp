<%@ page language="java" contentType="text/html; charset=utf-8"    pageEncoding="utf-8"%>
<%@page import="java.sql.*" %>
<%@page import="java.util.Date" %> 
<%@page import="java.text.DateFormat" %>
<%@page import="java.text.SimpleDateFormat" %>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<body>
<%
SimpleDateFormat hms = new SimpleDateFormat("HH:mm:ss");
out.println(hms.format(new Date()) + "<br>");

Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/hr" +
		"?user=root&password=password");
Statement s = connect.createStatement(); 

if(request.getParameter("Action") != null)	
{

	try {
		Class.forName("com.mysql.jdbc.Driver");
		
		connect =  DriverManager.getConnection("jdbc:mysql://localhost/hr" +
				"?user=root&password=password");
		
		String username = request.getParameter("txtUsername");
		String password = request.getParameter("txtPassword");
		
		s = connect.createStatement();
		
		String sql = "SELECT * FROM  employee_user WHERE " +
		" Username = '" + username + "' AND " + 
		" Password = '" + password + "' ";
		
		ResultSet rec = s.executeQuery(sql);
		
		if(!rec.next())
		{
			out.print("<font color=red>Username and Password Incorrect!</font>");
		} else {
			rec.first();
			session.setAttribute("sUserID",rec.getString("ID"));	
			response.sendRedirect("main.jsp");
		}
		
		} catch (Exception e) {
			// TODO Auto-generated catch block
			out.println(e.getMessage());
			e.printStackTrace();
		}
	
		try {
			if(s!=null){
				s.close();
				connect.close();
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			out.println(e.getMessage());
			e.printStackTrace();
		}
	
}
	
%>
<form name="frmLogin" method="post" action="index.jsp?Action=Login">
	Login<br>
	<table border="1" style="width: 300px">
		<tbody>
		<tr>
			<td> &nbsp;Username</td>
			<td>
			<input name="txtUsername" type="text" id="txtUsername">
			</td>
		</tr>
		<tr>
			<td> &nbsp;Password</td>
			<td><input name="txtPassword" type="password" id="txtPassword">
			</td>
		</tr>
		</tbody>
	</table>
	<br>
	<input type="submit" name="Submit" value="Login">
</form>
		
</body>
</html>