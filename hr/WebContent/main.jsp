<%@ page language="java" contentType="text/html; charset=utf-8"    pageEncoding="utf-8"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="com.hr.web.WebUtils"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Employee List</title>
</head>
<body>
	<%
	Object strUserID = session.getAttribute("sUserID");
	if(strUserID == null)
	{
		response.sendRedirect("index.jsp");
	}
	if("logout".equals(request.getParameter("action"))){
		session.invalidate();
		response.sendRedirect("index.jsp");
	}

	String sql = "SELECT u.*, r.rankname FROM  employee_user u left join info_user r on u.rank = r.id ORDER BY id ASC";
	List<Map<String, Object>> list = WebUtils.query(sql);	
	%>
	<h2>รายชื่อพนักงาน</h2>
	<a href="insert.jsp">+เพิ่มข้อมูลพนักงาน</a>
	
	<table border="1">	
	<tr>
		<th>ID</th>
		<th>ชื่อ นามสกุล</th>
		<th>ตำแหน่ง</th>
		<th>ตารางเวลา / แก้ใข / ลบ</th>
	</tr>
	<%
	for(int i = 0; i < list.size(); i++)
	{
		Map<String, Object> map = list.get(i);
	%>	
	<tr>
		<td><%= map.get("id") %></td>
		<td><%= map.get("firstname") %>&nbsp;<%= map.get("lastname") %></td>
		<td>
			<%=	map.get("rankname")	%>
		</td>
		<td>
		<a href="table.jsp?ID=<%= map.get("id") %>">ตารางเวลา</a> /
		<a href="edit.jsp?ID=<%= map.get("id") %>">แก้ใข</a> /
		<a href="delete.jsp?ID=<%= map.get("id") %>">ลบ</a>
		</td>
	</tr>	
	<%
   	}		
	%>
	</table>
	
	<br />
	<form method="get">
		<input type="hidden" name="action" value="logout">
    	<input type="submit" value="Logout"/>
	</form>
</body>
</html>