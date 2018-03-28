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
	Object strUserID = session.getAttribute("sUserID");
	if(strUserID == null)
	{
		response.sendRedirect("index.jsp");
	}
	
	String actions = request.getParameter("actions");
	if(actions == null || actions.equals("")){						// if this form no submit then actions = create
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
		timeList = empServices.getTimeList(year, month, id);		// if submit do insert
	}
	if(year == 0 || month == 0){									// if year,month = 0 (create)
		Date date = new Date();
		year = date.getYear()+1900+543;
		month = date.getMonth()+1;
	}	
	if(request.getMethod().equals("POST")){							// if POST (submit) do insert
		empServices.createTimeWork(request);
	}
	String disable = "";	
	String created = "";
	String qwork = "SELECT DISTINCT month,year FROM time WHERE uid = '"+id+"'";
	List<Map<String, Object>> listWork = WebUtils.query(qwork);
	for(int i = 0; i < listWork.size(); i++){
		Map<String, Object> map = listWork.get(i);
		//out.println( map.get("month") );		
		if( map.get("month").equals( month ) && map.get("year").equals( year ) && actions.equals("create") ){
			
			created = "<font color='red'>" + "ข้อมูลพนักงาน " + mapEmp.get("firstname") + " เดือน " + month + " ปี " + year + " มีอยู่ในระบบแล้ว" + "</font>";
			disable = "disabled";
		}
	}	
	%>			
	<form method="POST" action="" onsubmit="return buttonConfirm()">
		ลงเวลาการทำงาน <%= mapEmp.get("firstname") %> &nbsp; เดือน:<input type="text" name="" id="month" value="<%= month %>"> &nbsp; ปี:<input type="text" name="" id="year" value="<%= year %>"> 
		<input type="button" onclick="changeYearMonth()" value="เปลื่ยน" />	
		<% out.println(created); %>	
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
				<th>ออก (นาที)</th>
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
						mapTable.put("time_in", mapEmp.get("timein"));
						mapTable.put("time_out", mapEmp.get("timeout"));
						
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
					<input <%= disable %> type="text" name="time_in_<%= i+1 %>" value="<%=mapTable.get("time_in")%>">
				</td>
				<td>
					<input <%= disable %> type="text" name="time_out_<%= i+1 %>" value="<%=mapTable.get("time_out")%>">
				</td>
				<td>
					<input <%= disable %> type="text" name="actual_in_<%= i+1 %>" value="<%=mapTable.get("actual_in")%>">
				</td>
				<td>
					<input <%= disable %> type="text" name="actual_out_<%= i+1 %>" value="<%=mapTable.get("actual_out")%>">
				</td>
				<td>				
					<input <%= disable %> type="checkbox" name="holiday_<%= i+1 %>" value="1" <%=("1".equals(mapTable.get("holiday")) ? "checked":"") %> >	
				</td>
				<td>
					<input <%= disable %> type="checkbox" name="business_leave_<%= i+1 %>" value="1" <%=("1".equals(mapTable.get("business_leave")) ? "checked":"") %> >	
				</td>
				<td>
					<input <%= disable %> type="checkbox" name="sick_leave_<%= i+1 %>" value="1" <%=("1".equals(mapTable.get("sick_leave")) ? "checked":"") %> >	
				</td>
				<td>
					<input <%= disable %> type="checkbox" name="absence_<%= i+1 %>" value="1" <%=("1".equals(mapTable.get("absence")) ? "checked":"") %> >	
				</td>
				<td>
					<%
					SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm:ss");
					String time_in = String.valueOf(mapTable.get("time_in"));
					String actual_in = String.valueOf(mapTable.get("actual_in"));
					long totalin = 0;
					if(mapTable.get("time_in") != ""){
						Date datetime_in = timeFormat.parse(time_in);
						long difftime_in = datetime_in.getTime();
						
						if(mapTable.get("actual_in") != ""){
							Date dateactual_in = timeFormat.parse(actual_in);
							long diffactual_in = dateactual_in.getTime();					
							totalin = (difftime_in - diffactual_in) / 1000 / 60;
							
							out.println(totalin);
						}
					}		
					%>
				</td>
				<td>
					<%				
					String time_out = String.valueOf(mapTable.get("time_out"));
					String actual_out = String.valueOf(mapTable.get("actual_out"));
					long totalout = 0;
					if(mapTable.get("time_out") != ""){
						Date datetime_out = timeFormat.parse(time_out);
						long difftime_out = datetime_out.getTime();
						
						if(mapTable.get("actual_out") != ""){
							Date dateactual_out = timeFormat.parse(actual_out);
							long diffactual_out = dateactual_out.getTime();	
							totalout = (diffactual_out - difftime_out) / 1000 / 60;
							
							out.println(totalout);
						}
					}
					
					%>
				</td>
				<td>
					<%
					if(mapTable.get("time_in") != "" && mapTable.get("actual_in") != "" && mapTable.get("time_out") != "" && mapTable.get("actual_out") != ""){
						out.println(totalin + totalout);
					}
					SimpleDateFormat formatter = new SimpleDateFormat("HH:mm");
					Date timeformat = formatter.parse(time_out);
					String hhmm_timeout = formatter.format(timeformat);
					//out.println("<br />" + hhmm_timeout);
					%>
				</td>
			</tr>
			<%
		    }
			%>
		</table>
		<br />
		<input type="hidden" name="actions" id="actions" value="<%= actions %>">
		<input type="hidden" name="year" value="<%= year %>"> 
		<input type="hidden" name="month" value="<%= month %>"> 		 
		<input type="submit" name="submit" value="บันทึก" <%= disable %> />&nbsp;
		<a href="./table.jsp?ID=<%= id %>"> กลับ </a>
	</form>	

	<script>
		function changeYearMonth(){
			var year = document.getElementById("year").value;
			var month = document.getElementById("month").value;
			var actions = document.getElementById("actions").value;
			var link = "?ID=<%=id%>&month=" + month + "&year=" + year +"&actions=" + actions;
			window.document.location = link;
		} 
		function buttonConfirm() {
		    return confirm("ยืนยัน");
		   
		}			
	</script>
</body>
</html>