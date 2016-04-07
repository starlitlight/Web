package com.ifilmo.domain;

/**
 * Catalogue_table entity
 */

public class Catalogue_table {
	
	int id;
	String content;
	
	public Catalogue_table(int id, String content) {
		super();
		this.id = id;
		this.content = content;
	}
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}

}
