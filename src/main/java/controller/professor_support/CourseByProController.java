package controller.professor_support;

import java.util.List;

import javax.servlet.annotation.WebInitParam;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import gdu.mskim.MSLogin;
import gdu.mskim.MskimRequestMapping;
import gdu.mskim.RequestMapping;
import model.dao.learning_support.CourseDao;
import model.dao.professor_support.CourseByProDao;
import model.dto.learning_support.DeptDto;
import model.dto.professor_support.RegistCourseDto;

@WebServlet(urlPatterns = {"/professor_support/*"}, 
			initParams = {@WebInitParam(name="view",value = "/dist/")}
)
public class CourseByProController extends MskimRequestMapping {
	
	private CourseDao courseDao = new CourseDao();
	private CourseByProDao byProDao = new CourseByProDao();
	
	@MSLogin("loginStuCheck")
	@RequestMapping("registCourse")
	public String registerCourse (HttpServletRequest request, HttpServletResponse response) {
		List<DeptDto> departments = courseDao.getDepartments("");
		request.setAttribute("departments", departments);
		return "pages/professor_support/registCourseByPro";
	}
	
	//redirect 전용
	@MSLogin("loginStuCheck")
	@RequestMapping("registCourseByPro")
	public String registCourseByPro (HttpServletRequest request, HttpServletResponse response) {
		List<DeptDto> departments = courseDao.getDepartments("");
		
		request.setAttribute("departments", departments);
		request.setAttribute("errorMsg", request.getParameter("errorMsg"));
		
		return "pages/professor_support/registCourseByPro";
	}
	
	@RequestMapping("registCourseForm")
	public String registCourseForm (HttpServletRequest request, HttpServletResponse response) {
		
		String professorId = (String) request.getSession().getAttribute("login");
		
		String errorMsg = "";
		String courseId = byProDao.getMaxcourseIdNumber();
		String CourseTimeId = byProDao.getMaxcourseTimeIdNumber();
		RegistCourseDto dto = new RegistCourseDto();
		
		dto.setCourseId(courseId); 
        dto.setDeptId(request.getParameter("majorName"));
        dto.setProfessorId(professorId); 
        dto.setCourseName(request.getParameter("courseName"));
        dto.setCourseStatus("OPEN");
        dto.setCourseMaxCnt(Integer.valueOf(request.getParameter("courseMaxCnt")));
        dto.setCourseScore(Integer.valueOf(request.getParameter("score")));
        dto.setCreditCategory(request.getParameter("creditCategory"));
        dto.setCoursePeriod(request.getParameter("coursePeriod"));
        dto.setCoursePlan(request.getParameter("description"));

        dto.setCourseTimeId(CourseTimeId);
        dto.setCourseTimeYoil(request.getParameter("courseDay"));
        dto.setCourseTimeLoc(request.getParameter("courseLoc"));
        dto.setCourseTimeStart(request.getParameter("startTimeHour") + ":00");
        dto.setCourseTimeEnd(request.getParameter("endTimeHour") + ":50");
        
        try {
        	byProDao.insertCourseInfo(dto);
        }catch (RuntimeException e2) {
        	errorMsg = e2.getMessage();
        }

		return "redirect:registCourseByPro?errorMsg=" + errorMsg;
	}

	//로그인없이접근막기 + 교수만 ( get방식사용하지않으므로 이쪽에선 파라미터값을 막을필욘없음)
	public String loginStuCheck(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		String login  = (String)session.getAttribute("login");
		if(login==null ) {
			request.setAttribute("error", "로그인하세요");
			return "/pages/error";
		}
		else if(login.contains("S")) {
			request.setAttribute("error", "학생은 접근불가능합니다");
			return "/pages/error";
		}
		return null; //정상인경우
	}
}
