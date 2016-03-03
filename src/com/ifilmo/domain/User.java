package com.ifilmo.domain;

import java.io.Serializable;
import java.sql.Timestamp;

/**
 * �û�ʵ����
 */
public class User implements Serializable {

	private static final long serialVersionUID = -4313782718477229465L;

	// �û�ID
	private int user_id;
	// �û���
	private String user_name;
	// �û�����
	private String user_password;
	// �û�����
	private String email;
	// �û��Ա�0-Ů��1-��
	private int gender;
	// �û�ͷ��
	private String photo;
	// �û���ɫ�� 1-��ͨ�û���2-����Ա��3��������Ա
	private int role;
	// �����
	private String randomCode;
	// ����
	private Timestamp date;

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public User(int user_id, String user_name, String user_password, String email, int gender, String photo, int role) {
		super();
		this.user_id = user_id;
		this.user_name = user_name;
		this.user_password = user_password;
		this.email = email;
		this.gender = gender;
		this.photo = photo;
		this.role = role;
	}

	public User(int user_id, String user_name, String user_password, String email, int gender, String photo) {
		super();
		this.user_id = user_id;
		this.user_name = user_name;
		this.user_password = user_password;
		this.email = email;
		this.gender = gender;
		this.photo = photo;
	}

	public User(String user_name, String user_password, String email, int gender, String photo, int role) {
		super();
		this.user_name = user_name;
		this.user_password = user_password;
		this.email = email;
		this.gender = gender;
		this.photo = photo;
		this.role = role;
	}

	public User(String user_name, String user_password, String email, int gender, String photo) {
		super();
		this.user_name = user_name;
		this.user_password = user_password;
		this.email = email;
		this.gender = gender;
		this.photo = photo;
	}

	public User(String user_name, String user_password, String email) {
		super();
		this.user_name = user_name;
		this.user_password = user_password;
		this.email = email;
	}

	public int getUser_id() {
		return user_id;
	}

	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}

	public String getUser_name() {
		return user_name;
	}

	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}

	public String getUser_password() {
		return user_password;
	}

	public void setUser_password(String user_password) {
		this.user_password = user_password;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public int getGender() {
		return gender;
	}

	public void setGender(int gender) {
		this.gender = gender;
	}

	public String getPhoto() {
		return photo;
	}

	public void setPhoto(String photo) {
		this.photo = photo;
	}

	public int getRole() {
		return role;
	}

	public void setRole(int role) {
		this.role = role;
	}

	public String getRandomCode() {
		return randomCode;
	}

	public void setRandomCode(String randomCode) {
		this.randomCode = randomCode;
	}

	public Timestamp getDate() {
		return date;
	}

	public void setDate(Timestamp date) {
		this.date = date;
	}

}