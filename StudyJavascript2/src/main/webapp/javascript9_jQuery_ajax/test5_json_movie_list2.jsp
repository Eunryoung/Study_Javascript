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
		$("#btnOk").on("click", function() { // 이 줄 코드 생략 시 화면 뜨자마자 ajax 불러옴
			/*
			영화진흥위원회 오픈API 를 활용하여 영화 정보 JSON 데이터 처리
			https://www.kobis.or.kr/kobisopenapi/homepg/main/main.do
			-------------------------------------------------------------
			일별 박스오피스 목록 조회 후 테이블에 표시
			https://www.kobis.or.kr/kobisopenapi/homepg/apiservice/searchServiceInfo.do?serviceId=searchDailyBoxOffice
			=> 지정된 요청 파라미터 형식에 맞게 URL 을 수정해야함
			
			샘플 API 요청 주소
			http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=f5eef3421c602c6cb7ea224104795888&targetDt=20231205
			=> 조회일자(targetDt)를 입력받아 원하는 일자의 박스오피스 조회로 변경
			----------------------------------------
			*/
			
			// ------------------------ 날짜 입력받아 포맷 변환하기 ---------------------------------------------
			let selectedDate = $("#date").val(); // 2023-12-11(yyyy-mm-dd)
// 			console.log("선택된 날짜 : " + selectedDate);
			
			// 만약, 날짜가 선택되지 않았을 경우 오류메세지 출력 후 함수 실행 종료
			if(selectedDate == "") {
				alert("날짜 선택 필수!");
				$("#date").focus();
				return;
			}

			// 전달받은 날짜 형식 : yyyy-MM-dd
			// 파라미터로 전달할 날짜 형식 : yyyyMMdd
			// => 따라서, 조회 대상 일자 형식에 맞는 날짜 형식으로 포맷 변환 필요
			//    (날짜 사이에 끼어있는 '-' 기호 제거)

			// 1) split() 메서드 활용해 "-" 기호를 기준으로 문자열 분리하여 결합
// 			let targetDt = selectedDate.split("-")[0] + selectedDate.split("-")[1] + selectedDate.split("-")[2];
			// => 0번 인덱스 연도, 1번 인덱스 월, 2번 인덱스 일이므로 3개 값을 결합
		

			// 2) replaceAll() 메서드를 호출하여 모든 대상 문자열을 치환
// 			let targetDt = selectedDate.replaceAll("-", ""); // 20231210

			// 3) replace() 메서드를 호출하여 대상 문자열 치환
			//    단, 기본적으로는 1개의 대상 문자열만 치환됨
// 			let targetDt = selectedDate.replace("-", ""); // 202312-10
// 			console.log("요청할 조회 대상일자 : " + targetDt);
			// => replace() 메서드의 기본 특징은 처음 만나는 대상 문자열만 치환됨
			//    따라서, 첫번째 "-" 기호만 ""으로 치환되어 202312-10 리턴됨
			// -------------------
			// 정규표현식을 활용하여 문자열 내의 모든 대상 문자열을 탐색하도록 해야한다!
			// 이 때, 모든 문자열을 대상으로 찾을 문자열을 지정하여 전체 적용하려면
			// 정규표현식에서 제공하는 플래그 활용 필요!
			// 참고) 정규표현식 플래그 종류
			//       1)/g(global) : 대상 문자열 내에서 패턴에 해당되는 모든 대상 지정
			//       2)/i(ignore case) : 대상 문자열을 대소문자 무시하고 지정
			//       3)/m(multi line) : 대상 문자열이 복수개의 라인일 경우 전체 라인 지정
			// 자바스크립트에서는 "/" 사이에 문자열을 넣으면 정규표현식으로 인식!
			// 마찬가지로 하나만 변환하면 함수가 끝이 나므로 플래그 /g를 조합해야한다
			let targetDt = selectedDate.replace(/-/g, "");
			console.log("요청할 조회 대상일자(regex) : " + targetDt);
			
			
			// -----------------------------------------------------------------------------------------------------
			
			let key: "f5eef3421c602c6cb7ea224104795888";
			$.ajax({
				type: "GET", // 생략 가능
				url: "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json",
				data: {
					key: key,
					targetDt: targetDt
				},
				dataType: "json", // 응답 데이터를 JSON 객체로 취급 
				success: function(data) {
					// 임시) #resultArea 영역에 응답 데이터 출력
// 					$("#resultArea").html(JSON.stringify(data)); // 단순 문자열
					// 단순 파싱
// 					$("#resultArea").html(data.boxOfficeResult.dailyBoxOfficeList[0].movieNm);
					// -------------------------------------------------------------------------------------------------------------------
					// 응답데이터(박스오피스 목록) 객체(data)로부터 박스오피스 정보 추출하기
					// => 전체데이터가 하나의 객체({})로 묶여있음
					// 1. 박스오피스 전체 데이터가 저장된 "boxOfficeResult" 객체 추출
					let boxOfficeResult = data.boxOfficeResult;
// 					console.log("boxOfficeResult : " + boxOfficeResult); // [object Object]
// 					console.log("boxOfficeResult : " + JSON.stringify(boxOfficeResult)); // 단순문자열로 변환
					// => 콘솔에 모든 객체의 문자열 다 출력됨
					
					// 2. 박스오피스 타입("boxofficeType")과 조회날짜범위("showRange") 추출
					// => 1번에서 추출한 boxOfficeResult 객체를 통해 접근
					let boxOfficeType = data.boxOfficeResult.boxofficeType;
					let showRange = data.boxOfficeResult.showRange;
					// 추출된 두 데이터는 객체가 아니므로 별도의 변환 불필요
// 					console.log("boxOfficeType : " + boxOfficeType + ", showRange : " + showRange);
					// 테이블 바깥쪽 상단부에 2번 추출 결과 출력할 경우 => prepend 또는 before
					$("#resultArea").prepend("<h3>" + boxOfficeType + "(" + showRange.split("~")[0] + ")</h3>"); // split() 으로 쪼개면 배열이 된다
					// => 쪼갠 결과를 date 객체만들면 날짜로 관리 가능
					
					// 3. 일별 박스오피스 목록("dailyBoxOfficeList") 추출
					// => 복수개의 영화정보 객체{} 가 dailyBoxOfficeList 라는 배열[] 로 관리됨
					// => 단, 배열 내의 데이터가 객체로 이루어져 있으므로 별도의 처리 추가 필요
					let dailyBoxOfficeList = boxOfficeResult.dailyBoxOfficeList;
// 					console.log("dailyBoxOfficeList : " + JSON.stringify(dailyBoxOfficeList));

					// 4. 추출된 박스오피스 목록(배열)을 반복문을 통해 차례대로 접근하여
					//    현재순위(rank), 제목(movieNm), 개봉일(openDt), 누적관객수(audiAcc)
					//    추출 후 테이블 내에 출력
					for(let movie of dailyBoxOfficeList) {
// 						$("#resultArea > table").append(
// 							"<tr>"
// 							+ "<td>" + movie.rank + "</td>"
// 							+ "<td>" + movie.movieNm + "</td>"
// 							+ "<td>" + movie.openDT + "</td>"
// 							+ "<td>" + movie.audiAcc + "</td>"
// 							+"</tr>"
// 						);
						// 추가사항) 상세정보 버튼 클릭 시 영화 상세정보 조회 페이지로 이동
						//	         파라미터로 영화코드(movieCd) 값 전달
// 						let url = "location.href='test6_jason_movie_detail.jsp?movieCd=" + movie.movieCd +"'";
						let movieCd = movie.movieCd;
						let url = "location.href=\"test6_jason_movie_detail.jsp?key=" + key + "&movieCd=" + movieCD + "\""; 
						// =>  큰 따옴표로 단순문자열 취급 처리해 따옴표가 겹치는걸 방지 
						$("#resultArea > table").append(
							"<tr>"
							+ "<td>" + movie.rank + "</td>"
							+ "<td>" + movie.movieNm + "</td>"
							+ "<td>" + movie.openDT + "</td>"
							+ "<td>" + movie.audiAcc + "</td>"
							+ "<td><button onclick='" + url + "'>상세정보</button></td>"
							+"</tr>"
						);
					}
					
				},
				error : function() {
					$("#resultArea").html("AJAX 요청 실패!");
				}
			}); // ajax 요청 끝
			
		});// 버튼 클릭 이벤트 끝
		
	}); // document.ready 이벤트 끝
</script>
</head>
<body>
	<h1>AJAX - test5_json_movie_list2.jsp</h1>
	<input type="date" id="date">
	<input type="button" value="일별 박스오피스 조회" id="btnOk">
	<hr>
	<div id="resultArea">
		<table border="1">
			<tr>
				<th width="80">현재순위</th>
				<th width="400">영화명</th>
				<th width="150">개봉일</th>
				<th width="100">누적관객수</th>
				<th></th>
			</tr> 
			<%-- 영화 정보 파싱 결과가 출력될 위치 --%>
		</table>
	</div>
	
	<hr>
	<div id="resultArea2"></div>
</body>
</html>










