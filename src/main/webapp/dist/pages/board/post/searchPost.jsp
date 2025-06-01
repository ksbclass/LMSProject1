<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>문의게시판 검색</title>
</head>
<body>
    <div class="container mt-5">
        <h2 class="text-center fs-1">문의게시판 검색</h2> <br>
        <form action="searchPost" method="get" class="mb-4">
            <div class="row">
                <div class="col-md-3">
                    <select name="column" class="form-control">
                        <option value="" ${column == '' ? 'selected' : ''}>전체</option>
                        <option value="authorName" ${column == 'authorName' ? 'selected' : ''}>작성자</option>
                        <option value="postTitle" ${column == 'postTitle' ? 'selected' : ''}>제목</option>
                        <option value="postContent" ${column == 'postContent' ? 'selected' : ''}>내용</option>
                        <option value="postTitle,authorName" ${column == 'postTitle,authorName' ? 'selected' : ''}>제목+작성자</option>
                        <option value="postTitle,postContent" ${column == 'postTitle,postContent' ? 'selected' : ''}>제목+내용</option>
                        <option value="authorName,postContent" ${column == 'authorName,postContent' ? 'selected' : ''}>작성자+내용</option>
                        <option value="postTitle,authorName,postContent" ${column == 'postTitle,authorName,postContent' ? 'selected' : ''}>제목+작성자+내용</option>
                    </select>
                </div>
                <div class="col-md-6">
                    <input type="text" name="find" class="form-control" value="${find}" placeholder="검색어를 입력하세요">
                </div>
                <div class="col-md-3">
                    <button type="submit" class="btn btn-primary btn-block">검색</button>
                </div>
            </div>
        </form>

        <c:if test="${not empty msg}">
            <div class="alert alert-danger">${msg}</div>
            <% request.removeAttribute("msg"); %>
        </c:if>

        <c:if test="${not empty list}">
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>번호</th>
                        <th>제목</th>
                        <th>작성자</th>
                        <th>작성일</th>
                        <th>조회수</th>
                        <th>수정</th>
                        <th>삭제</th>
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
                                    <c:if test="${post.postNotice}">[공지]</c:if>
                                    ${post.postTitle}
                                </a>
                            </td>
                            <td>${post.authorName}</td>
                            <td><fmt:formatDate value="${post.postCreatedAt}" pattern="yyyy-MM-dd HH:mm"/></td>
                            <td>${post.postReadCount}</td>
                            <td>
                                <c:if test="${post.authorId == login}">
                                    <a href="updatePost?postId=${post.postId}" class="btn btn-sm btn-warning">수정</a>
                                </c:if>
                            </td>
                            <td>
                                <c:if test="${post.authorId == login}">
                                    <a href="deletePost?postId=${post.postId}" class="btn btn-sm btn-danger">삭제</a>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <nav>
                <ul class="pagination justify-content-center">
                    <c:if test="${pageNum > 1}">
                        <li class="page-item"><a class="page-link" href="?pageNum=${pageNum - 1}&column=${column}&find=${find}">이전</a></li>
                    </c:if>
                    <c:forEach begin="${startpage}" end="${endpage}" var="i">
                        <li class="page-item ${i == pageNum ? 'active' : ''}">
                            <a class="page-link" href="?pageNum=${i}&column=${column}&find=${find}">${i}</a>
                        </li>
                    </c:forEach>
                    <c:if test="${pageNum < maxpage}">
                        <li class="page-item"><a class="page-link" href="?pageNum=${pageNum + 1}&column=${column}&find=${find}">다음</a></li>
                    </c:if>
                </ul>
            </nav>
        </c:if>
        <c:if test="${empty list}">
            <p class="text-center">검색 결과가 없습니다.</p>
        </c:if>
        <div class="text-center">
            <a href="getPosts" class="btn btn-secondary">문의게시판 목록</a>
            <a href="createPost" class="btn btn-primary">글쓰기</a>
        </div>
    </div>
</body>
</html>