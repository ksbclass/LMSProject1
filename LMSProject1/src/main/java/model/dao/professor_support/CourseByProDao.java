package model.dao.professor_support;

import java.util.Map;

import org.apache.ibatis.exceptions.PersistenceException;
import org.apache.ibatis.session.SqlSession;

import config.MyBatisConnection;
import model.dto.professor_support.RegistCourseDto;


public class CourseByProDao {
	
	// 커스텀 예외 클래스 정의(강의명 중복허용으로인한 주석처리)
	/*
	 * public class DuplicateKeyException extends RuntimeException { public
	 * DuplicateKeyException(String message) { super(message); }
	 * 
	 * public DuplicateKeyException(String message, Throwable cause) {
	 * super(message, cause); } }
	 */

	public String getMaxcourseIdNumber() {
		SqlSession session = MyBatisConnection.getConnection(); 
		String result = "";
		Long num = 0L;
		try {
			 num = session.selectOne("getMaxcourseIdNumber");
			 result = "C" + (++num);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			MyBatisConnection.close(session);
		}
		
		
		return result;
	}

	public String getMaxcourseTimeIdNumber() {
		SqlSession session = MyBatisConnection.getConnection(); 
		String result = "";
		Long num = 0L;
		try {
			 num = session.selectOne("getMaxcourseTimeIdNumber");
			 result = "CT" + (++num);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			MyBatisConnection.close(session);
		}
		
		
		return result;
	}

	public void insertCourseInfo(RegistCourseDto dto) {
		SqlSession session = MyBatisConnection.getConnection(); 
		
		try {
			 int result = session.insert("insertCourseInfo",dto);
			 
			 if (result > 0) {
				 insertCourseTime(dto, session);
				 session.commit();
			 } else  {
				 throw new RuntimeException("fail registcourse");
			 }
		} catch (PersistenceException e) {
			/* 강의명 중복 허용으로인한 해당 오류 제거
			// 중복 키 오류 확인 (MyBatis는 SQL 상태 코드를 제공하지 않으므로 직접 확인 어려움)
	        if (e.getCause() != null && e.getCause().getMessage().contains("Duplicate entry")) {
	            throw new DuplicateKeyException("Duplicate", e);
	        }
	        */
	        throw new RuntimeException("DBERROR", e);
	    } finally {
			session.close();
		}
	}
	
	public void insertCourseTime(RegistCourseDto dto, SqlSession session) {
		
		try {
			 if (session.insert("insertCourseTime",dto) < 1) {
				 throw new RuntimeException("fail registcoursetime");
			 }
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException("DBERROR");
		}
	}

	public Map<String, Object> getProfessorInfo(String professorId) {
		
		SqlSession session = MyBatisConnection.getConnection(); 
		Map<String, Object> result = null;
		
		try {
			 result = session.selectOne("getProfessorInfo",professorId);
		} catch (Exception e) {
			e.printStackTrace();
	    } finally {
			MyBatisConnection.close(session);
		}
		
		return result;
		
	}

}
