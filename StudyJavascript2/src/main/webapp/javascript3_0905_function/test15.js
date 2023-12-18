/**
 * 함수를 갖는 외부 자바스크립트 파일
 */
// 3. 전달인자만 있고, 리턴값은 없는 함수 정의
// 외부로부터 문자열 1개를 전달받아 해당 문자열을 출력하는 showMessage() 함수 정의
// => 전달받을 문자열을 저장하는 매개변수 msg 기술
function showMessage(msg) {
	document.write(msg + "<br>"); // 전달받은 문자열 출력
}