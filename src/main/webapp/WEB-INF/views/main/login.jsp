<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="<%= request.getContextPath()%>"></c:set>

<!DOCTYPE html>
<html lang="en">
<head>
	<title>Login</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" type="text/css" href="${contextPath}/resources/fonts/font-awesome-4.7.0/css/font-awesome.min.css">
	<link rel="stylesheet" type="text/css" href="${contextPath}/resources/fonts/Linearicons-Free-v1.0.0/icon-font.min.css">
	<link rel="stylesheet" type="text/css" href="${contextPath}/resources/css/login_util.css">
	<link rel="stylesheet" type="text/css" href="${contextPath}/resources/css/login.css">
	<script type="text/javascript" src="/resources/vendor/jquery/jquery-1.9.1.min.js"></script>
	<script type="text/javascript" src="/resources/script/common.js"></script>
</head>
<body>
<script type="text/javascript">
/***************************************************************************************************
 * # Program: 	Login.jsp 최초 로그인 페이지 생성
 * 
 * # Modification Information
 * -------------------------------------------------------------------------------------------------
 *   Date			Modifier	Comment
 * -------------------------------------------------------------------------------------------------
 *   2019.05.21		최해림		Initial Created.
 *   
 * -------------------------------------------------------------------------------------------------
 * Copyright 2019-2019 By SM Entertainment Co,Ltd. All rights reserved.
 ****************************************************************************************************
 *   Form Common Script
 *      1) 공통 스크립트 위치 및 명칭은 수정 불가 입니다. 
 *      2) 각 함수에서 필요한 부분의 소스를 수정 하세요.  
 *      3) 해당 프로그램의 기능이 없는 경우 해당 함수의 이름만 놓고 공백 처리  
 *
 *  ★ 위 사항의 변경이 있거나 추가 사항이 있을 경우 반드시 개발 PL과 상의 후 수정 요망
 *     현재 총 100 컬럼임 되도록 100 컬럼 안으로 코딩을 하세요                         
 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 1234567890
 ********************************************************************************SMTOWN*CO*KR********/
 /************************
 *  공통 Script Include  *
 ************************/
 
 
 
 /*-----------------------------------+
 |  01.최초 화면 Load時 처리 할 사항  |
 +------------------------------------*/
 $(document).ready(function(){
	 
	 $('#loginButton').click(function(){
		login();
	 });
	 
	 //iD 또는 패스워드가 다를 경우 
	 <c:if test="${param.error != null}">
		loginFail();
	</c:if>
	 

 });
 
 
 /*----------------------+
 |  02.로그인 이벤트 처리 	 |
 +-----------------------*/
 function login(){
	/* 
		필수 입력사항 처리
	*/
	var USER_NAME = $("#USER_NAME").val();
    var PASS_WORD = $("#PASS_WORD").val();
    
    if(USER_NAME == "" || PASS_WORD == "" ){
        alert('아이디 또는 패스워드를 입력하지 않으셨습니다.');
        $("#USER_NAME").focus();
        return false;
    }
    
	$('#login_form').submit(); 		
}
 
 /*----------------------+
 |  02.로그인 이벤트 처리 	 |
 +-----------------------*/
 
 function loginFail(){
	 alert('아이디 또는 패스워드를 다시 확인하세요.');
	 return false;
 }
 
 
 /*----------------------+
 |  로그인 페이지 Enter 처리  	 |
 +-----------------------*/
 function meEnter(){
	 var keyCode = event.keyCode;	//User, password input 박스에서 발생한 키 코드를 불러온다. 

	 //Enter 키 처리시 로그인 이벤트 발생 
	if(keyCode == 13){
		login();
	}
	 
 }
 
 
</script>
	<div class="limiter">
		<div class="container-login100">
			<div class="wrap-login100 p-t-50 p-b-90">
				<c:url value="/login" var="loginUrl"/>
				<form id="login_form" action="${loginUrl}" method="post" class="login100-form validate-form flex-sb flex-w">
				
					<span class="login100-form-title p-b-51">
						<img class="hds-logo-image" src="${contextPath}/resources/images/SM_logo.png">
					</span>

					<%-- 
					<c:if test="${param.logout != null}">
						<p> You have been logged out. </p>
					</c:if> --%>
					
					<div class="wrap-input100 validate-input m-b-16">
						<input class="input100" type="text" id="USER_NAME" name="USER_NAME" placeholder="ID" onkeyup="javascript:meEnter();">
						<span class="focus-input100"></span>
					</div>
					
					
					<div class="wrap-input100 validate-input m-b-16">
						<input class="input100" type="password" id="PASS_WORD" name="PASS_WORD" placeholder="Password" onkeyup="javascript:meEnter();">
						<span class="focus-input100"></span>
					</div>
					
					<div class="flex-sb-m w-full p-t-3 p-b-24">
						<div class="contact100-form-checkbox">
							<input class="input-checkbox100" id="remember-me" type="checkbox" name="remember-me">
							<label class="label-checkbox100" for="remember-me">
								Remember me
							</label>
						</div>
						
						<div>
							<a href="/forgot" class="txt1">
								비밀번호 재설정
							</a>
						</div>
						

					</div>
					<!-- csrf : 웹 사이트의 취약점을 이용하여 이용자가 의도하지 않은 요청을 통한 공격  -->
					<!-- 해결책 : CSRF Token 정보를 Header 정보에 포함하여 서버 요청을 시도함 -->
					
					<input type="hidden" name="${_csrf.parameterName}" value = "${_csrf.token}"/>

					<div class="container-login100-form-btn m-t-17">
						
						<a href="javascript:login();" class="login100-form-btn" style="text-decoration: none;">로그인</a>
					</div>
					
					<div class="div_email">
						
						<br><br><img class="e-mail-image" src="${contextPath}/resources/images/email.png">
						<br>문제상황 발생 시 <br>cocoa1149@smtown.com으로 연락바랍니다.
					</div>
				</form>
			</div>
		</div>
	</div>
</body>
</html>