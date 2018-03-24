package com.hr.web;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Scanner;

public class WebUtils {

	public static Connection getConnection() throws Exception {
		Class.forName("com.mysql.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/hr?user=root&password=password");
		return conn;
	}

	public static int parseInt(Object value) {
		try {
			return Integer.parseInt(value.toString());
		} catch (Exception ex) {
			return 0;
		}
	}

	public static List<Map<String, Object>> query(String sql) throws Exception {
		List<Map<String, Object>> list = new ArrayList();
		Connection conn = WebUtils.getConnection();
		try {
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			while (rs.next()) {
				Map<String, Object> map = new HashMap();
				ResultSetMetaData metaData = rs.getMetaData();
				int columns = metaData.getColumnCount();
				for (int i = 0; i < columns; i++) {
					String columnName = metaData.getColumnName(i + 1);
					map.put(columnName, rs.getObject(columnName));
				}
				list.add(map);
			}
			conn.close();
		} catch (Exception ex) {
			conn.close();
			throw ex;
		}
		return list;
	}
	
	public static String nullToSpace(Object value) {
		if(value == null) {
			return "";
		}else {
			return value.toString();
		}
	}

}
