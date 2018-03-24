<%@page import="java.util.ArrayList"%>
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
	String actions = request.getParameter("actions");
	if(actions == null || actions.equals("")){
		actions = "create";
	}
	
	int id = request.getParameter("ID") == null ? 0 : Integer.parseInt(request.getParameter("ID"));
	int year = WebUtils.parseInt(request.getParameter("year"));
	int month = WebUtils.parseInt(request.getParameter("month"));
	EmployeeServices empServices = new EmployeeServices();	
	Map<String, Object> mapEmp = empServices.getEmployeeData(id);
	
	List<Map<String, Object>> timeList = null;
	if(actions.equals("create")){
		
	}else if(actions.equals("edit")){

		if(mapEmp == null){
			response.sendRedirect("./index.jsp");
			return;
		}
		timeList = empServices.getTimeList(year, month, id);
		//List<Map<String, Object>> timeStampList = empServices.getTime(id, month, year);
	}

	if(year == 0 || month == 0){
		Date date = new Date();
		year = date.getYear()+1900+543;
		month = date.getMonth()+1;
		
		out.println( year );
	}
	
	if(request.getMethod().equals("POST")){
		empServices.createTimeWork(request);
	}

	
	%>	
			
<form method="POST" action="">
	ลงเวลาการทำงาน <%= mapEmp.get("Firstname") %> &nbsp; เดือน:<input type="text" name="" id="month" value="<%= month %>"> &nbsp; ปี:<input type="text" name="" id="year" value="<%= year %>"> 
	<input type="button" onclick="changeYearMonth()" value="เปลื่ยน" />
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
		    
		    Map<String, Object> mapTable = new HashMap();
			if( request.getMethod().equals("GET") ){
				

				
				if(actions.equals("create")){
					mapTable.put("time_in", mapEmp.get("Timein"));
					mapTable.put("time_out", mapEmp.get("Timeout"));
					
					mapTable.put("actual_in",  "");
					mapTable.put("actual_out", "");
				}else{
					Map<String, Object> maptimestamp = new HashMap();
					for(int j = 0; j < timeList.size(); j++){
						Map<String, Object> map = timeList.get(j);
						if(day == (int) map.get("day")){
							maptimestamp = map;
							break;
						}
					}
					mapTable.put("time_in", WebUtils.nullToSpace(maptimestamp.get("time_in")));
					mapTable.put("time_out", WebUtils.nullToSpace(maptimestamp.get("time_out")));
					
					mapTable.put("actual_in", WebUtils.nullToSpace(maptimestamp.get("actual_in")));
					mapTable.put("actual_out", WebUtils.nullToSpace(maptimestamp.get("actual_out")));
					
					mapTable.put("holiday", WebUtils.nullToSpace(maptimestamp.get("holiday")));
					mapTable.put("business_leave", WebUtils.nullToSpace(maptimestamp.get("business_leave")));
					mapTable.put("sick_leave", WebUtils.nullToSpace(maptimestamp.get("sick_leave")));
					mapTable.put("absence", WebUtils.nullToSpace(maptimestamp.get("absence")));
				}
				
			}else if( request.getMethod().equals("POST") ){
				mapTable.put("time_in", request.getParameter("time_in_" + day));
				mapTable.put("time_out", request.getParameter("time_out_" + day));
				
				mapTable.put("actual_in", request.getParameter("actual_in_" + day));
				mapTable.put("actual_out", request.getParameter("actual_out_" + day));
				
				mapTable.put("holiday", request.getParameter("holiday_" + day));
				mapTable.put("business_leave", request.getParameter("business_leave_" + day));
				mapTable.put("sick_leave", request.getParameter("sick_leave_" + day));
				mapTable.put("absence", request.getParameter("absence_" + day));
			}
		    
				
		%>
		<tr>
			<td><% out.println(i+1); %></td>
			<td><% out.println( datename.format(cal.getTime()) ); %></td>
						
			<td>
				<input type="text" name="time_in_<%= i+1 %>" value="<%=mapTable.get("time_in")%>">
			</td>
			<td>
				<input type="text" name="time_out_<%= i+1 %>" value="<%=mapTable.get("time_out")%>">
			</td>
			<td>
				<input type="text" name="actual_in_<%= i+1 %>" value="<%=mapTable.get("actual_in")%>">
			</td>
			<td>
				<input type="text" name="actual_out_<%= i+1 %>" value="<%=mapTable.get("actual_out")%>">
			</td>
			<td>				
				<input type="checkbox" name="holiday_<%= i+1 %>" value="1" <%=("1".equals(mapTable.get("holiday")) ? "checked":"") %> >	
			</td>
			<td>
				<input type="checkbox" name="business_leave_<%= i+1 %>" value="1" <%=("1".equals(mapTable.get("business_leave")) ? "checked":"") %> >	
			</td>
			<td>
				<input type="checkbox" name="sick_leave_<%= i+1 %>" value="1" <%=("1".equals(mapTable.get("sick_leave")) ? "checked":"") %> >	
			</td>
			<td>
				<input type="checkbox" name="absence_<%= i+1 %>" value="1" <%=("1".equals(mapTable.get("absence")) ? "checked":"") %> >	
			</td>
			<td></td>
			<td></td>
			<td></td>
		</tr>
		<%
	    }
		%>
	</table>
	<br />
	<input type="hidden" name="actions" value="<%= actions %>">
	<input type="hidden" name="year" value="<%= year %>"> 
	<input type="hidden" name="month" value="<%= month %>"> 
	<input type="submit" name="submit" value="บันทึก">
</form>	
	<br>
	<a href="./table.jsp?ID=<%= id %>"> Back </a>

<script>
	function changeYearMonth(){
		var year = document.getElementById("year").value;
		var month = document.getElementById("month").value;
		var link = "?ID=<%=id%>&month=" + month + "&year=" + year;
		window.document.location = link;
	} 
</script>
</body>
</html>