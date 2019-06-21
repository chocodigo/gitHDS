<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../common/bootstrap.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="/resources/vendor/jquery/jquery-1.9.1.min.js"></script>
<title>faq Update</title>
</head>
<body>
<script type="text/javascript">
/***************************************************************************************************
 * # Program: 	faqUpdate.jsp 공지사항 게시글 수정 및 업데이트 페이지
 * 
 * # Modification Information
 * -------------------------------------------------------------------------------------------------
 *   Date			Modifier	Comment
 * -------------------------------------------------------------------------------------------------
 *   2019.05.30		최해림		Initial Created.
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
	<div class="mdl-card__title" style="height:60px;">
		<img class="main-image" src="${contextPath}/resources/images/megaphone.png" >
		<h2 class="mdl-card__title-text" style="display: inline-block;">공지사항 수정</h2>
	</div>
	<div class="mdl-card__supporting-text" style="width: 100%; font-size: 12px;">
		<form class="form-group" action="/faq_updateProc" method="post" enctype="multipart/form-data">
			
			<table class="mdl-data-table mdl-js-data-table mdl-shadow--2dp" style="width: 100%;">
				<thead>
					<tr align = "center">
						<th class="mdl-data-table__cell--non-numeric" width="10%">제목</th>
						<td class="mdl-data-table__cell--non-numeric" width="90%">
							<input type="text" class="form-control" id="titl_name" name="titl_name" value="${detail.titl_name}">
						</td>
	
					</tr>
					<tr align = "center">
						<th class="mdl-data-table__cell--non-numeric" width="10%">작성자</th>
						<td class="mdl-data-table__cell--non-numeric"><sec:authentication property="principal.username"/></td>
		
					</tr>
					<tr align = "center">
						<th class="mdl-data-table__cell--non-numeric" width="10%" style="vertical-align : middle;">내용</th>
						<td class="mdl-data-table__cell--non-numeric">
							<textarea class="form-control" id="cont_ents" name="cont_ents" rows="10" style="resize: none;">${detail.cont_ents}</textarea>
						</td>
					</tr>
					<tr align = "center">
						<th class="mdl-data-table__cell--non-numeric" width="10%" style="vertical-align : middle;">파일 첨부</th>
						<td class="mdl-data-table__cell--non-numeric" width="10%" style="vertical-align : middle;">
							<div class="file_input">
								
								<input type="text" readonly="readonly" title="File Route" id="files">
								<label>
									파일첨부
									<input type="file" name="files "onchange="javascript:document.getElementById('files').value=this.value" value="${files.file_orig}">
								</label>
							</div>
						</td>
					</tr>
				</thead>
			</table>
	
			
			<div class="detail_btn_group">
				<button type="submit" class="mdl-button mdl-js-button">수정</button>
				<button type="button" class="mdl-button mdl-js-button" onclick="location.href='/list'">목록</button>
			</div>
			
			<input type="hidden" name="${_csrf.parameterName}" value = "${_csrf.token}"/>
			<input type="hidden" name="idxx_numb" value="${detail.idxx_numb}"> 
		</form>
	</div>
</div>

</body>

</html>