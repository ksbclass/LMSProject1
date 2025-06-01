package model.dao.board;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import config.MyBatisConnection;
import domain.Post;
import domain.PostComment;

public class PostDao {

    public void insert(Post post) {
        SqlSession session = MyBatisConnection.getConnection();
        try {
            session.insert("post.insert", post);
            session.commit();
        } catch (Exception e) {
            session.rollback();
            throw e;
        } finally {
            MyBatisConnection.close(session);
        }
    }

    public void update(Post post) {
        SqlSession session = MyBatisConnection.getConnection();
        try {
            session.update("post.update", post);
            session.commit();
        } catch (Exception e) {
            session.rollback();
            throw e;
        } finally {
            MyBatisConnection.close(session);
        }
    }

    public void delete(String postId) {
        SqlSession session = MyBatisConnection.getConnection();
        try {
            session.delete("post.delete", postId);
            session.commit();
        } catch (Exception e) {
            session.rollback();
            throw e;
        } finally {
            MyBatisConnection.close(session);
        }
    }

    public void deleteWithComments(String postId) {
        SqlSession session = MyBatisConnection.getConnection();
        try {
            session.delete("post.deleteCommentsByPostId", postId);
            session.delete("post.delete", postId);
            session.commit();
        } catch (Exception e) {
            session.rollback();
            throw e;
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
            return session.selectOne("post.count", map);
        } finally {
            MyBatisConnection.close(session);
        }
    }

    public List<Post> listNotices() {
        SqlSession session = MyBatisConnection.getConnection();
        try {
            return session.selectList("post.selectNotices");
        } finally {
            MyBatisConnection.close(session);
        }
    }

    public List<Post> list(int pageNum, int limit, String column, String find) {
        SqlSession session = MyBatisConnection.getConnection();
        try {
            Map<String, Object> map = new HashMap<>();
            map.put("startRow", (pageNum - 1) * limit);
            map.put("pageSize", limit);
            map.put("column", column);
            map.put("find", find);
            return session.selectList("post.selectList", map);
        } finally {
            MyBatisConnection.close(session);
        }
    }

    public Post selectOne(String postId) {
        SqlSession session = MyBatisConnection.getConnection();
        try {
            return session.selectOne("post.selectOne", postId);
        } finally {
            MyBatisConnection.close(session);
        }
    }

    public void incrementReadCount(String postId) {
        SqlSession session = MyBatisConnection.getConnection();
        try {
            session.update("post.incrementReadCount", postId);
            session.commit();
        } catch (Exception e) {
            session.rollback();
            throw e;
        } finally {
            MyBatisConnection.close(session);
        }
    }

    public String getMaxPostId() {
        SqlSession session = MyBatisConnection.getConnection();
        try {
            return session.selectOne("post.getMaxPostId");
        } finally {
            MyBatisConnection.close(session);
        }
    }

    public Integer getMaxGroup() {
        SqlSession session = MyBatisConnection.getConnection();
        try {
            return session.selectOne("post.getMaxGroup");
        } finally {
            MyBatisConnection.close(session);
        }
    }

    public void updateGroupStep(int group, int step) {
        SqlSession session = MyBatisConnection.getConnection();
        try {
            Map<String, Integer> map = new HashMap<>();
            map.put("group", group);
            map.put("step", step);
            session.update("post.updateGroupStep", map);
            session.commit();
        } catch (Exception e) {
            session.rollback();
            throw e;
        } finally {
            MyBatisConnection.close(session);
        }
    }

    public void insertComment(PostComment comment) {
        SqlSession session = MyBatisConnection.getConnection();
        try {
            session.insert("post.insertComment", comment);
            session.commit();
        } catch (Exception e) {
            session.rollback();
            throw e;
        } finally {
            MyBatisConnection.close(session);
        }
    }

    public List<PostComment> selectCommentList(String postId) {
        SqlSession session = MyBatisConnection.getConnection();
        try {
            return session.selectList("post.selectCommentList", postId);
        } finally {
            MyBatisConnection.close(session);
        }
    }

    public String getMaxCommentId() {
        SqlSession session = MyBatisConnection.getConnection();
        try {
            return session.selectOne("post.getMaxCommentId");
        } finally {
            MyBatisConnection.close(session);
        }
    }

    public List<String> getAllPostIds() {
        SqlSession session = MyBatisConnection.getConnection();
        try {
            return session.selectList("post.getAllPostIds");
        } finally {
            MyBatisConnection.close(session);
        }
    }

    public PostComment selectComment(String commentId) {
        SqlSession session = MyBatisConnection.getConnection();
        try {
            return session.selectOne("post.selectComment", commentId);
        } finally {
            MyBatisConnection.close(session);
        }
    }

    public void updateComment(PostComment comment) {
        SqlSession session = MyBatisConnection.getConnection();
        try {
            session.update("post.updateComment", comment);
            session.commit();
        } catch (Exception e) {
            session.rollback();
            throw e;
        } finally {
            MyBatisConnection.close(session);
        }
    }

    public void deleteComment(String commentId) {
        SqlSession session = MyBatisConnection.getConnection();
        try {
            session.delete("post.deleteComment", commentId);
            session.commit();
        } catch (Exception e) {
            session.rollback();
            throw e;
        } finally {
            MyBatisConnection.close(session);
        }
    }
}