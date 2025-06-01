package controller.professor_support;

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
import model.dao.professor_support.ManageCourseDao;
import model.dto.professor_support.PaginationDto;
import model.dto.professor_support.RegistCourseDto;

@WebServlet(urlPatterns = {"/professor_support/manage/*"}, 
			initParams = {@WebInitParam(name="view",value = "/dist/")}
)
public class ManageCourseController extends MskimRequestMapping {
	
	private ManageCourseDao mDao = new ManageCourseDao();
	
	@MSLogin("loginStuCheck")
	@RequestMapping("manageCourse")
	public String searchCourseInfo (HttpServletRequest request, HttpServletResponse response) {
		
		String professorId = (String) request.getSession().getAttribute("login");
		String search = request.getParameter("search");
		String errorMsg = request.getParameter("errorMsg");
		
		Map<String, String> map = new HashMap<>();
		map.put("professorId", professorId);
		map.put("search", search);
		
		//페이징 처리
	    PaginationDto dto = new PaginationDto();

		String pageParam = request.getParameter("page");
		Integer currentPage = 
				(pageParam != null && !pageParam.isEmpty()) ? Integer.parseInt(pageParam) : 1;
		Integer offset = (currentPage - 1) * dto.getItemsPerPage();
		Integer totalRows = mDao.getCourseCountRows(map); // 데이터 총갯수 
		Integer totalPages = (int) Math.ceil((double)totalRows / dto.getItemsPerPage());
		System.out.println("sort: " + request.getParameter("sortDirection"));
		try {
		    BeanUtils.populate(dto, request.getParameterMap());
		    
		    dto.setProfessorId(professorId);
		    dto.setCurrentPage(currentPage);
		    dto.setTotalRows(totalRows);
		    dto.setTotalPages(totalPages);
		    dto.setOffset(offset);
		    
		} catch (RuntimeException e2) {
        	errorMsg = e2.getMessage();
        } catch (Exception e) {
		    e.printStackTrace();
		} 
		
		List<RegistCourseDto> result =  mDao.searchCourseInfo(dto);
		
		request.setAttribute("courses", result);
		request.setAttribute("pagination", dto);
		request.setAttribute("errorMsg", errorMsg);
		
		return "pages/professor_support/manageCourse";
	}
	
	@RequestMapping("changeCourse")
	public String changeCourse (HttpServletRequest request, HttpServletResponse response) {
		// 강의 닫기 변환시 해당강의에 수강생이 신청한게 없어야됨. course테이블에서 수강인원을관리하고있으니
		// 해당컬럼 확인하여 0 이 아닐시 닫기버튼 못하게 막아야 함 or 확실하게 registration 테이블 에서 course_id로 
		// 찾아서 존재유무 확인하는것도 좋을듯
		
		//파라미터 세팅
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("courseId", request.getParameter("courseId"));
		paramMap.put("courseStatus", request.getParameter("courseStatus"));
		
		//반환할 데이터 세팅
		Map<String, Object> jsonMap = new HashMap<>();
		
		try {
			if (mDao.changeCourse(paramMap) == 1) {
				jsonMap.put("result", "success");
			}
		} catch (RuntimeException e) {
			jsonMap.put("result", "fail");
			jsonMap.put("errorMsg", e.getMessage());
		}
		
		ObjectMapper mapper = new ObjectMapper();
        String json;
        
		try {
			json = mapper.writeValueAsString(jsonMap);
			request.setAttribute("json", json);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return "/pages/returnAjax";
	}
	
	@MSLogin("loginStuCheck")
	@RequestMapping("updateCourseInfo")
	public String updateCourseInfo (HttpServletRequest request, HttpServletResponse response) {
		
		String professorId = (String) request.getSession().getAttribute("login");
		String errorMsg = "";
		// 기존 페이지정보 전달
		String search = request.getParameter("search");
		String page = request.getParameter("page");
		
		//파라미터 세팅
		RegistCourseDto dto = new RegistCourseDto();
		
		try {
		    BeanUtils.populate(dto, request.getParameterMap());
		    dto.setProfessorId(professorId);
		    mDao.updateCourseInfo(dto);
		} catch (RuntimeException e2) {
        	errorMsg = e2.getMessage();
        } catch (Exception e) {
		    e.printStackTrace();
		} 
		request.setAttribute("errorMsg", errorMsg);
		
		return "redirect:manageCourse?page=" + page + "&search=" + search;
	}
	
	@MSLogin("loginStuCheck")
	@RequestMapping("deleteCourseInfo")
	public String deleteCourseInfo (HttpServletRequest request, HttpServletResponse response) {
		
		String errorMsg = "";
		// 기존 페이지정보 전달
		String search = request.getParameter("search");
		String page = request.getParameter("page");
		
		String courseId = request.getParameter("courseId");
		
		mDao.deleteCourseInfo(courseId);
		request.setAttribute("errorMsg", errorMsg);
		
		return "redirect:manageCourse?page=" + page + "&search=" + search;
	}
	
	//로그인없이접근막기 + 교수만 ( get방식사용하지않으므로 이쪽에선 파라미터값을 막을필욘없음)
	public String loginStuCheck(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		String login  = (String)session.getAttribute("login");
		if(login==null ) {
			request.setAttribute("msg", "로그인하세요");
			request.setAttribute("url", "doLogin");
			return "alert";
		}
		else if(login.contains("S")) {
			request.setAttribute("msg", "학생은 접근불가능합니다");
			request.setAttribute("url", "index");
			return "alert";
		}
		return null; //정상인경우
	}
}
