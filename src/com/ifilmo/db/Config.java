package com.ifilmo.db;

public interface Config {
	public static final String DRIVER = "com.mysql.jdbc.Driver";
	//public static final String URL    = "jdbc:mysql://lan.cosry6cq3b4f.ap-northeast-1.rds.amazonaws.com:3306/ifilmo";
	//public static final String UNAME  = "lan";
	//public static final String PWD    = "Lfm890918";
	public static final String URL    = "jdbc:mysql://localhost/ifilmo_project?characterEncoding=utf8";
	public static final String UNAME  = "root";
	public static final String PWD    = "";
	//public static final String PWD    = "";
	//public static final String URL    = "jdbc:mysql://43.241.221.94:3360/ifilmo_project?characterEncoding=utf8";
	//public static final String UNAME  = "ifilmo";
	//public static final String PWD    = "5JxeviVbyimrOa5AsRfU";
	//mysql -h lan.cosry6cq3b4f.ap-northeast-1.rds.amazonaws.com -P 3306 -u lan -p
}
