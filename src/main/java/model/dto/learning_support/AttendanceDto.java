package model.dto.learning_support;

import java.sql.Time;

public class AttendanceDto {
	private String studentName; // 학생 이름
	private String courseName; // 강의명
	private String professorName; // 교수명
	private String courseTimeYoil; // 요일
	private Time courseTimeStart; // 시작 시간 (TIME 타입)
	private Time courseTimeEnd; // 종료 시간 (TIME 타입)
	private String courseTimeLoc; // 강의실

	// 포맷팅된 시간 필드
	private String courseTimeStartFormatted;
	private String courseTimeEndFormatted;

	// Getters and Setters
	public String getStudentName() {
		return studentName;
	}

	public void setStudentName(String studentName) {
		this.studentName = studentName;
	}

	public String getCourseName() {
		return courseName;
	}

	public void setCourseName(String courseName) {
		this.courseName = courseName;
	}

	public String getProfessorName() {
		return professorName;
	}

	public void setProfessorName(String professorName) {
		this.professorName = professorName;
	}

	public String getCourseTimeYoil() {
		return courseTimeYoil;
	}

	public void setCourseTimeYoil(String courseTimeYoil) {
		this.courseTimeYoil = courseTimeYoil;
	}

	public Time getCourseTimeStart() {
		return courseTimeStart;
	}

	public void setCourseTimeStart(Time courseTimeStart) {
		this.courseTimeStart = courseTimeStart;
	}

	public Time getCourseTimeEnd() {
		return courseTimeEnd;
	}

	public void setCourseTimeEnd(Time courseTimeEnd) {
		this.courseTimeEnd = courseTimeEnd;
	}

	public String getCourseTimeLoc() {
		return courseTimeLoc;
	}

	public void setCourseTimeLoc(String courseTimeLoc) {
		this.courseTimeLoc = courseTimeLoc;
	}

	public String getCourseTimeStartFormatted() {
		return courseTimeStartFormatted;
	}

	public void setCourseTimeStartFormatted(String courseTimeStartFormatted) {
		this.courseTimeStartFormatted = courseTimeStartFormatted;
	}

	public String getCourseTimeEndFormatted() {
		return courseTimeEndFormatted;
	}

	public void setCourseTimeEndFormatted(String courseTimeEndFormatted) {
		this.courseTimeEndFormatted = courseTimeEndFormatted;
	}
}