package model.dao.professor_support;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import config.MyBatisConnection;
import model.dto.professor_support.ScoreMngDto;


public class ScoreMngDao {
	
	public List<Map<String, Object>> getCoursesInfo(String professorId) {
		
		SqlSession session = MyBatisConnection.getConnection();
		
		List<Map<String, Object>> result = null;
	    
		try { 
	        // course 테이블 업데이트
	        result = session.selectList("ScoreMng.getCoursesInfo", professorId);
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	    	MyBatisConnection.close(session);
	    }
		
		return result;
	}

	public List<ScoreMngDto> getScoreInfo(Map<String, Object> params) {
		
		SqlSession session = MyBatisConnection.getConnection();
		
		List<ScoreMngDto> result = null;
	    
		try { 
	        result = session.selectList("ScoreMng.getScoreInfo", params);
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	    	MyBatisConnection.close(session);
	    }
		
		return result;
	}

	public int updateScore(List<Map<String, Object>> params) {
		
		int result = 0;
	    
		try (SqlSession session = MyBatisConnection.getConnection()){
			for(Map<String, Object> m : params) {
				
				Map<String, Object> paramMap = new HashMap<String, Object>();
				paramMap.put("studentId", m.get("studentId"));
				paramMap.put("courseId", m.get("courseId"));
				paramMap.put("scoreMid", m.get("scoreMid"));
				paramMap.put("scoreFinal", m.get("scoreFinal"));
				paramMap.put("scoreTotal", m.get("scoreTotal"));
				paramMap.put("scoreGrade", m.get("scoreGrade"));
				
				session.update("ScoreMng.updateScore", paramMap);
				result++;
			}
			if (result != params.size()) {
				throw new RuntimeException("update Fail");
			}
			session.commit();
	    } catch (Exception e) {
	        e.printStackTrace();
	        throw e;
	    }
		
		return result;
	}

}
