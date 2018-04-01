package com.anuparp.s.restaurant.api;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.anuparp.s.restaurant.RestaurantRepository;

@RestController
@RequestMapping("/api")
public class OrderController {
	
	@Autowired
    private RestaurantRepository repo;
	
	@Transactional(rollbackFor = Exception.class)
	@RequestMapping(value="/order", method = RequestMethod.POST)
	public int createOrder(@RequestBody Map<String, Object> map) throws Exception{
		
		Map<String, Object> mapOrderMaster = (Map<String, Object>)map.get("order_master");
		List<Map<String, Object>> listOrderDetails = (List<Map<String, Object>>)map.get("order_details");
		
		// 1 Check table available
		String tableNo = (String)mapOrderMaster.get("table_no");
		String sql = "SELECT * FROM main_table WHERE table_no = :table_no";
		List<Map<String, Object>> mainTableList = repo.query(sql, mapOrderMaster);
		Map<String, Object> mainTableMap = mainTableList.get(0);
		int tableStatus = (int)mainTableMap.get("status_id");
		
		if(tableStatus != 1) {
			throw new Exception ("โต๊ะ " + tableNo + " ไม่ว่าง");
		}
		
		// 2 Generate order ID
		int newOrderNo = 0;
		{
			int maxOrder = 0;
			String sqlmaxorder = "SELECT MAX(order_no) AS max_order FROM order_master";
			List<Map<String, Object>> listMaxOrder = repo.query(sqlmaxorder);
			Map<String, Object> mapMaxOrder = listMaxOrder.get(0);
			
			if(mapMaxOrder != null) {
				Integer value = (Integer) mapMaxOrder.get("max_order");
				if(value != null) {
					maxOrder = value;
				}
			}
			
			newOrderNo = maxOrder + 1;
		}
		
		//3 create Insert order_master
		Date now = new Date();
		mapOrderMaster.put("order_no", newOrderNo);
		mapOrderMaster.put("order_status", 2);
		mapOrderMaster.put("create_time", now);
		mapOrderMaster.put("update_time", now);
		String insertordermaster = "INSERT INTO order_master  ( order_no ,  table_no ,  customer_no ,  order_status ,  create_time ,  update_time ) VALUES (:order_no, :table_no, :customer_no, :order_status, :create_time, :update_time)";
		int result = repo.execute(insertordermaster, mapOrderMaster);
		
		//4 Generate order detail_id
		int newOrderDetailNo = 0;
		{
			int maxOrder = 0;
			String sqlmaxorder = "SELECT MAX(order_detail_no) AS max_order FROM order_details";
			List<Map<String, Object>> listMaxOrder = repo.query(sqlmaxorder);
			Map<String, Object> mapMaxOrder = listMaxOrder.get(0);
			
			if(mapMaxOrder != null) {
				Integer value = (Integer) mapMaxOrder.get("max_order");
				if(value != null) {
					maxOrder = value;
				}
			}
			
			newOrderDetailNo = maxOrder + 1;
		}
		
		//5 create Insert order_detail
		for(int i = 0; i < listOrderDetails.size(); i++) {
			Map<String, Object> mapDetail = listOrderDetails.get(i);
			//5.1 get standard_price
			double standardPrice = 0;
			
			//5.2 insert
			mapDetail.put("order_detail_no", newOrderDetailNo);
			mapDetail.put("order_no", newOrderNo);
			mapDetail.put("standard_price", standardPrice);
			mapDetail.put("order_status", 2);
			mapDetail.put("create_time", now);
			mapDetail.put("update_time", now);
			
			String insertdetail = "INSERT INTO order_details (order_detail_no, order_no, food_id, standard_price, actual_price, order_status, create_time, update_time) VALUES (:order_detail_no, :order_no, :food_id, :standard_price, :actual_price, :order_status, :create_time, :update_time)";
			repo.execute(insertdetail, mapDetail);
			
			newOrderDetailNo++;		
		}
		
		// 6 update main_table
		Map<String, Object> mapTableMain = new HashMap();
		mapTableMain.put("order_no", newOrderNo);
		mapTableMain.put("status_id", 2);
		mapTableMain.put("table_no", tableNo);
		
		String sqlUpdateTable = "UPDATE main_table SET order_no = :order_no, status_id = :status_id WHERE table_no = :table_no";
		repo.execute(sqlUpdateTable, mapTableMain);
		 
		return result;
	}
	
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
