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
 * # Program: 	forgot.jsp 비밀번호 초기화 페이지 
 * 
 * # Modification Information
 * -------------------------------------------------------------------------------------------------
 *   Date			Modifier	Comment
 * -------------------------------------------------------------------------------------------------
 *   2019.06.17		최해림		Initial Created.
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

 });
 
 /*----------------------+
 |  02.생일 인증 처리 	 |
 +-----------------------*/
 function permit(){

		/* 
		필수 입력사항 처리
		 */
		var USER_NAME = $("#USER_NAME").val();
		var BIRT_HDAY = $("#BIRT_HDAY").val();

		/* 
		입력하지 않았을 때 처리
		 */
		if (USER_NAME == "" || BIRT_HDAY == "") {
			alert('아이디 또는 생년원일을 입력하지 않으셨습니다.');
			$("#USER_NAME").focus();
			return false;
		}
		
		/* 
		전송할 데이터(ID, 생일)
		 */
		var data = {"user_name" : USER_NAME,
					"birt_hday" : BIRT_HDAY};
		
		ajaxJsonCallSync("/forgotProc", data, birthSuccessCallBack);	//ajax sync 통신
	}
 

 /*----------------------+
 |  03. 생일인증 success call back |
 +-----------------------*/
 function birthSuccessCallBack(data){
	 if(data.isItPermit == 1){
		 alert("인증 완료");
		 $("#div_password").css("display","block");
		 $("#div_confirm").css("display","block");
		 $("#reset_btn").css("display","flex");
		 $("#permit_btn").css("display","none");
	 }else{
		 alert("아이디나 생년월일이 잘못되었습니다.");
	 }
 }
 
 /*----------------------+
 |  04. 비밀번호 재설정 처리 |
 +-----------------------*/
 function resetPassword(){
	 
		/* 
		필수 입력사항 처리
		 */
		var USER_NAME = $("#USER_NAME").val();
		var PASS_WORD = $("#PASS_WORD").val();
		var CONF_PSWD = $("#CONF_PSWD").val();

		/* 
		입력하지 않았을 때 처리
		 */
		if (USER_NAME == ""  || PASS_WORD == "" || CONF_PSWD == "") {
			alert('입력하지 않은 값이 있습니다.');
			$("#USER_NAME").focus();
			return false;
		}

		//비밀번호 같은지 확인
		if(PASS_WORD === CONF_PSWD){
			/* 
			전송할 데이터(ID, 비밀번호, 비밀번호 확인)
			 */
			var data = {
				"user_name" : USER_NAME,
				"pass_word" : PASS_WORD,
			};
			ajaxJsonCallSync("/resetPWProc", data, resetSuccessCallBack); //ajax sync 통신
		}else{
			alert("비밀번호가 일치하지 않습니다.");
		}
		
	}
 
 /*----------------------+
 |  05. 비밀번호 재설정 SuccessCallback |
 +-----------------------*/
 
 function resetSuccessCallBack(data){
	 alert("변경 완료되었습니다.");
	 location.href="/login";
 }
</script>
	<div class="limiter">
		<div class="container-login100">
			<div class="wrap-login100 p-t-50 p-b-90">
				<span class="login100-form-title p-b-51"> <img
					class="hds-logo-image"
					src="${contextPath}/resources/images/SM_logo.png">
				</span>
				
				<!-- ID 입력칸 -->
				<div class="wrap-input100 validate-input m-b-16">
					<input class="input100" type="text" id="USER_NAME" name="USER_NAME"
						placeholder="ID를 입력해주세요" >
					<span class="focus-input100"></span>
				</div>

				<!-- 생년월일 입력칸 -->
				<div class="wrap-input100 validate-input m-b-16">
					<input class="input100" type="text" id="BIRT_HDAY" name="BIRT_HDAY"
						placeholder="생년월일 여섯자리를 입력해주세요">
					<span class="focus-input100"></span>
				</div>
				
				<!-- 비밀번호 변경 칸 -->
				<div id="div_password" class="wrap-input100 validate-input m-b-16" style="display: none;">
					<input class="input100" type="password"" id="PASS_WORD" name="PASS_WORD"
						placeholder="변경할 비밀번호">
					<span class="focus-input100"></span>
				</div>
				
				<!-- 비밀번호 확인 칸 -->
				<div id="div_confirm" class="wrap-input100 validate-input m-b-16" style="display: none;">
					<input class="input100" type="password" id="CONF_PSWD" name="CONF_PSWD"
						placeholder="비밀번호 확인" ">
					<span class="focus-input100"></span>
				</div>
				<!-- csrf : 웹 사이트의 취약점을 이용하여 이용자가 의도하지 않은 요청을 통한 공격  -->
				<!-- 해결책 : CSRF Token 정보를 Header 정보에 포함하여 서버 요청을 시도함 -->

				<input type="hidden" name="${_csrf.parameterName}"
					value="${_csrf.token}" />

				<div class="container-login100-form-btn m-t-17">

					<a id="permit_btn" href="javascript:permit();" class="login100-form-btn"
						style="text-decoration: none;">인증</a> 
					<a id="reset_btn" href="javascript:resetPassword();"
						class="login100-form-btn" style="text-decoration: none; display: none;">비밀번호 변경</a>

				</div>

			</div>
		</div>
	</div>
</body>
</html>