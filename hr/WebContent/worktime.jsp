<%@page import="java.util.HashMap"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="java.util.Collections"%>
<%@ page language="java" contentType="text/html; charset=utf-8"    pageEncoding="utf-8"%>
<%@page import="java.util.List"%>
<%@page import="com.hr.controller.EmployeeServices"%>
<%@page import="java.util.Map"%> 
<%@page import="com.hr.web.WebUtils"%>

<%@page import="java.util.Date" %>
<%@page import="java.util.Arrays" %> 
<%@page import="java.util.Calendar" %>
<%@page import="java.util.GregorianCalendar" %> 
<%@page import="java.text.SimpleDateFormat" %>  
<!DOCTYPE html PUBLIC "-//W3C//Dth HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dth">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Work Time</title>
</head>
<body>
	<%
//	String method = request.getMethod();
//	System.out.println("method = " + method);
//	int id = WebUtils.parseInt(request.getParameter("user_id"));
	int id = request.getParameter("ID") == null ? 0 : Integer.parseInt(request.getParameter("ID"));
	EmployeeServices empServices = new EmployeeServices();	
	Map<String, Object> mapEmp = empServices.getEmployeeData(id);
	if(mapEmp == null){
		response.sendRedirect("./index.jsp");
		return;
	}

	int year = WebUtils.parseInt(request.getParameter("year"));
	int month = WebUtils.parseInt(request.getParameter("month"));
	List<Map<String, Object>> timeList = empServices.getTimeList(year, month, id);
	List<Map<String, Object>> timeStampList = empServices.getTime(id, month, year);	
	
	out.println( year );
	%>		

	Check-in : &nbsp; Name:(<%= mapEmp.get("Firstname") %>) &nbsp; Month:(<%= month %>) &nbsp; Year:(<% out.println( year );%>)
	<table border="1" width="100%">
		<tr>
			<th>วันที่</th>
			<th>วัน</th>
			<th>เวลาเข้าปกติ</th>
			<th>เวลาออกปกติ</th>
			<th>ลงเวลาเข้า</th>
			<th>ลงเวลาออก</th>
			<th>วันหยุด</th>
			<th>ลากิจ</th>
			<th>ลาป่วย</th>
			<th>ขาด</th>
			<th>เข้า (นาที)</th>
			<th>ออก</th>
			<th>รวม (ชั่วโมง)</th>
		</tr>
		<%
		SimpleDateFormat datename = new SimpleDateFormat("EEEE");			
	    Calendar cal = Calendar.getInstance();
	    
	   		cal.set(Calendar.YEAR, year); 
		    cal.set(Calendar.MONTH, month - 1);  // month
		    cal.set(Calendar.DAY_OF_MONTH, 1);
	    int maxDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
	    for (int i = 0; i < maxDay; i++){
		    cal.set(Calendar.DAY_OF_MONTH, i + 1);  // i + 1
		    int day = i + 1;
		    List<Map<String, Object>> timeListFiltered = timeList
		    								.stream()
		    								.filter(map -> {
		    										int dayInList = (int) map.get("day");
		    										return dayInList == day;
		    								 })
		    								.collect(Collectors.toList());
		    
		    Map<String, Object> mapTime = new HashMap();
		    if(timeListFiltered.size() > 0){
		    	mapTime = timeListFiltered.get(0);
		    }
		    
			Map<String, Object> maptimestamp = new HashMap();
			for(int j = 0; j < timeStampList.size(); j++){
				Map<String, Object> map = timeStampList.get(j);
				if(day == (int) map.get("day")){
					maptimestamp = map;
					break;
				}
			}
				
		%>
		<tr>
			<td><% out.println(i+1); %></td>
			<td><% out.println( datename.format(cal.getTime()) ); %></td>
			<td><%= mapEmp.get("Timein") %></td>
			<td><%= mapEmp.get("Timeout") %></td>
			<td>
				<%=maptimestamp.get("time_in") %>
			</td>
			<td>
				<%=maptimestamp.get("time_out") %>
				<%
				
				%>
			</td>
			<td>				
						
			</td>
			<td>
				
			</td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
		</tr>
		<%
	    }
		%>
	</table>
	<br>
	<button><a onclick="window.location='./main.jsp'"> Back </a></button>	
</body>
</html>