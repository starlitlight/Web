package com.ifilmo.domain;

import java.io.Serializable;
import java.sql.Timestamp;

/**
 * 用户实体类
 */
public class User implements Serializable {

	private static final long serialVersionUID = -4313782718477229465L;

	// 用户ID
	private int user_id;
	// 用户名
	private String user_name;
	// 用户密码
	private String user_password;
	// 用户邮箱
	private String email;
	// 用户性别：0-女，1-男
	private int gender;
	// 用户头像
	private String photo;
	// 用户角色： 1-普通用户，2-管理员，3超级管理员
	private int role;
	// 随机码
	private String randomCode;
	// 日期
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