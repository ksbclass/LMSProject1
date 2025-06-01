<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
     <%
     	String id = (String)request.getAttribute("id");
     	request.setAttribute("id", id);
     %>
<script>
   alert("${msg}");
   location.href = "${url}";
</script>
