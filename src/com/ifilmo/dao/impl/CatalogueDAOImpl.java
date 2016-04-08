package com.ifilmo.dao.impl;

import java.sql.SQLException;
import java.util.List;

import com.ifilmo.dao.CatalogueDAO;
import com.ifilmo.db.JdbcTemplate;
import com.ifilmo.domain.Catalogue_table;
import com.ifilmo.domain.First_catalogue;
import com.ifilmo.domain.Picture;
import com.ifilmo.domain.Second_catalogue;
import com.ifilmo.domain.Third_catalogue;
import com.ifilmo.domain.User;
import com.ifilmo.mapping.catalogue_tableMapping;
import com.ifilmo.mapping.first_catalogueMapping;
import com.ifilmo.mapping.pictureMapping;
import com.ifilmo.mapping.second_catalogueMapping;
import com.ifilmo.mapping.third_catalogueMapping;
import com.ifilmo.mapping.userMapping;

public class CatalogueDAOImpl implements CatalogueDAO {
	
	private JdbcTemplate jdbctemplate = new JdbcTemplate();

	@Override
	public boolean deleteThird_catalogue(String course_name) {
		String sql = "DELETE FROM third_catalogue WHERE t_name = '" + course_name + "'";
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
	
	public boolean deleteSecond_catalogue(String course_name) {
		String sql = "DELETE FROM second_catalogue WHERE s_name = '" + course_name + "'";
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
	
	public boolean deleteFirst_catalogue(String course_name) {
		String sql = "DELETE FROM first_catalogue WHERE f_name = '" + course_name + "'";
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
	
	public Third_catalogue findContentyById(int t_id) {
		Third_catalogue tc = null;
		String sql = "SELECT * FROM third_catalogue where t_id = " + t_id;
		try {
			List<Object> entitys = jdbctemplate.query(sql, new third_catalogueMapping());
			tc = (Third_catalogue) entitys.get(0);
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return tc;
	}
	
	@Override
	public List<First_catalogue> findFirst_catalogue() {
		String sql = "SELECT f_id, f_name FROM first_catalogue";
		List<First_catalogue> first_catalogue = null;
		try {
			first_catalogue = jdbctemplate.query(sql, new first_catalogueMapping());
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return first_catalogue;
	}

	@Override
	public List<Second_catalogue> findSecond_catalogueByf_id(int f_id) {
		String sql = "SELECT * FROM second_catalogue WHERE f_id = " + f_id;
		List<Second_catalogue> second_catalogue = null;
		try {
			second_catalogue = jdbctemplate.query(sql, new second_catalogueMapping());
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return second_catalogue;
	}
	
	public List<Second_catalogue> findSecond_catalogueByf_name(String f_name) {
		String sql = "SELECT * FROM second_catalogue WHERE s_name = " + f_name;
		List<Second_catalogue> second_catalogue = null;
		try {
			second_catalogue = jdbctemplate.query(sql, new second_catalogueMapping());
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return second_catalogue;
	}

	@Override
	public List<Third_catalogue> findThird_catalogueBys_id(int s_id) {
		String sql = "SELECT t_id, t_name, t_content FROM third_catalogue WHERE s_id = " + s_id;
		List<Third_catalogue> third_catalogue = null;
		try {
			third_catalogue = jdbctemplate.query(sql, new third_catalogueMapping());
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return third_catalogue;
	}
	
	public List<Third_catalogue> searchThird_catalogueBykeyword(String keyword) {
		String sql = "SELECT * FROM third_catalogue WHERE t_content like '%" + keyword + "%' order by t_id";
		List<Third_catalogue> third_catalogue = null;
		try {
			third_catalogue = jdbctemplate.query(sql, new third_catalogueMapping());
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return third_catalogue;
	}
	
	public boolean insertFirst_catalogue(String courseName) {
		String sql = "INSERT INTO first_catalogue(f_name)" + "VALUES"
				+ "(?)";
		Object[] values = new Object[] {courseName};
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
	
	public boolean insertSecond_catalogue(String courseName, int f_id) {
		String sql = "INSERT INTO second_catalogue(s_name, f_id)" + "VALUES"
				+ "(?,?)";
		Object[] values = new Object[] {courseName,f_id};
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
	
	public boolean insertThird_catalogue(String courseName, String content, int s_id) {
		String sql = "INSERT INTO third_catalogue(t_name, t_content, s_id)" + "VALUES"
				+ "(?,?,?)";
		Object[] values = new Object[] {courseName, content, s_id};
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
	
	public boolean insertThird_catalogue(String courseName, int s_id) {
		String sql = "INSERT INTO third_catalogue(t_name, t_content, s_id)" + "VALUES"
				+ "(?,?,?)";
		Object[] values = new Object[] {courseName, null, s_id};
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
	
	public boolean updatePictures(String path, int t_id) {
		
		String sql = "UPDATE picture SET path = " + "'" + path + "'" + " WHERE t_id = " + t_id;
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
	
	public Third_catalogue findThird_catalogueByName(String courseName) {
		Third_catalogue third_catalogue = null;
		String sql = "SELECT * FROM third_catalogue WHERE  t_name= '" + courseName + "'";
		System.out.println(sql);
		try {
			List<Object> entitys = jdbctemplate.query(sql, new third_catalogueMapping());
			if(entitys.size()!=0){
				third_catalogue = (Third_catalogue) entitys.get(0);
			}else{
				System.out.println("找不到三级目录");
			}
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return third_catalogue;
	}
	
	public List<Picture> findPictureByTid(int t_id) {
		String sql = "SELECT * FROM picture WHERE t_id = " + t_id;
		List<Picture> picture = null;
		try {
			picture = jdbctemplate.query(sql, new pictureMapping());
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return picture;
	}
	
	public boolean UpdateCourseContentById(String content, int t_id) {
		//User user = null;
		String sql = "UPDATE third_catalogue SET t_content = " + "'" + content + "'" + " WHERE t_id = " + t_id;
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
	
	public boolean updateCatalogue(String content) {
		
		String sql = "UPDATE catalogue_table SET content= " + "'" + content+ "'";
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
	
	public Catalogue_table selectCatalogue() {
			String sql = "SELECT * FROM catalogue_table";
			Catalogue_table catalogue = null;
			try {
				List<Object> entitys = jdbctemplate.query(sql, new catalogue_tableMapping());
				if(entitys.size()!=0){
					catalogue = (Catalogue_table) entitys.get(0);
				}else{
					System.out.println("找不到目录");
				}
			} catch (ClassNotFoundException e) {
				System.out.println("NO DRIVER");
			} catch (SQLException e) {
				System.out.println("NO CONNECTION");
				e.printStackTrace();
			}
			return catalogue;
		}
	
}
