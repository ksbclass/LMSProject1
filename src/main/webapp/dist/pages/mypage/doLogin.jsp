
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>		
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Login</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<style>
body {
	font-family: 'Noto Sans KR', sans-serif;
	margin: 0;
	padding: 0;
	height: 100vh;
	width: 100vw;
	overflow: hidden;
	display: flex;
	flex-direction: column;
	justify-content: center;
	/* 배경 사진과 그라디언트 오버레이 */
	background: linear-gradient(135deg, rgba(74, 144, 226, 0.5),
		rgba(80, 201, 195, 0.5)),
		url('https://images.unsplash.com/photo-1600585154340-be6161a56a0c?ixlib=rb-4.0.3&auto=format&fit=crop&w=1920&q=80');
	background-size: cover;
	background-position: center;
	background-repeat: no-repeat;
	background-attachment: fixed;
}

.card {
	border: none;
	box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
	width: 70%;
	max-width: 500px; /* 최대 너비 제한 */
	padding: 20px; /* 내부 여백 조정 */
	background: rgba(255, 255, 255, 0.9);
	backdrop-filter: blur(5px);
	margin: auto; /* 수평 및 수직 가운데 정렬 */
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
}

.form-control {
	height: 70px;
	font-size: 1.5em;
	padding: 15px;
	margin-bottom: 20px;
	width: 80%;
	max-width: 600px;
	border-radius: 10px;
	border: 2px solid #4a90e2;
}

.form-label {
	font-size: 1.5em;
	font-weight: 500;
	margin-bottom: 10px;
	display: block;
	color: #333;
}

.btn-custom {
	background-color: #4a90e2;
	color: #ffffff;
	border: none;
}

.btn-custom:hover {
	background-color: #357abd;
}

.btn-link-custom {
	color: #4a90e2;
	text-decoration: none;
	font-size: 1.2em;
	margin: 0 15px;
}

.btn-link-custom:hover {
	text-decoration: underline;
}

.btn-primary {
	width: 80%;
	max-width: 600px;
	padding: 20px;
	font-size: 1.6em;
	border-radius: 10px;
	margin-top: 20px;
	background-color: #4a90e2;
	border: none;
}

.ldb-text {
	font-weight: bold;
	font-size: 1.8em;
}

h4 {
	font-size: 2.5em;
	font-weight: bold;
	margin-bottom: 40px;
	color: #333;
}

.link-container {
	display: flex;
	justify-content: center;
	margin-top: 20px;
	width: 80%;
	max-width: 600px;
}

@media ( max-width : 768px) {
	.card {
		padding: 10px;
	}
	.form-control {
		height: 60px;
		font-size: 1.3em;
		width: 90%;
	}
	.form-label {
		font-size: 1.3em;
	}
	.btn-primary {
		padding: 15px;
		font-size: 1.4em;
		width: 90%;
	}
	.ldb-text {
		font-size: 1.5em;
	}
	.btn-link-custom {
		font-size: 1.1em;
		margin: 0 10px;
	}
	h4 {
		font-size: 2em;
	}
}
</style>
</head>
<body>
	<div class="card">
		<form action="login" name="f" method="post"
			onsubmit="return input_check(this)">
			<label class="form-label" style="text-align: center;">로그인</label>
			<div class="mb-3">
				<label for="id" class="form-label">아이디</label> <input type="text"
					class="form-control" id="id" name="id" placeholder="아이디 입력">
			</div>
			<div class="mb-3">
				<label for="password" class="form-label">비밀번호</label> <input
					type="password" class="form-control" id="password" name="password"
					placeholder="비밀번호 입력">
			</div>
			<button class="btn btn-primary">
				<span class="ldb-text">LDB</span> 로그인
			</button>
		</form>
		<div class="link-container">
			<a href="javascript:goFindId()" class="btn-link-custom">아이디 찾기</a> <a
				href="javascript:goFindPw()" class="btn-link-custom">비밀번호 찾기</a> <a
				href="${pageContext.request.contextPath}/mypage/registerUser"
				class="btn-link-custom">회원가입</a>
		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
	<script>
    function input_check(form) {
        if (!form.id.value.trim()) {
            alert("아이디를 입력하세요.");
            form.id.focus();
            return false;
        }
        if (!form.pass.value.trim()) {
            alert("비밀번호를 입력하세요.");
            form.pass.focus();
            return false;
        }
        return true;
    }
    
    function goFindId(){
    	let op = "width=500,height=500 ,top=50 ,left=150";
    	window.open("findId","",op);
    	
    }
    
    function goFindPw(){
    	let op = "width=500,height=500 ,top=50 ,left=150";
    	window.open("findPw","",op);
    	
    }
</script>
</body>
</html>