<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- 다음 주소검색 API 사용을 위한 라이브러리 추가 -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
	window.onload = function() {
		let isSamePasswd = false; // 패스워드 일치 여부 저장할 변수
		
		// 1. ID 중복확인 버튼 클릭 시 새 창(check_id.html) 띄우기
// 		document.querySelector("#btnCheckId").onclick = function() {
// 			window.open("check_id.html", "id_check", "width=300,height=300");
// 		};
		
		// 2. 아이디 입력란에서 커서가 빠져나갈 때 아이디 길이 체크하기 => blur
// 		document.joinForm.id.onblur = function() {
// 			let id = document.joinForm.id.value; // 입력받은 아이디값 저장
			
// 			// 입력된 ID 텍스트의 길이가 4 ~ 8글자 사이일 경우 
// 			// 우측 빈공간(span 태그 영역)에 "사용 가능" 초록색으로 표시
// 		    // 아니면, "4~8글자만 사용 가능합니다" 빨간색으로 표시
// 		    if(id.length >= 4 && id.length <= 8) {
// 		     	document.querySelector("#checkIdResult").innerText = "사용 가능";
// 		     	document.querySelector("#checkIdResult").style.color = "green";
// 		    } else {
// 		     	document.querySelector("#checkIdResult").innerText = "4~8글자만 사용 가능합니다";
// 		     	document.querySelector("#checkIdResult").style.color = "red";
// 		    }
// 		};
		
		// 3. 비밀번호 입력란에 키를 누를때마다 비밀번호 길이 체크하기 = keyup
		document.joinForm.passwd.onkeyup = function() {
			let passwd = document.joinForm.passwd.value;
			
			// 비밀번호 길이 체크를 통해 8 ~ 16글자 사이이면 "사용 가능한 패스워드"(파란색) 표시,
			// 아니면, "사용 불가능한 패스워드"(빨간색) 표시
		    if(passwd.length >= 8 && passwd.length <= 16) {
		     	document.querySelector("#checkPasswdResult").innerText = "사용 가능한 패스워드";
		     	document.querySelector("#checkPasswdResult").style.color = "blue";
		    } else {
		     	document.querySelector("#checkPasswdResult").innerText = "사용 불가능한 패스워드";
		     	document.querySelector("#checkPasswdResult").style.color = "red";
		    }
			
		};
		
		// 4. 비밀번호확인 입력란에 키를 누를때마다 비밀번호와 같은지 체크하기
		document.joinForm.passwd2.onkeyup = function() {
			let passwd = document.joinForm.passwd.value;
			let passwd2 = document.joinForm.passwd2.value;
			
			// 비밀번호와 비밀번호확인 입력 내용이 같으면 "비밀번호 일치"(파란색) 표시,
   			// 아니면, "비밀번호 불일치"(빨간색) 표시
		    if(passwd == passwd2) { // 일치
		     	document.querySelector("#checkPasswd2Result").innerText = "비밀번호 일치";
		     	document.querySelector("#checkPasswd2Result").style.color = "blue";
		     	// 일치 여부를 저장하는 변수 isSamePasswd 값을 true 로 변경
		     	isSamePasswd = true;
		    } else { // 불일치
		     	document.querySelector("#checkPasswd2Result").innerText = "비밀번호 불일치";
		     	document.querySelector("#checkPasswd2Result").style.color = "red";
		     	// 일치 여부를 저장하는 변수 isSamePasswd 값을 true 로 변경
		     	isSamePasswd = false;
		    }
			
		};
		
		// 5. 주민번호 숫자 입력할때마다 길이 체크하기
		// => 주민번호 앞자리 입력란에 입력된 숫자가 6자리이면 뒷자리 입력란으로 커서 이동시키기
		// => 주민번호 뒷자리 입력란에 입력된 숫자가 7자리이면 뒷자리 입력란에서 커서 제거하기
		document.joinForm.jumin1.onkeyup = function() {
		    if(document.joinForm.jumin1.value.length == 6) {
		    	document.joinForm.jumin2.focus();
		    }
		};
		
		document.joinForm.jumin2.onkeyup = function() {
		    if(document.joinForm.jumin2.value.length == 7) {
		    	document.joinForm.jumin2.blur();
		    }
		};
		
		// 6. 이메일 도메인 선택 셀렉트 박스 항목 변경 시 = change
		//    선택된 셀렉트 박스 값을 이메일 두번째 항목(@ 기호 뒤)에 표시하기
		document.joinForm.emailDomain.onchange = function() {
			document.joinForm.email2.value = document.joinForm.emailDomain.value;
			
			// 단, 직접입력 선택 시 표시된 도메인 삭제하기
		    // 또한, "직접입력" 항목 외의 도메인 선택 시 도메인 입력창을 잠금처리 및 회색으로 변경하고,
		    // "직접입력" 항목 선택 시 도메인 입력창에 커서 요청 및 잠금 해제
		    if(document.joinForm.emailDomain.value == "") { // 직접 입력 선택 시
		    	document.joinForm.email2.focus(); // 포커스 요청
		    	document.joinForm.email2.readOnly = false; // 입력창 잠금 해제(readonly 아님!)
		    	document.joinForm.email2.style.background = "";
		    } else { // 도메인 선택 시
		    	document.joinForm.email2.readOnly = true; // 입력창 잠금 해제
		    	document.joinForm.email2.style.background = "lightgray";
		    }
		};
		
		// 7. 취미의 "전체선택" 체크박스 체크 시 취미 항목 모두 체크, 
		//    "전체선택" 해제 시 취미 항목 모두 체크 해제하기
		document.querySelector("#checkAllHobby").onclick = function() {
// 			document.joinForm.hobby[0].checked = document.querySelector("#checkAllHobby").checked;
// 			document.joinForm.hobby[1].checked = document.querySelector("#checkAllHobby").checked;
// 			document.joinForm.hobby[2].checked = document.querySelector("#checkAllHobby").checked;
		
			for(let i = 0; i < document.joinForm.hobby.length; i++) {
				document.joinForm.hobby[i].checked = document.querySelector("#checkAllHobby").checked;
			}
		};
		
		// 8. 가입(submit) 클릭 시 이벤트 처리를 통해
	    // 이름, 아이디, 비밀번호, 비밀번호확인, 주민번호, Email, 직업, 성별, 취미, 가입동기 항목을
	    // 모두 입력했는지 체크하고 모든 항목이 입력되었을 경우에만 submit 동작이 수행되도록 처리
		document.joinForm.onsubmit = function() {
			if(document.joinForm.name.value == "") {
				alert("이름 입력 필수!");
				document.joinForm.name.focus();
				return false; // submit 동작 취소
			} else if(document.joinForm.id.value == "") {
				alert("아이디 입력 필수!");
				document.joinForm.id.focus();
				return false; // submit 동작 취소
			} else if(document.joinForm.passwd.value == "") {
				alert("패스워드 입력 필수!");
				document.joinForm.passwd.focus();
				return false; // submit 동작 취소
			} else if(document.joinForm.passwd2.value == "") {
				alert("패스워드 확인 입력 필수!");
				document.joinForm.passwd2.focus();
				return false; // submit 동작 취소
// 			} else if(document.joinForm.passwd2.value != document.joinForm.passwd.value) {
// 				alert("패스워드 불일치!");
// 				document.joinForm.passwd2.focus();
// 				return false; // submit 동작 취소
			} else if(!isSamePasswd) { // 일치 여부 저장 변수 isSamePasswd 값 활용
				alert("패스워드 불일치!");
				document.joinForm.passwd2.focus();
				return false; // submit 동작 취소
			} else if(document.joinForm.jumin1.value == "") {
				alert("주민번호 입력 필수!");
				document.joinForm.jumin1.focus();
				return false; // submit 동작 취소
			} else if(document.joinForm.jumin2.value == "") {
				alert("주민번호 입력 필수!");
				document.joinForm.jumin2.focus();
				return false; // submit 동작 취소
			} else if(document.joinForm.email1.value == "") {
				alert("이메일 주소 입력 필수!");
				document.joinForm.email1.focus();
				return false; // submit 동작 취소
			} else if(document.joinForm.email2.value == "") {
				alert("이메일 주소 입력 필수!");
				document.joinForm.email2.focus();
				return false; // submit 동작 취소
			} else if(document.joinForm.job.value == "") {
				alert("직업 선택 필수!");
				document.joinForm.job.focus();
				return false; // submit 동작 취소
			} else if(document.joinForm.gender.value == "") {
				alert("성별 선택 필수!");
				return false; // submit 동작 취소
			} else if(!document.joinForm.hobby[0].checked && !document.joinForm.hobby[1].checked && !document.joinForm.hobby[2].checked) {
				// 취미는 모든 체크박스 체크상태가 false 일 때 체크 요청 메세지 출력
				alert("취미 선택 필수!");
				return false; // submit 동작 취소
			} else if(document.joinForm.motivation.value == "") {
				alert("가입동기 입력 필수!");
				document.joinForm.motivation.focus();
				return false; // submit 동작 취소
			}
			
			return true; // submit 동작 수행(생략 가능)
		};
		
		// =====================================================================
		// 주소 검색 API 활용 기능 추가
		// "t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js" 스크립트 파일 로딩 필수!
		document.querySelector("#btnSearchAddress").onclick = function() {
			new daum.Postcode({
				// 주소검색 창에서 주소 검색 후 검색된 주소를 클릭하면
				// oncomplete: 뒤의 익명함수가 실행(호출)됨 => callback(콜백) 함수라고 함
		        oncomplete: function(data) {
		        	// 클릭(선택)된 주소에 대한 정보(객체)가 익명함수 파라미터 data 에 전달됨
					// => data.xxx 형식으로 각 주소 정보에 접근
					// 1) 우편번호(zonecode) 가져와서 우편번호 항목(postCode)에 출력
					document.joinForm.postCode.value = data.zonecode; 
					
					// 2) 기본주소(address) 가져와서 기본주소 항목(address1)에 출력
// 					document.joinForm.address1.value = data.address;
					let address = data.address;
					
					// 만약, 건물명(buildingName)이 존재(널스트링이 아님)할 경우
					// 기본주소 뒤에 건물명을 결합
					if(data.buildingName != "") {
						address += " (" + data.buildingName + ")";
					}
					
					document.joinForm.address1.value = address;
					
					// 3) 상세주소 항목(address2)에 포커스(커서) 요청
					document.joinForm.address2.focus();
		        }
		    }).open();
		};
		
	}; // window.onload 이벤트 끝
</script>
<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.js"></script>
<script type="text/javascript">
	$(function() {
		// 아이디 입력란에서 포커스가 해제될 때(커서가 빠져나갈 때)의 이벤트 처리 = blur
		$("#id").on("blur", function() {
			// 입력받은 아이디 가져오기
			let id = $("#id").val();
			
			// 입력된 아이디가 없을 경우(= 널스트링) 
			// "checkIdResult" 영역에 "아이디 입력 필수!" 메세지 출력(빨간색) 후 함수 종료
			if(id == "") {
				$("#checkIdResult").text("아이디 입력 필수!").css("color", "red");
	// 			$("#checkIdResult").css("color", "red");
				return;				
			}
			
			// AJAX 를 활용하여 "test2_check_id2.jsp" 페이지 요청을 통해
			// 아이디 중복 검사 작업 수행 후 결과값을 리턴받아 처리
			// => 아이디 파라미터 전달
			$.ajax({
				// type 속성 생략 시 기본값 "get"
				url: "test2_check_id2.jsp",
				data: {
					id: id // id 변수값 전달
					// 자바스크립트 변수명 그대로 지정(파라미터명 : 데이터 형식으로 지정)
					// 변수 없을 시 id: $("#id").val()
				},
				success: function(result) {
// 					alert(">" + result + "<"); // jsp 파일의 라인을 다 공백으로 취급하는걸 확인
	
					// 처리 페이지에서 아이디 중복 검사 비즈니스 로직 처리 성공 후
					// "true" 또는 "false" 값 리턴 
					// => 자바에서 출력된 데이터지만, 웹 페이지에서는 단순 문자로 취급(boolean 타입 아님!)
					// 리턴받은 결과값에 대해 판별 수행
					// => "true" 일 경우 checkIdResult 영역에 "이미 사용중인 아이디" 출력(빨간색) 
					// => "false" 일 경우 checkIdResult 영역에 "사용 가능한 아이디" 출력(파란색)
					// => 주의! 리턴받은 값을 문자열로만 판별해야할 경우
					//    test2_check_id2.jsp 파일의 코드 라인을 다 공백으로 취급하므로
					//    문자열 앞 뒤의 공백 제거를 위해 trim() 메서드 사용 권장
					if(result.trim() == "true") { // 문자열 비교 필수! 문자열 앞뒤 공백 제거
						alert("true");
						$("#checkIdResult").text("이미 사용중인 아이디").css("color", "red");
					} else if(result.trim() == "false") {
						alert("false");
						$("#checkIdResult").text("사용 가능한 아이디").css("color", "blue");
					}
				}
				// 에러 시 아무 작업도 하지 않을 경우 error 속성 생략 가능

			});

		});
	});
	
	function checkId() {
		// ID 중복확인 버튼 클릭 시 새 창(check_id.html) 띄우기
		window.open("test2_check_id.jsp?id=" + $("#id").val(), "id_check", "width=300,height=300");
	}
</script>
</head>
<body>	
	<div align="center">
		<h1>회원 가입</h1>
		<form action="request3Pro.jsp" method="post" name="joinForm">
			<table border="1">
				<tr>
					<th>이름</th>
					<td><input type="text" name="name"></td>
				</tr>
				<tr>
					<th>아이디</th>
					<td>
						<input type="text" name="id" id="id" placeholder="4 ~ 8글자 사이 입력">
<!-- 						<input type="button" value="ID중복확인" onclick="checkId()"> -->
						<input type="button" value="ID중복확인" id="btnCheckId" onclick="checkId()">
						<span id="checkIdResult"></span>
					</td>
				</tr>
				<tr>
					<th>비밀번호</th>
					<td>
						<input type="password" name="passwd" placeholder="8 ~ 16글자 사이 입력">
						<span id="checkPasswdResult"></span>
					</td>
				</tr>
				<tr>
					<th>비밀번호확인</th>
					<td>
						<input type="password" name="passwd2">
						<span id="checkPasswd2Result"></span>
					</td>
				</tr>
				<tr>
					<th>주민번호</th>
					<td>
						<!-- 입력 문자 갯수 제한 시 maxLength 속성 지정 -->
						<input type="text" name="jumin1" size="8" maxlength="6"> -
						<input type="text" name="jumin2" size="8" maxlength="7">
					</td>
				</tr>
				<tr>
					<th>주소</th>
					<td>
						<input type="text" name="postCode" id="postCode" size="6">
						<input type="button" id="btnSearchAddress" value="주소검색">
						<br>
						<input type="text" name="address1" id="address1" size="25" placeholder="기본주소">
						<br>
						<input type="text" name="address2" id="address2" size="25" placeholder="상세주소">
					</td>
				</tr>
				<tr>
					<th>E-Mail</th>
					<td>
						<input type="text" name="email1" size="8"> @
						<input type="text" name="email2" size="8">
						<select name="emailDomain">
							<option value="">직접입력</option>
							<option value="naver.com">naver.com</option>
							<option value="gmail.com">gmail.com</option>
							<option value="nate.com">nate.com</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>직업</th>
					<td>
						<select name="job">
							<option value="">항목을 선택하세요</option>
							<option value="개발자">개발자</option>
							<option value="DB엔지니어">DB엔지니어</option>
							<option value="서버엔지니어">서버엔지니어</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>성별</th>
					<td>
						<input type="radio" name="gender" value="남">남
						<input type="radio" name="gender" value="여">여
					</td>
				</tr>
				<tr>
					<th>취미</th>
					<td>
						<input type="checkbox" name="hobby" value="여행">여행
						<input type="checkbox" name="hobby" value="독서">독서
						<input type="checkbox" name="hobby" value="게임">게임
						<input type="checkbox" id="checkAllHobby" value="전체선택">전체선택
					</td>
				</tr>
				<tr>
					<th>가입동기</th>
					<td>
						<textarea rows="5" cols="40" name="motivation"></textarea>
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<input type="submit" value="가입">
						<input type="reset" value="초기화">
						<input type="button" value="돌아가기">
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>















