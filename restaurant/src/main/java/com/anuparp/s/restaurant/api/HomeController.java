package com.anuparp.s.restaurant.api;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.anuparp.s.restaurant.RestaurantRepository;

@RestController
@RequestMapping("/api")
public class HomeController {
	
	@Autowired
    private RestaurantRepository repo;
	
	@RequestMapping("/home")
	public List<Map<String, Object>> home() {
		
		String sql = "SELECT m.*, c.status_name FROM main_table m left join const_statusname c on m.status_id = c.status_id ORDER BY m.table_no";		
		List<Map<String, Object>> list = repo.query(sql);
		return list;
	}
	
	@RequestMapping("/home-hard-code")
	public List<Map<String, Object>> homeHardCode() {
		
		List<Map<String, Object>> list = new ArrayList();
	
		{
			
			Map<String, Object> map = new HashMap<>();
			map.put("tableNo", 1);
			map.put("status", 1);
			map.put("statusName", "ว่าง");
			map.put("customerCount", 0);
			list.add(map);
		}
		
		{
			Map<String, Object> map = new HashMap<>();
			map.put("tableNo", 2);
			map.put("status", 1);
			map.put("statusName", "ว่าง");
			map.put("customerCount", 0);
			list.add(map);
		}
		
		{
			Map<String, Object> map = new HashMap<>();
			map.put("tableNo", 3);
			map.put("status", 1);
			map.put("statusName", "ว่าง");
			map.put("customerCount", 0);
			list.add(map);
		}
		
		{
			Map<String, Object> map = new HashMap<>();
			map.put("tableNo", 4);
			map.put("status", 1);
			map.put("statusName", "ว่าง");
			map.put("customerCount", 0);
			list.add(map);
		}
		
		{
			Map<String, Object> map = new HashMap<>();
			map.put("tableNo", 5);
			map.put("status", 1);
			map.put("statusName", "ว่าง");
			map.put("customerCount", 0);
			list.add(map);
		}
		
		{
			Map<String, Object> map = new HashMap<>();
			map.put("tableNo", 6);
			map.put("status", 1);
			map.put("statusName", "ว่าง");
			map.put("customerCount", 0);
			list.add(map);
		}
		
		{
			Map<String, Object> map = new HashMap<>();
			map.put("tableNo", 7);
			map.put("status", 1);
			map.put("statusName", "ว่าง");
			map.put("customerCount", 0);
			list.add(map);
		}
		
		{
			Map<String, Object> map = new HashMap<>();
			map.put("tableNo", 8);
			map.put("status", 1);
			map.put("statusName", "ว่าง");
			map.put("customerCount", 0);
			list.add(map);
		}
		
		{
			Map<String, Object> map = new HashMap<>();
			map.put("tableNo", 9);
			map.put("status", 1);
			map.put("statusName", "ว่าง");
			map.put("customerCount", 0);
			list.add(map);
		}
		
		{
			Map<String, Object> map = new HashMap<>();
			map.put("tableNo", 10);
			map.put("status", 1);
			map.put("statusName", "ว่าง");
			map.put("customerCount", 0);
			list.add(map);
		}
		return list;
	}
}
