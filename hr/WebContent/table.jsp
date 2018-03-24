<%@ page language="java" contentType="text/html; charset=utf-8"    pageEncoding="utf-8"%>
<%@page import="com.hr.controller.EmployeeServices"%>
<%@page import="com.hr.web.WebUtils"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Table</title>
</head>
<body>
<% 
int id = Integer.parseInt(request.getParameter("ID")); 

EmployeeServices empServices = new EmployeeServices();
Map<String, Object> mapEmp = empServices.getEmployeeData(id);

out.println("<h2>" + mapEmp.get("Firstname") + " " + mapEmp.get("Lastname") + "</h2>");
%>
	<table border=1>
		<tr>
			<th>ปี</th>
			<th>เดือน</th>
			<th>แก้ใข</th>
		</tr>
<%
String selectdate = "SELECT DISTINCT month, year FROM time WHERE UID = '"+id+"' ORDER BY year DESC, month DESC ";
List<Map<String, Object>> listdate = WebUtils.query(selectdate);
for(int i = 0; i < listdate.size(); i++)
{
	Map<String, Object> map = listdate.get(i);
%>		
		<tr>
			<td><%= map.get("year") %></td>
			<td><%= map.get("month") %></td>
			<td><a href="worktime.jsp?ID=<%= id %>&month=<%= map.get("month") %>&year=<%= map.get("year") %>">Table</a></td>
		</tr>
<%
}
%>		
	</table>		
</body>
</html>