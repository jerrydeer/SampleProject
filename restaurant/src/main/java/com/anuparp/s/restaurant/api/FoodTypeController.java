package com.anuparp.s.restaurant.api;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.anuparp.s.restaurant.RestaurantRepository;

@RestController
@RequestMapping("/api")
public class FoodTypeController {
	
	@Autowired
    private RestaurantRepository repo;
	
	@RequestMapping("/foodtype")
	public List<Map<String, Object>> foodtype() {
		String sql = "SELECT * FROM food_type";
		List<Map<String, Object>> list = repo.query(sql);
		return list;
	}
	
	@RequestMapping(value="/foodtype/{foodtype_code}", method = RequestMethod.GET)
	public Map<String, Object> getFoodtype(@PathVariable("foodtype_code") String foodTypecode) {
		Map<String, Object> mapParam = new HashMap();
		mapParam.put("foodtype_code", foodTypecode);
		
		String sql = "SELECT * FROM food_type WHERE foodtype_code = :foodtype_code";
		List<Map<String, Object>> list = repo.query(sql, mapParam);
		return list.get(0);
	}
	
	
	
	@RequestMapping(value="/foodtype", method = RequestMethod.POST)
	public int insertFoodtype(@RequestBody Map<String, Object> map) {
		
		String sql = "INSERT INTO food_type (foodtype_code, foodtype_name) VALUES (:foodtype_code, :foodtype_name)";
		int result = repo.execute(sql, map);
		
		return result;
	}
	
	@RequestMapping(value="/foodtype/{foodtype_code}", method = RequestMethod.PUT)
	public int updateFoodtype(
			@PathVariable("foodtype_code") String foodTypeCode,  
			@RequestBody Map<String, Object> map) {
		
		map.put("foodtype_code", foodTypeCode);
		String sql = "UPDATE food_type SET foodtype_name = :foodtype_name WHERE foodtype_code = :foodtype_code";
		int result = repo.execute(sql, map);
		
		return result;
	}
	
	@RequestMapping(value="/foodtype/{foodtype_code}", method = RequestMethod.DELETE)
	public int deleteFoodtype(
			@PathVariable("foodtype_code") String foodTypeCode,  
			@RequestBody Map<String, Object> map) {
		
		map.put("foodtype_code", foodTypeCode);
		String sql = "DELETE FROM food_type WHERE foodtype_code = :foodtype_code";
		int result = repo.execute(sql, map);
		
		return result;
	}
	
	@RequestMapping("/testparam")
	public String test(@RequestParam("data") String itemid, @RequestParam("data2") String itemid2) {
		
		return "test " + itemid + ", " + itemid2;
	}
}
