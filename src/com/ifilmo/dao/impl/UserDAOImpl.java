package com.ifilmo.dao.impl;

import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.List;

import com.ifilmo.dao.UserDAO;
import com.ifilmo.db.JdbcTemplate;
import com.ifilmo.domain.User;
import com.ifilmo.mapping.userMapping;

public class UserDAOImpl implements UserDAO {

	private JdbcTemplate jdbctemplate = new JdbcTemplate();

	@Override
	public User login(String user_name, String user_password) {
		User user = null;
		String sql = "SELECT * FROM user WHERE user_name =" + "'" + user_name + "'" + " AND user_password = " + "'"
				+ user_password + "'";
		try {
			@SuppressWarnings("unchecked")
			List<Object> entitys = jdbctemplate.query(sql, new userMapping());
			if(entitys.size()!=0){
				user = (User) entitys.get(0);
			}else{
				System.out.println("��½ʧ��");
			}
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return user;
	}

	@Override
	public boolean insertUser(User user) {
		String sql = "INSERT INTO user(user_name, user_password, email, gender, photo, role) " + "VALUES"
				+ "(?,?,?,?,?,?)";
		Object[] values = new Object[] { user.getUser_name(), user.getUser_password(), user.getEmail(), user.getGender(),
				user.getPhoto(), user.getRole()};
		//System.out.println("Role = " + user.getRole());
		int rows = 0;
		try {
			rows = jdbctemplate.update(sql, values);
		} catch (ClassNotFoundException e) {
			System.out.println("NO DRIVER");
		} catch (SQLException e) {
			System.out.println("NO CONNECTION");
			e.printStackTrace();
		}
		return (rows == 1);
	}

	@Override
	public boolean deleteUser(int user_id) {
		String sql = "DELETE FROM user WHERE user_id = " + user_id;
		try {
			return (jdbctemplate.update(sql) == 1);
		} catch (ClassNotFoundException e) {
			System.out.println("NO DRIVER");
		} catch (SQLException e) {
			System.out.println("NO CONNECTION");
			e.printStackTrace();
		}
		return false;
	}

	@Override
	public List<User> findUserByRole(int role) {
		List<User> users = null;
		String sql = "SELECT * FROM user WHERE role = " + role;
		try {
			users = jdbctemplate.query(sql, new userMapping());

		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return users;
	}

	@Override
	public User insertPhoto(String photo, String user_name) {
		User user = null;
		String sql = "UPDATE user SET photo = " + "'" + photo + "'" + " WHERE user_name = " + "'" + user_name + "'";
		try {
			List<Object> entitys = jdbctemplate.query(sql, new userMapping());
			user = (User) entitys.get(0);
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return user;
	}

	@Override
	public boolean updateUserAccunt(User user) {
		
		String sql = "UPDATE user SET user_name=?,user_password=?,email=?,gender=?,photo=? WHERE user_id=?";
		Object[] values = new Object[] { user.getUser_name(), user.getUser_password(), user.getEmail(), user.getGender(),
				user.getPhoto(), user.getUser_id()};
		int rows = 0;
		try {
			rows = jdbctemplate.update(sql, values);
		} catch (ClassNotFoundException e) {
			System.out.println("NO DRIVER");
		} catch (SQLException e) {
			System.out.println("NO CONNECTION");
			e.printStackTrace();
		}
		return (rows == 1);
	}

	public List<User> findAllUser() {
		String sql = "SELECT user_id, user_name, user_password, email, gender, photo, role FROM user";
		List<User> user = null;
		try {
			user = jdbctemplate.query(sql, new userMapping());
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return user;
	}

	@Override
	public boolean UpdatePasswordByUserId(String user_password, int user_id) {
		//User user = null;
		String sql = "UPDATE user SET user_password = " + "'" + user_password + "'" + " WHERE user_id = " + user_id;
		//System.out.println(sql);
		//int rows = 0;
		try {
			return (jdbctemplate.update(sql)==1);
		} catch (ClassNotFoundException e) {
			System.out.println("NO DRIVER");
		} catch (SQLException e) {
			System.out.println("NO CONNECTION");
			e.printStackTrace();
		}
		return false;
	}
	
	public boolean UpdateRoleByUserId(int role, int user_id) {
		//User user = null;
		String sql = "UPDATE user SET role = " + role + " WHERE user_id = " + user_id;
		//int rows = 0;
		try {
			return (jdbctemplate.update(sql)==1);
		} catch (ClassNotFoundException e) {
			System.out.println("NO DRIVER");
		} catch (SQLException e) {
			System.out.println("NO CONNECTION");
			e.printStackTrace();
		}
		return false;
	}
	
	//通过用户的ID上传图片路径
	public boolean UpdatePhotoByUserId(String photo, int user_id) {
		//User user = null;
		String sql = "UPDATE user SET photo = '" + photo + "' WHERE user_id = " + user_id;
		System.out.println(sql);
		try {
			return (jdbctemplate.update(sql)==1);
		} catch (ClassNotFoundException e) {
			System.out.println("NO DRIVER");
		} catch (SQLException e) {
			System.out.println("NO CONNECTION");
			e.printStackTrace();
		}
		return false;
	}
	
	public User findUserAccountById(int user_id){
		User user = null;
		String sql = "SELECT * FROM user WHERE user_id = "+ user_id;
		try {
			List<Object> entitys = jdbctemplate.query(sql, new userMapping());
			if(entitys.size()!=0){
				user = (User) entitys.get(0);
			}else{
				System.out.println("�����û�ʧ��");
			}
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return user;
	}
	
	public User findUserByEmail(String email){
		User user = null;
		String sql = "SELECT * FROM user WHERE email = "+ "'" + email +"'";
		try {
			List<Object> entitys = jdbctemplate.query(sql, new userMapping());
			if(entitys.size()!=0){
				user = (User) entitys.get(0);
			}else{
				System.out.println("�����û�ʧ��");
			}
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return user;
	}
	
	public User findUserByName(String username) {
		User user = null;
		String sql = "SELECT * FROM user WHERE user_name = "+ "'" + username +"'";
		System.out.println(sql);
		try {
			List<Object> entitys = jdbctemplate.query(sql, new userMapping());
			if(entitys.size()!=0){
				user = (User) entitys.get(0);
			}else{
				System.out.println("通过用户名查找用户失败");
			}

		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return user;
	}
	

	
	public boolean UpdateCodeByUserId(String code, Timestamp date, int user_id) {
		//User user = null;
		String sql = "UPDATE user SET random_code = '" + code + "' ,date ='" + date + "' WHERE user_id = " + user_id;
		//int rows = 0;
		try {
			return (jdbctemplate.update(sql)==1);
		} catch (ClassNotFoundException e) {
			System.out.println("NO DRIVER");
		} catch (SQLException e) {
			System.out.println("UpdateCodeByUserId NO CONNECTION");
			e.printStackTrace();
		}
		return false;
	}
	
}
