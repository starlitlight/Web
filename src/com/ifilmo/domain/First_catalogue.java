package com.ifilmo.domain;

/**
 * һ��Ŀ¼Ŀ¼ʵ����
 */

public class First_catalogue {
	
	private int f_id;
	//һ��Ŀ¼��
	private String f_name;
	
	
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
