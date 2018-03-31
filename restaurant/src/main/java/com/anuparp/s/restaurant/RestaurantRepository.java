package com.anuparp.s.restaurant;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class RestaurantRepository {
	@Autowired
	private NamedParameterJdbcTemplate namedParameterJdbcTemplate;

	// Find all customers, thanks Java 8, you can create a custom RowMapper like this : 
    public List<Map<String, Object>> query(String sql) {
        return query(sql, null);
    }
    
 // Find all customers, thanks Java 8, you can create a custom RowMapper like this : 
    public List<Map<String, Object>> query(String sql, Map<String, Object> mapValue) {

        List<Map<String, Object>> result = namedParameterJdbcTemplate.query(sql, mapValue, (rs, row) -> {
        	Map<String, Object> map = new HashMap();
        	int columnCount = rs.getMetaData().getColumnCount();
        	
        	for(int i = 0; i < columnCount; i++) {
        		String columnName = rs.getMetaData().getColumnName(i+1);
        		Object value = rs.getObject(i+1);
        		map.put(columnName, value);
        	}
        	return map;
        });

        return result;

    }
    
    
    public int execute(String sql, Map<String, Object> mapValue) {
    	
    	int result = namedParameterJdbcTemplate.execute(sql, mapValue, (p) -> {
    		//p.seto
    		return p.executeUpdate();
    	});
    	return result;
    }
}
