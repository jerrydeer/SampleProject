package com.anuparp.s.restaurant.api;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.PathVariable;
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
	@RequestMapping(value="/order/{order_no}", method = RequestMethod.PUT)
	public int updateOrder(
			@PathVariable("order_no") int order_no,  
			@RequestBody Map<String, Object> map) throws Exception{
		
		
		map.put("order_no", order_no);
		
		// 1 ดึงข้อมูล order_master จาก DB   ==  05
		String selectOrderMaster = "SELECT * FROM order_master WHERE order_no = :order_no";
		List<Map<String, Object>> listOrderMaster = repo.query(selectOrderMaster, map);
		Map<String, Object> mapOrderMaster = listOrderMaster.get(0);
		
		// 2 เช็ค if โต๊ะจาก parameter = DB หรือไม่ ถ้าไม่เท่ากันให้ไป update main_table ด้วย
		String tableNoParam = (String)map.get("table_no");    // 06
		String tableNoDb = (String)mapOrderMaster.get("table_no");  // 05
		
		if(!tableNoParam.equals(tableNoDb)) {
			// Logic ย้ายโต๊ะ  
			// set old order_no = null , status_id = 1 
			// check main_table
			// เช็คโต๊ะว่าง
			// set new order_no = maxOrder , status_id = 2  // !
			
			String sql = "SELECT * FROM main_table WHERE table_no = '"+tableNoParam+"' ";
			List<Map<String, Object>> mainTableList = repo.query(sql, null);
			Map<String, Object> mainTableMap = mainTableList.get(0);
			int tableStatus = (int)mainTableMap.get("status_id");
			
			if(tableStatus != 1) {
				throw new Exception ("โต๊ะ " + tableNoParam + " ไม่ว่าง");
			}
					
			String updateMainTablOld = "UPDATE main_table SET status_id = 1, order_no = null WHERE table_no = '"+tableNoDb+"' ";
			repo.execute(updateMainTablOld, null);
			
			String  updateMainTableNew = "UPDATE main_table SET status_id = "+mapOrderMaster.get("order_status")+", order_no = "+order_no+" WHERE table_no = '"+tableNoParam+"' ";
			repo.execute(updateMainTableNew, null);
		}
		
		// 3 ทำการ execute update
		Date now = new Date();
		map.put("update_time", now);
		String updateOrderMaster = "UPDATE order_master SET table_no = :table_no, customer_no = :customer_no, update_time = :update_time WHERE order_no = :order_no ";
		int resultUpdateOrderMaster = repo.execute(updateOrderMaster, map);
		
		return resultUpdateOrderMaster;
	}
	
	@RequestMapping(value="/order/{order_no}", method = RequestMethod.GET)
	public Map<String, Object> getOrder(@PathVariable("order_no") int order_no) {
		// สร้างแมพเปล่า
		Map<String, Object> mapResult = new HashMap();
		
		// ดึงข้อมูล order_master 
		String sqlOrderMaster = "SELECT * FROM order_master WHERE order_no = "+order_no+" ";
		List<Map<String, Object>> listOrderMaster = repo.query(sqlOrderMaster);
		Map<String, Object> mapOrderMaster = listOrderMaster.get(0);
		
		// นำ order_master มาใส่ใน mapResult
		mapResult.put("order_master", mapOrderMaster);
		
		// ดึงข้อมูล order_detail มาเป็น list
		String sqlOrderDetails = "SELECT * FROM order_details WHERE order_no = "+order_no+" ";
		List<Map<String, Object>> listOrderDetails = repo.query(sqlOrderDetails);
		
		// นำ list order_detail มาใส่ใน mapResult
		mapResult.put("order_details", listOrderDetails);
		
		// return mapResult ที่สร้างไว้แต่แรก
		return mapResult;
	}
	
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
			String sqlFoodMenu = "SELECT * FROM food_menu WHERE food_id = " + mapDetail.get("food_id");
			List<Map<String, Object>> listFood = repo.query(sqlFoodMenu);
			
			BigDecimal standardPrice = (BigDecimal) listFood.get(0).get("food_price");
			
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
