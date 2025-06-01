<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>공지사항 검색</title>
</head>
<body>
    <div class="container mt-5">
        <h2 class="text-center fs-1">공지사항 검색</h2> <br>
        <form action="searchNotice" method="get" class="mb-4">
            <div class="row">
                <div class="col-md-3">
                    <select name="column" class="form-control">
                        <option value="" ${column == '' ? 'selected' : ''}>전체</option>
                        <option value="writerName" ${column == 'writerName' ? 'selected' : ''}>작성자</option>
                        <option value="noticeTitle" ${column == 'noticeTitle' ? 'selected' : ''}>제목</option>
                        <option value="noticeContent" ${column == 'noticeContent' ? 'selected' : ''}>내용</option>
                        <option value="noticeTitle,writerName" ${column == 'noticeTitle,writerName' ? 'selected' : ''}>제목+작성자</option>
                        <option value="noticeTitle,noticeContent" ${column == 'noticeTitle,noticeContent' ? 'selected' : ''}>제목+내용</option>
                        <option value="writerName,noticeContent" ${column == 'writerName,noticeContent' ? 'selected' : ''}>작성자+내용</option>
                        <option value="noticeTitle,writerName,noticeContent" ${column == 'noticeTitle,writerName,noticeContent' ? 'selected' : ''}>제목+작성자+내용</option>
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
                    <c:forEach var="notice" items="${list}" varStatus="status">
                        <tr>
                            <td>${boardNum - status.index}</td>
                            <td>
                                <a href="${path}/notice/getNoticeDetail?notice_id=${notice.noticeId}">${notice.noticeTitle}</a>
                            </td>
                            <td>${notice.writerName}</td>
                            <td><fmt:formatDate value="${notice.noticeCreatedAt}" pattern="yyyy-MM-dd HH:mm"/></td>
                            <td>${notice.noticeReadCount}</td>
                            <td>
                                <c:if test="${notice.writerId == login}">
                                    <a href="${path}/notice/updateNotice?noticeId=${notice.noticeId}" class="btn btn-sm btn-warning">수정</a>
                                </c:if>
                            </td>
                            <td>
                                <c:if test="${notice.writerId == login}">
                                    <a href="${path}/notice/deleteNotice?noticeId=${notice.noticeId}" class="btn btn-sm btn-danger">삭제</a>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <nav>
                <ul class="pagination justify-content-center">
                    <c:if test="${pageNum > 1}">
                        <li class="page-item">
                            <a class="page-link" href="${path}/notice/searchNotice?pageNum=${pageNum - 1}&column=${column}&find=${find}">이전</a>
                        </li>
                    </c:if>
                    <c:forEach begin="${startpage}" end="${endpage}" var="i">
                        <li class="page-item ${i == pageNum ? 'active' : ''}">
                            <a class="page-link" href="${path}/notice/searchNotice?pageNum=${i}&column=${column}&find=${find}">${i}</a>
                        </li>
                    </c:forEach>
                    <c:if test="${pageNum < maxpage}">
                        <li class="page-item">
                            <a class="page-link" href="${path}/notice/searchNotice?pageNum=${pageNum + 1}&column=${column}&find=${find}">다음</a>
                        </li>
                    </c:if>
                </ul>
            </nav>
        </c:if>
        <c:if test="${empty list}">
            <p class="text-center">검색 결과가 없습니다.</p>
        </c:if>
        <div class="text-center">
            <a href="${path}/notice/getNotices" class="btn btn-secondary">공지사항 목록</a>
        </div>
    </div>
</body>
</html>