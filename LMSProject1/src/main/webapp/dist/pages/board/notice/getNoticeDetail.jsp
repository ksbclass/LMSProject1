<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>공지사항 게시물 상세</title>
</head>
<body>
    <div class="container mt-5">
        <h1 class="fs-1">공지사항</h1> <br>
        <c:if test="${not empty msg}">
            <div class="alert alert-danger">${msg}</div>
            <% request.removeAttribute("msg"); %>
        </c:if>
        <c:if test="${not empty notice}">
            <table class="table">
                <tr>
                    <th>제목</th>
                    <td>${notice.noticeTitle}</td>
                </tr>
                <tr>
                    <th>작성자</th>
                    <td>${notice.writerName}</td>
                </tr>
                <tr>
                    <th>작성일</th>
                    <td><fmt:formatDate value="${notice.noticeCreatedAt}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                </tr>
                <tr>
                    <th>조회수</th>
                    <td>${notice.noticeReadCount}</td>
                </tr>
                <tr>
                    <th>내용</th>
                    <td>${notice.noticeContent}</td>
                </tr>
                <tr>
                    <th>첨부파일</th>
                    <td>
                        <c:if test="${not empty notice.noticeFile}">
                            <a href="${path}/dist/assets/upload/${notice.noticeFile}" download="${notice.noticeFile}">${notice.noticeFile}</a>
                        </c:if>
                        <c:if test="${empty notice.noticeFile}">
                            없음
                        </c:if>
                    </td>
                </tr>
            </table>
            <div class="text-end mb-5">
                <a href="${path}/notice/getNotices" class="btn btn-secondary">목록</a>
                <c:if test="${notice.writerId == sessionScope.login}">
                    <a href="${path}/notice/updateNotice?noticeId=${notice.noticeId}" class="btn btn-secondary">수정</a>
                    <a href="${path}/notice/deleteNotice?noticeId=${notice.noticeId}" class="btn btn-danger">삭제</a>
                </c:if>
            </div>
        </c:if>
        <c:if test="${empty notice && empty msg}">
            <div class="alert alert-warning">게시물이 존재하지 않습니다.</div>
        </c:if>
    </div>
</body>
</html>