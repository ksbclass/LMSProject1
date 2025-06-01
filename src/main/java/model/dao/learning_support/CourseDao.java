package model.dao.learning_support;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.exceptions.PersistenceException;
import org.apache.ibatis.session.SqlSession;

import config.MyBatisConnection;
import model.dto.learning_support.AttendanceDto;
import model.dto.learning_support.CourseDto;
import model.dto.learning_support.CoursePagingDto;
import model.dto.learning_support.DeptDto;
import model.dto.learning_support.RegistrationDto;
import model.dto.learning_support.SearchDto;


public class CourseDao {

	public List<String> getColleges() {
		
		SqlSession session = MyBatisConnection.getConnection(); 
		List<String> result = null;
		
		try {
			 result = session.selectList("course.selectColleges");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			MyBatisConnection.close(session);
		}
		
		return result;
	}

	public List<DeptDto> getDepartments(String college) {
		
		SqlSession session = MyBatisConnection.getConnection(); 
		List<DeptDto> result = null;
		
		try {
			 result = session.selectList("course.selectDepartments", college);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			MyBatisConnection.close(session);
		}
		
		return result;
	}

	public List<CourseDto> searchCourse(CoursePagingDto cpDto) {

		SqlSession session = MyBatisConnection.getConnection(); 
		List<CourseDto> result = null;
		
		try {
			 result = session.selectList("course.searchCourse", cpDto);
		} catch (Exception e) {	
			e.printStackTrace();
		} finally {
			MyBatisConnection.close(session);
		}
		
		return result;
	}

	public int addCourse(Map<String, Object> map) {
		
		SqlSession session = MyBatisConnection.getConnection(); 
		
		int result = 0;
		long maxId = 0;
		Integer enrollment = 0;
		Integer maxCnt = 0;
		
		// 등록된 수강신청id 최대값 조회
		maxId = session.selectOne("getMaxRegistrationIdNumber");
		String registrationId = "R" + (++maxId);
		map.put("registrationId", registrationId);
		
		// 현재 수강인원 조회
		Map<String, Object> courseInfo = session.selectOne("getCurrentEnrollment", map);
		enrollment = (Integer) courseInfo.get("course_current_enrollment");
		maxCnt = (Integer) courseInfo.get("course_max_cnt");
		
		try {
			if (enrollment < maxCnt) {
				map.put("enrollment",(++enrollment));
				session.update("updateEnrollment", map);
				session.insert("course.addCourse", map);
				map.remove("registrationId");
				addAttendance(map, session);
				addScore(map, session);
				session.commit();
				result = 1;
			} else {
				throw new RuntimeException("course is full");
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException("course regist fail: " + e.getMessage(), e);
		} finally {
			session.close();
		}
		
		return result;
	}
	
	public void addAttendance(Map<String, Object> map, SqlSession session) {
		
		int result = 0;
		long maxId = -1;
		
		// 등록된 수강신청id 최대값 조회
		maxId = session.selectOne("getMaxAttendanceIdNumber");
		String attendanceId = "A" + (++maxId);
		map.put("attendanceId", attendanceId);
		
		try {
			session.insert("course.addAttendance", map);
		} catch (Exception e) {	
			e.printStackTrace();
			throw new RuntimeException("시간표 데이터 등록 실패; " + e.getMessage(), e);
		}	
	}
	
	public void addScore(Map<String, Object> map, SqlSession session) {
		
		// 학점Id 세팅
		long maxId = session.selectOne("getScoreIdNumber");
		String scoreId = "SC" + (++maxId);
		
		Map<String, String> studentInfo = session.selectOne("getStudentInfo", map);
		String studentName = studentInfo.get("studentName");
		String deptId = studentInfo.get("dept_id");
				
		map.put("scoreId", scoreId);
		map.put("studentName", studentName);
		map.put("deptId", deptId);
		
		try { 
	        if (session.insert("course.addScore", map) <= 0) {
	            throw new RuntimeException("Failed to update course info");
	        }

	    } catch (PersistenceException e) {
	        throw new RuntimeException("ScoreTb insert failed: " + e.getMessage(), e);
	    }	
	}

	public List<RegistrationDto> searchRegistrationCourses(String studentId) {
		
		SqlSession session = MyBatisConnection.getConnection(); 
		List<RegistrationDto> result = null;
		
		try {
			 result = session.selectList("course.searchRegistrationCourses", studentId);
		} catch (Exception e) {	
			e.printStackTrace();
		} finally {
			MyBatisConnection.close(session);
		}
		
		return result;
	}

	public int deleteCourse(String registrationId, String courseId, String studentId) {
		
		SqlSession session = MyBatisConnection.getConnection(); 
		int num = 0;
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("courseId", courseId);
		map.put("studentId", studentId);
		
		// 현재 수강인원 조회
		Map<String, Object> courseInfo = session.selectOne("getCurrentEnrollment", map);
		Integer enrollment = (Integer) courseInfo.get("course_current_enrollment");
		if (enrollment == null || enrollment <= 0) {
		    enrollment = 0;
		} else {
			enrollment--;
		}
		
		try {
			map.put("enrollment",(enrollment));
			session.update("updateEnrollment", map);
			session.delete("course.deleteCourse", registrationId);
			deleteAttendance(map, session);
			deleteScore(map, session);
			num=1;
			MyBatisConnection.close(session);
		} catch (Exception e) {	
			session.close();
			e.printStackTrace();
			throw e;
		}
		
		return num;
		
	}
	
	public void deleteAttendance(Map<String, Object> map, SqlSession session) {
		
		try {
			session.delete("course.deleteAttendance", map); 
		} catch (Exception e) {	
			e.printStackTrace();
			throw new RuntimeException("courseTime delete fail " + e.getMessage(), e);
		}	
	}
	
	public void deleteScore(Map<String, Object> map, SqlSession session) {
		
		try { 
	        if (session.delete("course.deleteScore", map) <= 0) {
	            throw new RuntimeException("Failed to delete ScoreTb");
	        }

	    } catch (PersistenceException e) {
	        throw new RuntimeException("ScoreTb delete failed: " + e.getMessage(), e);
	    }	
	}
	
	public List<AttendanceDto> viewCourseTime(String studentId) {
		
		SqlSession session = MyBatisConnection.getConnection(); 
		List<AttendanceDto> result = null;
		
		try {
			result = session.selectList("course.viewCourseTime", studentId);
		} catch (Exception e) {	
			e.printStackTrace();
		} finally {
			MyBatisConnection.close(session);
		}
		
		return result;
	}

	public Integer countCourses(SearchDto searchDto) {
		int result = 0;
		
		try (SqlSession session = MyBatisConnection.getConnection()) {
			result = session.selectOne("countCourses", searchDto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	

}
