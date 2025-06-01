<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Sign Up</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<style>
body {
	font-family: 'Noto Sans KR', sans-serif;
	background-color: #f8f9fa;
	display: flex;
	justify-content: center;
	align-items: center;
	min-height: 100vh;
	margin: 0;
	overflow-y: auto;
}

.card {
	border: none;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
	width: 100%;
	max-width: 400px;
	padding: 20px;
	margin-top: 20px;
	margin-bottom: 20px;
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
		<h4 class="text-center mb-4">회원가입</h4>
		<form action="registerNumChk" name="f" method="post"
			onsubmit="return input_check(this)">
			<input type="hidden" name="picture" value="">
			<!-- 업로드된 이미지의 이름이 들어갈태그 -->
			<div class="mb-3">
				<img src="" width="100" height="120" id="pic"><br> <font
					size="1"><a href="javascript:win_upload()">사진등록</a></font>
			</div>
			<div class="mb-3">
				<label for="id" class="form-label">아이디</label> <input type="text"
					class="form-control" id="id" name="id" value="가입시 자동부여" readonly>
			</div>
			<div class="mb-3">
				<label for="name" class="form-label">이름</label> <input type="text"
					class="form-control" id="name" name="name" placeholder="이름 입력">
			</div>
			<div class="mb-3">
				<label for="birth" class="form-label">생년월일</label> <input
					type="date" class="form-control" id="birth" name="birth"
					placeholder="생년월일">
			</div>
			<div class="mb-3">
				<label class="form-label">직급</label>
				<div class="form-check">
					<input class="form-check-input" type="radio" name="position"
						id="pro" value="pro" checked> <label
						class="form-check-label" for="pro">교수</label>
				</div>
				<div class="form-check">
					<input class="form-check-input" type="radio" name="position"
						id="stu" value="stu"> <label class="form-check-label"
						for="stu">학생</label>
				</div>
			</div>
			<div class="mb-3">
				<label for="major" class="form-label">전공 선택</label> <select
					class="form-select" id="major" name="deptId">
					<option selected value="none">전공</option>
					<c:forEach items="${dept}" var="s">
						<option value="${s.deptId}">${s.deptName}</option>
					</c:forEach>
					<!-- <option value="Computer Science">컴퓨터공학과</option>
                <option value="Electrical Engineering">전자공학과</option>
                <option value="Mechanical Engineering">기계공학과</option>
                <option value="Business Administration">경영학과</option> -->

				</select>
			</div>
			<div class="mb-3">
				<label for="password" class="form-label">비밀번호</label> <input
					type="password" class="form-control" id="password" name="password"
					placeholder="비밀번호 입력" onkeyup="passwordChk(this)"> <font
					id="passValid"></font>

			</div>
			<div class="mb-3">
				<label for="confirmPassword" class="form-label">비밀번호 확인</label> <input
					type="password" class="form-control" id="confirmPassword"
					name="confirmPassword" placeholder="비밀번호 확인"
					onkeyup="re_passwordChk(this)"> <font id="pEqulasCp"></font>

			</div>
			<div class="mb-3">
				<label for="phone" class="form-label">전화번호</label> <input
					type="text" class="form-control" id="phone" name="phone"
					placeholder="전화번호 입력" onkeyup="phoneChk(this)"> <font
					id='phoneValid'></font>
			</div>
			<div class="mb-3">
				<label for="email" class="form-label">이메일</label> <input
					type="email" class="form-control" id="email" name="email"
					placeholder="이메일 입력" onkeyup="emailChk(this)"> <font
					id='emailValid'></font>
			</div>

			<button class="btn btn-custom w-100 mb-3">가입</button>
		</form>

		<div class="text-center">
			<a href="doLogin" class="btn-link-custom">로그인 화면으로 돌아가기</a>
		</div>

	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
	<script type="text/javascript">
  

    function win_upload(){
    	let op = "width=500,height=500 ,top=50 ,left=150";
    	open("registerImg","",op);
    	
    }
    
    
   function passwordChk(p){
    	const passVal = document.querySelector("#passValid");
    	if(!valid(p.value,'pass')){
    		passVal.innerHTML= '특수문자,영어,숫자포함 8~16자리';
    		passVal.style.color='red';
    	}
    	else{
    		passVal.innerHTML= '유효한비밀번호';
    		passVal.style.color='green';
    	}
    }
    
    function re_passwordChk(cp){ //비밀번호와 재입력한비밀번호가 같은지?
		let  p = document.querySelector("#password").value;
		let  pEqulasCp = document.querySelector("#pEqulasCp");
		if(!(p===cp.value)){
			pEqulasCp.innerHTML = '비밀번호가 일치하지않아요';
		}
		else{
			pEqulasCp.innerHTML = '';
		}

    }
    
    function phoneChk(t){
    	const phoneVal = document.querySelector("#phoneValid");
    	if(!valid(t.value,'phone')){
    		phoneVal.innerHTML= '올바른 휴대폰번호입력바람';
    		phoneVal.style.color='red';
    	}
    	else{
    		phoneVal.innerHTML= '유효한 번호';
    		phoneVal.style.color='green';
    	}
    }
    function emailChk(e){
    	const emailVal = document.querySelector("#emailValid");
    	if(!valid(e.value,'email')){
    		emailVal.innerHTML= '올바른 Email형식작성하세요';
    		emailVal.style.color='red';
    	}
    	else{
    		emailVal.innerHTML= '유효한E-mail';
    		emailVal.style.color='green';
    	}
    }
    
    
    
    //검증부분
    function valid(text,type){
    	if(type==='email'){//넘어온값과 name=email의 값이 동일할때
    		const regex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9._]+\.[a-zA-Z]{2,}$/;
    		return regex.test(text);
    	}
    	else if(type==='phone'){ //넘어온값과 name=tel의 값이 동일할때
    		const regex = /^(01[0126789])[ -]?\d{3,4}[ -]?\d{4}$/;
    		return regex.test(text);
    	}
    	else if(type==='pass'){ //비밀번호유효성검사
    		const regex = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[\W_])[A-Za-z\d\W_]{8,16}$/;
    		//(?=.*[A-Za-z]) → 문자열 어딘가에 영문자가 있어야 해 (확인만)
    		//\W : 특수문자 , [A-Za-z\d\W_]{8,16} : 해당문자들이 8개~16개존재해야함
    		return regex.test(text);
    	}
    }
 
    
    //폼검증
    function input_check(f){
    	//f : <form...>
    	//f.pass : <input name="id">name이 pass인태그
    	
    	if(f.password.value.trim() == ""){ 
		alert("비밀번호입력")
		f.password.focus();
		return false; 
		}
    	else if(f.confirmPassword.value.trim() == ""){ 
		alert("비밀번호재입력")
		f.confirmPassword.focus();
		return false; 
	}
    	else if (f.password.value.trim() != f.confirmPassword.value.trim()) {
        alert("비밀번호와 재입력한 비밀번호가 일치하지 않습니다.");
        f.confirmPassword.focus();
        return false;
        }
    	else if(f.name.value.trim() == ""){ 
		alert("이름입력")
		f.name.focus();
		return false; 
	}
    	else if(f.birth.value.trim() == ""){
			alert("생년월일입력바람");

			return false;
    	}
    	else if(f.major.value.trim() == "none"){ 
		alert("전공선택")
		f.major.focus();
		return false; 
	}

    	else if(f.phone.value.trim() == ""){ 
		alert("전화번호입력바람")
		f.phone.focus();
		return false; 
	}
    	else if(f.email.value.trim() == ""){ 
		alert("email입력바람")
		f.email.focus();
		return false; 
	}
    	else if(!(
    	valid(f.password.value.trim(),'pass') 
		&& valid(f.email.value.trim(),'email')
		&& valid(f.phone.value.trim(),'phone')
			)){ //3개중 한개라도 유효성검사를 실패했다면 실행
			alert("형식을준수해주세요")
			return false;
		}
    	else{
			return true;
	}

    
    }
    
    </script>
</body>
</html>