package com.ifilmo.domain;

/**
 * ����Ŀ¼Ŀ¼ʵ����
 */
public class Third_catalogue {
	
	// Ŀ¼��ID
	private int t_id;
	// ����Ŀ¼������
	private String t_name;
	// Ŀ¼������
	private String t_content;

	// ���캯��
	public Third_catalogue(int t_id, String t_name, String t_content) {
		super();
		this.t_id = t_id;
		this.t_name = t_name;
		this.t_content = t_content;
	}

	public int getT_id() {
		return t_id;
	}

	public void setT_id(int t_id) {
		this.t_id = t_id;
	}

	public String getT_name() {
		return t_name;
	}

	public void setT_name(String t_name) {
		this.t_name = t_name;
	}

	public String getT_content() {
		return t_content;
	}

	public void setT_content(String t_content) {
		this.t_content = t_content;
	}

}
