package com.anuparp.s.restaurant.api;

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
public class ConstantDetailsController {

	@Autowired
	private RestaurantRepository repo;
	
	@RequestMapping(value = "/const-status-orderdetails", method = RequestMethod.GET)
	public List<Map<String, Object>> getConstDetails() {

		String selectConstName = "SELECT * FROM const_status_orderdetails";
		List<Map<String, Object>> listConstName = repo.query(selectConstName);

		return listConstName;
	}
	
	
	@Transactional(rollbackFor = Exception.class)
	@RequestMapping(value = "/const-status-orderdetails", method = RequestMethod.POST)
	public int createConstName(@RequestBody Map<String, Object> map) throws Exception {

		try {
			Map<String, Object> mapConstName = new HashMap();

			mapConstName.put("status_id", map.get("status_id"));
			mapConstName.put("status_name", map.get("status_name"));

			String insertConstName = "INSERT INTO const_status_orderdetails (status_id, status_name) VALUES (:status_id, :status_name)";
			int result = repo.execute(insertConstName, mapConstName);

			return result;
		} catch (Exception e) {
			if(e.getMessage().contains("com.mysql.jdbc.exceptions.jdbc4.MySQLIntegrityConstraintViolationException: Duplicate entry")) {
				throw new Exception("ไอดี " + map.get("status_id") + " อยู่ในระบบแล้ว");
			}else {
				throw e;
			}
		}
	}
	
	
	@Transactional(rollbackFor = Exception.class)
	@RequestMapping(value = "/const-status-orderdetails/{status_id}", method = RequestMethod.PUT)
	public int updateConstName(@PathVariable("status_id") int statusId, @RequestBody Map<String, Object> map)
			throws Exception {

		// Check Exists status_id of Data
		checkExistsConstNameStatusId(statusId);

		Map<String, Object> mapConstName = new HashMap();
		mapConstName.put("status_id", statusId);
		mapConstName.put("status_name", map.get("status_name"));

		String updateConstName = "UPDATE const_status_orderdetails SET status_name = :status_name WHERE status_id = :status_id";
		int result = repo.execute(updateConstName, mapConstName);

		return result;
	}
	
	
	// ถ้าเป็น String ให้เอาไปใส่ Map Parameter ในคำสัั่ง SQL
	@Transactional(rollbackFor = Exception.class)
	@RequestMapping(value = "/const-status-orderdetails/{status_id}", method = RequestMethod.DELETE)
	public int deleteConstName(@PathVariable("status_id") int statusId) throws Exception {

		// Check Exists status_id of Data
		checkExistsConstNameStatusId(statusId);

		String deleteConstName = "DELETE FROM const_status_orderdetails WHERE status_id = " + statusId;
		int result = repo.execute(deleteConstName, null);

		return result;
	}

	private void checkExistsConstNameStatusId(int StatusId) throws Exception {

		// Check Exists Order Master Data
		String selectConstName = "SELECT * FROM const_status_orderdetails WHERE status_id = " + StatusId;
		List<Map<String, Object>> listConstName = repo.query(selectConstName);
		if (listConstName.size() < 1) {
			throw new Exception("ไม่มี Status ID " + StatusId + " อยู่ในระบบ");
		}
	}
	
	
	
}
