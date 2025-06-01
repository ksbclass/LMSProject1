<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>문의게시판</title>
</head>
<body>
    <div class="container mt-5">
        <h2 class="text-center fs-1">문의게시판</h2>

        <c:if test="${not empty msg}">
            <div class="alert alert-danger">${msg}</div>
            <% request.removeAttribute("error"); %>
        </c:if>


        <div class="text-right mb-3">
            <a href="searchPost" class="btn btn-primary">문의게시판 검색</a>
        </div>

        <!-- 공지사항 목록 -->
        <c:if test="${not empty notices}">
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
                    <c:forEach var="post" items="${notices}">
                        <tr>
                            <td>공지</td>
                            <td>
                                <a href="getPostDetail?post_id=${post.postId}">
                                    [공지] ${post.postTitle}
                                </a>
                            </td>
                            <td>${post.authorName}</td>
                            <td>
                                <c:set var="todayDate"><fmt:formatDate value="${today}" pattern="yyyy-MM-dd"/></c:set>
                                <c:set var="createDate"><fmt:formatDate value="${post.postCreatedAt}" pattern="yyyy-MM-dd"/></c:set>
                                <c:choose>
                                    <c:when test="${todayDate eq createDate}">
                                        <fmt:formatDate value="${post.postCreatedAt}" pattern="HH:mm"/>
                                    </c:when>
                                    <c:otherwise>
                                        <fmt:formatDate value="${post.postCreatedAt}" pattern="yyyy-MM-dd"/>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>${post.postReadCount}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:if>

        <!-- 일반 게시물 목록 -->
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
                <c:forEach var="post" items="${list}" varStatus="status">
                    <tr>
                        <td>${boardNum - status.index}</td>
                        <td>
                            <c:if test="${post.postGroupLevel > 0}">
                                <span style="margin-left: ${post.postGroupLevel * 20}px;">↳</span>
                            </c:if>
                            <a href="getPostDetail?post_id=${post.postId}">
                                ${post.postTitle}
                            </a>
                        </td>
                        <td>${post.authorName}</td>
                        <td>
                            <c:set var="todayDate"><fmt:formatDate value="${today}" pattern="yyyy-MM-dd"/></c:set>
                            <c:set var="createDate"><fmt:formatDate value="${post.postCreatedAt}" pattern="yyyy-MM-dd"/></c:set>
                            <c:choose>
                                <c:when test="${todayDate eq createDate}">
                                    <fmt:formatDate value="${post.postCreatedAt}" pattern="HH:mm"/>
                                </c:when>
                                <c:otherwise>
                                    <fmt:formatDate value="${post.postCreatedAt}" pattern="yyyy-MM-dd"/>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>${post.postReadCount}</td>
                    </tr>
                </c:forEach>
                <c:if test="${empty list && empty notices}">
                    <tr>
                        <td colspan="5" class="text-center">게시물이 없습니다.</td>
                    </tr>
                </c:if>
            </tbody>
        </table>

        <!-- 페이지네이션 -->
        <nav>
            <ul class="pagination justify-content-center">
                <c:if test="${pageNum > 1}">
                    <li class="page-item">
                        <a class="page-link" href="?pageNum=${pageNum - 1}">이전</a>
                    </li>
                </c:if>
                <c:forEach begin="${startpage}" end="${endpage}" var="i">
                    <li class="page-item ${i == pageNum ? 'active' : ''}">
                        <a class="page-link" href="?pageNum=${i}">${i}</a>
                    </li>
                </c:forEach>
                <c:if test="${pageNum < maxpage}">
                    <li class="page-item">
                        <a class="page-link" href="?pageNum=${pageNum + 1}">다음</a>
                    </li>
                </c:if>
            </ul>
        </nav>

        <!-- 글쓰기 버튼 -->
        <div class="text-right">
            <a href="createPost" class="btn btn-primary">글쓰기</a>
        </div>
    </div>
</body>
</html>