<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>공지 게시물 삭제</title>
    <style>
        body {
            background-color: #f8f9fa;
        }
        .container {
            background-color: #fff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);
            border: 1px solid #e9ecef;
        }
        .form-group {
            margin-bottom: 1.5rem;
        }
        .form-group label {
            font-weight: bold;
            color: #495057;
            margin-bottom: 0.5rem;
            display: block;
        }
        .form-control {
            border: 1px solid #ced4da;
            border-radius: 0.25rem;
            padding: 0.75rem 1rem;
            font-size: 1rem;
        }
        .btn {
            border-radius: 0.25rem;
            padding: 0.75rem 1.25rem;
            font-size: 1rem;
            font-weight: 500;
        }
        .btn-danger {
            background-color: #dc3545;
            border-color: #dc3545;
            color: #fff;
        }
        .btn-danger:hover {
            background-color: #c82333;
            border-color: #bd2130;
        }
        .btn-secondary {
            background-color: #6c757d;
            border-color: #6c757d;
            color: #fff;
        }
        .btn-secondary:hover {
            background-color: #5a6268;
            border-color: #545b62;
        }
        .alert-danger {
            padding: 1rem 1.5rem;
            margin-bottom: 1.5rem;
            border: 1px solid #f5c6cb;
            border-radius: 0.25rem;
            background-color: #f8d7da;
            color: #721c24;
        }
        .text-center {
            color: #343a40;
            margin-bottom: 2rem;
        }
        .fs-1 {
            font-size: 2.2rem !important;
            color: #343a40;
            margin-bottom: 1.5rem;
            font-weight: bold;
        }
        .font-weight-bold {
            color: #007bff;
        }
        .ml-2 {
            margin-left: 0.5rem;
            color: #6c757d;
        }
        .mt-4 {
            margin-top: 2rem !important;
        }
        .btn-group {
            margin-top: 1rem;
        }
        .btn-group > .btn {
Shear {
            margin-right: 0.5rem;
        }
        .btn-group > .btn:last-child {
            margin-right: 0;
        }
    </style>
</head>
<body>
    <div class="container mt-5">
        <h2 class="text-center fs-1">게시물 삭제</h2>
        <c:if test="${not empty msg}">
            <div class="alert alert-danger">${msg}</div>
            <% request.removeAttribute("msg"); %>
        </c:if>
        <form action="delete" method="post" class="mt-4">
            <input type="hidden" name="noticeId" value="${notice.noticeId}">
            <div class="form-group">
                <label class="font-weight-bold">작성자:</label>
                <span class="ml-2">${notice.writerName}</span>
            </div>
            <div class="form-group">
                <label class="font-weight-bold">제목:</label>
                <span class="ml-2">${notice.noticeTitle}</span>
            </div>
            <div class="form-group">
                <label for="pass">비밀번호:</label>
                <input type="password" name="pass" id="pass" class="form-control" required>
            </div>
            <div class="btn-group mt-1">
                <button type="submit" class="btn btn-danger">삭제</button>
                <a href="${path}/notice/getNotices" class="btn btn-secondary">취소</a>
            </div>
        </form>
    </div>
</body>
</html>