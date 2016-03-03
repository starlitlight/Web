package com.ifilmo.db;

import java.sql.Connection;

import java.sql.DriverManager;
import java.sql.SQLException;

public class DBManager {
	private static Connection con = null;

	/**
	 * 构造方法私有，外部不能创建对象
	 */
	private DBManager() {

	}

	public synchronized static Connection getConnection() throws ClassNotFoundException, SQLException {

		if (con == null) {
			Class.forName(Config.DRIVER);
			try {

				con = DriverManager.getConnection(Config.URL, Config.UNAME, Config.PWD);
			} catch (SQLException ex) {
				// handle any errors
				System.out.println("SQLException: " + ex.getMessage());
				System.out.println("SQLState: " + ex.getSQLState());
				System.out.println("VendorError: " + ex.getErrorCode());
			}
		}
		return con;
	}
}
