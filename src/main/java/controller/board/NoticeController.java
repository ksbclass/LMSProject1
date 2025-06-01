package controller.board;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebInitParam;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;

import domain.Notice;
import domain.Professor;
import gdu.mskim.MSLogin;
import gdu.mskim.MskimRequestMapping;
import gdu.mskim.RequestMapping;
import model.dao.board.NoticeDao;

@WebServlet(urlPatterns = {"/notice/*"}, initParams = {@WebInitParam(name = "view", value = "/dist/pages/")})
public class NoticeController extends MskimRequestMapping {
    private NoticeDao dao = new NoticeDao();
    private static final String UPLOAD_DIR = "dist/assets/upload";

    // 로그인 체크
    public String loginIdCheck(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();
        String login = (String) session.getAttribute("login");
        if (login == null) {
            request.setAttribute("msg", "로그인하세요");
            request.setAttribute("url", "/LMSProject1/mypage/doLogin");
            return "alert";
        }
        return null;
    }

    // 교수 전용 체크
    public String loginProCheck(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();
        String login = (String) session.getAttribute("login");
        if (login == null) {
            request.setAttribute("msg", "로그인하세요");
            request.setAttribute("url", "/LMSProject1/mypage/doLogin");
            return "alert";
        } else if (login.contains("S")) {
            request.setAttribute("msg", "학생은 접근 불가능합니다");
            request.setAttribute("url", "/LMSProject1/notice/getNotices");
            return "alert";
        }
        return null;
    }

    private synchronized String generateNewNoticeId() {
        String maxNoticeId = dao.getMaxNoticeId();
        System.out.println("Max notice_id: " + maxNoticeId);
        if (maxNoticeId == null || maxNoticeId.isEmpty()) {
            System.out.println("Returning default notice_id: N001");
            return "N001";
        }
        try {
            String numberPart = maxNoticeId.substring(1);
            int number = Integer.parseInt(numberPart);
            number++;
            String newId = "N" + String.format("%03d", number);
            System.out.println("Generated notice_id: " + newId);
            return newId;
        } catch (Exception e) {
            System.err.println("Notice_id 생성 실패: " + e.getMessage());
            return "N001";
        }
    }

    @MSLogin("loginIdCheck")
    @RequestMapping("getNotices")
    public String getNotices(HttpServletRequest request, HttpServletResponse response) {
        System.out.println("getNotices called with pageNum: " + request.getParameter("pageNum"));
        int limit = 10;
        int pageNum = 1;

        try {
            String pageNumParam = request.getParameter("pageNum");
            if (pageNumParam != null && !pageNumParam.trim().isEmpty()) {
                pageNum = Integer.parseInt(pageNumParam);
                if (pageNum < 1) pageNum = 1;
            }
        } catch (NumberFormatException e) {
            pageNum = 1;
        }

        int boardcount = dao.boardCount(null, null);
        List<Notice> list = dao.list(pageNum, limit, null, null);
        if (list == null) {
            list = new ArrayList<>();
        }
        for (Notice notice : list) {
            System.out.println("getNotices - Notice ID: " + notice.getNoticeId() + ", WriterName: " + notice.getWriterName());
        }
        System.out.println("Board count: " + boardcount + ", List size: " + list.size());
        int maxpage = (int) Math.ceil((double) boardcount / limit);
        int startpage = ((int) (pageNum / 10.0 + 0.9) - 1) * 10 + 1;
        int endpage = startpage + 9;
        if (endpage > maxpage) endpage = maxpage;

        int boardNum = boardcount - (pageNum - 1) * limit;

        HttpSession session = request.getSession();
        String login = (String) session.getAttribute("login");
        Object user = session.getAttribute("m");
        boolean isProfessor = (user instanceof Professor);

        request.setAttribute("login", login);
        request.setAttribute("isProfessor", isProfessor);
        request.setAttribute("boardcount", boardcount);
        request.setAttribute("pageNum", pageNum);
        request.setAttribute("list", list);
        request.setAttribute("startpage", startpage);
        request.setAttribute("endpage", endpage);
        request.setAttribute("maxpage", maxpage);
        request.setAttribute("boardNum", boardNum);
        request.setAttribute("today", new Date());

        return "board/notice/getNotices";
    }

    @MSLogin("loginIdCheck")
    @RequestMapping("searchNotice")
    public String searchNotice(HttpServletRequest request, HttpServletResponse response) {
        System.out.println("searchNotice called with pageNum: " + request.getParameter("pageNum"));
        int limit = 10;
        int pageNum = 1;

        try {
            String pageNumParam = request.getParameter("pageNum");
            if (pageNumParam != null && !pageNumParam.trim().isEmpty()) {
                pageNum = Integer.parseInt(pageNumParam);
                if (pageNum < 1) pageNum = 1;
            }
        } catch (NumberFormatException e) {
            pageNum = 1;
        }

        String column = request.getParameter("column");
        String find = request.getParameter("find");

        System.out.println("Parameters - column: " + column + ", find: " + find);
        if (column == null || column.trim().isEmpty() || find == null || find.trim().isEmpty() ||
            !isValidColumn(column)) {
            column = null;
            find = null;
            request.setAttribute("msg", "유효한 검색 조건과 검색어를 입력해주세요.");
        }

        int boardcount = dao.boardCount(column, find);
        List<Notice> list = dao.list(pageNum, limit, column, find);
        if (list == null) {
            list = new ArrayList<>();
        }
        for (Notice notice : list) {
            System.out.println("searchNotice - Notice ID: " + notice.getNoticeId() + ", WriterName: " + notice.getWriterName());
        }
        
        int maxpage = (int) Math.ceil((double) boardcount / limit);
        int startpage = ((int) (pageNum / 10.0 + 0.9) - 1) * 10 + 1;
        int endpage = startpage + 9;
        if (endpage > maxpage) endpage = maxpage;

        int boardNum = boardcount - (pageNum - 1) * limit;

        request.setAttribute("boardcount", boardcount);
        request.setAttribute("pageNum", pageNum);
        request.setAttribute("list", list);
        request.setAttribute("startpage", startpage);
        request.setAttribute("endpage", endpage);
        request.setAttribute("maxpage", maxpage);
        request.setAttribute("boardNum", boardNum);
        request.setAttribute("today", new Date());
        request.setAttribute("column", column);
        request.setAttribute("find", find);

        return "board/notice/searchNotice";
    }

    private boolean isValidColumn(String column) {
        if (column == null) return false;
        String[] validColumns = {
            "writerName", "noticeTitle", "noticeContent",
            "noticeTitle,writerName", "noticeTitle,noticeContent",
            "writerName,noticeContent", "noticeTitle,writerName,noticeContent"
        };
        for (String valid : validColumns) {
            if (valid.equals(column)) return true;
        }
        return false;
    }

    @MSLogin("loginProCheck")
    @RequestMapping("createNotice")
    public String createNotice(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();
        Object user = session.getAttribute("m");
        String writerName = user instanceof Professor ? ((Professor) user).getProfessorName() : "Unknown";
        request.setAttribute("writerName", writerName);
        return "board/notice/createNotice";
    }

    @MSLogin("loginProCheck")
    @RequestMapping("write")
    public String write(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        HttpSession session = request.getSession();
        String login = (String) session.getAttribute("login");
        Object user = session.getAttribute("m");
        String writerName = user instanceof Professor ? ((Professor) user).getProfessorName() : "Unknown";

        String uploadPath = request.getServletContext().getRealPath("/") + UPLOAD_DIR;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdirs();
        int maxSize = 20 * 1024 * 1024; // 20MB
        MultipartRequest multi = new MultipartRequest(request, uploadPath, maxSize, "UTF-8");

        String pass = multi.getParameter("pass");
        String noticeTitle = multi.getParameter("notice_title");
        String noticeContent = multi.getParameter("notice_content");
        String noticeFile = multi.getFilesystemName("notice_file");
        if (noticeFile == null) noticeFile = "";

        if (pass == null || pass.trim().isEmpty() || noticeTitle == null || noticeTitle.trim().isEmpty()) {
            request.setAttribute("msg", "비밀번호와 제목은 필수입니다.");
            request.setAttribute("url", "/LMSProject1/notice/createNotice");
            return "alert";
        }

        Notice notice = new Notice();
        String noticeId = generateNewNoticeId();
        notice.setNoticeId(noticeId);
        notice.setWriterId(login);
        notice.setWriterName(writerName);
        notice.setNoticePassword(pass);
        notice.setNoticeTitle(noticeTitle);
        notice.setNoticeContent(noticeContent);
        notice.setNoticeFile(noticeFile);
        notice.setNoticeCreatedAt(new Date());
        notice.setNoticeUpdatedAt(new Date());
        notice.setNoticeReadCount(0);

        try {
            if (dao.insert(notice)) {
                return "redirect:/LMSProject1/notice/getNotices";
            } else {
                request.setAttribute("msg", "게시물 등록 실패");
                request.setAttribute("url", "/LMSProject1/notice/createNotice");
                return "alert";
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("msg", "게시물 등록 실패: " + e.getMessage());
            request.setAttribute("url", "/LMSProject1/notice/createNotice");
            return "alert";
        }
    }

    @MSLogin("loginIdCheck")
    @RequestMapping("getNoticeDetail")
    public String getNoticeDetail(HttpServletRequest request, HttpServletResponse response) {
        String noticeId = request.getParameter("notice_id");
        String readcnt = request.getParameter("readcnt");
        System.out.println("getNoticeDetail called with notice_id: " + noticeId + ", readcnt: " + readcnt);

        if (noticeId == null || noticeId.trim().isEmpty()) {
            request.setAttribute("msg", "게시물 ID가 필요합니다.");
            request.setAttribute("url", "/LMSProject1/notice/getNotices");
            return "alert";
        }

        try {
            Notice notice = dao.selectOne(noticeId);
            if (notice == null) {
                request.setAttribute("msg", "게시물을 찾을 수 없습니다.");
                request.setAttribute("url", "/LMSProject1/notice/getNotices");
                return "alert";
            }

            if (readcnt == null || !readcnt.trim().equalsIgnoreCase("f")) {
                dao.incrementReadCount(noticeId);
                notice = dao.selectOne(noticeId);
            }

            System.out.println("getNoticeDetail - Notice ID: " + notice.getNoticeId() + ", WriterName: " + notice.getWriterName());
            request.setAttribute("notice", notice);
            return "board/notice/getNoticeDetail";
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("msg", "게시물 조회 실패: " + e.getMessage());
            request.setAttribute("url", "/LMSProject1/notice/getNotices");
            return "alert";
        }
    }

    @MSLogin("loginProCheck")
    @RequestMapping("updateNotice")
    public String updateNotice(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();
        String login = (String) session.getAttribute("login");
        String noticeId = request.getParameter("noticeId");

        if (noticeId == null || noticeId.trim().isEmpty()) {
            request.setAttribute("msg", "게시물 ID가 필요합니다.");
            request.setAttribute("url", "/LMSProject1/notice/getNotices");
            return "alert";
        }

        Notice notice = dao.selectOne(noticeId);
        if (notice == null) {
            request.setAttribute("msg", "게시물을 찾을 수 없습니다.");
            request.setAttribute("url", "/LMSProject1/notice/getNotices");
            return "alert";
        }

        if (!notice.getWriterId().equals(login)) {
            request.setAttribute("msg", "자신의 게시물만 수정할 수 있습니다.");
            request.setAttribute("url", "/LMSProject1/notice/getNotices");
            return "alert";
        }

        Object user = session.getAttribute("m");
        String writerName = user instanceof Professor ? ((Professor) user).getProfessorName() : "Unknown";
        request.setAttribute("writerName", writerName);
        System.out.println("updateNotice - Login: " + login + ", WriterName: " + writerName);
        request.setAttribute("notice", notice);
        return "board/notice/updateNotice";
    }

    @MSLogin("loginProCheck")
    @RequestMapping("update")
    public String update(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        HttpSession session = request.getSession();
        String login = (String) session.getAttribute("login");
        Object user = session.getAttribute("m");
        String writerName = user instanceof Professor ? ((Professor) user).getProfessorName() : "Unknown";
        System.out.println("update - Login: " + login + ", WriterName: " + writerName);

        String uploadPath = request.getServletContext().getRealPath("/") + UPLOAD_DIR;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdirs();
        int maxSize = 20 * 1024 * 1024; // 20MB
        MultipartRequest multi = new MultipartRequest(request, uploadPath, maxSize, "UTF-8");

        String noticeId = multi.getParameter("noticeId");
        String noticePassword = multi.getParameter("noticePassword");
        String noticeTitle = multi.getParameter("noticeTitle");
        String noticeContent = multi.getParameter("noticeContent");
        String originalFile = multi.getParameter("noticeFile");
        String newFile = multi.getFilesystemName("noticeFile");

        if (noticeId == null || noticeId.trim().isEmpty() || noticePassword == null || noticePassword.trim().isEmpty() ||
            noticeTitle == null || noticeTitle.trim().isEmpty()) {
            request.setAttribute("msg", "필수 입력값이 누락되었습니다.");
            request.setAttribute("url", "/LMSProject1/notice/updateNotice?noticeId=" + noticeId);
            return "alert";
        }

        Notice notice = dao.selectOne(noticeId);
        if (notice == null) {
            request.setAttribute("msg", "게시물을 찾을 수 없습니다.");
            request.setAttribute("url", "/LMSProject1/notice/getNotices");
            return "alert";
        }

        if (!notice.getWriterId().equals(login)) {
            request.setAttribute("msg", "자신의 게시물만 수정할 수 있습니다.");
            request.setAttribute("url", "/LMSProject1/notice/getNotices");
            return "alert";
        }
        if (!notice.getNoticePassword().equals(noticePassword)) {
            request.setAttribute("msg", "비밀번호가 일치하지 않습니다.");
            request.setAttribute("url", "notice/updateNotice?noticeId=" + noticeId);
            return "alert";
        }
        
        if (newFile == null || newFile.isEmpty()) {
            newFile = originalFile;
        } else {
            if (originalFile != null && !originalFile.isEmpty()) {
                File oldFile = new File(uploadPath, originalFile);
                if (oldFile.exists()) oldFile.delete();
            }
        }

        notice.setNoticeId(noticeId);
        notice.setWriterId(login);
        notice.setWriterName(writerName);
        notice.setNoticePassword(notice.getNoticePassword());
        notice.setNoticeTitle(noticeTitle);
        notice.setNoticeContent(noticeContent);
        notice.setNoticeFile(newFile);
        notice.setNoticeUpdatedAt(new Date());

        try {
            dao.update(notice);
            return "redirect:/LMSProject1/notice/getNotices";
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("msg", "게시물 수정 실패: " + e.getMessage());
            request.setAttribute("url", "/LMSProject1/notice/updateNotice?noticeId=" + noticeId);
            return "alert";
        }
    }

    @MSLogin("loginProCheck")
    @RequestMapping("deleteNotice")
    public String deleteNotice(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();
        String login = (String) session.getAttribute("login");
        String noticeId = request.getParameter("noticeId");
        System.out.println("deleteNotice called with noticeId: " + noticeId);

        if (noticeId == null || noticeId.trim().isEmpty()) {
            request.setAttribute("msg", "게시물 ID가 필요합니다.");
            request.setAttribute("url", "/LMSProject1/notice/getNotices");
            return "alert";
        }

        Notice notice = dao.selectOne(noticeId);
        if (notice == null) {
            request.setAttribute("msg", "삭제하려는 게시물이 존재하지 않습니다.");
            request.setAttribute("url", "/LMSProject1/notice/getNotices");
            return "alert";
        }

        if (!notice.getWriterId().equals(login)) {
            request.setAttribute("msg", "자신의 게시물만 삭제할 수 있습니다.");
            request.setAttribute("url", "/LMSProject1/notice/getNotices");
            return "alert";
        }

        request.setAttribute("notice", notice);
        return "board/notice/deleteNotice";
    }

    @MSLogin("loginProCheck")
    @RequestMapping("delete")
    public String delete(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();
        String login = (String) session.getAttribute("login");
        String noticeId = request.getParameter("noticeId");
        String pass = request.getParameter("pass");
        System.out.println("delete called with noticeId: " + noticeId + ", pass: " + pass);

        if (noticeId == null || noticeId.trim().isEmpty() || pass == null || pass.trim().isEmpty()) {
            request.setAttribute("msg", "게시물 ID와 비밀번호는 필수입니다.");
            request.setAttribute("url", "/LMSProject1/notice/deleteNotice?noticeId=" + (noticeId != null ? noticeId : ""));
            return "alert";
        }

        Notice notice = dao.selectOne(noticeId);
        if (notice == null) {
            request.setAttribute("msg", "삭제하려는 게시물이 존재하지 않습니다.");
            request.setAttribute("url", "/LMSProject1/notice/deleteNotice?noticeId=" + noticeId);
            return "alert";
        }

        if (!notice.getWriterId().equals(login)) {
            request.setAttribute("msg", "자신의 게시물만 삭제할 수 있습니다.");
            request.setAttribute("url", "/LMSProject1/notice/deleteNotice?noticeId=" + noticeId);
            return "alert";
        }
        if (!notice.getNoticePassword().equals(pass)) {
            request.setAttribute("msg", "비밀번호가 일치하지 않습니다.");
            request.setAttribute("url", "notice/deleteNotice?noticeId=" + noticeId);
            return "alert";
        }


        try {
            if (notice.getNoticeFile() != null && !notice.getNoticeFile().isEmpty()) {
                String uploadPath = request.getServletContext().getRealPath("/") + UPLOAD_DIR;
                File file = new File(uploadPath, notice.getNoticeFile());
                if (file.exists()) file.delete();
            }
            dao.delete(noticeId);
            return "redirect:/LMSProject1/notice/getNotices";
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("msg", "게시물 삭제 실패: " + e.getMessage());
            request.setAttribute("url", "/LMSProject1/notice/deleteNotice?noticeId=" + noticeId);
            return "alert";
        }
    }
}