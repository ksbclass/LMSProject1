package controller.professor_support;

import java.io.BufferedReader;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.annotation.WebInitParam;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import gdu.mskim.MSLogin;
import gdu.mskim.MskimRequestMapping;
import gdu.mskim.RequestMapping;
import model.dao.professor_support.ManageAttendanceDao;
import model.dto.professor_support.AttendanceDataDto;

@WebServlet(urlPatterns = { "/professor_support/attendance/*" }, 
			initParams = {@WebInitParam(name = "view", value = "/dist/") })
public class ManageAttendanceController extends MskimRequestMapping {

	private ManageAttendanceDao attDao = new ManageAttendanceDao();	
	ObjectMapper mapper = new ObjectMapper();
	
	@MSLogin("loginStuCheck")
	@RequestMapping("attendance")
	public String attendance(HttpServletRequest request, HttpServletResponse response) {

		String professorId = (String) request.getSession().getAttribute("login");
		List<Map<String, Object>> result = attDao.getCoursesInfoByPro(professorId);
		request.setAttribute("courses", result);

		return "pages/professor_support/manageAttendance";
	}
	/**
	 * 선택한강의 수강생들 조회
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("getAttendance")
	public String getAttendance(HttpServletRequest request, HttpServletResponse response) {
		
		String professorId = (String) request.getSession().getAttribute("login");
		AttendanceDataDto attDto = new AttendanceDataDto();
		
		try {
			attDto.setCourseId(request.getParameter("courseId"));
			// LocalDate타입을 위한 set
			attDto.setAttendanceDate(request.getParameter("attendanceDate"));
			
			List<Map<String, Object>> attList =  attDao.getAttendance(attDto);
			String json = mapper.writeValueAsString(attList);
			request.setAttribute("json", json);
		} catch (Exception e) {
			e.printStackTrace();
			Map<String, Object> errorMap = new HashMap<>();
			errorMap.put("errorMsg", "수강생목록 불러오기 오류발생. 관리자에게 문의 하십시오.");
			try {
				request.setAttribute("json", mapper.writeValueAsString(errorMap));
			} catch (JsonProcessingException e1) {
				e1.printStackTrace();
			}
		}
		
		return "pages/returnAjax";
	}
	
	@RequestMapping("updateAttendance")
	public String updateAttendance(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		String professorId = (String) request.getSession().getAttribute("login");
		
		//클라이언트로부터 받은 json데이터 파싱
		BufferedReader reader = request.getReader();
		StringBuilder sb = new StringBuilder();
		String line;
		while ((line = reader.readLine()) != null) {
			sb.append(line);
		}
		String jsonData = sb.toString();
		
		try {
			List<AttendanceDataDto> dtoList = 
					mapper.readValue(jsonData, mapper.getTypeFactory()
							.constructParametricType(List.class, AttendanceDataDto.class));
			attDao.updateAttendance(dtoList);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("error: " + e);
			return "returnAjax";
		}
		
		return "pages/dummy";
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
