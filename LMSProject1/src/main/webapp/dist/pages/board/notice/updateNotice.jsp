<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시물 수정</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/summernote.min.css" rel="stylesheet">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/summernote.min.js"></script>
</head>
<body>
    <div class="container mt-5">
        <h2 class="text-center fs-1">공지사항 수정</h2>
        <c:if test="${not empty msg}">
            <div class="alert alert-danger">${msg}</div>
            <% request.removeAttribute("msg"); %>
        </c:if>
        <form action="update" method="post" enctype="multipart/form-data" name="f">
            <input type="hidden" name="noticeId" value="${notice.noticeId}">
            <table class="table">
                <tr>
                    <td>글쓴이</td>
                    <td>
                        <input type="text" name="writerId" class="form-control" value="${notice.writerId}" readonly>
                    </td>
                </tr>
                <tr>
                    <td>작성자 이름</td>
                    <td>
                        <input type="text" class="form-control" value="${writerName}" readonly>
                    </td>
                </tr>
                <tr>
                    <td>비밀번호</td>
                    <td><input type="password" name="noticePassword" class="form-control" required></td>
                </tr>
                <tr>
                    <td>제목</td>
                    <td><input type="text" name="noticeTitle" class="form-control" value="${notice.noticeTitle}" required></td>
                </tr>
                <tr>
                    <td>내용</td>
                    <td><textarea rows="15" name="noticeContent" class="form-control" id="summernote">${notice.noticeContent}</textarea></td>
                </tr>
                <tr>
                    <td>첨부파일</td>
                    <td>
                        <input type="file" name="noticeFile" class="form-control">
                        <c:if test="${not empty notice.noticeFile}">
                            <p>현재 파일: ${notice.noticeFile}</p>
                            <input type="hidden" name="noticeFile" value="${notice.noticeFile}">
                        </c:if>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <button type="button" onclick="inputcheck()" class="btn btn-primary">수정 완료</button>
                        <a href="${path}/notice/getNotices" class="btn btn-secondary">목록</a>
                    </td>
                </tr>
            </table>
        </form>
    </div>
    <script>
    $(document).ready(function() {
        $("#summernote").summernote({
            height: 300,
            callbacks: {
                onImageUpload: function(files) {
                    for (let i = 0; i < files.length; i++) {
                        sendFile(files[i]);
                    }
                }
            }
        });
    });

    function sendFile(file) {
        let data = new FormData();
        data.append("file", file);
        $.ajax({
            url: "${path}/notice/uploadImage",
            type: "POST",
            data: data,
            processData: false,
            contentType: false,
            success: function(url) {
                $('#summernote').summernote('insertImage', url);
            },
            error: function(e) {
                alert("이미지 업로드 실패: " + e.status);
                console.error("Error details: ", e);
            }
        });
    }

    function inputcheck() {
        let f = document.f;
        if (f.writerId.value.trim() === "") {
            alert("글쓴이를 입력하세요");
            f.writerId.focus();
            return;
        }
        if (f.noticePassword.value.trim() === "") {
            alert("비밀번호를 입력하세요");
            f.noticePassword.focus();
            return;
        }
        if (f.noticeTitle.value.trim() === "") {
            alert("제목을 입력하세요");
            f.noticeTitle.focus();
            return;
        }
        console.log("Submitting form");
        f.submit();
    }
    </script>
</body>
</html>