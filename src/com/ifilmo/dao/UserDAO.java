package com.ifilmo.dao;

import java.sql.Timestamp;
import java.util.List;

import com.ifilmo.domain.User;

public interface UserDAO {

	/**
     * User login
     * @param user_name
     * @param user_password
     * @return User
     */
	public User login(String user_name, String user_password);

	/**
     * Add new User
     * @param user
     * @return boolean
     */
    public boolean insertUser(User user);

    /**
     * Delete one User
     * @param id
     * @return boolean
     */
    public boolean deleteUser(int id);
    
    
    /**
     * Find all users by role
     * @param role
     * @return users
     */
    public List<User> findUserByRole(int role);
    
    
    /**
     * Find all users by role
     * @param role
     * @return users
     */
    public User insertPhoto(String photo, String user_name);

	public boolean updateUserAccunt(User user);
	
	public List<User> findAllUser();
	
	public boolean UpdateRoleByUserId(int role, int user_id);
	
	public User findUserAccountById(int user_id);
	
	public boolean UpdatePhotoByUserId(String photo, int user_id);
	
	public boolean UpdatePasswordByUserId(String user_password, int user_id);
	
	public User findUserByEmail(String email);

	public boolean UpdateCodeByUserId(String code, Timestamp outDate, int user_id);
	
	public User findUserByName(String username);
	
	public List<User> findUserNameAndEmail(String userName, String email);
}