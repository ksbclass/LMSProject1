package model.dao.professor_support;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.exceptions.PersistenceException;
import org.apache.ibatis.session.SqlSession;

import config.MyBatisConnection;
import model.dto.professor_support.PaginationDto;
import model.dto.professor_support.RegistCourseDto;

public class ManageCourseDao {

	public List<RegistCourseDto> searchCourseInfo(PaginationDto dto) {
		
		SqlSession session = MyBatisConnection.getConnection(); 
		List<RegistCourseDto> result = null;
		
		try {
			 result = session.selectList("CourseByPro.searchCourseInfo", dto);
			 
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			MyBatisConnection.close(session);
		}
		return result;
		
	}
	
	public int getCourseCountRows(Map<String, String> map) {
		
		SqlSession session = MyBatisConnection.getConnection(); 
		int totalRows = 0;
		
		try {
			 totalRows = session.selectOne("CourseByPro.getCourseCountRows",map);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			MyBatisConnection.close(session);
		}
		
		
		return totalRows;
		
	}

	public int changeCourse(Map<String, Object> paramMap) {
		
		SqlSession session = MyBatisConnection.getConnection(); 
		int result = 0;
		
		try {
			if ("OPEN".equals(((String) paramMap.get("courseStatus")).toUpperCase())) {
				int rowCnt = session.selectOne("CourseByPro.countEnrollments", paramMap);
			    if (rowCnt > 0) {
			        throw new RuntimeException("course have enrollment");
			    }
			}
			
			if (session.update("CourseByPro.changeCourse",paramMap) > 0) {
				session.commit();
				return result + 1;
			} else {
				 throw new RuntimeException("chgCourseFail");
			}
		} catch (PersistenceException e) {
			e.printStackTrace();
			throw new RuntimeException("chgCourseFail", e);
		} finally {
			session.close();
		}

	}

	public void updateCourseInfo(RegistCourseDto dto) {
		
	    try (SqlSession session = MyBatisConnection.getConnection()) { 
	        // course 테이블 업데이트
	        if (session.update("CourseByPro.updateCourseInfo", dto) <= 0) {
	            throw new RuntimeException("Failed to update course info");
	        }

	        // course_time 테이블 업데이트
	        if (updateCourseTimeInfo(dto, session) <= 0) {
	            throw new RuntimeException("Failed to update course time info");
	        }

	        // 성공 시 커밋
	        session.commit();
	    } catch (PersistenceException e) {
	        throw new RuntimeException("Course update failed: " + e.getMessage(), e);
	    }
	}

	public int updateCourseTimeInfo(RegistCourseDto dto, SqlSession session) {
		
	    int updatedRows = session.update("CourseByPro.updateCourseTimeInfo", dto);
	    
	    if (updatedRows <= 0) {
	        throw new RuntimeException("Failed to update course time info for courseTimeId: ");
	    }
	    return updatedRows;
	}

	public void deleteCourseInfo(String courseId) {
		
		try (SqlSession session = MyBatisConnection.getConnection()) { 
	        
			// course_time 테이블 삭제(time테이블에서 courseId참조로인한 time테이블먼저 삭제)
	        if (deleteCourseTimeInfo(courseId, session) <= 0) {
	            throw new RuntimeException("Failed to delete course time info");
	        }
	        
	        // score 테이블 삭제
	        deleteScore(courseId, session);
	        
			// course 테이블 삭제
	        if (session.delete("CourseByPro.deleteCourseInfo", courseId) <= 0) {
	            throw new RuntimeException("Failed to delete course info");
	        }
	        
	        // 성공 시 커밋
	        session.commit();
	    } catch (PersistenceException e) {
	        throw new RuntimeException("Course delete failed: " + e.getMessage(), e);
	    }
		
	}

	private void deleteScore(String courseId, SqlSession session) {
		session.delete("CourseByPro.deleteScore", courseId);
	}
	

	private int deleteCourseTimeInfo(String courseId, SqlSession session) {
		
		int deleteddRows = session.delete("CourseByPro.deleteCourseTimeInfo", courseId);
		
	    if (deleteddRows <= 0) {
	        throw new RuntimeException("Failed to delete course time");
	    }
	    return deleteddRows;
	}
		

}
