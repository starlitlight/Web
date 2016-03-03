package com.ifilmo.domain;

/**
 * һ��Ŀ¼Ŀ¼ʵ����
 */

public class Picture {
	
	int id;
	String path;
	int t_id;
	
	
	public Picture(int id, String path, int t_id) {
		super();
		this.id = id;
		this.path = path;
		this.t_id = t_id;
	}
	
	public Picture(String path, int t_id) {
		super();
		this.path = path;
		this.t_id = t_id;
	}
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getPath() {
		return path;
	}
	public void setPath(String path) {
		this.path = path;
	}
	public int getT_id() {
		return t_id;
	}
	public void setT_id(int t_id) {
		this.t_id = t_id;
	}

}
