package com.ifilmo.mapping;

import java.sql.ResultSet;
import java.sql.SQLException;

import com.ifilmo.db.EntityMapping;
import com.ifilmo.domain.User;

public class userMapping implements EntityMapping{

	@Override
	public User mapping(ResultSet rs) throws SQLException {

		User user = new User(
				rs.getInt("user_id"),
				rs.getString("user_name"),
				rs.getString("user_password"),
				rs.getString("email"),
				rs.getInt("gender"),
				rs.getString("photo"),
				rs.getInt("role")
				);
		return user;
	}

	
}
