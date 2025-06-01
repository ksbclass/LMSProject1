<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>답글 작성</title>
   	<link href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/summernote.min.css" rel="stylesheet">
	<script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/summernote.min.js"></script>
</head>
<body>
<form action="writeReply" method="post" name="f" enctype="multipart/form-data">
    <input type="hidden" name="num" value="${board.postId}">
    <input type="hidden" name="grp" value="${board.postGroup}">
    <input type="hidden" name="grplevel" value="${board.postGroupLevel}">
    <input type="hidden" name="grpstep" value="${board.postGroupStep}">
    <div class="container">
        <h2 class="text-center fs-1">답글 작성</h2>
        <c:if test="${not empty msg}">
            <div style="color: red;">${msg}</div>
            <% request.removeAttribute("msg"); %>
        </c:if>
        <table class="table">
            <tr>
                <th>글쓴이</th>
                <td>
                    <input type="text" name="writer" class="form-control" value="${userName}" readonly>
                </td>
            </tr>
            <tr>
                <th>비밀번호</th>
                <td>
                    <input type="password" name="pass" class="form-control" required>
                </td>
            </tr>
            <tr>
                <th>제목</th>
                <td>
                    <input type="text" name="title" class="form-control" value="RE: ${board.postTitle}" required>
                </td>
            </tr>
            <tr>
                <th>내용</th>
                <td>
                    <textarea name="content" rows="15" class="form-control" id="summernote"></textarea>
                </td>
            </tr>
            <tr>
                <th>파일</th>
                <td>
                    <input type="file" name="post_file" class="form-control">
                </td>
            </tr>
            <tr>
                <td colspan="2" align="center">
                    <button type="button" onclick="inputcheck()" class="btn btn-primary">답변글 등록</button>
                    <a href="getPosts" class="btn btn-secondary">목록</a>
                </td>
            </tr>
        </table>
    </div>
</form>
<script type="text/javascript">
    $(function() {
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
            url: "${path}/post/uploadImage",
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
        if (f.writer.value.trim() === "") {
            alert("글쓴이를 입력하세요");
            f.writer.focus();
            return;
        }
        if (f.pass.value.trim() === "") {
            alert("비밀번호를 입력하세요");
            f.pass.focus();
            return;
        }
        if (f.title.value.trim() === "") {
            alert("제목을 입력하세요");
            f.title.focus();
            return;
        }
        console.log("Submitting form");
        f.submit();
    }
    </script>
</body>
</html>