<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
alert("${msg}")
//requestScope.msg
opener.document.f.id.value = "${id}"
//requestScope.id
self.close();
</script>