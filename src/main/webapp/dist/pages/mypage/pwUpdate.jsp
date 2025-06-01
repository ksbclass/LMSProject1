<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Find Password</title>
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
	height: 100vh;
	margin: 0;
}

.card {
	border: none;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
	width: 100%; max-width : 400px;
	padding: 20px;
	background-color: #ffffff;
	border-radius: 10px;
	max-width: 400px;
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
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
	transition: all 0.3s ease;
	text-decoration: none;
	display: inline-block;
}

.btn-link-custom:hover {
	background-color: #5a6268;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
	transform: translateY(-2px);
	color: #ffffff;
}

.btn-link-custom:active {
	transform: translateY(0);
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
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
</style>
</head>
<body>
	<div class="card">
		<h4 class="text-center mb-4">비밀번호 변경</h4>
		<form action="pw" method="post" onsubmit="return input_check(this)">

			<input type="hidden" value="${param.id}" name="id"> <input
				type="hidden" value="${param.email}" name="email">
			<!-- 현재비밀번호는 비밀번호찾기가성공적으로됐다면 자동으로 입력될것임 -->
			<div class="mb-3">
				<label for="pw" class="form-label">현재 비밀번호</label> <input
					type="password" class="form-control" id="pw" name="pw">
			</div>

			<div class="mb-3">
				<label for="cPw" class="form-label">변경할 비밀번호</label> <input
					type="password" class="form-control" id="cPw" name="cPw"
					placeholder="변경할 비밀번호" onkeyup="passwordChk(this)"> <span
					id="passValid"></span>
			</div>

			<div class="mb-3">
				<label for="cPw2" class="form-label">변경할 비밀번호 재입력</label> <input
					type="password" class="form-control" id="cPw2" name="cPw2"
					placeholder="재입력" onkeyup="re_passwordChk(this)"> <span
					id="pEqulasCp"></span>
			</div>

			<button class="btn btn-custom w-100 mb-3">비밀번호 변경</button>
			<div class="text-center">
				<a href="close" class="btn btn-link-custom">비밀번호를 나중에 바꾸고 싶으면
					클릭!</a>
			</div>
		</form>
	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
	<script type="text/javascript">

      
        
        function passwordChk(p){
        	const passVal = document.querySelector("#passValid");
        	if(!valid(p.value.trim(),'pass')){
        		passVal.innerHTML= '특수문자,영어,숫자포함 8~16자리';
        		passVal.style.color='red';
        	}
        	else{
        		passVal.innerHTML= '유효한비밀번호';
        		passVal.style.color='green';
        	}
        }
        
        function re_passwordChk(cp){ //비밀번호와 재입력한비밀번호가 같은지?
    		let  p = document.querySelector("#cPw").value;
    		let  pEqulasCp = document.querySelector("#pEqulasCp");
    		if(!(p===cp.value)){
    			pEqulasCp.innerHTML = '비밀번호가 일치하지않아요';
    		}
    		else{
    			pEqulasCp.innerHTML = '';
    		}

        }
        
        function valid(text,type){    
        if(type==='pass'){ //비밀번호유효성검사
        		const regex = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[\W_])[A-Za-z\d\W_]{8,16}$/;
        		//(?=.*[A-Za-z]) → 문자열 어딘가에 영문자가 있어야 해 (확인만)
        		//\W : 특수문자 , [A-Za-z\d\W_]{8,16} : 해당문자들이 8개~16개존재해야함
        		return regex.test(text);
        	}
        
        }
        
        function input_check(t) {
            if (t.cPw.value.trim() != t.cPw2.value.trim()) {
                alert("변경할 비밀번호와 재입력한 비밀번호가 일치하지 않습니다.");
                t.cPw2.focus();
                return false;
            }
            else if (t.pw.value.trim()==""){
				alert("현재비번입력");
				t.pw.focus();
				return false;
            }
            else if(t.cPw.value.trim() == ""){ 
        		alert("비밀번호입력")
        		t.password.focus();
        		return false; 
        	}
            else if(t.cPw2.value.trim() == ""){ 
        		alert("비밀번호재입력")
        		t.confirmPassword.focus();
        		return false; 
        	}
            //valid(t.pw.value.trim(),'pass')
            else if(!(
            		 valid(t.cPw.value.trim(),'pass')
            		&& valid(t.cPw2.value.trim(),'pass')
            		)){ 
        	alert("형식을준수해주세요")
        	return false;
        	}
            return true;
        }
        
      

    </script>
</body>
</html>