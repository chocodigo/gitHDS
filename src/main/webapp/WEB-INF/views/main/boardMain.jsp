<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/bootstrap.jsp" %>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<title></title>
<meta charset="UTF-8">
<script type="text/javascript" src="/resources/vendor/jquery/jquery-1.9.1.min.js"></script>
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
	getCookie();							//쿠키 상태를 통해 팝업 출력
 });
 
 /*-----------------------------------+
 |  02.일주일동안 열지 않음 처리  |
 +------------------------------------*/
 function week_close(){
	 
	 setCookie("todayCookie","done", 7);	//파라미터: 쿠키 이름, 7일 경과시 done, 7일동안 열지 않기
	 										//7일간 열지 않음 설정
	 $("#howto_popup").css("display","none");	//팝업 사라짐
 }
 
 /*-----------------------------------+
 |  03. 7일간 열지 않음 설정 |
 +------------------------------------*/
 function setCookie(name, value, expiredays){	//파라미터: 쿠키 이름, 7일 경과시 done, 7일동안 열지 않기

	var today = new Date();						//오늘 날짜
 	today.setDate(today.getDate()+expiredays);	//팝업을 다시 띄울 날짜 설정
 	document.cookie = name + "=" + escape(value) + "; path:/; expires=" + today.toGMTString() + ";";	//todayCookie 설정
 	
 }	
 
 /*-----------------------------------+
 |  04. todayCookie를 통해 받아와서 팝업 유무 설정 |
 +------------------------------------*/
 function getCookie(){
	 var cookiedata = document.cookie;
	 if(cookiedata.indexOf("todayCookie=done")<0){	//todayCookie가 설정돼있지 않으면 팝업 출력
		 $("#howto_popup").css("display","block");
	 }else{
		 $("#howto_popup").css("display","none");	//todayCookie가 설정돼있으면 팝업 사라짐
	 }
 }
 
 /*-----------------------------------+
 |  05. 검색 버튼 클릭 시 진행 |
 +------------------------------------*/
 function search(){
	 location.href="/list?search="+$("#search_box").val();		//검색 창에 있는 값으로 검색
 }
 
 /*----------------------+
 |  06. 검색 Enter 처리  	 |
 +-----------------------*/
 function meEnter(){
	 var keyCode = event.keyCode;	//검색 input 박스에서 발생한 키 코드를 불러온다. 

	 //Enter 키 처리시 검색 이벤트 발생 
	if(keyCode == 13){
		search();
	}
	 
 }
</script>

<!-- 진행과정 안내 팝업 -->
<div id="howto_popup" class="white_content">
	<%@ include file="/WEB-INF/views/main/howToUse.jsp" %>
	<a href="javascript: week_close();" style="text-decoration: none;">일주일 동안 열지 않음</a>
</div>

<!-- 검색창 -->
<div class="container" style="width: 100%; margin-top: 100px;">

	<div class="mdl-color--white mdl-shadow--2dp mdl-cell mdl-cell--12-col mdl-grid">
		<div class="mdl-card__title" style="width: 100%;">
			<input id="search_box" type="text" placeholder="질문을 입력하세요." style="border: 0; width:99%; font-size: 18px;" onkeyup="javascript:meEnter();">
			<img height="50" class="main-image" src="${contextPath}/resources/images/search.png" onclick="search();" style="cursor: pointer;">
		</div>
	</div>
</div>

<!-- 공지사항 -->
<div class="container" style="width: 60%; display: inline-block">

	<div class="mdl-color--white mdl-shadow--2dp mdl-cell mdl-cell--12-col mdl-grid">

		  <div class="mdl-card__title">
		  	<img class="main-image" src="${contextPath}/resources/images/megaphone.png">
		    <h2 class="mdl-card__title-text" style="display: inline-block;">공지사항</h2>
		  </div>
		  <div class="mdl-card__supporting-text" style="width: 100%">
		  	<table class="mdl-data-table mdl-js-data-table mdl-shadow--2dp" >
				<thead>
					<tr align="center">
						<th class="mdl-data-table__cell--non-numeric" width="40%">제목</th>
						<th class="mdl-data-table__cell--non-numeric" width="10%">이름</th>
						<th class="mdl-data-table__cell--non-numeric" width="10%">입력일자</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="item" items="${list}">
						<tr align="center">
							<td class="mdl-data-table__cell--non-numeric"><a
								class="boardlist_title" style="color: #223055;"
								href='<c:url value="/notice_detail/${item.idxx_numb}"/>'>${item.titl_name}</a></td>
							<td class="mdl-data-table__cell--non-numeric">${item.user_name}</td>
							<td class="mdl-data-table__cell--non-numeric"><fmt:formatDate
									pattern="yyyy-MM-dd" value="${item.crea_date}" /></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		  </div>
		  <div class="mdl-card__actions mdl-card--border" >
		    <a class="mdl-button mdl-button--colored mdl-js-button mdl-js-ripple-effect" style="float:right; text-decoration:none;" href="/notice_list">
		      MORE
		    </a>
		  </div>

	</div>
</div>

<!-- FAQ -->
<div class="container" style="width: 40%; display: inline-block; float: right;">

	<div class="mdl-color--white mdl-shadow--2dp mdl-cell mdl-cell--12-col mdl-grid">

		  <div class="mdl-card__title">
		  	<img class="main-image" src="${contextPath}/resources/images/faq.png">
		    <h2 class="mdl-card__title-text" style="display: inline-block;">자주묻는질문</h2>
		  </div>
		  <div class="mdl-card__supporting-text" style="width: 100%">
		  	<table class="mdl-data-table mdl-js-data-table mdl-shadow--2dp" >
				<thead>
					<tr align="center">
						<th class="mdl-data-table__cell--non-numeric" width="30%">제목</th>
						<th class="mdl-data-table__cell--non-numeric" width="10%">입력일자</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="item" items="${faq_list}">
						<tr align="center">
							<td class="mdl-data-table__cell--non-numeric"><a
								class="boardlist_title" style="color: #223055;"
								href='<c:url value="/faq_detail/${item.idxx_numb}"/>'>${item.titl_name}</a></td>
							<td class="mdl-data-table__cell--non-numeric"><fmt:formatDate
									pattern="yyyy-MM-dd" value="${item.crea_date}" /></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		  </div>
		  <div class="mdl-card__actions mdl-card--border" >
		    <a class="mdl-button mdl-button--colored mdl-js-button mdl-js-ripple-effect" style="float:right; text-decoration:none;" href="/faq_list">
		      MORE
		    </a>
		  </div>

	</div>
</div>

<%@ include file="/WEB-INF/views/include/footer.jsp" %>       
</body>

</html>