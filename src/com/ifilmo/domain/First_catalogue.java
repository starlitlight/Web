package com.ifilmo.domain;

/**
 * 一级目录目录实体类
 */

public class First_catalogue {
	
	int f_id;
	//一级目录名
	String f_name;
	
	
	public First_catalogue(int f_id, String f_name) {
		this.f_id = f_id;
		this.f_name = f_name;
	}
	
	public int getF_id() {
		return f_id;
	}
	public void setF_id(int f_id) {
		this.f_id = f_id;
	}
	public String getF_name() {
		return f_name;
	}
	public void setF_name(String f_name) {
		this.f_name = f_name;
	}
	
	

}
