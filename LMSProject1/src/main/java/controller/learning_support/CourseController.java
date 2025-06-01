package controller.learning_support;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.annotation.WebInitParam;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.beanutils.BeanUtils;

import com.fasterxml.jackson.databind.ObjectMapper;

import gdu.mskim.MSLogin;
import gdu.mskim.MskimRequestMapping;
import gdu.mskim.RequestMapping;
import model.dao.learning_support.CourseDao;
import model.dto.learning_support.CourseDto;
import model.dto.learning_support.CoursePagingDto;
import model.dto.learning_support.DeptDto;
import model.dto.learning_support.RegistrationDto;
import model.dto.learning_support.SearchDto;
import model.dto.professor_support.PaginationDto;

@WebServlet(urlPatterns = {"/learning_support/*"}, 
			initParams = {@WebInitParam(name="view",value = "/dist/")}
)
public class CourseController extends MskimRequestMapping {
	
	private CourseDao courseDao = new CourseDao();
	ObjectMapper mapper = new ObjectMapper();
	
	
	@MSLogin("loginStuCheck")
	@RequestMapping("registerCourse")
	public String registerCourse (HttpServletRequest request, HttpServletResponse response) {

		return "/pages/learning_support/registerCourse";
	}
	
	
	@RequestMapping("colleges")
	public String getColleges (HttpServletRequest request, HttpServletResponse response) {
		
		List<String> colleges = courseDao.getColleges();
		
        ObjectMapper mapper = new ObjectMapper();
        String json;
        
		try {
			json = mapper.writeValueAsString(colleges);
			request.setAttribute("json", json);
			
		} catch (IOException e) {
			e.printStackTrace();

		}
		return "/pages/learning_support/ajax_learning_support";
	}
	
	@RequestMapping("departments")
	public String getDepartments (HttpServletRequest request, HttpServletResponse response) {
		
		String college = request.getParameter("college");
		System.out.println("college: " + college);
		List<DeptDto> departments = courseDao.getDepartments(college);
		
        ObjectMapper mapper = new ObjectMapper();
        String json;
        
		try {
			json = mapper.writeValueAsString(departments);
			request.setAttribute("json", json);
		} catch (IOException e) {
			e.printStackTrace();

		}
		return "/pages/learning_support/ajax_learning_support";
	}
	/**
	 * 강의목록 조회
	 * @param request
	 * @param response
	 * @return 
	 */
	@RequestMapping("searchCourse")
	public String searchCourse (HttpServletRequest request, HttpServletResponse response) {
		//세션 불러오기
		String studentId = (String) request.getSession().getAttribute("login");
		
		SearchDto searchDto = new SearchDto();
		PaginationDto pageDto = new PaginationDto();
		CoursePagingDto cpDto = new CoursePagingDto();
		
		try {
			BeanUtils.populate(searchDto, request.getParameterMap());
			searchDto.setStudentId(studentId);
			BeanUtils.populate(pageDto, request.getParameterMap());
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		// 페이징처리 
		Integer pageSize = pageDto.getItemsPerPage(); 
		Integer currentPage = pageDto.getCurrentPage();
		currentPage = currentPage != null ? currentPage : 1;
		Integer offset = (currentPage - 1) * pageSize;
		Integer totalRows = courseDao.countCourses(searchDto);
		Integer totalPages = (int) Math.ceil((double)totalRows / pageSize); 
		
		pageDto.setCurrentPage(currentPage);
		pageDto.setTotalRows(totalRows);
		pageDto.setTotalPages(totalPages);
		pageDto.setOffset(offset);

		cpDto.setPaginationDto(pageDto);
		cpDto.setSearchDto(searchDto);

		List<CourseDto> courses = courseDao.searchCourse(cpDto);
		
		ObjectMapper mapper = new ObjectMapper();
        
		Map<String, Object> responseMap = new HashMap<String, Object>();
		responseMap.put("courses", courses);
		responseMap.put("pagination", pageDto);
		
		try {
			String json = mapper.writeValueAsString(responseMap);
			request.setAttribute("json", json);
			
		} catch (IOException e) {
			e.printStackTrace();
		}
		
        return "/pages/learning_support/ajax_learning_support";
	}
	
	/**
	 * 강의 추가
	 * @param request
	 * @param response
	 * @return
	 */
	@MSLogin("loginStuCheck")
	@RequestMapping("addCourse")
	public String addCourse (HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> errorMap = new HashMap<>();
		ObjectMapper mapper = new ObjectMapper();
        String json;
	
        String studentId = (String) request.getSession().getAttribute("login");
		
		Map<String, Object> map = new HashMap<>();
		map.put("studentId", studentId);
		map.put("courseId", request.getParameter("courseId"));
		map.put("professorId", request.getParameter("professorId"));
		 
		try {
			courseDao.addCourse(map);
		} catch(Exception e) {
			errorMap.put("errorMsg", e.getMessage());
			try {
				json = mapper.writeValueAsString(errorMap);
				request.setAttribute("json", json);
			} catch (IOException e2) {
				e2.printStackTrace();
			}
			return "/pages/returnAjax";
		}
		
		return "/pages/dummy";
	}
	
	@RequestMapping("searchRegistrationCourses")
	public String searchRegistrationCourses (HttpServletRequest request, HttpServletResponse response) {
		
		String studentId = (String) request.getSession().getAttribute("login");
		
		List<RegistrationDto> result = courseDao.searchRegistrationCourses(studentId);
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
	
	@MSLogin("loginStuCheck")
	@RequestMapping("deleteCourse")
	public String deleteCourse (HttpServletRequest request, HttpServletResponse response) {

		String studentId = (String) request.getSession().getAttribute("login");
		
		String registrationId = request.getParameter("registrationId");
		String courseId = request.getParameter("courseId");
		
		try {
			courseDao.deleteCourse(registrationId,courseId, studentId);
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return "/pages/dummy";
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
