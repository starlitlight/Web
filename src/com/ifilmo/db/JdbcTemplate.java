package com.ifilmo.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.Vector;

public class JdbcTemplate {

	/**
	 * executing insert,update,delete
	 * 
	 * @param sql
	 * @param values
	 * @return 1 if
	 * @throws ClassNotFoundException
	 * @throws SQLException
	 */
	public int update(String sql, Object... values) throws ClassNotFoundException, SQLException {
		int row = 0;
		PreparedStatement psta = null;
		Connection con = null;
		try {
			con = DBManager.getConnection();
			psta = con.prepareStatement(sql);
			for (int i = 0; i < values.length; i++) {
				psta.setObject(i + 1, values[i]);
			}
			row = psta.executeUpdate();
		} finally {
			if (psta != null) {
				psta.close();
				psta = null;
			}

		}
		return row;
	}

	/**
	 * executing select
	 * 
	 * @param sql
	 * @param mapping
	 * @param values
	 * @return
	 * @throws ClassNotFoundException
	 * @throws SQLException
	 */
	public List query(String sql, EntityMapping mapping, Object... values) throws ClassNotFoundException, SQLException {
		PreparedStatement psta = null;
		ResultSet rs = null;
		Connection con = null;
		List<Object> list = new Vector<Object>();
		try {
			con = DBManager.getConnection();
			psta = con.prepareStatement(sql);
			for (int i = 0; i < values.length; i++) {
				psta.setObject(i + 1, values);
			}
			rs = psta.executeQuery();
			while (rs.next()) {
				Object entity = mapping.mapping(rs);
				list.add(entity);
			}
		} finally {
			if (psta != null) {
				psta.close();
				psta = null;
			}
			if (rs != null) {
				rs.close();
				rs = null;
			}

		}
		return list;
	}

	/**
	 * executing select count(*)
	 * 
	 * @param sql
	 * @return
	 * @throws SQLException
	 * @throws ClassNotFoundException
	 */
	public int query(String sql) throws SQLException, ClassNotFoundException {
		int result = 0;
		PreparedStatement psta = null;
		ResultSet rs = null;
		Connection con = null;
		try {
			con = DBManager.getConnection();
			psta = con.prepareStatement(sql);
			rs = psta.executeQuery();
			while (rs.next()) {
				result = rs.getInt(1);
			}
		} finally {
			if (psta != null) {
				psta.close();
				psta = null;
			}
			if (rs != null) {
				rs.close();
				rs = null;
			}

		}
		return result;
	}

}
