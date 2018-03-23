<%@ page language="java" contentType="text/html; charset=utf-8"    pageEncoding="utf-8"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="com.hr.web.WebUtils"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<body>
	<%
	Object strUserID = session.getAttribute("sUserID");
	if(strUserID == null) // Check Login
	{
		response.sendRedirect("index.jsp");
	}	
	// SELECT u.*, r.Rankname, r.ID as RankID FROM  employee_user u left join info_user r on u.Rank = r.ID
	// u = *   r = Rankname
	// result  select *(u) and Rankname(r) FROM employee_user and info_user(left join) Rankname on 	Rank = r.ID
	String sql = "SELECT u.*, r.Rankname FROM  employee_user u left join info_user r on u.Rank = r.ID ORDER BY ID ASC";
	List<Map<String, Object>> list = WebUtils.query(sql);	
	%>
	<h2>Employee List</h2>
	<a href="insert.jsp">Add Profile</a>
	<table border="1">
	<tr>
		<th>ID</th>
		<th>FullName</th>
		<th>Rank</th>
		<th>Table / Edit / Delete</th>
	</tr>
	<%
	out.println(list.size());	
	for(int i = 0; i < list.size(); i++)
	{
		Map<String, Object> map = list.get(i);
	%>	
	<tr>
		<td><%= map.get("ID") %></td>
		<td><%= map.get("Firstname") %>&nbsp;<%= map.get("Lastname") %></td>
		<td>
			<%=	map.get("Rankname")	%>
		</td>
		<td>
		<a href="table.jsp?ID=<%= map.get("ID") %>">Table</a> /
		<a href="edit.jsp?ID=<%= map.get("ID") %>">Edit</a> /
		<a href="delete.jsp?ID=<%= map.get("ID") %>">Delete</a>
		</td>
	</tr>	
	<%
   	}		
	%>
	</table>
</body>
</html>