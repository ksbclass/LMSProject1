package controller.mypage;

import java.io.File;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Random;
import java.util.Set;

import javax.servlet.annotation.WebInitParam;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.mindrot.jbcrypt.BCrypt;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import domain.Dept;
import domain.Notice;
import domain.Professor;
import domain.Schedule;
import domain.Student;
import gdu.mskim.MSLogin;
import gdu.mskim.MskimRequestMapping;
import gdu.mskim.RequestMapping;
import model.dao.board.NoticeDao;
import model.dao.learning_support.CourseDao;
import model.dao.mypage.DeptDao;
import model.dao.mypage.GetScoreDao;
import model.dao.mypage.ProStuDao;
import model.dao.mypage.ProfessorDao;
import model.dao.mypage.ScheduleDao;
import model.dao.mypage.StudentDao;
import model.dto.learning_support.AttendanceDto;
import model.dto.mypage.GetScoresDto;
//http://localhost:8080/LMSProject1/dist/pages/mypage/registerUserChk
@WebServlet(urlPatterns = {"/mypage/*"},
initParams = {@WebInitParam(name="view", value="/dist/pages/")}
		)
public class MypageController  extends MskimRequestMapping{
	
	//로그인없이 접근을 막아줄 함수 ( get방식사용하지않으므로 이쪽에선 파라미터값을 막을필욘없음)
	public String loginIdCheck(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		String login  = (String)session.getAttribute("login");
		if(login==null) {
			request.setAttribute("msg", "로그인하세요");
			request.setAttribute("url", "doLogin");
			return "alert";
		}
		return null; //정상인경우
	}
	
	public  String IdChk(String a) { 
		String num = null;
		if(a.equals("pro")) {
			num = createProfessorId();	
		}
		else if(a.equals("stu")) {
			num = createStudentId();
		}
		return num;
	}
	
	//로그인없이접근막기 + 학생만 ( get방식사용하지않으므로 이쪽에선 파라미터값을 막을필욘없음)
		public String loginStuCheck(HttpServletRequest request, HttpServletResponse response) {
			HttpSession session = request.getSession();
			String login  = (String)session.getAttribute("login");
			if(login==null ) {
				request.setAttribute("msg", "로그인하세요");
				request.setAttribute("url", "doLogin");
				return "alert";
			}
			else if(login.contains("P")) {
				request.setAttribute("msg", "교수는접근불가능합니다");
				request.setAttribute("url", "index");
				return "alert";
			}
			return null; //정상인경우
		}
		
		//로그인없이접근막기 + 교수만 
		public String loginProCheck(HttpServletRequest request, HttpServletResponse response) {
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
		

	//임시비밀번호를 만드는 알고리즘(비밀번호찾기 시에만 발급이 될것임)
		public  String getTempPw() {
			List<String> lowerList = Arrays.asList
		    ("a" ,"b" ,"c" ,"d" ,"e" ,"f" ,"g" ,"h" ,"i" ,"j" ,"k" 
			,"l" ,"m" ,"n" ,"o" ,"p","q","r","s","t","z");
					
					List<String> upperList = new ArrayList<>();
					for (String string : lowerList) {
						upperList.add(string.toUpperCase());
					}	
					List<String> specialList = Arrays.asList("%","@","#","^","&","*","!");
					
					List<Object> combineList = new ArrayList<>();
					combineList.addAll(specialList);
					combineList.addAll(lowerList);
					combineList.addAll(upperList);
					for (int i = 0; i < 15; i++) { //랜덤한0~9 숫자 10개집어넣기
						 combineList.add(new Random().nextInt(10)); 
					}
					//무작위 섞기
					Collections.shuffle(combineList);
					String tempNum = "";
					for (int i = 0; i < 6; i++) {
						int num = new Random().nextInt(combineList.size());
						tempNum += combineList.get(num);
					}
					return tempNum;
				}
	
		
	
	//교수의아이디를 자동생성하는 메서드(p000)
	private  String createProfessorId() {
		int[] num = {0,1,2,3,4,5,6,7,8,9}; 

		String sNum="";
		for(int i=0;i<3;i++) {
			//0 ~ (num.length-1)의 랜덤한숫자반환
			int ranNum = new Random().nextInt(num.length);
			sNum+=num[ranNum]; //랜덤한 3개의숫자
		}
		ProfessorDao dao = new ProfessorDao();

		while(true) { 
			if(dao.idchk("P"+sNum)) { //true(id가존재하지않을 시 )면 루프탈출
				break;
			}
			else {
				int iNum = Integer.parseInt(sNum);//sNum을 Integer로형변환 
				iNum +=1; // 1 증가
				sNum = String.valueOf(iNum); // sNum으로 다시넣기
			}
		}
		//p0000 형식
		return "P"+sNum;

	}
	//학생의아이디를 자동생성하는 메서드(s00000)
	private   String createStudentId() {
		int[] num = {0,1,2,3,4,5,6,7,8,9};
		String sNum="";

		for(int i=0;i<5;i++) {
			//0 ~ (num.length-1)의 랜덤한숫자반환
			int ranNum = new Random().nextInt(num.length);
			sNum+=num[ranNum]; //랜덤한 5개의숫자
		}
		StudentDao memberDao = new StudentDao();

		while(true) { 
			if(memberDao.idchk("S"+sNum)) { //true(id가존재하지않을 시 )면 루프탈출
				break;
			}
			else {
				int iNum = Integer.parseInt(sNum);//sNum을 Integer로형변환 
				iNum +=1; // 1 증가
				sNum = String.valueOf(iNum); // sNum으로 다시넣기
			}
		}

		return "S"+sNum;
	}

	

	@RequestMapping("registerUser")
	public String  registerUser(HttpServletRequest request , HttpServletResponse response) throws ParseException {
		request.getSession().invalidate();//회원가입창에 들어오게된다면 일단 세션정보 다날려
		List<Dept> dept = new DeptDao().selectAll();
		request.setAttribute("dept", dept);
		return "mypage/registerUser";
	}


	//회원가입버튼을 누르면 동작하게됨 ( 인증번호를 넘겨 인증번호가맞아야회원가입이완료됨)
	@RequestMapping("registerNumChk")
	public String  registerUserChk(HttpServletRequest request , HttpServletResponse response) throws ParseException {
		String name  = request.getParameter("name");
		String date = request.getParameter("birth");
		
		String pass = request.getParameter("password");
		String hashpw = BCrypt.hashpw(pass, BCrypt.gensalt());//hashPassword : 암호화 (복호화는불가능)
		
		String position = request.getParameter("position");
		String img = request.getParameter("picture");
		String deptId = request.getParameter("deptId");
		String email = request.getParameter("email");
		String phone = request.getParameter("phone");
		String id = IdChk(position);//직급에따른 아이디부여해주는 메서드

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date birthDate = sdf.parse(date); // "YYYY-MM-dd" 형식의 문자열을 Date로 파싱

		//객체에 값 넣어주는과정 (교수 , 학생 따로)
		//직급 = 교수일경우
		if(id.contains("P")) {
			Professor pro = new Professor();
			pro.setProfessorId(id);
			pro.setProfessorImg(img);
			pro.setProfessorName(name);
			pro.setProfessorBirthday(birthDate);
			pro.setProfessorEmail(email);
			pro.setProfessorPassword(hashpw);
			//pro.setProfessorPassword(pass);
			pro.setDeptId(deptId);
			pro.setProfessorPhone(phone);
			System.out.println(pro);
			request.setAttribute("id", id);
			request.getSession().setAttribute("mem", pro);
			String num = EmailUtil.sendNum(email, name, id);
			request.setAttribute("num", num);
			
		}
		//학생일경우
		else {
			Student stu = new Student();
			stu.setStudentId(id);
			stu.setStudentNum(id.substring(1));
			stu.setDeptId(deptId);
			stu.setStudentName(name);
			stu.setStudentBirthday(birthDate);
			stu.setStudentEmail(email);
			stu.setStudentImg(img);
			stu.setStudentPassword(hashpw);
			//stu.setStudentPassword(pass);
			stu.setStudentPhone(deptId);
			stu.setStudentPhone(phone);
			stu.setStudentStatus("재학");

			System.out.println(stu);
			request.setAttribute("id", id);
			request.getSession().setAttribute("mem", stu);
			String num = EmailUtil.sendNum(email, name, id);
			request.setAttribute("num", num);
			
		}
		return "mypage/registerNumChk";
	}

	//회원가입 인증번호가 정상적으로 입력되었다면 넘어오는 곳 (페이지는없음)
	@RequestMapping("registerSuccess")
	public String  registerSuccess(HttpServletRequest request , HttpServletResponse response) throws ParseException {
		String id = request.getParameter("id");
		String msg = "회원가입성공 id = "+id;
		String url = "doLogin";
		
		
		if(id.contains("S")) {
			Student stu = (Student)request.getSession().getAttribute("mem");
			StudentDao sDao = new StudentDao();
			if(!sDao.insert(stu)) { //DB에오류발생시
				msg = "회원가입실패";
				url = "registerUser";
			}
			else {
				//회원가입성공 시 해당email로 발급된 id를 보내줄거임
				String email = stu.getStudentEmail();
				String name = stu.getStudentName();
				EmailUtil.sendIdEmail(email, name, id);
				
			}
		}
		else {
			Professor pro = (Professor)request.getSession().getAttribute("mem");
			ProfessorDao pDao = new ProfessorDao();
			if(!pDao.insert(pro)) {
				msg = "회원가입실패";
				url = "registerUser";
			}
			else {
				String email = pro.getProfessorEmail();
				String name = pro.getProfessorName();
				EmailUtil.sendIdEmail(email, name, id);
				

			}

		}
		request.getSession().invalidate();
		request.setAttribute("msg", msg);
		request.setAttribute("url", url);
		 //회원가입이실패하든 성공하든 세션정보는 모두지워줌
		
		return "alert";
	}



	//사진업로드관련
	@RequestMapping("picture")
	public String picture(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String path = request.getServletContext().getRealPath("")+"/dist/assets/picture/";
		
		//기준 디렉토리 의 실제 경로
		String fname = null;
		File f = new File(path);//업로드되는 폴더정보
		if(!f.exists()){
			f.mkdirs(); //없으면 폴더생성
		}
		MultipartRequest multi = new MultipartRequest(
		request,path,10*1024*1024,"UTF-8",new DefaultFileRenamePolicy());
		
		fname = multi.getFilesystemName("picture");//사진명
		request.setAttribute("fname", fname);
		System.out.println(fname);
		return "mypage/picture";
	}
	

	@RequestMapping("doLogin") //로그인상태로접근불가능
	public String doLogin(HttpServletRequest request, HttpServletResponse response) throws IOException {
		request.getSession().invalidate();//로그인창에 들어오게된다면 일단 세션정보 다날려
		HttpSession session = request.getSession();
		String login = (String)session.getAttribute("login");
		if(login==null) {
			return "mypage/doLogin";
		}
		else {
			request.setAttribute("msg", "로그아웃을하세요");
			request.setAttribute("url","index");
			return "alert";
		}

	}

	//(id,pw입력 후 )로그인버튼 클릭시 발생하는  컨트롤러
	@RequestMapping("login")
	public String login(HttpServletRequest request, HttpServletResponse response) throws IOException {

		HttpSession session = request.getSession();
		session.setMaxInactiveInterval(5400); // 1시간 30분(5400초)으로 세션 타임아웃 설정
		//session정보를 얻음(session영역 속성 등록을위해)

		String id = request.getParameter("id");
		String pass = request.getParameter("password");

		if(id==null || id.trim()=="" || pass==null || pass.trim()=="") {
			request.setAttribute("msg", "아이디or비번확인");
			request.setAttribute("url","doLogin");
			return "alert";
		}
		//student or professor의 id,pw,name을가지고있는 map
		Map<String,String> map = new ProStuDao().login(id); 
		if(map==null){
			request.setAttribute("msg", "아이디 확인하세요");
			request.setAttribute("url","doLogin");
		}

		else{
			String dbId="";
			String dbPw="";
			String dbName="";
			Set<Entry<String,String>> entrySet = map.entrySet();
			for (Entry<String, String> entry : entrySet) {
				if(entry.getKey().contains("id")) {
					dbId = entry.getValue();
				}
				else if(entry.getKey().contains("password")) {
					dbPw = entry.getValue();
				}
				else {
					dbName = entry.getValue();
				}
			} //dbId,dbPw,dbName 꺼내기종료

			
			//Bcrypt.checkpw(입력,검증) : 입력과 검증(암호화된비번) 을 비교할수있음
			if(BCrypt.checkpw(pass, dbPw) ){
				
				if(dbId.contains("S")) { //학생 중 퇴학상태인 학생을 검증하는 단계
					if(new StudentDao().selectStatus(dbId)) { 
						request.setAttribute("msg","퇴학한사람은 로그인할수없어요");
						request.setAttribute("url","doLogin");
						return "alert";
					}
				}

				session.setAttribute("login", dbId);
				request.setAttribute("msg", dbName+"님이 로그인 하셨습니다");
				request.setAttribute("url","index");

			}
			else{
				request.setAttribute("msg", "비번을 확인하세요");
				request.setAttribute("url","doLogin");
			}
		}
		return "alert";
	}

	@MSLogin("loginIdCheck")
	@RequestMapping("index") 
	public String main(HttpServletRequest request , HttpServletResponse response) {
		String dbId = (String)request.getSession().getAttribute("login");
		HttpSession session = request.getSession();

		if(dbId.contains("S")) {
			StudentDao dao = new StudentDao();
			Student student = dao.selectOne(dbId);
			String deptName = new DeptDao().selectName(student.getDeptId());
			session.setAttribute("deptName", deptName);
			session.setAttribute("m", student);
		}
		else if(dbId.contains("P")){
			ProfessorDao dao = new ProfessorDao();
			Professor professor = dao.selectOne(dbId);
			String deptName = new DeptDao().selectName(professor.getDeptId());
			session.setAttribute("deptName", deptName);
			session.setAttribute("m", professor);	

		}
        List<Notice> allNotices = NoticeDao.listAll();
        List<Notice> recentNotices = new ArrayList<>();
        if (allNotices != null) {
            Collections.sort(allNotices, Comparator.comparing(Notice::getNoticeCreatedAt).reversed());
            for (int i = 0; i < Math.min(4, allNotices.size()); i++) {
                recentNotices.add(allNotices.get(i));
            }
        }
        request.setAttribute("recentNotices", recentNotices);

		return "index"; //forward 됨
		//redirect시 다른 request영역이므로 속성이 넘어가지않음

	}

	@RequestMapping("logout")
	public String logout(HttpServletRequest request, HttpServletResponse response) {
		request.getSession().invalidate();
		return "redirect:doLogin"; //redirect하도록 설정(속성초기화)
	}

	@RequestMapping("findIdProcess")
	public String findIdProcess(HttpServletRequest request, HttpServletResponse response) {
		String name = request.getParameter("name");
		String email = request.getParameter("email");

		ProStuDao proStuDao = new ProStuDao();
		String id = proStuDao.findId(name, email);
		if(id==null) {
			request.setAttribute("msg", "입력된정보가없어요");			
			return "idSearch";
		}
		else {
			EmailUtil.sendIdEmail(email, name, id);
			request.setAttribute("msg", "id는 이메일로 발송해드렸어요...!"); 
			request.setAttribute("id", id);
			return "idSearch";
		}

	}

	
	

	@RequestMapping("findPwProcess")
	public String findPwProcess(HttpServletRequest request, HttpServletResponse response) {
		String id = request.getParameter("id");
		String email = request.getParameter("email");
		//아이디와이메일이 일치 시 비밀번호를 반환
		String pw = new ProStuDao().findPw(id,email);
		if(pw==null) {
			request.setAttribute("msg", "입력된정보가없어요");			
			return "mypage/close";
		}
		else {
			String tempPw = getTempPw(); //임시비번생성하는 알고리즘이있는 메서드
			String hashpw = BCrypt.hashpw(tempPw, BCrypt.gensalt()); //임시비밀번호를 암호화
			
			if(new ProStuDao().updateTempPw(hashpw,id)) { //넘겨받은 id의 비밀번호를 임시비번으로 업데이트
				EmailUtil.sendTempPw(email, id, tempPw);//임시비밀번호를 메일로발송
				request.setAttribute("msg", "임시 비밀번호는이메일로 전송해드렸어요 , 바로비밀번호를 변경할까요?"); 
				request.setAttribute("id", id);
				request.setAttribute("email", email);
				//알림창을 띄워주고 pwUpdate폼으로이동
				return "mypage/alertPw";
			}
			else {
				request.setAttribute("msg", "오류발생");
				return "mypage/close";
			}
		}
	}

	//pwUpdate에서 넘어오는곳(비밀번호처리만담당)
	@RequestMapping("pw")
	public String pw(HttpServletRequest request, HttpServletResponse response) {
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		String cPw = request.getParameter("cPw");
		String email = request.getParameter("email");

		System.out.println(id);
		System.out.println(email);
		System.out.println("pw"+pw);


		String msg="현재비밀번호가 틀립니다";

		String hashPw = new ProStuDao().findPw(id, email);
		System.out.println(hashPw);
		//pw.equals(hashPw)
		if(BCrypt.checkpw(pw, hashPw)) {
			String hashpw2 = BCrypt.hashpw(cPw, BCrypt.gensalt());
			boolean updatePw = new ProStuDao().updatePw(id,hashpw2);
			if(updatePw) {
				if(request.getSession()!=null) {
					msg="비밀번호변경실패";
					request.setAttribute("logout", "logout");
				}
				msg = "비밀번호변경완료!!!";
			}
		}
		request.setAttribute("msg",msg);
		return "mypage/close";


	}

	@RequestMapping("close")
	public String close(HttpServletRequest request, HttpServletResponse response) {
		request.setAttribute("msg", request.getAttribute("msg"));
		return "mypage/close";
	}

	@MSLogin("loginIdCheck")
	@RequestMapping("userInfo")
	public String info(HttpServletRequest request, HttpServletResponse response) {
		String id = (String)request.getSession().getAttribute("login");
		String deptName = new ProStuDao().selectDeptName(id);
		request.setAttribute("deptName", deptName);
		return "mypage/userInfo";
	}

	@MSLogin("loginIdCheck")
	@RequestMapping("userUpdate")
	public String userUpdate(HttpServletRequest request, HttpServletResponse response) {
		String id = (String)request.getSession().getAttribute("login");
		String img = request.getParameter("picture");
		String phone = request.getParameter("phone");
		String email = request.getParameter("email");
		String msg="입력값이맞지않아요";
		request.setAttribute("url", "index");
		if(ProStuDao.userUpdate(id,img,phone,email)) {
			msg=id+"님 수정성공";
			request.setAttribute("msg", msg);
			return "alert";
		}
		else {
			request.setAttribute("msg", msg);
			return "alert";
		}
	}

	@MSLogin("loginStuCheck")
	@RequestMapping("deleteUser")
	public String deleteUser(HttpServletRequest request, HttpServletResponse response) { 
		List<Dept> list = new DeptDao().selectAll();
		request.setAttribute("dept", list);
		return "mypage/deleteUser";
	}


	@MSLogin("loginStuCheck")
	@RequestMapping("delete")
	public String delete(HttpServletRequest request, HttpServletResponse response) { 
		String id = (String)request.getSession().getAttribute("login");
		String inputId= request.getParameter("id");
		String pw = request.getParameter("pw");
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		String deptId = request.getParameter("deptId");
		
		if(id.equals(inputId)) {
			String dbId = new ProStuDao().findPw(inputId, email);
			//db의비밀번호와 입력한비밀번호비교
			//암호화때문에 equals로 비교불가능
			boolean checkpw = BCrypt.checkpw(pw, dbId);
			System.out.println("비밀번호 검증 성공여부 : "+checkpw);
			
			boolean result = new StudentDao().deleteUser(inputId,deptId,name);
			//비밀번호검증 , delete여부 모두 true일 시
			if(checkpw&&result) {
				EmailUtil.sendDeleteMsg(email, name); // 자퇴성공시 메일발송
				request.setAttribute("logout", "logout");
				request.setAttribute("msg", "자퇴성공");
			}
			else {
				request.setAttribute("msg", "변경실패");
			}
		}
		//id가 로그인한정보와 일치하지않을 시
		else {
			request.setAttribute("msg", "입력한 아이디가 로그인한 아이디와 일치하지않아요");				
		}
		return "mypage/close";
	}
	
	
	//성적확인
	@MSLogin("loginStuCheck")
	@RequestMapping("getCourseScores")
	public String getCourseScores (HttpServletRequest request, HttpServletResponse response) {
		String id = (String)request.getSession().getAttribute("login");
		try {
			List<GetScoresDto> score = new GetScoreDao().getScore(id);
			request.setAttribute("score", score);
			return "mypage/getCourseScores";
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		request.setAttribute("msg", "오류발생");
		request.setAttribute("url", "index");
		return "alert";
	}
	
	
	
	
	//시간표조회폼
	@MSLogin("loginStuCheck")
	@RequestMapping("getCourseTimetable")
	public String getCourseTimetable (HttpServletRequest request, HttpServletResponse response) {
		return "mypage/getCourseTimetable";
	}
	
	
	//시간표조회에 들어가면 타는 폼
	@RequestMapping("viewCourseTimetable")
	public String viewCourseTime (HttpServletRequest request, HttpServletResponse response) {
		//		String studentId = (String) request.getSession().getAttribute("login");
		//		테스트위한 임시 studentId 지정
		String studentId = (String)request.getSession().getAttribute("login");
		Map<String, Object> map = new HashMap<>();


		try {
			CourseDao courseDao = new CourseDao();
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
			System.out.println(json);
		} catch (IOException e) {
			e.printStackTrace();

		}

		return "mypage/ajax_mypage_support";
	}
	
	@RequestMapping("schedule")
    public String schedule(HttpServletRequest request, HttpServletResponse response) {
        Map<String, Object> map = new HashMap<>();
        try {
            ScheduleDao scheduleDao = new ScheduleDao();
            List<Schedule> schedules = scheduleDao.listAll();

            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            List<Map<String, Object>> formattedSchedules = new ArrayList<>();
            for (Schedule item : schedules) {
                Map<String, Object> scheduleMap = new HashMap<>();
                scheduleMap.put("scheduleId", item.getScheduleId());
                scheduleMap.put("scheduleDate", item.getScheduleDate().getTime());
                scheduleMap.put("scheduleTitle", item.getScheduleTitle());
                scheduleMap.put("scheduleDescription", item.getScheduleDescription());
                if (item.getScheduleDate() != null) {
                    scheduleMap.put("scheduleDateFormatted", dateFormat.format(item.getScheduleDate()));
                } else {
                    scheduleMap.put("scheduleDateFormatted", null);
                }
                formattedSchedules.add(scheduleMap);
            }

            ObjectMapper mapper = new ObjectMapper();
            map.put("success", true);
            map.put("schedules", formattedSchedules);
            String json = mapper.writeValueAsString(map);
            System.out.println("Generated JSON: " + json);
            request.setAttribute("json", json);
        } catch (Exception e) {
            System.out.println("getScheduleList exception: " + e.getMessage());
            e.printStackTrace();
            map.put("success", false);
            map.put("message", "데이터 로드 실패: " + e.getMessage());
            try {
                ObjectMapper mapper = new ObjectMapper();
                String json = mapper.writeValueAsString(map);
                request.setAttribute("json", json);
            } catch (IOException e2) {
                e2.printStackTrace();
                request.setAttribute("json", "{\"success\":false,\"message\":\"JSON 직렬화 오류\"}");
            }
        }
        return "mypage/ajax_mypage_support";
    }
}
