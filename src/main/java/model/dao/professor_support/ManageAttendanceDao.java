package model.dao.professor_support;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import config.MyBatisConnection;
import model.dto.professor_support.AttendanceDataDto;


public class ManageAttendanceDao {
	
	public List<Map<String, Object>> getCoursesInfoByPro(String professorId) {
		
		List<Map<String, Object>> result = null;
	    
		try (SqlSession session = MyBatisConnection.getConnection()) { 
	        result = session.selectList("MngAttendance.getCoursesInfoByPro", professorId);
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
		
		return result;
		
	}

	public List<Map<String, Object>> getAttendance(AttendanceDataDto attDto) {
		List<Map<String, Object>> result = null;
	    
		try (SqlSession session = MyBatisConnection.getConnection()) { 
	        result = session.selectList("MngAttendance.getAttendance", attDto);
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
		
		return result;
	}

	public int updateAttendance(List<AttendanceDataDto> dtoList) {
		int result = 0;
		
		try (SqlSession session = MyBatisConnection.getConnection()) {
			for (AttendanceDataDto dto : dtoList) {
				Map<String, Object> paramMap = new HashMap<>();
				paramMap.put("attendanceId", dto.getAttendanceId());
				paramMap.put("attendanceDate", dto.getAttendanceDate());
				paramMap.put("studentName", dto.getStudentName());
				paramMap.put("attendanceStatus", convertStatus(dto.getAttendanceStatus()));
				
				int insertResult = session.insert("MngAttendance.insertAttendanceHistory", paramMap);
				int updateResult = session.update("MngAttendance.updateAttendance", paramMap);
				result += (insertResult + updateResult);
			}
	        session.commit();
	    } catch (Exception e) {
	    	throw new RuntimeException("Attendance update failed", e);
	    }
		
		return result;
		
	}

	private String convertStatus(String status) {
		if (status == null) return "출석";
        
		switch (status.toLowerCase()) {
	        case "present":
	            return "출석";
	        case "absent":
	            return "결석";
	        case "late":
	            return "지각";
	        default:
	            return "출석";
        }
		
	}
	

	

}
