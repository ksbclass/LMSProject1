package model.dao.mypage;

import org.apache.ibatis.session.SqlSession;

import config.MyBatisConnection;
import domain.Professor;

public class ProfessorDao {
	
	
	public boolean idchk(String id) {
		SqlSession connection = MyBatisConnection.getConnection();
		int x  = (Integer)connection.selectOne("professor.cnt",id);
		connection.close();
		if(x!=0) {	
			return false;
		}
		return true;
	}

	public boolean insert(Professor pro) {
		SqlSession connection = MyBatisConnection.getConnection();
		try {
			if(connection.insert("professor.insert",pro)>0) {
				return true;
			}
			else {
				return false;
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		finally {
			MyBatisConnection.close(connection);
		}
		return false;

	}

	public Professor selectOne(String id) {
		SqlSession connection = MyBatisConnection.getConnection();
		try {
			return connection.selectOne("professor.selectOne",id); //id를가진 객체반환
			
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
