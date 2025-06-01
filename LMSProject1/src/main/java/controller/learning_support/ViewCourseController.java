package controller.learning_support;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.annotation.WebInitParam;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.fasterxml.jackson.databind.ObjectMapper;

import gdu.mskim.MSLogin;
import gdu.mskim.MskimRequestMapping;
import gdu.mskim.RequestMapping;
import model.dao.learning_support.CourseDao;
import model.dto.learning_support.AttendanceDto;
import model.dto.learning_support.RegistrationDto;

@WebServlet(urlPatterns = {"/learning_support/viewCourse/*"}, 
initParams = {@WebInitParam(name="view",value = "/dist/")}
)
public class ViewCourseController extends MskimRequestMapping{
	
	private CourseDao courseDao = new CourseDao();
	
	@MSLogin("loginStuCheck")
	@RequestMapping("viewCourse")
	public String registerCourse (HttpServletRequest request, HttpServletResponse response) {

		String studentId = (String) request.getSession().getAttribute("login");
		int totalScore = 0;
		
		//화면 로드시 수강신청내역 불러오기
		List<RegistrationDto> result = courseDao.searchRegistrationCourses(studentId);
		// 총학점 계산
		for (RegistrationDto r : result) {
			totalScore += r.getCourseScore();
		}
		
		request.setAttribute("registration", result);
		request.setAttribute("totalScore", totalScore);	
		
		return "/pages/learning_support/viewCourse";
	}
	
	@RequestMapping("deleteCourse")
	public String deleteCourse (HttpServletRequest request, HttpServletResponse response) {
		
		String studentId = (String) request.getSession().getAttribute("login");
		int totalScore = 0;
		
		// 수강신청내역 삭제
		String registrationId = request.getParameter("registrationId");
		String courseId = request.getParameter("courseId");
		int row = courseDao.deleteCourse(registrationId, courseId, studentId);
		Map<String, Object> result = new HashMap<>();
		
		if(row > 0) {
			//화면 로드시 수강신청내역 불러오기
			List<RegistrationDto> courseResult = courseDao.searchRegistrationCourses(studentId);
			// 총학점 계산
			for (RegistrationDto r : courseResult) {
				totalScore += r.getCourseScore();
			}
			result.put("totalScore", totalScore);
			result.put("success", "true");
			result.put("message", "삭제 성공");
		} else {
			result.put("success", "false");
			result.put("message", "삭제 실패");
		}
		
		ObjectMapper mapper = new ObjectMapper();
        String json;
        
		try {
			json = mapper.writeValueAsString(result);
			request.setAttribute("json", json);
			
		} catch (IOException e) {
			e.printStackTrace();

		}
		
		return "/pages/learning_support/ajax_learning_support";
	}
	
	@RequestMapping("viewCourseTime")
	public String viewCourseTime (HttpServletRequest request, HttpServletResponse response) {
		
		String studentId = (String) request.getSession().getAttribute("login");		
		Map<String, Object> map = new HashMap<>();
		
		try {
			List<AttendanceDto> result = courseDao.viewCourseTime(studentId);

            // 시간 포맷팅
            SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm");
            for (AttendanceDto item : result) {
                if (item.getCourseTimeStart() != null) {
                    item.setCourseTimeStartFormatted(timeFormat.format(item.getCourseTimeStart()));
                }
                if (item.getCourseTimeEnd() != null) {
                    item.setCourseTimeEndFormatted(timeFormat.format(item.getCourseTimeEnd()));
                }
            }

            map.put("success", true);
            map.put("timetable", result);
        } catch (Exception e) {
        	map.put("success", false);
        	map.put("message", "시간표 로드 실패: " + e.getMessage());
        }
		
		ObjectMapper mapper = new ObjectMapper();
        String json;
        
		try {
			json = mapper.writeValueAsString(map);
			request.setAttribute("json", json);
		} catch (IOException e) {
			e.printStackTrace();

		}

		return "/pages/learning_support/ajax_learning_support";
	}

	//로그인없이접근막기 + 학생만 ( get방식사용하지않으므로 이쪽에선 파라미터값을 막을필욘없음)
	public String loginStuCheck(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		String login  = (String)session.getAttribute("login");
		if(login==null ) {
			request.setAttribute("error", "로그인하세요");			
			return "/pages/error";
		}
		else if(login.contains("P")) {
			request.setAttribute("error", "교수는접근불가능합니다");
			return "/pages/error";
		}
		return null; //정상인경우
	}
	

}
