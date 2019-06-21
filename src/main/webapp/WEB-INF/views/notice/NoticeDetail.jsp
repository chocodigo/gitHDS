<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../common/bootstrap.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Notice detail</title>
<script type="text/javascript" src="/resources/vendor/jquery/jquery-1.9.1.min.js"></script>
</head>
<body>
<script type="text/javascript">
/***************************************************************************************************
 * # Program: 	NoticeDetail.jsp 공지사항 상세 내용페이지
 * 
 * # Modification Information
 * -------------------------------------------------------------------------------------------------
 *   Date			Modifier	Comment
 * -------------------------------------------------------------------------------------------------
 *   2019.05.28		최해림		Initial Created.
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
 
</script>

<div class="container" style="width: 100%; margin-top: 90px;">
	<div style="margin-bottom: 10px;">
		<div class="mdl-card__title" style="height:60px;">
			<img class="main-image" src="${contextPath}/resources/images/megaphone.png" >
			<h2 class="mdl-card__title-text" style="display: inline-block;">공지사항</h2>
		</div>
	</div>
	<div class="mdl-card__supporting-text" style="width: 100%;">
		<table class="mdl-data-table mdl-js-data-table mdl-shadow--2dp">
			<thead>
				<tr align = "center">
					<th class="mdl-data-table__cell--non-numeric" width="10%" style="vertical-align: middle;">순번</th>
					<td class="mdl-data-table__cell--non-numeric">${detail.idxx_numb}</td>
					<th class="mdl-data-table__cell--non-numeric" width="10%" style="vertical-align: middle;">작성자</th>
					<td class="mdl-data-table__cell--non-numeric">${detail.user_name}</td>
				</tr>
				<tr align = "center">
					<th class="mdl-data-table__cell--non-numeric" width="10%" style="vertical-align: middle;">제목</th>
					<td class="mdl-data-table__cell--non-numeric">${detail.titl_name}</td>
					<th class="mdl-data-table__cell--non-numeric" width="10%" style="vertical-align: middle;">작성일</th>
					<td class="mdl-data-table__cell--non-numeric"><fmt:formatDate pattern="yyyy-MM-dd" value="${detail.crea_date}"/></td>
				</tr>
				<tr align = "center">
					<th class="mdl-data-table__cell--non-numeric" width="10%" style="vertical-align : middle; height: 300px;">내용</th>
					<td class="mdl-data-table__cell--non-numeric" colspan="3" style="vertical-align: top; white-space:pre;">${detail.cont_ents}</td>
				</tr>
				<tr align = "center">
					<th class="mdl-data-table__cell--non-numeric" width="10%" style="vertical-align: middle;">첨부파일</th>
					<td class="mdl-data-table__cell--non-numeric" colspan="3"><a href="/fileDown/${files.idxx_numb}">${files.file_orig}</a></td>
				</tr>
				
				<c:forTokens var="token" items="${files.file_orig }" delims="." varStatus="status">
					<c:if test="${status.last }">
						<c:choose>
							<c:when test="${token eq 'png' || token eq 'jpg' || token eq 'jpeg' || token eq 'gif' || token eq 'bmp'}">
								<tr class="detail_th">
									<th class="mdl-data-table__cell--non-numeric" width="10%" style="vertical-align: middle;">첨부파일 이미지</th>
									<td class="mdl-data-table__cell--non-numeric" colspan="3">
										<img class="file_img" src="/resources/upload/${files.file_name}">
										
									</td>
								</tr>
							</c:when>
						</c:choose>
					</c:if>
				</c:forTokens>
			</thead>
		</table>
		<div class="detail_btn_group" style="display: center;">
			<sec:authorize access="hasAuthority('001')">
				<button class="mdl-button mdl-js-button" onclick="location.href='/notice_update/${detail.idxx_numb}'">수정</button>
				<button class="mdl-button mdl-js-button" onclick="location.href='/notice_delete/${detail.idxx_numb}'">삭제</button>
			</sec:authorize>
			<button class="mdl-button mdl-js-button" onclick="location.href='/notice_list'">목록</button>
		</div>
	</div>
</div>

</body>
</html>