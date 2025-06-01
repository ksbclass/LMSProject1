package model.dao.mypage;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import config.MyBatisConnection;
import model.dto.mypage.GetScoresDto;

public class GetScoreDao {
	
	public List<GetScoresDto> getScore(String id) {
		SqlSession conn = MyBatisConnection.getConnection();
		GetScoresDto dto = new GetScoresDto();
		dto.setStudentId(id);
		try {
			List<GetScoresDto> list = conn.selectList("getScore.getScore",id);
			return list;
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		finally {
			MyBatisConnection.close(conn);
		}
		
		return null;
	}

}
