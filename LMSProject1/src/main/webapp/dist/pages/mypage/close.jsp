<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<script>
if(${msg!=null}){
	alert("${msg}");
}
	self.close();
if(${logout!=null}){ /*로그인상태(즉 개인정보에서 비밀번호변경시 속성을삭제시키고 opener의주소를 logout으로보낸다)*/
	opener.location.href="${logout}"
	//logout으로매핑될 시 세션정보가 다 날라가고 redirect:doLogin으로갈거임
}	
</script>