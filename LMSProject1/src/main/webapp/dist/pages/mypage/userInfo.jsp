
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="path" value="${pageContext.request.contextPath}" scope="application" />
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Academic Management System</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Noto Sans KR', sans-serif;
            background: linear-gradient(135deg, #e6e9f0 0%, #b8c6db 100%);
            margin: 0;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: flex-start;
            color: #2d3748;
        }

        .container {
            max-width: 960px;
            margin: 40px auto;
            padding: 0 16px;
        }

        .card {
            background: #ffffff;
            border-radius: 12px;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.1);
            padding: 32px;
            margin-bottom: 32px;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .card:hover {
            transform: translateY(-4px);
            box-shadow: 0 10px 28px rgba(0, 0, 0, 0.12);
        }

        .card h2 {
            font-size: 1.75rem;
            font-weight: 700;
            color: #1a202c;
            margin-bottom: 20px;
            border-bottom: 2px solid #e2e8f0;
            padding-bottom: 10px;
        }

        .profile-section {
            display: flex;
            align-items: center;
            gap: 20px;
            margin-bottom: 24px;
            background: #f8fafc;
            padding: 16px;
            border-radius: 10px;
            flex-wrap: wrap;
        }

        .profile-img {
            width: 100px;
            height: 100px;
            object-fit: cover;
            border-radius: 50%;
            border: 3px solid #e2e8f0;
            transition: border-color 0.3s ease;
        }

        .profile-img:hover {
            border-color: #2b6cb0;
        }

        .form-section {
            display: grid;
            gap: 12px;
        }

        .form-section div {
            display: flex;
            align-items: center;
            gap: 12px;
            background: #f7fafc;
            padding: 12px;
            border-radius: 8px;
            transition: background 0.2s ease;
        }

        .form-section div:hover {
            background: #edf2f7;
        }

        .form-section strong {
            width: 100px;
            text-align: right;
            font-weight: 600;
            color: #4a5568;
        }

        .form-section input {
            padding: 8px 12px;
            border: 1px solid #cbd5e0;
            border-radius: 6px;
            width: 260px;
            background: #ffffff;
            font-size: 0.95rem;
            color: #2d3748;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
        }

        .form-section input:focus {
            outline: none;
            border-color: #2b6cb0;
            box-shadow: 0 0 0 3px rgba(43, 108, 176, 0.1);
        }

        .form-section input[readonly] {
            background: #f1f5f9;
            cursor: not-allowed;
        }

        .btn {
            padding: 8px 16px;
            border-radius: 6px;
            font-weight: 500;
            font-size: 0.95rem;
            transition: all 0.2s ease;
            cursor: pointer;
            text-align: center;
        }

        .btn-primary {
            background: #2b6cb0;
            color: white;
            border: none;
        }

        .btn-primary:hover {
            background: #2c5282;
            transform: translateY(-1px);
        }

        .btn-secondary {
            background: #e2e8f0;
            color: #4a5568;
            border: none;
        }

        .btn-secondary:hover {
            background: #cbd5e0;
            transform: translateY(-1px);
        }

        .btn-danger {
            background: #c53030;
            color: white;
            border: none;
        }

        .btn-danger:hover {
            background: #9b2c2c;
            transform: translateY(-1px);
        }

        .action-buttons {
            display: flex;
            gap: 12px;
            margin-top: 20px;
            padding-left: 112px;
            flex-wrap: wrap;
        }

        @media (max-width: 768px) {
            .container {
                margin: 16px auto;
                padding: 0 12px;
            }

            .card {
                padding: 20px;
            }

            .profile-section {
                flex-direction: column;
                align-items: flex-start;
            }

            .form-section div {
                flex-direction: column;
                align-items: flex-start;
            }

            .form-section strong {
                width: auto;
                text-align: left;
            }

            .form-section input {
                width: 100%;
            }

            .action-buttons {
                padding-left: 0;
                flex-direction: column;
                align-items: flex-start;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Personal Information -->
        <div class="card">
            <h2>개인 정보</h2>

            <form action="userUpdate" class="form-section" name="f" method="post">
                <div class="profile-section">
                    
                    <input type="hidden" name="picture" value="${m.img}">
                    <img src="${path}/dist/assets/picture/${m.img}" id="pic" class="profile-img" alt="Profile Image">
                    <button type="button" class="btn btn-secondary" onclick="win_upload()">이미지 변경</button>
                </div>
                <c:choose>
                    <c:when test="${fn:contains(sessionScope.login, 'S')}">
                        <!-- Student Information -->
                        <div>
                            <strong>이름:</strong>
                            <input type="text" readonly="readonly" value="${m.studentName}" name="name">
                        </div>
                        <div>
                            <strong>학번:</strong>
                            <input type="text" readonly="readonly" value="${m.studentNum}" name="studentNum">
                        </div>
                        <div>
                            <strong>생년월일:</strong>
                            <input type="text" readonly="readonly" value="<fmt:formatDate value='${m.studentBirthday}' pattern='yyyy-MM-dd'/>" name="birthday">
                        </div>
                        <div>
                            <strong>직위:</strong>
                            <input type="text" readonly="readonly" value="학생" name="position">
                        </div>
                        <div>
                            <strong>학과:</strong>
                            <input type="text" readonly="readonly" value="${deptName}" name="deptName">
                        </div>
                    </c:when>
                    <c:when test="${fn:contains(sessionScope.login, 'P')}">
                        <!-- Professor Information -->
                        <div>
                            <strong>이름:</strong>
                            <input type="text" readonly="readonly" value="${m.professorName}" name="name">
                        </div>
                        <div>
                            <strong>생년월일:</strong>
                            <input type="text" readonly="readonly" value="<fmt:formatDate value='${m.professorBirthday}' pattern='yyyy-MM-dd'/>" name="birthday">
                        </div>
                        <div>
                            <strong>직위:</strong>
                            <input type="text" readonly="readonly" value="교수" name="position">
                        </div>
                        <div>
                            <strong>학과:</strong>
                            <input type="text" readonly="readonly" value="${deptName}" name="deptName">
                        </div>
                    </c:when>
                </c:choose>

                <div>
                    <c:choose>
                        <c:when test="${fn:contains(sessionScope.login, 'S')}">
                            <strong>연락처:</strong>
                            <input type="text" readonly="readonly" value="${m.studentPhone}" name="phone" id="phone">
                            <button class="btn btn-secondary" type="button" onclick="updatePhone()">수정</button>
                        </c:when>
                        <c:when test="${fn:contains(sessionScope.login, 'P')}">
                            <strong>연락처:</strong>
                            <input type="text" readonly="readonly" value="${m.professorPhone}" name="phone" id="phone">
                            <button class="btn btn-secondary" type="button" onclick="updatePhone()">수정</button>
                        </c:when>
                    </c:choose>
                </div>
                <div>
                    <c:choose>
                        <c:when test="${fn:contains(sessionScope.login, 'S')}">
                            <strong>이메일:</strong>
                            <input type="email" readonly="readonly" value="${m.studentEmail}" name="email" id="email">
                            <button class="btn btn-secondary" type="button" onclick="updateEmail()">수정</button>
                        </c:when>
                        <c:when test="${fn:contains(sessionScope.login, 'P')}">
                            <strong>이메일:</strong>
                            <input type="email" readonly="readonly" value="${m.professorEmail}" name="email" id="email">
                            <button class="btn btn-secondary" type="button" onclick="updateEmail()">수정</button>
                        </c:when>
                    </c:choose>
                </div>
                <div class="action-buttons">
                    <button class="btn btn-primary" type="submit">수정완료</button>
                    <button class="btn btn-primary" type="button" onclick="updatePw()">비밀번호 변경</button>
                    <c:if test="${fn:contains(sessionScope.login, 'S')}"> <%--학생만선택가능 --%>
						<button class="btn btn-danger" type="button" onclick="deleteUser()">자퇴신청</button>                    
                    </c:if>                  
                </div>
            </form>
            <form id="pwForm" action="pwUpdate" method="post" target="pwUpdateWindow" name="c">
                <input type="hidden" name="id" value="${sessionScope.login}">
                <input type="hidden" name="email" value="${fn:contains(sessionScope.login, 'S') ? m.studentEmail : m.professorEmail}">
            </form>
        </div>
    </div>

    <script type="text/javascript">
        function updateEmail() {
            let op = "width=500,height=500,top=50,left=150";
            window.open("updateEmail", "", op);
        }

        function updatePhone() {
            let op = "width=500,height=500,top=50,left=150";
            window.open("updatePhone", "", op);
        }

        function win_upload() {
            let op = "width=500,height=500,top=50,left=150";
            window.open("registerImg", "", op);
        }

        function updatePw() {
            let loginId = "${sessionScope.login}";
            let email = "${fn:contains(sessionScope.login, 'S') ? m.studentEmail : m.professorEmail}";
            if (!loginId) {
                alert("로그인이 필요합니다.");
                return;
            }
            if (!email) {
                alert("이메일 정보가 없습니다.");
                return;
            }

            let op = "width=500,height=500,top=50,left=150";
            window.open("", "pwUpdateWindow", op);
            document.getElementById("pwForm").submit();
        }

        function deleteUser() {
            if (confirm("정말 퇴학하시겠습니까? 이 작업은 되돌릴 수 없습니다.")) {
                let op = "width=500,height=500,top=50,left=150";
                window.open("deleteUser", "", op);
            }
        }
    </script>
</body>
</html>
```