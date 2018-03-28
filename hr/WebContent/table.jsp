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
	Object strUserID = session.getAttribute("sUserID");
	if(strUserID == null)
	{
		response.sendRedirect("index.jsp");
	}	
	int id = Integer.parseInt(request.getParameter("ID")); 
	
	EmployeeServices empServices = new EmployeeServices();
	Map<String, Object> mapEmp = empServices.getEmployeeData(id);
	
	out.println("<h2>" + mapEmp.get("firstname") + " " + mapEmp.get("lastname") + "</h2>");
	%>
	<a href="work.jsp?ID=<%= id %>&actions=create">+เพิ่มข้อมูล</a>
	<table border=1>
		<tr>
			<th>ปี</th>
			<th>เดือน</th>
			<th>แก้ใข / ลบ</th>
		</tr>
	<%
	String selectdate = "SELECT DISTINCT month, year FROM time WHERE uid = '"+id+"' ORDER BY year DESC, month DESC ";
	List<Map<String, Object>> listdate = WebUtils.query(selectdate);
	for(int i = 0; i < listdate.size(); i++)
	{
		Map<String, Object> map = listdate.get(i);
	%>		
		<tr>
			<td><%= map.get("year") %></td>
			<td><%= map.get("month") %></td>
			<td>
				<a href="work.jsp?ID=<%= id %>&month=<%= map.get("month") %>&year=<%= map.get("year") %>&actions=edit">แก้ใข</a>
				/
				<a href="workdelete.jsp?ID=<%= id %>&month=<%= map.get("month") %>&year=<%= map.get("year") %>">ลบ</a>
			</td>
		</tr>
	<%
	}
	%>		
	</table>
	<br>
	<button><a onclick="window.location='./main.jsp'"> กลับ </a></button>	
</body>
</html>