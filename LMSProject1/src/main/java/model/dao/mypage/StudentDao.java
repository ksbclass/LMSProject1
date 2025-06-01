package model.dao.mypage;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import config.MyBatisConnection;
import domain.Student;
import model.dto.mypage.DeleteUserDto;

public class StudentDao {
	
	
	public boolean idchk(String id) {
		SqlSession connection = MyBatisConnection.getConnection();
		int x  = (Integer)connection.selectOne("student.cnt",id);
		if(x!=0) {
			return false;
		}
		return true;
	}
	
	public void list() {
		SqlSession connection = MyBatisConnection.getConnection();
		List<Student> list = connection.selectList("student.list");
		for (Student student : list) {
			System.out.println(student);
		}
	}

	
	//registerUser매핑부분에서 호출하는곳(회원가입)
	public boolean insert(Student stu) {
		SqlSession connection = MyBatisConnection.getConnection();
		try {
			if(connection.insert("student.insert",stu)>0) {
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

	public Student selectOne(String id) {
		SqlSession connection = MyBatisConnection.getConnection();
		try {
			return connection.selectOne("student.selectOne",id);
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		finally {
			MyBatisConnection.close(connection);
		}
		return null;
		
	}

	public boolean deleteUser(String inputId, String deptId, String name) {
		SqlSession connection = MyBatisConnection.getConnection();
		try {
			DeleteUserDto dto = new DeleteUserDto();
			System.out.println(inputId);
			System.out.println(deptId);
			dto.setDeptId(deptId);
			dto.setStudentId(inputId);
			dto.setStudentName(name);
			dto.setStudentStatus("퇴학");
			System.out.println(dto);
			if(connection.update("student.deleteUser",dto)>0) {				
				connection.commit();
				return true;
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
	


	public boolean selectStatus(String dbId) {
		SqlSession connection = MyBatisConnection.getConnection();
		try {
			String status = connection.selectOne("student.selectStatus",dbId);
			if(status.equals("퇴학")) {
				return true;
			}
			return false;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally {
			MyBatisConnection.close(connection);
		}
		return false;
		
	}

}
