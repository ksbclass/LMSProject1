package domain;

public class Course {

    private String courseId;
    private String deptId;
    private String professorId;
    private String courseName;
    private String courseStatus;
    private Integer courseCurrentEnrollment;  // NULL 가능성이 있어서 Integer로 선언
    private Integer courseMaxCnt;             // NULL 가능성이 있어서 Integer로 선언
    private int courseScore;
    private String creditCategory;
    private String coursePeriod;
    private String coursePlan;

    // 기본 생성자
    public Course() {}

    // 모든 필드를 포함한 생성자
    public Course(String courseId, String deptId, String professorId, String courseName, String courseStatus,
                     Integer courseCurrentEnrollment, Integer courseMaxCnt, int courseScore, String creditCategory,
                     String coursePeriod, String coursePlan) {
        this.courseId = courseId;
        this.deptId = deptId;
        this.professorId = professorId;
        this.courseName = courseName;
        this.courseStatus = courseStatus;
        this.courseCurrentEnrollment = courseCurrentEnrollment;
        this.courseMaxCnt = courseMaxCnt;
        this.courseScore = courseScore;
        this.creditCategory = creditCategory;
        this.coursePeriod = coursePeriod;
        this.coursePlan = coursePlan;
    }

    // Getter & Setter
    public String getCourseId() {
        return courseId;
    }

    public void setCourseId(String courseId) {
        this.courseId = courseId;
    }

    public String getDeptId() {
        return deptId;
    }

    public void setDeptId(String deptId) {
        this.deptId = deptId;
    }

    public String getProfessorId() {
        return professorId;
    }

    public void setProfessorId(String professorId) {
        this.professorId = professorId;
    }

    public String getCourseName() {
        return courseName;
    }

    public void setCourseName(String courseName) {
        this.courseName = courseName;
    }

    public String getCourseStatus() {
        return courseStatus;
    }

    public void setCourseStatus(String courseStatus) {
        this.courseStatus = courseStatus;
    }

    public Integer getCourseCurrentEnrollment() {
        return courseCurrentEnrollment;
    }

    public void setCourseCurrentEnrollment(Integer courseCurrentEnrollment) {
        this.courseCurrentEnrollment = courseCurrentEnrollment;
    }

    public Integer getCourseMaxCnt() {
        return courseMaxCnt;
    }

    public void setCourseMaxCnt(Integer courseMaxCnt) {
        this.courseMaxCnt = courseMaxCnt;
    }

    public int getCourseScore() {
        return courseScore;
    }

    public void setCourseScore(int courseScore) {
        this.courseScore = courseScore;
    }

    public String getCreditCategory() {
        return creditCategory;
    }

    public void setCreditCategory(String creditCategory) {
        this.creditCategory = creditCategory;
    }

    public String getCoursePeriod() {
        return coursePeriod;
    }

    public void setCoursePeriod(String coursePeriod) {
        this.coursePeriod = coursePeriod;
    }

    public String getCoursePlan() {
        return coursePlan;
    }

    public void setCoursePlan(String coursePlan) {
        this.coursePlan = coursePlan;
    }
}
