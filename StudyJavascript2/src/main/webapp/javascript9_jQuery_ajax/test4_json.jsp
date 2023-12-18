<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.js"></script>
<script type="text/javascript">
	$(function() {
		$("#btnOk").on("click", function() {
			$.ajax({
				type: "GET", // 생략 가능
				url: "test4_json_data.json", 
				dataType: "json", // 응답 데이터를 JSON 객체로 취급 
				success: function(data) {
					// 테이블에 해당 데이터 출력하기 위해 테이블 생성
					$("#resultArea").html("<table border='1'><tr><th>이름</th></tr></table>");
					
					// 응답된 JSON 데이터가 배열 형식일 경우
					// 일반 자바스크립트 배열 접근 방법과 동일(반복문 또는 직접 출력)
					// 1) 배열 직접 출력
// 					$("#resultArea > table").append(
// 						"<tr>"
// 						+ "<td>" + data + "</td>"
// 						+ "</tr>"
// 					);
				
					// 2) 일반 for문을 통해 반복으로 배열 인덱스 접근
					//    (배열명.length 활용)
// 					for(let i = 0; i < data.length; i++) {
// 						$("#resultArea > table").append(
// 							"<tr>"
// 							// 배열명[인덱스] 로 각 요소에 접근
// 							+ "<td>" + data[i] + "</td>"
// 							+ "</tr>"
// 						);
// 					}
		
					// 3) 향상된 for문(for...of)을 통해 반복문 사용
					for(let name of data) {
						$("#resultArea > table").append(
							"<tr>"
							// 전달받은 변수 그대로 데이터 접근
							+ "<td>" + name + "</td>"
							+ "</tr>"
						);
					}
					
				},
				error : function() {
					$("#resultArea").html("AJAX 요청 실패!");
				}
			}); // ajax 요청 끝
			
			
			// =============================================================================================================
			// test4_json_data2.json 요청
			$.ajax({
				type: "GET",
				url: "test4_json_data2.json",
				dataType: "json",
				success: function(data) {
					// 테이블에 해당 데이터 출력하기 위해 테이블 생성
					$("#resultArea2").html(
						"<table border='1'><tr><th>아이디</th><th>이름</th><th>나이</th></tr></table>"
					);
					
					// 배열 내에 객체 형태로 JSON 데이터가 존재할 경우
					// => 배열 반복하면서 각 배열 요소(객체) 내의 속성에 접근
					for(let member of data) {
						$("#resultArea2 > table").append(
							"<tr>"
							+ "<td>" + member.id + "</td>"
							+ "<td>" + member.name + "</td>"
							+ "<td>" + member.age + "</td>"
							+ "</tr>"
						);
					}
					
				},
				error : function() {
					$("#resultArea2").html("AJAX 요청 실패!");
				}
			});
			
		});// 버튼 클릭 이벤트 끝
		
	}); // document.ready 이벤트 끝
</script>
</head>
<body>
	<h1>AJAX - test4_json.jsp</h1>
	<input type="button" value="JSON 데이터 파싱" id="btnOk">
	<hr>
	<div id="resultArea"></div>
	<hr>
	<div id="resultArea2"></div>
</body>
</html>










