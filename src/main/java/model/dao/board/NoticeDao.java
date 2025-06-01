package model.dao.board;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import config.MyBatisConnection;
import domain.Notice;

public class NoticeDao {

	public boolean insert(Notice notice) {
        SqlSession session = MyBatisConnection.getConnection();
        try {
            int result = session.insert("notice.insert", notice);
            session.commit();
            return result > 0; // 삽입 성공 여부 반환
        } catch (Exception e) {
            session.rollback();
            e.printStackTrace();
            return false;
        } finally {
            MyBatisConnection.close(session);
        }
    }

    public int boardCount(String column, String find) {
        SqlSession session = MyBatisConnection.getConnection();
        try {
            Map<String, Object> map = new HashMap<>();
            map.put("column", column);
            map.put("find", find);
            int count = session.selectOne("notice.count", map);
            System.out.println("Board count: " + count);
            return count;
        } finally {
            MyBatisConnection.close(session);
        }
    }

    public List<Notice> list(int pageNum, int limit, String column, String find) {
        SqlSession session = MyBatisConnection.getConnection();
        try {
            Map<String, Object> map = new HashMap<>();
            map.put("startRow", (pageNum - 1) * limit);
            map.put("pageSize", limit);
            map.put("column", column);
            map.put("find", find);
            List<Notice> result = session.selectList("notice.selectList", map);
            System.out.println("List size: " + result.size());
            System.out.println("List content: " + result);
            return result;
        } finally {
            MyBatisConnection.close(session);
        }
    }

    public String getMaxNoticeId() {
        SqlSession session = MyBatisConnection.getConnection();
        try {
            return session.selectOne("notice.getMaxNoticeId");
        } finally {
            MyBatisConnection.close(session);
        }
    }

    public Notice selectOne(String noticeId) {
        SqlSession session = MyBatisConnection.getConnection();
        try {
            return session.selectOne("notice.selectOne", noticeId);
        } finally {
            MyBatisConnection.close(session);
        }
    }

    public void incrementReadCount(String noticeId) {
        SqlSession session = MyBatisConnection.getConnection();
        try {
            session.update("notice.incrementReadCount", noticeId);
            session.commit();
        } catch (Exception e) {
            session.rollback();
            throw e;
        } finally {
            MyBatisConnection.close(session);
        }
    }

    public void delete(String noticeId) {
        SqlSession session = MyBatisConnection.getConnection();
        try {
            session.delete("notice.delete", noticeId);
            session.commit();
        } catch (Exception e) {
            session.rollback();
            throw e;
        } finally {
            MyBatisConnection.close(session);
        }
    }

	public void update(Notice notice) {
		SqlSession session = MyBatisConnection.getConnection();
		 try {
	            session.update("notice.update", notice);
	            session.commit(); 
	        } catch (Exception e) {
	            session.rollback();
	            throw e;
	        } finally {
	            MyBatisConnection.close(session);
	        }

	}
	public static List<Notice> listAll() {
		SqlSession session = MyBatisConnection.getConnection();
		try {
			return session.selectList("notice.selectListAll"); 
		} finally {
			MyBatisConnection.close(session);
		}
	}
}