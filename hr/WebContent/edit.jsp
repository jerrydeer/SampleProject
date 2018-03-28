<%@ page language="java" contentType="text/html; charset=utf-8"    pageEncoding="utf-8"%>
<%@page import="java.util.List"%>
<%@page import="com.hr.controller.EmployeeServices"%>
<%@page import="java.util.Map"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Edit</title>
</head>
<body>
	<%
	Object strUserID = session.getAttribute("sUserID");
	if(strUserID == null)
	{
		response.sendRedirect("index.jsp");
	}
	int id = request.getParameter("ID") == null ? 0 : Integer.parseInt(request.getParameter("ID"));
	EmployeeServices empServices = new EmployeeServices();
		
	if("edit".equals(request.getParameter("action")))	
	{			
		empServices.updateEmployee(request, id);
		String redirectURL = "./main.jsp";
	    response.sendRedirect(redirectURL);
	    return;
	}
	
	Map<String, Object> mapEmp = empServices.getEmployeeData(id);
	List<Map<String, Object>> rankList = empServices.getRanks();	
	%>
	<h2>แก้ใขข้อมูลพนักงาน : <%= mapEmp.get("firstname") %> <%= mapEmp.get("lastname") %></h2>
	
	<form method="POST" action="edit.jsp?ID=<%=id%>" onsubmit="return buttonConfirm()">
		<input type="hidden" name="action" value="edit" />

		<table>
			<tr>
				<td>First Name: </td>
				<td><input type="text" name="fname" value="<%= mapEmp.get("firstname") %>"></td>
			</tr>
			<tr>
				<td>Last Name: </td>
				<td><input type="text" name="lname" value="<%= mapEmp.get("lastname") %>"></td>
			</tr>
			<tr>
				<td>Gender: </td>
				<td>
				  <input type="radio" name="gender" value="male" <% if("male".equals(mapEmp.get("gender"))){ %> checked <%} %>> Male<br>
				  <input type="radio" name="gender" value="female" <% if("female".equals(mapEmp.get("gender"))){ %> checked <%} %>> Female<br>			
				</td>
			</tr>
			<tr>
				<td>Birth Date: </td>
				<td><input type="date" name="birthdate" value="<%= mapEmp.get("birthdate") %>"></td>
			</tr>
			<tr>
				<td>Address: </td>
				<td><input type="text" name="address" value="<%= mapEmp.get("address") %>"></td>
			</tr>
			<tr>
				<td>Sub District: </td>
				<td><input type="text" name="subdistrict" value="<%= mapEmp.get("subdistrict") %>"></td>
			</tr>
			<tr>
				<td>District: </td>
				<td><input type="text" name="district" value="<%= mapEmp.get("district") %>"></td>
			</tr>
			<tr>
				<td>Province: </td>
				<td><input type="text" name="province" value="<%= mapEmp.get("province") %>"></td>
			</tr>
			<tr>
				<td>Post Code: </td>
				<td><input type="text" name="postcode" value="<%= mapEmp.get("postcode") %>"></td>
			</tr>														
			
			<tr>
			<td><u>Detail</u></td>
			</tr>
		
			<tr>
				<td>Rank: </td>
				
				<td>
				<select name="rank">
				<%
					int rankSize = rankList.size();
					for(int i = 0 ; i < rankSize; i++){
						Map<String, Object> rankMap = rankList.get(i);
						
						Integer rankId = (Integer) rankMap.get("id"); //Integer = int
						String rankName = (String) rankMap.get("rankname");
						String selected = rankId.equals(mapEmp.get("rank")) ? "selected" : "";
						%>
						<option value="<%=rankId%>" <%=selected%> ><%=rankName%></option>
						<%
					}
				%>
				</select>
				</td>
				
			</tr>
			<tr>
				<td>Salary: </td>
				<td><input type="number" name="salary" value='<%= mapEmp.get("salary") %>'/>
			</tr>
			<tr>
				<td>Time in: </td>
				<td><input type="time" name="timein" value='<%= mapEmp.get("timein") %>'></td>
			</tr>
			<tr>
				<td>Time out: </td>
				<td><input type="time" name="timeout" value='<%= mapEmp.get("timeout") %>'></td>
			</tr>
			<tr>
				<td>Day Work: </td>
				<td>
				<input type="checkbox" name="work_mon" <% if(new Integer(1).equals(mapEmp.get("work_mon"))){%> checked <%}%>>Mon<br>
				<input type="checkbox" name="work_tue" <% if(new Integer(1).equals(mapEmp.get("work_tue"))){%> checked <%}%>>Tue<br>
				<input type="checkbox" name="work_wed" <% if(new Integer(1).equals(mapEmp.get("work_wed"))){%> checked <%}%>>Wed<br>
				<input type="checkbox" name="work_thu" <% if(new Integer(1).equals(mapEmp.get("work_thu"))){%> checked <%}%>>Thu<br>
				<input type="checkbox" name="work_fri" <% if(new Integer(1).equals(mapEmp.get("work_fri"))){%> checked <%}%>>Fri<br>
				<input type="checkbox" name="work_sat" <% if(new Integer(1).equals(mapEmp.get("work_sat"))){%> checked <%}%>>Sat<br>
				<input type="checkbox" name="work_sun" <% if(new Integer(1).equals(mapEmp.get("work_sun"))){%> checked <%} %>>Sun<br>
				</td>
			</tr>
	 		 
		</table>
		<input type="hidden" name="hidden" value="<%= id %>">
		<input type="submit" name="submit" value="บันทึก">
		<input type="button" name="BackButton" value="กลับ" onclick="window.location='./main.jsp'">
	</form>
	
	<script>
	function buttonConfirm() {
	    return confirm("ยืนยัน");
	   
	}			
	</script>
</body>
</html>