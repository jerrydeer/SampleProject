package com.hr.controller;

import java.sql.Connection;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.hr.web.WebUtils;

public class EmployeeServices {

	public static void calendar(String[] args) {
		Calendar now = Calendar.getInstance();

		SimpleDateFormat format = new SimpleDateFormat("MM/dd/yyyy");

		String[] days = new String[7];
		int delta = -now.get(GregorianCalendar.DAY_OF_WEEK) + 2; // add 2 if your week start on monday
		now.add(Calendar.DAY_OF_MONTH, delta);
		for (int i = 0; i < 7; i++) {
			days[i] = format.format(now.getTime());
			now.add(Calendar.DAY_OF_MONTH, 1);
		}
		System.out.println(Arrays.toString(days));

	}

	// ctrl + shift + o = auto add import
	// ctrl + shift + f = format code
	// ctrl + 1 = solve problem
	// alt + shift + r = change valiable name
	public Map<String, Object> getEmployeeData(int id) throws Exception {
		String sql = "SELECT * FROM employee_user WHERE ID = '" + id + "'";
		List<Map<String, Object>> list = WebUtils.query(sql);
		if(list.size() <= 0) {
			return null;
		}
		Map<String, Object> map = list.get(0);
		return map;
	}

	public void updateEmployee(HttpServletRequest request, int id) throws Exception {
		Connection conn = WebUtils.getConnection();

		String fname = request.getParameter("fname");
		String lname = request.getParameter("lname");
		String gender = request.getParameter("gender");
		String birthdate = request.getParameter("birthdate");
		String address = request.getParameter("address");
		String subdistrict = request.getParameter("subdistrict");
		String district = request.getParameter("district");
		String province = request.getParameter("province");
		String postcode = request.getParameter("postcode");
		int rank = WebUtils.parseInt(request.getParameter("rank"));
		int salary = WebUtils.parseInt(request.getParameter("salary"));
		String timein = request.getParameter("timein");
		String timeout = request.getParameter("timeout");
		boolean mon = request.getParameter("work_mon") != null;
		boolean tue = request.getParameter("work_tue") != null;
		boolean wed = request.getParameter("work_wed") != null;
		boolean thu = request.getParameter("work_thu") != null;
		boolean fri = request.getParameter("work_fri") != null;
		boolean sat = request.getParameter("work_sat") != null;
		boolean sun = request.getParameter("work_sun") != null;
		int work_mon = (mon) ? 1 : 0;
		int work_tue = (tue) ? 1 : 0;
		int work_wed = (wed) ? 1 : 0;
		int work_thu = (thu) ? 1 : 0;
		int work_fri = (fri) ? 1 : 0;
		int work_sat = (sat) ? 1 : 0;
		int work_sun = (sun) ? 1 : 0;

		String update = "UPDATE employee_user SET " +
				"Firstname='" + fname + "', " + // String
				"Lastname='" + lname + "', " + // String
				"Gender='" + gender + "', " +
				"Birthdate='" + birthdate + "', " +
				"Address='" + address + "', " +
				"Subdistrict='" + subdistrict + "', " +
				"District='" + district + "', " +
				"Province='" + province + "', " +
				"Postcode='" + postcode + "', " +
				"Salary='" + salary + "', " + // int
				"Timein='" + timein + "', " + // String
				"Timeout='" + timeout + "', " + // String
				"Rank='" + rank + "', " + // int
				"work_mon='" + work_mon + "',  " + // int (Set)
				"work_tue='" + work_tue + "',  " + // int (Set)
				"work_wed='" + work_wed + "',  " + // int (Set)
				"work_thu='" + work_thu + "',  " + // int (Set)
				"work_fri='" + work_fri + "',  " + // int (Set)
				"work_sat='" + work_sat + "',  " + // int (Set)
				"work_sun='" + work_sun + "' " + // int (Set)
				"WHERE ID = '" + id + "' "; //

		Statement stmt = conn.createStatement();
		stmt.execute(update);

		conn.close();
	}

	public static void insert(HttpServletRequest request) throws Exception {
		Connection conn = WebUtils.getConnection();
		Statement stmt = conn.createStatement();

		boolean mon = request.getParameter("work_mon") != null;
		boolean tue = request.getParameter("work_tue") != null;
		boolean wed = request.getParameter("work_wed") != null;
		boolean thu = request.getParameter("work_thu") != null;
		boolean fri = request.getParameter("work_fri") != null;
		boolean sat = request.getParameter("work_sat") != null;
		boolean sun = request.getParameter("work_sun") != null;

		String fname = request.getParameter("fname");
		String lname = request.getParameter("lname");
		String gender = request.getParameter("gender");
		String birthdate = request.getParameter("birthdate");
		String address = request.getParameter("address");
		String subdistrict = request.getParameter("subdistrict");
		String district = request.getParameter("district");
		String province = request.getParameter("province");
		String postcode = request.getParameter("postcode");
		int rank = WebUtils.parseInt(request.getParameter("rank"));
		int salary = WebUtils.parseInt(request.getParameter("salary"));
		String timein = request.getParameter("timein");
		String timeout = request.getParameter("timeout");
		int work_mon = (mon) ? 1 : 0;
		int work_tue = (tue) ? 1 : 0;
		int work_wed = (wed) ? 1 : 0;
		int work_thu = (thu) ? 1 : 0;
		int work_fri = (fri) ? 1 : 0;
		int work_sat = (sat) ? 1 : 0;
		int work_sun = (sun) ? 1 : 0;

		String insert = "INSERT INTO employee_user "
				+ "(Firstname, Lastname, Gender, Birthdate, Address, Subdistrict, District, Province, Postcode, Rank, Salary, Timein, Timeout, work_mon, work_tue, work_wed, work_thu, work_fri, work_sat, work_sun) "
				+ "VALUES "
				+ "('" + fname + "', '" + lname + "', '" + gender + "', '" + birthdate + "', '" + address + "', '" + subdistrict + "', '" + district + "', '" + province + "', '" + postcode + "', " + rank + ", " + salary + ", '" + timein + "', '" + timeout + "', " + work_mon + ", " + work_tue + ", " + work_wed + ", " + work_thu + ", " + work_fri + ", " + work_sat + ", " + work_sun + ")";
		stmt.executeUpdate(insert);

		conn.close();
	}
	//
	public void delete(int id) throws Exception {
		Connection conn = WebUtils.getConnection();
		try {
			Statement stmt = conn.createStatement();
			String sql1 = "DELETE FROM employee_user WHERE ID = '" + id + "' ";
			stmt.executeUpdate(sql1);
			conn.close();
		}catch (Exception ex) {
			conn.close();
			throw ex;
		}
	}

	public List<Map<String, Object>> getRanks() throws Exception {
		String sql = "SELECT * FROM info_user";
		List<Map<String, Object>> list = WebUtils.query(sql);
		return list;
	}

	public List<Map<String, Object>> getTimeList(int year, int month, int user_id) throws Exception {
		String sql = "SELECT * FROM time where uid = "+user_id+" and year = " + year + " and month = " + month + " ";
		List<Map<String, Object>> list = WebUtils.query(sql);
		return list;
	}
	
	public List<Map<String, Object>> getTime(int id, int month, int year) throws Exception {
		String sql = "SELECT * FROM time WHERE UID = '"+id+"' AND month = '"+month+"' AND year = '"+year+"' ";
		List<Map<String, Object>> list = WebUtils.query(sql);
		
		return list;
	}

}
