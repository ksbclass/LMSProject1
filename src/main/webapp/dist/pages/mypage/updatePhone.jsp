<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>핸드폰번호변경</title>
<style>
body {
    font-family: 'Noto Sans KR', sans-serif;
    padding: 20px;
}
input[type="email"] {
    padding: 8px;
    border: 1px solid #ccc;
    border-radius: 4px;
    width: 250px;
    margin-right: 10px;
}
button {
    padding: 8px 16px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
}
button:first-of-type {
    background: #3182ce;
    color: white;
}
button:first-of-type:hover {
    background: #2b6cb0;
}
button:last-of-type {
    background: #e2e8f0;
    color: #4a5568;
}
button:last-of-type:hover {
    background: #cbd5e0;
}
</style>
</head>
<body>
    <h2>변경할 핸드폰번호를 입력</h2>
    <input type="text" id="phone" name="phone" onkeyup="phoneChk(this)">
    <span id="phoneValid"></span>
    <button onclick="update()" type="button">변경</button>
    <button onclick="closeWindow()" type="button">취소</button>

    <script type="text/javascript">
    function update() {
            // 부모 창의 #email 요소 찾기
      const parentEmailInput = window.opener.document.querySelector("#phone");
       const newEmail = document.querySelector("#phone").value;

       if(valid(document.querySelector("#phone").value, 'phone')){
    	   // 부모 창의 이메일 값 변경
           parentEmailInput.value = newEmail;
           window.close();
       }
       else{
			alert("!! 형식을 지키지않아 적용되지않음 !!")
			window.close();
       }
           
    }

    function closeWindow() {
        window.close();
    }
    function phoneChk(p){
    	const phoneVal = document.querySelector("#phoneValid");
    	if(!valid(p.value,'phone')){
    		phoneVal.innerHTML= '올바른 휴대폰번호입력바람';
    		phoneVal.style.color='red';
    	}
    	else{
    		phoneVal.innerHTML= '유효한 번호';
    		phoneVal.style.color='green';
    	}
    }
    
    function valid(text,type){
    	 if(type==='phone'){ //넘어온값과 name=tel의 값이 동일할때
    		const regex = /^(01[0126789])[ -]?\d{3,4}[ -]?\d{4}$/;
    		return regex.test(text);
    	}
    	
    }
    
    </script>
</body>
</html>