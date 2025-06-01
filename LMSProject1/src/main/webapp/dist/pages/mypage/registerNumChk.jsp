<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>register Num Chk</title>
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
        }
        .btn-custom {
            background-color: #007bff;
            color: #ffffff;
            border: none;
        }
        .btn-custom:hover {
            background-color: #0056b3;
        }
        .btn-link-custom {
            color: #007bff;
            text-decoration: none;
        }
        .btn-link-custom:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="card">
        <h4 class="text-center mb-4">인증번호 입력</h4>
        <form action="registerSuccess" onsubmit="return numChk(this)">      
        <div class="mb-3">
            <label for="name" class="form-label">인증번호</label>
            <input type="text" class="form-control" id="num" name="num"
												placeholder="인증번호입력">
												
            <input type="hidden" value="${mem}" name="mem">
            <input type="hidden" value="${id}" name="id">
            <input type="hidden" value="${num}" name="emailNum">
        </div>
        <button class="btn btn-custom w-100 mb-3">인증</button>
        </form>
    </div>
    <script type="text/javascript">
    	function numChk(f){
			if(f.num.value.trim() !== f.emailNum.value){
				alert("인증번호가틀려요")
				return false
			}
			else{
				return true;
			}
    	}
    </script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>