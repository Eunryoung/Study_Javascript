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
			// test3_json_data.txt 파일을 AJAX 를 통해 요청
			// - 응답 데이터 형식(dataType 속성)을 지정하지 않으면 자동 식별
			//   만약, 단순 텍스트일 경우 "text" 또는 "html" 형식으로 지정해도 됨
			// - 전송할 파라미터가 없을 경우 data 속성 생략
// 			$.ajax({
// 				type: "GET", // 생략 가능
// 				url: "test3_json_data.txt", // 일반 파일도 요청 가능
				// url에 전송할 데이터가 없어서 data 속성 생략
// // 				dataType: "text", // 응답 데이터를 단순 텍스트로 취급
// // 				dataType: "html", // 응답 데이터에 HTML 태그 포함 시 태그 인식하도록 태그로 취급
// 				dataType: "json", // 응답 데이터를 JSON 객체로 취급
// 				// => 객체로 취급되어 JSON을 사용하는 객체로 처리가 됨
// 				success: function(data) { // 파라미터는 변수명같은것. 이름 아무거나 줘도 됨
// 					$("#resultArea").html("AJAX 요청 성공<br>" + data);
// 				},
// 				error : function() { // 파라미터 아무것도 안 줘도 됨
// 					$("#resultArea").html("AJAX 요청 실패!");
// 				}
// 			});
			// =========================================================================================
			// test3_json_data.txt 파일 요청 시 응답 형식을 JSON 형식으로 지정한 경우
			// 응답 데이터가 JSON 객체로 관리되어 객체로 접근 가능
			// => 단, 잘못된 JSON 형식일 경우 오류 발생
			$.ajax({
				type: "GET", // 생략 가능
				url: "test3_json_data.txt", // 일반 파일도 요청 가능
// 				dataType: "text", // 응답 데이터를 단순 텍스트로 취급
// 				dataType: "html", // 응답 데이터의 HTML 태그 인식하도록 태그로 취급 
				dataType: "json", // 응답 데이터를 JSON 객체로 취급 
				success: function(data) {
// 					$("#resultArea").html("AJAX 요청 성공<br>" + data); // [object Object]
					// => JSON 객체 형태(object 타입)이므로 그대로 사용 불가
					// -----------------------------------------------------
					// 만약, 전달받은 JSON 객체를 단순 문자열 형식으로 변환할 경우
					// 자바스크립트 내장 객체 JSON 의 stringify() 메서드 호출하여 변환 가능
					// => 파라미터 : JSON 객체
// 					$("#resultArea").html(JSON.stringify(data)); // {"id":"admin","name":"관리자","age":0}
// 					$("#resultArea").append("<br>타입 : " + typeof(JSON.stringify(data))); // string
					// --------------------------------------------------------------------
					// JSON 데이터를 객체 형태(중괄호{})로 접근할 경우 
					// 해당 객체 내의 속성들이 변수 역할을 수행하므로
					// AJAX 를 통해 리턴받은 객체가 저장된 변수 data 를 통해 id, name, age 속성에 접근
					// => 객체명.속성명 형태로 접근(e.g. data.id)
// 					$("#resultArea").html(data.id + ", " + data.name + ", " + data.age);
					
					// 테이블에 해당 데이터 출력하기 위해 테이블 생성
					$("#resultArea").html("<table border='1'><tr><th>아이디</th><th>이름</th><th>나이</th></tr></table>");
					// 생성된 테이블 내의 마지막 요소로 1개 행 삽입하여 데이터 출력
					$("#resultArea > table").append(
						"<tr>"
						+ "<td>" + data.id + "</td>"
						+ "<td>" + data.name + "</td>"
						+ "<td>" + data.age + "</td>"
						+ "</tr>"
					);
					
				},
				error : function() {
					$("#resultArea").html("AJAX 요청 실패!");
				}
			}); // ajax 요청 끝
			
			
			// =============================================================================================================
			// test3_json_data2.json 요청	
			$.ajax({
				type: "GET", // 단순 요청은 보통 겟. 포스트는 파라미터가 있거나 데이터를 입력해야하는 경우
				url: "test3_json_data2.json",
				dataType: "json", // 응답 데이터를 JSON 객체로 취급
				// => 객체로 취급되어 JSON을 사용하는 객체로 처리가 됨
				success: function(data) {
					// 테이블에 해당 데이터 출력하기 위해 테이블 생성
					$("#resultArea2").html("<table border='1'><tr><th>아이디</th><th>이름</th><th>나이</th><th>주소</th></tr></table>");
					// 생성된 테이블 내의 마지막 요소로 1개 행 삽입하여 데이터 출력
					$("#resultArea2 > table").append(
						"<tr>"
						+ "<td>" + data.id + "</td>"
						+ "<td>" + data.name + "</td>"
						+ "<td>" + data.age + "</td>"
						// JSON 객체 내에 또 다른 객체가 포함되어 있을 경우
						// 객체명1.객체명2.속성명 형태로 접근
// 						+ "<td>" + data.address + "</td>" // 속성명 없고 객체명만 지정 시 [object Object] 출력됨
						+ "<td>" + data.address.address1 + ", " + data.address.address2 + "</td>"
						+ "</tr>"
					);
						
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
	<h1>AJAX - test3_json.jsp</h1>
	<input type="button" value="JSON 데이터 파싱" id="btnOk">
	<hr>
	<div id="resultArea"></div>
	<hr>
	<div id="resultArea2"></div>
</body>
</html>










