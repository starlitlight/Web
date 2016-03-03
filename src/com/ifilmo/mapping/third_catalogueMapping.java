package com.ifilmo.mapping;

import java.sql.ResultSet;
import java.sql.SQLException;

import com.ifilmo.db.EntityMapping;
import com.ifilmo.domain.Third_catalogue;

public class third_catalogueMapping implements EntityMapping{

	@Override
	public Object mapping(ResultSet rs) throws SQLException {

		Third_catalogue catalogue = new Third_catalogue(
				rs.getInt("t_id"),
				rs.getString("t_name"),
				rs.getString("t_content")
				);
		return catalogue;
	}

	
}
