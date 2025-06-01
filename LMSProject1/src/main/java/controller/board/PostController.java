package controller.board;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebInitParam;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.oreilly.servlet.MultipartRequest;

import domain.Post;
import domain.PostComment;
import domain.Professor;
import domain.Student;
import gdu.mskim.MSLogin;
import gdu.mskim.MskimRequestMapping;
import gdu.mskim.RequestMapping;
import model.dao.board.PostDao;

@WebServlet(urlPatterns = {"/post/*"}, initParams = {@WebInitParam(name = "view", value = "/dist/pages/")})
public class PostController extends MskimRequestMapping {
    private PostDao dao = new PostDao();
    private static final String UPLOAD_DIR = "dist/assets/upload";

    // 로그인 체크
    public String loginIdCheck(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();
        String login = (String) session.getAttribute("login");
        if (login == null) {
            request.setAttribute("msg", "로그인하세요");
            request.setAttribute("url", request.getContextPath()+"/mypage/doLogin");
            return "alert";
        }
        return null;
    }

    // 학생만 접근 가능 체크
    public String loginStuCheck(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();
        String login = (String) session.getAttribute("login");
        if (login == null) {
            request.setAttribute("msg", "로그인하세요");
            request.setAttribute("url", request.getContextPath()+"/mypage/doLogin");
            return "alert";
        } else if (login.contains("P")) {
            request.setAttribute("msg", "교수는 접근 불가능합니다");
            request.setAttribute("url", request.getContextPath()+"/mypage/index");
            return "alert";
        }
        return null;
    }

    private synchronized String generateNewPostId() {
        String maxPostId = dao.getMaxPostId();
        if (maxPostId == null || maxPostId.isEmpty()) {
            return "PO001";
        }
        try {
            if (maxPostId.startsWith("PO")) {
                String numberPart = maxPostId.substring(2);
                int number = Integer.parseInt(numberPart);
                number++;
                return "PO" + String.format("%03d", number);
            } else {
                return "PO001";
            }
        } catch (NumberFormatException e) {
            System.err.println("post_id 생성 실패: " + e.getMessage() + ", maxPostId: " + maxPostId);
            List<String> allIds = dao.getAllPostIds();
            int maxNumber = 0;
            for (String id : allIds) {
                if (id.startsWith("PO")) {
                    try {
                        int num = Integer.parseInt(id.substring(2));
                        maxNumber = Math.max(maxNumber, num);
                    } catch (NumberFormatException ignored) {}
                }
            }
            return "PO" + String.format("%03d", maxNumber + 1);
        } catch (Exception e) {
            System.err.println("post_id 생성 실패: " + e.getMessage());
            return "PO001";
        }
    }

    private synchronized int getNextGroupId() {
        Integer maxGroup = dao.getMaxGroup();
        if (maxGroup == null) {
            return 1;
        }
        return maxGroup + 1;
    }

    private synchronized String generateNewCommentId() {
        String maxCommentId = dao.getMaxCommentId();
        if (maxCommentId == null || maxCommentId.isEmpty()) {
            return "CM001";
        }
        try {
            String numberPart = maxCommentId.substring(2);
            int number = Integer.parseInt(numberPart);
            number++;
            return "CM" + String.format("%03d", number);
        } catch (Exception e) {
            System.err.println("comment_id 생성 실패: " + e.getMessage());
            return "CM001";
        }
    }

    @MSLogin("loginIdCheck")
    @RequestMapping("getPosts")
    public String getPosts(HttpServletRequest request, HttpServletResponse response) {
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

        List<Post> notices = dao.listNotices();
        if (notices == null) notices = new ArrayList<>();

        int boardcount = dao.boardCount(null, null);
        List<Post> list = dao.list(pageNum, limit, null, null);
        if (list == null) list = new ArrayList<>();

        int maxpage = (int) Math.ceil((double) boardcount / limit);
        int startpage = ((int) (pageNum / 10.0 + 0.9) - 1) * 10 + 1;
        int endpage = startpage + 9;
        if (endpage > maxpage) endpage = maxpage;

        int boardNum = boardcount - (pageNum - 1) * limit;

        request.setAttribute("notices", notices);
        request.setAttribute("boardcount", boardcount);
        request.setAttribute("pageNum", pageNum);
        request.setAttribute("list", list);
        request.setAttribute("startpage", startpage);
        request.setAttribute("endpage", endpage);
        request.setAttribute("maxpage", maxpage);
        request.setAttribute("boardNum", boardNum);
        request.setAttribute("today", new Date());

        return "board/post/getPosts";
    }

    @MSLogin("loginIdCheck")
    @RequestMapping("searchPost")
    public String searchPost(HttpServletRequest request, HttpServletResponse response) {
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

        if ((column == null || column.trim().isEmpty()) || (find == null || find.trim().isEmpty())) {
            column = null;
            find = null;
            request.setAttribute("error", "검색 조건과 검색어를 입력해주세요.");
        }

        List<Post> notices = dao.listNotices();
        if (notices == null) notices = new ArrayList<>();

        int boardcount = dao.boardCount(column, find);
        List<Post> list = dao.list(pageNum, limit, column, find);
        if (list == null) list = new ArrayList<>();

        int maxpage = (int) Math.ceil((double) boardcount / limit);
        int startpage = ((int) (pageNum / 10.0 + 0.9) - 1) * 10 + 1;
        int endpage = startpage + 9;
        if (endpage > maxpage) endpage = maxpage;

        int boardNum = boardcount - (pageNum - 1) * limit;

        request.setAttribute("notices", notices);
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
        request.setAttribute("login", (String) request.getSession().getAttribute("login"));

        return "board/post/searchPost";
    }

    @MSLogin("loginIdCheck")
    @RequestMapping("createPost")
    public String createPost(HttpServletRequest request, HttpServletResponse response) {
        String parentPostId = request.getParameter("parent_post_id");
        if (parentPostId != null && !parentPostId.trim().isEmpty()) {
            request.setAttribute("parent_post_id", parentPostId);
        }
        HttpSession session = request.getSession();
        Object user = session.getAttribute("m");
        String userName = user != null ?
            (user instanceof Professor ? ((Professor) user).getProfessorName() : ((Student) user).getStudentName()) : "Unknown";
        request.setAttribute("login", (String) session.getAttribute("login"));
        request.setAttribute("userName", userName);
        return "board/post/createPost";
    }

    @MSLogin("loginIdCheck")
    @RequestMapping("write")
    public String write(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        HttpSession session = request.getSession();
        String login = (String) session.getAttribute("login");
        Object user = session.getAttribute("m");
        String authorName = user != null ?
            (user instanceof Professor ? ((Professor) user).getProfessorName() : ((Student) user).getStudentName()) : "Unknown";

        // 학생은 공지사항 설정 불가
        if (user instanceof Student && "1".equals(request.getParameter("post_notice"))) {
            request.setAttribute("msg", "학생은 공지사항을 설정할 수 없습니다.");
            request.setAttribute("url", "/post/createPost");
            return "alert";
        }

        String uploadPath = request.getServletContext().getRealPath("/") + UPLOAD_DIR;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdirs();
        int maxSize = 20 * 1024 * 1024; // 20MB
        MultipartRequest multi = new MultipartRequest(request, uploadPath, maxSize, "UTF-8");

        String postFile = multi.getFilesystemName("post_file");
        if (postFile == null) {
            postFile = "";
        }

        String pass = multi.getParameter("pass");
        String postTitle = multi.getParameter("post_title");
        String postContent = multi.getParameter("post_content");
        String parentPostId = multi.getParameter("parent_post_id");
        String postNotice = multi.getParameter("post_notice");

        if (login == null || login.trim().isEmpty() ||
            pass == null || pass.trim().isEmpty() ||
            postTitle == null || postTitle.trim().isEmpty()) {
            request.setAttribute("msg", "글쓴이, 비밀번호, 제목은 필수입니다.");
            request.setAttribute("url", "/post/createPost");
            return "alert";
        }

        String newPostId = generateNewPostId();
        Post post = new Post();
        post.setPostId(newPostId);
        post.setAuthorId(login);
        post.setAuthorName(authorName);
        post.setPostPassword(pass);
        post.setPostTitle(postTitle);
        post.setPostContent(postContent);
        post.setPostFile(postFile);
        post.setPostCreatedAt(new Date());
        post.setPostUpdatedAt(new Date());
        post.setPostReadCount(0);
        post.setPostNotice("1".equals(postNotice));

        if (parentPostId != null && !parentPostId.trim().isEmpty()) {
            Post parentPost = dao.selectOne(parentPostId);
            if (parentPost != null) {
                dao.updateGroupStep(parentPost.getPostGroup(), parentPost.getPostGroupStep());
                post.setPostGroup(parentPost.getPostGroup());
                post.setPostGroupLevel(parentPost.getPostGroupLevel() + 1);
                post.setPostGroupStep(parentPost.getPostGroupStep() + 1);
            } else {
                post.setPostGroup(getNextGroupId());
                post.setPostGroupLevel(0);
                post.setPostGroupStep(0);
            }
        } else {
            post.setPostGroup(getNextGroupId());
            post.setPostGroupLevel(0);
            post.setPostGroupStep(0);
        }

        try {
            dao.insert(post);
            return "redirect:/LMSProject1/post/getPosts";
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("msg", "게시물 등록 실패: " + e.getMessage());
            request.setAttribute("url", "/post/createPost");
            return "alert";
        }
    }

    @MSLogin("loginIdCheck")
    @RequestMapping("getPostDetail")
    public String getPostDetail(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();
        String postId = request.getParameter("post_id");
        String readcnt = request.getParameter("readcnt");
        if (postId == null || postId.trim().isEmpty()) {
            request.setAttribute("msg", "게시물 ID가 필요합니다.");
            request.setAttribute("url", "/post/getPosts");
            return "alert";
        }

        Post post = dao.selectOne(postId);
        if (post == null) {
            request.setAttribute("msg", "게시물을 찾을 수 없습니다.");
            request.setAttribute("url", "/post/getPosts");
            return "alert";
        }

        if (readcnt == null || !readcnt.trim().equals("f")) {
            dao.incrementReadCount(postId);
            post.setPostReadCount(post.getPostReadCount() + 1);
        }

        List<PostComment> commentList = dao.selectCommentList(postId);

        List<PostComment> uniqueCommentList = commentList.stream()
            .distinct()
            .collect(Collectors.toList());
        for (PostComment comment : uniqueCommentList) {
            System.out.println("Comment ID: " + comment.getCommentId() + ", Parent Comment ID: " + comment.getParentCommentId());
        }

        String login = (String) session.getAttribute("login");
        String authorName = "Unknown";
        if (login != null) {
            Object user = session.getAttribute("m");
            if (user != null) {
                authorName = (user instanceof Professor) ? ((Professor) user).getProfessorName() : ((Student) user).getStudentName();
            }
        }

        request.setAttribute("post", post);
        request.setAttribute("commentList", uniqueCommentList);
        request.setAttribute("authorName", authorName);
        request.setAttribute("isLoggedIn", login != null);
        return "board/post/getPostDetail";
    }

    @MSLogin("loginIdCheck")
    @RequestMapping("replyPost")
    public String replyPost(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();
        String postId = request.getParameter("postId");
        if (postId == null || postId.trim().isEmpty()) {
            request.setAttribute("msg", "부모 게시물 ID가 필요합니다.");
            request.setAttribute("url", "/post/getPosts");
            return "alert";
        }

        Object user = session.getAttribute("m");
        String userName = user != null ?
            (user instanceof Professor ? ((Professor) user).getProfessorName() : ((Student) user).getStudentName()) : "Unknown";

        Post parentPost = dao.selectOne(postId);
        if (parentPost == null) {
            request.setAttribute("msg", "부모 게시물을 찾을 수 없습니다.");
            request.setAttribute("url", "/post/getPosts");
            return "alert";
        }

        request.setAttribute("board", parentPost);
        request.setAttribute("login", (String) session.getAttribute("login"));
        request.setAttribute("userName", userName);
        return "board/post/replyPost";
    }

    @MSLogin("loginIdCheck")
    @RequestMapping("writeReply")
    public String writeReply(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        HttpSession session = request.getSession();
        String login = (String) session.getAttribute("login");
        Object user = session.getAttribute("m");
        String authorName = user != null ?
            (user instanceof Professor ? ((Professor) user).getProfessorName() : ((Student) user).getStudentName()) : "Unknown";

        String uploadPath = request.getServletContext().getRealPath("/") + UPLOAD_DIR;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdirs();
        int maxSize = 20 * 1024 * 1024; // 20MB
        MultipartRequest multi = new MultipartRequest(request, uploadPath, maxSize, "UTF-8");

        String postId = multi.getParameter("num");
        String pass = multi.getParameter("pass");
        String title = multi.getParameter("title");
        String content = multi.getParameter("content");
        int grp = Integer.parseInt(multi.getParameter("grp"));
        int grplevel = Integer.parseInt(multi.getParameter("grplevel"));
        int grpstep = Integer.parseInt(multi.getParameter("grpstep"));
        String postFile = multi.getFilesystemName("post_file");
        if (postFile == null) {
            postFile = "";
        }

        if (login == null || login.trim().isEmpty() || pass == null || pass.trim().isEmpty() || title == null || title.trim().isEmpty()) {
            request.setAttribute("msg", "글쓴이, 비밀번호, 제목은 필수입니다.");
            request.setAttribute("url", "/post/replyPost?num=" + postId);
            return "alert";
        }

        Post post = new Post();
        String newPostId = generateNewPostId();
        post.setPostId(newPostId);
        post.setAuthorId(login);
        post.setAuthorName(authorName);
        post.setPostPassword(pass);
        post.setPostTitle(title);
        post.setPostContent(content);
        post.setPostFile(postFile);
        post.setPostCreatedAt(new Date());
        post.setPostUpdatedAt(new Date());
        post.setPostReadCount(0);
        post.setPostGroup(grp);
        post.setPostGroupLevel(grplevel + 1);
        post.setPostGroupStep(grpstep + 1);
        post.setPostNotice(false); // 답글은 공지사항 설정 불가

        try {
            dao.updateGroupStep(grp, grpstep);
            dao.insert(post);
            return "redirect:/LMSProject1/post/getPosts";
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("msg", "답글 등록 실패: " + e.getMessage());
            request.setAttribute("url", "/post/replyPost?num=" + postId);
            return "alert";
        }
    }

    @MSLogin("loginIdCheck")
    @RequestMapping("updatePost")
    public String updatePost(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();
        String postId = request.getParameter("postId");
        if (postId == null || postId.trim().isEmpty()) {
            request.setAttribute("msg", "게시물 ID가 필요합니다.");
            request.setAttribute("url", "/post/getPosts");
            return "alert";
        }

        String login = (String) session.getAttribute("login");
        Post post = dao.selectOne(postId);
        if (post == null) {
            request.setAttribute("msg", "게시물을 찾을 수 없습니다.");
            request.setAttribute("url", "/post/getPosts");
            return "alert";
        }

        if (!post.getAuthorId().equals(login)) {
            request.setAttribute("msg", "자신의 게시물만 수정할 수 있습니다.");
            request.setAttribute("url", "/post/getPosts");
            return "alert";
        }
        request.setAttribute("p", post);
        return "board/post/updatePost";
    }

    @MSLogin("loginIdCheck")
    @RequestMapping("update")
    public String update(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        HttpSession session = request.getSession();
        String login = (String) session.getAttribute("login");
        Object user = session.getAttribute("m");
        String authorName = user != null ?
            (user instanceof Professor ? ((Professor) user).getProfessorName() : ((Student) user).getStudentName()) : "Unknown";

        // 학생은 공지사항 설정 불가
        if (user instanceof Student && "1".equals(request.getParameter("post_notice"))) {
            request.setAttribute("msg", "학생은 공지사항을 설정할 수 없습니다.");
            request.setAttribute("url", "/post/updatePost?postId=" + request.getParameter("postId"));
            return "alert";
        }

        String uploadPath = request.getServletContext().getRealPath("/") + UPLOAD_DIR;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdirs();
        int maxSize = 20 * 1024 * 1024; // 20MB
        MultipartRequest multi = new MultipartRequest(request, uploadPath, maxSize, "UTF-8");

        String postId = multi.getParameter("postId");
        String postPassword = multi.getParameter("postPassword");
        String postTitle = multi.getParameter("postTitle");
        String postContent = multi.getParameter("postContent");
        String originalFile = multi.getParameter("postFile");
        String newFile = multi.getFilesystemName("postFile");
        String postNotice = multi.getParameter("post_notice");

        if (postId == null || postId.trim().isEmpty() || postPassword == null || postPassword.trim().isEmpty() ||
            postTitle == null || postTitle.trim().isEmpty()) {
            request.setAttribute("msg", "필수 입력값이 누락되었습니다.");
            request.setAttribute("url", "/post/updatePost?postId=" + postId);
            return "alert";
        }

        Post post = dao.selectOne(postId);
        if (post == null || !post.getAuthorId().equals(login)) {
            request.setAttribute("msg", "자신의 게시물만 수정할 수 있습니다.");
            request.setAttribute("url", "/post/updatePost?postId=" + postId);
            return "alert";
        }

        if (!post.getPostPassword().equals(postPassword)) {
            request.setAttribute("msg", "비밀번호가 일치하지 않습니다.");
            request.setAttribute("url", "/post/updatePost?postId=" + postId);
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

        post.setAuthorId(login);
        post.setAuthorName(authorName);
        post.setPostPassword(postPassword);
        post.setPostTitle(postTitle);
        post.setPostContent(postContent);
        post.setPostFile(newFile);
        post.setPostUpdatedAt(new Date());
        post.setPostNotice("1".equals(postNotice));

        try {
            dao.update(post);
            return "redirect:/LMSProject1/post/getPosts";
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("msg", "게시물 수정 실패: " + e.getMessage());
            request.setAttribute("url", "/post/updatePost?postId=" + postId);
            return "alert";
        }
    }

    @MSLogin("loginIdCheck")
    @RequestMapping("deletePost")
    public String deletePost(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();
        String postId = request.getParameter("postId");
        if (postId == null || postId.trim().isEmpty()) {
            request.setAttribute("msg", "게시물 ID가 필요합니다.");
            request.setAttribute("url", "/post/getPosts");
            return "alert";
        }

        String login = (String) session.getAttribute("login");
        Post post = dao.selectOne(postId);
        if (post == null) {
            request.setAttribute("msg", "삭제하려는 게시물이 존재하지 않습니다.");
            request.setAttribute("url", "/post/getPosts");
            return "alert";
        }
        if (!post.getAuthorId().equals(login)) {
            request.setAttribute("msg", "자신의 게시물만 삭제할 수 있습니다.");
            request.setAttribute("url", "/post/getPosts");
            return "alert";
        }
        request.setAttribute("post", post);
        return "board/post/deletePost";
    }

    @MSLogin("loginIdCheck")
    @RequestMapping("delete")
    public String delete(HttpServletRequest request, HttpServletResponse response) {
        String postId = request.getParameter("postId");
        String pass = request.getParameter("pass");
        HttpSession session = request.getSession();
        String login = (String) session.getAttribute("login");

        if (postId == null || postId.trim().isEmpty() || pass == null || pass.trim().isEmpty()) {
            request.setAttribute("msg", "게시물 ID와 비밀번호가 필요합니다.");
            request.setAttribute("url", "/post/deletePost?postId=" + (postId != null ? postId : ""));
            return "alert";
        }

        Post post = dao.selectOne(postId);
        if (post == null) {
            request.setAttribute("msg", "게시물을 찾을 수 없습니다.");
            request.setAttribute("url", "/post/deletePost?postId=" + postId);
            return "alert";
        }

        if (!post.getAuthorId().equals(login)) {
            request.setAttribute("msg", "자신의 게시물만 삭제할 수 있습니다.");
            request.setAttribute("url", "/post/deletePost?postId=" + postId);
            return "alert";
        }

        if (!post.getPostPassword().equals(pass)) {
            request.setAttribute("msg", "비밀번호가 일치하지 않습니다.");
            request.setAttribute("url", "/post/deletePost?postId=" + postId);
            return "alert";
        }

        try {
            if (post.getPostFile() != null && !post.getPostFile().isEmpty()) {
                String uploadPath = request.getServletContext().getRealPath("/") + UPLOAD_DIR;
                File file = new File(uploadPath, post.getPostFile());
                if (file.exists()) file.delete();
            }
            dao.deleteWithComments(postId);
            return "redirect:/LMSProject1/post/getPosts";
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("msg", "게시물 삭제 실패: " + e.getMessage());
            request.setAttribute("url", "/post/deletePost?postId=" + postId);
            return "alert";
        }
    }

    @MSLogin("loginIdCheck")
    @RequestMapping("writeComment")
    public String writeComment(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        HttpSession session = request.getSession();
        String login = (String) session.getAttribute("login");
        Object user = session.getAttribute("m");
        String authorName = user != null ?
            (user instanceof Professor ? ((Professor) user).getProfessorName() : ((Student) user).getStudentName()) : "Unknown";

        String postId = request.getParameter("postId");
        String commentContent = request.getParameter("commentContent");
        String parentCommentId = request.getParameter("parentCommentId");

        if (postId == null || postId.trim().isEmpty() || commentContent == null || commentContent.trim().isEmpty()) {
            request.setAttribute("msg", "필수 입력값이 누락되었습니다.");
            request.setAttribute("url", "/post/getPostDetail?post_id=" + postId);
            return "alert";
        }

        String newCommentId = generateNewCommentId();
        PostComment comment = new PostComment();
        comment.setCommentId(newCommentId);
        comment.setPostId(postId);
        comment.setWriterId(login);
        comment.setCommentAuthorName(authorName);
        comment.setCommentContent(commentContent);
        comment.setParentCommentId(parentCommentId);
        comment.setCreatedAt(new Date());
        comment.setUpdatedAt(new Date());

        try {
            dao.insertComment(comment);
            return "redirect:/LMSProject1/post/getPostDetail?post_id=" + postId;
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("msg", "댓글 등록 실패: " + e.getMessage());
            request.setAttribute("url", "/post/getPostDetail?post_id=" + postId);
            return "alert";
        }
    }

    @MSLogin("loginIdCheck")
    @RequestMapping("updateComment")
    public String updateComment(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        HttpSession session = request.getSession();
        String login = (String) session.getAttribute("login");
        Object user = session.getAttribute("m");
        String authorName = user != null ?
            (user instanceof Professor ? ((Professor) user).getProfessorName() : ((Student) user).getStudentName()) : "Unknown";

        String commentId = request.getParameter("commentId");
        String commentContent = request.getParameter("commentContent");

        if (commentId == null || commentId.trim().isEmpty() || commentContent == null || commentContent.trim().isEmpty()) {
            request.setAttribute("msg", "필수 입력값이 누락되었습니다.");
            request.setAttribute("url", "/post/getPostDetail?post_id=" + request.getParameter("postId"));
            return "alert";
        }

        PostComment comment = dao.selectComment(commentId);
        if (comment == null || !comment.getWriterId().equals(login)) {
            request.setAttribute("msg", "자신의 댓글만 수정할 수 있습니다.");
            request.setAttribute("url", "/post/getPostDetail?post_id=" + request.getParameter("postId"));
            return "alert";
        }

        comment.setCommentContent(commentContent);
        comment.setCommentAuthorName(authorName);
        comment.setUpdatedAt(new Date());

        try {
            dao.updateComment(comment);
            return "redirect:/LMSProject1/post/getPostDetail?post_id=" + comment.getPostId();
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("msg", "댓글 수정 실패: " + e.getMessage());
            request.setAttribute("url", "/post/getPostDetail?post_id=" + comment.getPostId());
            return "alert";
        }
    }

    @MSLogin("loginIdCheck")
    @RequestMapping("deleteComment")
    public String deleteComment(HttpServletRequest request, HttpServletResponse response) {
        String commentId = request.getParameter("commentId");
        String postId = request.getParameter("postId");
        HttpSession session = request.getSession();
        String login = (String) session.getAttribute("login");

        Map<String, Object> result = new HashMap<>();
        ObjectMapper mapper = new ObjectMapper();
        String json;

        try {
            if (commentId == null || commentId.trim().isEmpty() || postId == null || postId.trim().isEmpty()) {
                result.put("status", "error");
                result.put("message", "댓글 ID 또는 게시물 ID가 누락되었습니다.");
                json = mapper.writeValueAsString(result);
                request.setAttribute("json", json);
                return "board/post/ajax_post_support";
            }

            PostComment comment = dao.selectComment(commentId);
            if (comment == null) {
                result.put("status", "error");
                result.put("message", "삭제할 댓글이 존재하지 않습니다.");
                json = mapper.writeValueAsString(result);
                request.setAttribute("json", json);
                return "board/post/ajax_post_support";
            }

            if (!comment.getWriterId().equals(login)) {
                result.put("status", "error");
                result.put("message", "자신의 댓글만 삭제할 수 있습니다.");
                json = mapper.writeValueAsString(result);
                request.setAttribute("json", json);
                return "board/post/ajax_post_support";
            }

            dao.deleteComment(commentId);

            result.put("status", "success");
            result.put("message", "댓글이 성공적으로 삭제되었습니다.");
            json = mapper.writeValueAsString(result);
            request.setAttribute("json", json);
        } catch (Exception e) {
            e.printStackTrace();
            result.put("status", "error");
            result.put("message", "댓글 삭제 중 오류가 발생했습니다: " + e.getMessage());
            try {
                json = mapper.writeValueAsString(result);
                request.setAttribute("json", json);
            } catch (IOException ex) {
                ex.printStackTrace();
            }
        }

        return "board/post/ajax_post_support";
    }
}