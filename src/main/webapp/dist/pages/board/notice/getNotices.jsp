<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>공지사항</title>
</head>
<body>
    <div class="container mt-5">
        <h2 class="text-center fs-1">공지사항</h2>
        <c:if test="${not empty msg}">
            <div class="alert alert-danger">${msg}</div>
            <% request.removeAttribute("msg"); %>
        </c:if>
        <div class="text-right mb-3">
            <a href="searchNotice" class="btn btn-primary">공지사항 검색</a>
        </div>
        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>번호</th>
                    <th>제목</th>
                    <th>작성자</th>
                    <th>작성일</th>
                    <th>조회수</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="notice" items="${list}" varStatus="status">
                    <tr>
                        <td>${boardNum - status.index}</td>
                        <td>
                            <a href="${path}/notice/getNoticeDetail?notice_id=${notice.noticeId}">
                                ${notice.noticeTitle}
                            </a>
                        </td>
                        <td>${notice.writerName}</td>
                        <td>
                            <c:set var="todayDate"><fmt:formatDate value="${today}" pattern="yyyy-MM-dd"/></c:set>
                            <c:set var="createDate"><fmt:formatDate value="${notice.noticeCreatedAt}" pattern="yyyy-MM-dd"/></c:set>
                            <c:choose>
                                <c:when test="${todayDate eq createDate}">
                                    <fmt:formatDate value="${notice.noticeCreatedAt}" pattern="HH:mm"/>
                                </c:when>
                                <c:otherwise>
                                    <fmt:formatDate value="${notice.noticeCreatedAt}" pattern="yyyy-MM-dd"/>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>${notice.noticeReadCount}</td>
                    </tr>
                </c:forEach>
                <c:if test="${empty list}">
                    <tr>
                        <td colspan="5" class="text-center">공지사항이 없습니다.</td>
                    </tr>
                </c:if>
            </tbody>
        </table>
        <div class="text-right">
            <c:if test="${not empty login and isProfessor}">
                <a href="${path}/notice/createNotice" class="btn btn-primary">글쓰기</a>
            </c:if>
        </div>
        <nav>
            <ul class="pagination justify-content-center">
                <c:if test="${pageNum > 1}">
                    <li class="page-item">
                        <a class="page-link" href="${path}/notice/getNotices?pageNum=${pageNum - 1}">이전</a>
                    </li>
                </c:if>
                <c:forEach begin="${startpage}" end="${endpage}" var="i">
                    <li class="page-item ${i == pageNum ? 'active' : ''}">
                        <a class="page-link" href="${path}/notice/getNotices?pageNum=${i}">${i}</a>
                    </li>
                </c:forEach>
                <c:if test="${pageNum < maxpage}">
                    <li class="page-item">
                        <a class="page-link" href="${path}/notice/getNotices?pageNum=${pageNum + 1}">다음</a>
                    </li>
                </c:if>
            </ul>
        </nav>
    </div>
</body>
</html>