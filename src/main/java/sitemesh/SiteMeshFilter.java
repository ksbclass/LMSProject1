package sitemesh;

import javax.servlet.annotation.WebFilter;

import org.sitemesh.builder.SiteMeshFilterBuilder;
import org.sitemesh.config.ConfigurableSiteMeshFilter;

/*
 * 1. sitemesh 패키지 생성
 * 2. SiteMeshFilter 클래스 파일생성
 * 
 * sitemesh 기능 : 화면 layout 페이지를 구현하여 jsp 페이지를 적용하는 프레임워크
 * 
 * filter 기능 : servlet 이전에 먼저 실행하여 request나 response 객체를 변경할 수 있는 기능
 */

@WebFilter("/*") // url mapping /* => 모든 요청시 필터 적용
public class SiteMeshFilter extends ConfigurableSiteMeshFilter{

	@Override
	protected void applyCustomConfiguration(SiteMeshFilterBuilder builder) {
		// layout 페이지의 위치정보 설정
		// /member/* => http://localhost:8080/model1Study/member/ 이하 모든 요청시
		// /layout/layout.jsp 페이지를 layout 페이지로 설정
		builder.addDecoratorPath("/learning_support/*", "/dist/pages/layout.jsp")
				.addExcludedPath("/learning_support/colleges*")
				.addExcludedPath("/learning_support/departments*")
				.addExcludedPath("/learning_support/searchCourse*")
				.addExcludedPath("/learning_support/addCourse*")
				.addExcludedPath("/learning_support/searchRegistrationCourses*")
				.addExcludedPath("/learning_support/deleteCourse*")
				.addExcludedPath("/learning_support/viewCourse/deleteCourse*")
				.addExcludedPath("/learning_support/viewCourse/viewCourseTime*")
				.addExcludedPath("/learning_support/viewCourse/deleteCourse*")

				.addExcludedPath("/mypage/registerUser*")
				.addExcludedPath("/mypage/doLogin*")
				.addExcludedPath("/mypage/findPw*")
				.addExcludedPath("/mypage/findId*")
				.addExcludedPath("/mypage/registerImg*")
				.addExcludedPath("/mypage/picture*")
				.addExcludedPath("/mypage/pwUpdate*")
				.addExcludedPath("/mypage/updateEmail*")
				.addExcludedPath("/mypage/updatePhone*")
				.addExcludedPath("/mypage/deleteUser*")
				.addExcludedPath("/mypage/viewCourseTimetable*")
				.addExcludedPath("/mypage/registerNumChk*")
				.addExcludedPath("/mypage/schedule*")
				
				
				
				.addExcludedPath("/post/deleteComment*");
				
				
				
		builder.addDecoratorPath("/professor_support/*", "/dist/pages/layout.jsp");
		
		builder.addDecoratorPath("/professor_support/manage/*", "/dist/pages/layout.jsp")
				.addExcludedPath("/professor_support/manage/changeCourse*")
				.addExcludedPath("/professor_support/manage/updateCourseInfo*")
				.addExcludedPath("/professor_support/manage/deleteCourseInfo*")
				;
		
		builder.addDecoratorPath("/professor_support/score/*", "/dist/pages/layout.jsp")
				.addExcludedPath("/professor_support/score/getScoreInfo*")
				.addExcludedPath("/professor_support/score/getCoursesInfo*")
				.addExcludedPath("/professor_support/score/updateScore*")
				;
		
		builder.addDecoratorPath("/professor_support/attendance/*", "/dist/pages/layout.jsp")
				.addExcludedPath("/professor_support/attendance/getAttendance*")
				.addExcludedPath("/professor_support/attendance/updateAttendance*")
				;
		
		builder.addDecoratorPath("/post/*","/dist/pages/layout.jsp");
		
		
		builder.addDecoratorPath("/notice/*","/dist/pages/layout.jsp");
		
		
		builder.addDecoratorPath("/mypage/*","/dist/pages/layout.jsp");
		
	}
	
	

}

