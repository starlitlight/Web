package com.ifilmo.mapping;

import java.sql.ResultSet;
import java.sql.SQLException;

import com.ifilmo.db.EntityMapping;
import com.ifilmo.domain.Catalogue_table;

public class catalogue_tableMapping implements EntityMapping{

	@Override
	public Object mapping(ResultSet rs) throws SQLException {

		Catalogue_table catalogue_table = new Catalogue_table(
				rs.getInt("id"),
				rs.getString("content")
				);
		return catalogue_table;
	}

	
}
