<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>    
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Find Password</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Noto Sans KR', sans-serif;
            background-color: #f8f9fa;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .card {
            border: none;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            width: 100%;
            max-width: 400px;
            padding: 20px;
            background-color: #ffffff;
            border-radius: 10px;
        }
        .btn-custom {
            background-color: #007bff;
            color: #ffffff;
            border: none;
            transition: background-color 0.3s ease;
        }
        .btn-custom:hover {
            background-color: #0056b3;
        }
        .btn-link-custom {
            color: #ffffff;
            background-color: #6c757d; /* 회색 톤으로 부드러운 느낌 */
            border: none;
            padding: 10px 20px;
            font-size: 1rem;
            font-weight: 500;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
        }
        .btn-link-custom:hover {
            background-color: #5a6268;
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
            transform: translateY(-2px);
            color: #ffffff;
        }
        .btn-link-custom:active {
            transform: translateY(0);
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .text-center {
            margin-top: 15px;
        }
        .form-label {
            font-weight: 500;
            color: #333;
        }
        .form-control {
            border-radius: 8px;
            border: 1px solid #ced4da;
            padding: 10px;
        }
        h4 {
            color: #333;
            font-weight: 700;
        }
        @media (max-width: 576px) {
            .card {
                padding: 15px;
                max-width: 90%;
            }
            .btn-link-custom {
                font-size: 0.9rem;
                padding: 8px 16px;
            }
        }
    </style>
</head>
<body>
    <div class="card">
        <h4 class="text-center mb-4">자퇴 form</h4>
        <form action="delete" method="post" >
        
           <div class="mb-3">
                <label for="id" class="form-label">아이디</label>
                <input type="text" class="form-control" id="id" name="id" >
            </div> 
            
            <div class="mb-3">
                <label for="name" class="form-label">이름</label>
                <input type="text" class="form-control" id="name" name="name" >
            </div>
            
            <div class="mb-3">
                <label for="pw" class="form-label">비밀번호</label>
                <input type="password" class="form-control" id="pw" name="pw" >
            </div>  
            
            <div class="mb-3">
                <label for="email" class="form-label">이메일</label>
                <input type="email" class="form-control" id="email" name="email" >
            </div>       
            
           <div class="mb-3">
            <label for="major" class="form-label">전공선택</label>
            <select class="form-select" id="major" name="deptId">
                <option selected value="none">전공</option>
                <c:forEach items="${dept}" var="s">
                <option value="${s.deptId}">${s.deptName}</option>
                </c:forEach>   
            </select>
        </div>
            
            <button class="btn btn-custom w-100 mb-3">자퇴신청</button>
            <div class="text-center">
                <a href="close" class="btn btn-link-custom">취소하고 싶으면 클릭!</a>
            </div>
        </form>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script type="text/javascript">
       
      

    </script>
</body>
</html>