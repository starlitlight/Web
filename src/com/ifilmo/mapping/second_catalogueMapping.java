package com.ifilmo.mapping;

import java.sql.ResultSet;
import java.sql.SQLException;

import com.ifilmo.db.EntityMapping;
import com.ifilmo.domain.Second_catalogue;

public class second_catalogueMapping implements EntityMapping{

	@Override
	public Object mapping(ResultSet rs) throws SQLException {

		Second_catalogue catalogue = new Second_catalogue(
				rs.getInt("s_id"),
				rs.getString("s_name"),
				rs.getInt("f_id")
				);
		return catalogue;
	}

	
}
