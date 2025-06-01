package model.dao.mypage;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import config.MyBatisConnection;
import domain.Schedule;

public class ScheduleDao {

    // 모든 일정 조회
    public List<Schedule> listAll() {
        SqlSession session = MyBatisConnection.getConnection();
        try {
            List<Schedule> schedules = session.selectList("schedule.listAll");
            System.out.println("listAll 결과: " + schedules);
            return schedules;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            MyBatisConnection.close(session);
        }
    }

    // 특정 ID의 일정 조회
    public Schedule getScheduleById(int scheduleId) {
        SqlSession session = MyBatisConnection.getConnection();
        try {
            Schedule schedule = session.selectOne("schedule.selectOneById", scheduleId);
            System.out.println("getScheduleById 결과: " + schedule);
            return schedule;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            MyBatisConnection.close(session);
        }
    }

    // 일정 추가
    public void addSchedule(Schedule schedule) {
        SqlSession session = MyBatisConnection.getConnection();
        try {
            session.insert("schedule.insert", schedule);
            session.commit();
            System.out.println("addSchedule 완료: " + schedule);
        } catch (Exception e) {
            e.printStackTrace();
            session.rollback();
            throw new RuntimeException("일정 추가 중 오류 발생: " + e.getMessage());
        } finally {
            MyBatisConnection.close(session);
        }
    }

    // 일정 삭제
    public boolean deleteSchedule(int scheduleId) {
        SqlSession session = MyBatisConnection.getConnection();
        try {
            int count = session.delete("schedule.delete", scheduleId);
            session.commit();
            System.out.println("deleteSchedule 결과 (영향 받은 행 수): " + count);
            return count > 0;
        } catch (Exception e) {
            e.printStackTrace();
            session.rollback();
            return false;
        } finally {
            MyBatisConnection.close(session);
        }
    }

    // 일정 수정
    public boolean updateSchedule(Schedule schedule) {
        SqlSession session = MyBatisConnection.getConnection();
        try {
            int count = session.update("schedule.update", schedule);
            session.commit();
            System.out.println("updateSchedule 결과 (영향 받은 행 수): " + count);
            return count > 0;
        } catch (Exception e) {
            e.printStackTrace();
            session.rollback();
            return false;
        } finally {
            MyBatisConnection.close(session);
        }
    }
}