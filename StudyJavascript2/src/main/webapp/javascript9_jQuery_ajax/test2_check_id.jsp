<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%-- 전달받은 id 파라미터 값이 "admin" 이면 "이미 사용중인 아이디" 출력하고 --%>
<%-- 아니면, "사용 가능한 아이디" 출력 --%>
<%
String id = request.getParameter("id");
if(id.equals("admin")) {
	out.print(id + ": 이미 사용중인 아이디");
} else {
	out.print(id + " : 사용 가능한 아이디");
}

%>