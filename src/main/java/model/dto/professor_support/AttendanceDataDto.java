package model.dto.professor_support;

import java.time.LocalDate;
import java.util.Arrays;

public class AttendanceDataDto {

	private String attendanceId;
	private String courseId;
	private String studentId;
	private String professorId;
	private Integer attendanceLate; 
	private Integer attendanceAbsent; 
	private String attendanceRemarks;
	private LocalDate attendanceDate; // String -> LocalDate
	private String attendanceStatus;
	private String studentName;

	// getter와 setter
	public String getAttendanceId() {
		return attendanceId;
	}

	public void setAttendanceId(String attendanceId) {
		this.attendanceId = attendanceId;
	}

	public String getCourseId() {
		return courseId;
	}

	public void setCourseId(String courseId) {
		this.courseId = courseId;
	}

	public String getStudentId() {
		return studentId;
	}

	public void setStudentId(String studentId) {
		this.studentId = studentId;
	}

	public String getProfessorId() {
		return professorId;
	}

	public void setProfessorId(String professorId) {
		this.professorId = professorId;
	}

	public Integer getAttendanceLate() {
		return attendanceLate;
	}

	public void setAttendanceLate(Integer attendanceLate) {
		this.attendanceLate = attendanceLate;
	}

	public Integer getAttendanceAbsent() {
		return attendanceAbsent;
	}

	public void setAttendanceAbsent(Integer attendanceAbsent) {
		this.attendanceAbsent = attendanceAbsent;
	}

	public String getAttendanceRemarks() {
		return attendanceRemarks;
	}

	public void setAttendanceRemarks(String attendanceRemarks) {
		this.attendanceRemarks = attendanceRemarks;
	}

	public LocalDate getAttendanceDate() {
		return attendanceDate;
	}

	public void setAttendanceDate(LocalDate attendanceDate) {
		this.attendanceDate = attendanceDate;
	}

	public String getAttendanceStatus() {
		return attendanceStatus;
	}

	public void setAttendanceStatus(String attendanceStatus) {
		this.attendanceStatus = attendanceStatus;
	}

	public String getStudentName() {
		return studentName;
	}

	public void setStudentName(String studentName) {
		this.studentName = studentName;
	}

	// JSON 직렬화/역직렬화용 
	public void setAttendanceDate(String dateStr) {
		if (dateStr != null && !dateStr.trim().isEmpty()) {
			this.attendanceDate = LocalDate.parse(dateStr); // "yyyy-MM-dd" 형식
		}
	}

	public String getAttendanceDateAsString() {
		return attendanceDate != null ? attendanceDate.toString() : "";
	}

	@Override
	public String toString() {
		return "AttendanceDataDto [attendanceId=" + attendanceId + ", courseId=" + courseId + ", studentId=" + studentId
				+ ", professorId=" + professorId + ", attendanceLate=" + attendanceLate + ", attendanceAbsent="
				+ attendanceAbsent + ", attendanceRemarks=" + attendanceRemarks + ", attendanceDate=" + attendanceDate
				+ ", attendanceStatus=" + attendanceStatus + ", studentName=" + studentName + "]";
	}
	
	

}
