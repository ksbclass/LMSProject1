package model.dao.mypage;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import config.MyBatisConnection;
import domain.Dept;

public class DeptDao {
	

	  public String selectId(String name) {
	 SqlSession connection = MyBatisConnection.getConnection();
	 try {
		 String id = connection.selectOne("dept.selectId",name);
			return  id;
	 }
	 catch (Exception e) {
		e.printStackTrace();
	}
	 finally {
		 MyBatisConnection.close(connection);
	 }
	 return null;
	 
	}
	  
	  
	  public List<Dept> selectAll() {
		  SqlSession connection = MyBatisConnection.getConnection();
		  try {
			return connection.selectList("dept.selectAll");
		  }
		  catch (Exception e) {
			e.printStackTrace();
		}
		  finally {
			  MyBatisConnection.close(connection);
		  }
		  return null;
	  }


	public String selectName(String deptId) {
		  SqlSession connection = MyBatisConnection.getConnection();
		  try {
			return connection.selectOne("dept.selectName",deptId);
		  }
		  catch (Exception e) {
			e.printStackTrace();
		}
		  finally {
			  MyBatisConnection.close(connection);
		  }
		  return null;
		
	}

	
	 
		
		

}
