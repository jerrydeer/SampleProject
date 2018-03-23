<%@ page language="java" contentType="text/html; charset=utf-8"    pageEncoding="utf-8"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="com.hr.controller.EmployeeServices"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<body>

	<%
	if("edit".equals(request.getParameter("action")))	{
		
		EmployeeServices.insert(request);
		String redirectURL = "./main.jsp";
	    response.sendRedirect(redirectURL);

		return;
	}	
	%>

	<h2>Employee List : </h2>
	
	<form method="POST" action="insert.jsp">
		<input type="hidden" name="action" value="edit" />
		
		<u>Profile</u>
		<table>
			<tr>
				<td>First Name: </td>
				<td><input type="text" name="fname"></td>
			</tr>
			<tr>
				<td>Last Name: </td>
				<td><input type="text" name="lname"></td>
			</tr>
			<tr>
				<td>Gender: </td>
				<td>
				  <input type="radio" name="gender" value="male"> Male<br>
				  <input type="radio" name="gender" value="female"> Female<br>			
				</td>
			</tr>
			<tr>
				<td>Birth Date: </td>
				<td><input type="date" name="birthdate"></td>
			</tr>
			<tr>
				<td>Address: </td>
				<td><input type="text" name="address"></td>
			</tr>
			<tr>
				<td>Sub District: </td>
				<td><input type="text" name="subdistrict"></td>
			</tr>
			<tr>
				<td>Distric: </td>
				<td><input type="text" name="district"></td>
			</tr>
			<tr>
				<td>Province: </td>
				<td><input type="text" name="province"></td>
			</tr>
			<tr>
				<td>Post Code: </td>
				<td><input type="text" name="postcode"></td>
			</tr>														
			
			<tr>
			<td><u>Detail</u></td>
			</tr>
		
			<tr>
				<td>Rank: </td>
				
				<td>
				<select name="rank">
				<%
					EmployeeServices empServices = new EmployeeServices();
					List<Map<String, Object>> rankList = empServices.getRanks();
					int rankSize = rankList.size();
					for(int i = 0 ; i < rankSize; i++){
						Map<String, Object> rankMap = rankList.get(i);
						
						Integer rankId = (Integer) rankMap.get("ID"); //Integer = int
						String rankName = (String) rankMap.get("Rankname");
						%>
						<option value="<%=rankId%>"><%=rankName%></option>
						<%
					}
				%>
				</select>
				</td>
				
			</tr>
			<tr>
				<td>Salary: </td>
				<td><input type="number" name="salary"/></td>
			</tr>
			<tr>
				<td>Time in: </td>
				<td><input type="time" name="timein"></td>
			</tr>
			<tr>
				<td>Time out: </td>
				<td><input type="time" name="timeout"></td>
			</tr>
			<tr>
				<td>Day Work: </td>
				<td>
				<input type="checkbox" name="work_mon">Mon<br>
				<input type="checkbox" name="work_tue">Tue<br>
				<input type="checkbox" name="work_wed">Wed<br>
				<input type="checkbox" name="work_thu">Thu<br>
				<input type="checkbox" name="work_fri">Fri<br>
				<input type="checkbox" name="work_sat">Sat<br>
				<input type="checkbox" name="work_sun">Sun<br>
				</td>
			</tr>
	 		 
		</table>
		<input type="submit" name="submit" value="Create User">
		<input type="button" name="BackButton" value="Back" onclick="window.location='./main.jsp'">
	</form>

</body>
</html>