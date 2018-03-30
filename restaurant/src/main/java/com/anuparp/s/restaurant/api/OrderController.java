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
public class OrderController {
	
	@Autowired
    private RestaurantRepository repo;
	
	@RequestMapping("/order")
	public List<Map<String, Object>> order() {
		
		List<Map<String, Object>> list = new ArrayList();
	
		{
			
			Map<String, Object> map = new HashMap<>();
			map.put("orderNo", 1);
			map.put("status", 1);
			map.put("statusName", "ว่าง");
			map.put("customerCount", 0);
			list.add(map);
		}
		return list;
	}
}
