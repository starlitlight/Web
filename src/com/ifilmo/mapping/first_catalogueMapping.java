package com.ifilmo.mapping;

import java.sql.ResultSet;
import java.sql.SQLException;

import com.ifilmo.db.EntityMapping;
import com.ifilmo.domain.First_catalogue;

public class first_catalogueMapping implements EntityMapping{

	@Override
	public Object mapping(ResultSet rs) throws SQLException {

		First_catalogue catalogue = new First_catalogue(
				rs.getInt("f_id"),
				rs.getString("f_name")
				);
		return catalogue;
	}

	
}
