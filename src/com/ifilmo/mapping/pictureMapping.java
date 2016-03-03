package com.ifilmo.mapping;

import java.sql.ResultSet;
import java.sql.SQLException;

import com.ifilmo.db.EntityMapping;
import com.ifilmo.domain.Picture;

public class pictureMapping implements EntityMapping{

	@Override
	public Object mapping(ResultSet rs) throws SQLException {

		Picture picture= new Picture(
				rs.getInt("p_id"),
				rs.getString("path"),
				rs.getInt("t_id")
				);
		return picture;
	}

	
}
