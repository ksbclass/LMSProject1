<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>오류 발생</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .error-container {
            text-align: center;
            padding: 40px;
            border-radius: 12px;
            background-color: #ffffff;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            max-width: 500px;
        }
        .error-code {
            font-size: 64px;
            font-weight: bold;
            color: #dc3545;
        }
        .error-message {
            font-size: 20px;
            margin-bottom: 15px;
        }
        .alert-custom {
            font-size: 16px;
            margin-top: 10px;
        }
        .home-btn {
            margin-top: 20px;
        }
    </style>
</head>
<body>
<div class="error-container">
    <div class="error-code">오류!</div>
    <div class="error-message">문제가 발생했습니다.</div>
    
    <!-- 에러 메시지가 존재할 경우 출력 -->
    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-custom" role="alert">
            ${error}
        </div>
    </c:if>

    <p>잠시 후 다시 시도하거나, 메인 페이지로 돌아가주세요.</p>
    <a href="/LMSProject1/mypage/index" class="btn btn-danger home-btn">홈으로 이동</a>
</div>
</body>
</html>
