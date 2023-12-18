<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- test1.jsp 페이지에서 AJAX 를 통한 요청 작업 처리 및 응답 결과 생성 페이지 --%>
<h1>AJAX - test1_result.jsp</h1>
<%-- 파라미터로 전달받은 id, passwd 값 확인 --%>
<h3>아이디 : ${param.id}</h3>
<h3>패스워드 : ${param.passwd}</h3>
<%-- 
이 페이지로 이동하여 결과값을 출력하는 것이 아니라
이 페이지의 내용이 요청을 발생시킨 페이지(test1.jsp)에서
응답데이터로 전달받아 출력됨
--%>
