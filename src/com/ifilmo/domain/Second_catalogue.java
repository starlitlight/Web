package com.ifilmo.domain;

/**
 * ����Ŀ¼Ŀ¼ʵ����
 */
public class Second_catalogue {
	
	private int s_id;
	//����Ŀ¼��
	private String s_name;
	//һ��Ŀ¼ID
	private int f_id;
	
	public Second_catalogue(int s_id, String s_name, int f_id) {
		this.s_id = s_id;
		this.s_name = s_name;
		this.f_id = f_id;
	}
	
	public int getS_id() {
		return s_id;
	}
	public void setS_id(int s_id) {
		this.s_id = s_id;
	}
	public String getS_name() {
		return s_name;
	}
	public void setS_name(String s_name) {
		this.s_name = s_name;
	}
	
	public int getF_id() {
		return f_id;
	}

	public void setF_id(int f_id) {
		this.f_id = f_id;
	}

}
