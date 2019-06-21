<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<%@ include file="../common/bootstrap.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert Form</title>
<script type="text/javascript" src="/resources/vendor/jquery/jquery-1.9.1.min.js"></script>
</head>
<body>
<script type="text/javascript">
/***************************************************************************************************
 * # Program: 	BoardInsert.jsp 게시글 입력 페이지
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
 		
 	});
	
  /*-----------------------------------+
  |  02. 작성 버튼 클릭 시 진행되는 함수|
  +------------------------------------*/
  function insert(){
	  var titl_name = $("#titl_name").val();	//글 제목
	  var cont_ents = $("#cont_ents").val();	//글 내용
	  var select_code =  $("#select_category option:selected").val();	//선택한 값의 code 가져오기
	  
	  if(titl_name === ""){
		  alert("제목을 입력하세요");
		  $("#titl_name").focus();
	  }else if(cont_ents === ""){
		  alert("내용을 입력하세요");
		  $("#cont_ents").focus();
	  }else if (select_code === "cate_all"){
		  alert("카테고리를 선택하세요.");
	  }else{
		  $("#insert_form").submit();
	  }
  }
 /*-----------------------------------+
 |  03.셀렉트박스 변경 시 내용 placeholder 변경 처리  |
 +------------------------------------*/
 function changePlaceholder(){
	 var select_code =  $("#select_category option:selected").val();	//선택한 값의 code 가져오기
	 
	 switch(select_code){
	 case '01':
		 $("#cont_ents").attr("placeholder","PC 문제 셀프체크");
		 $("#cate_gory").val(select_code);
		 break;
	 case '02':
		 $("#cont_ents").attr("placeholder","Network 문제 셀프체크");
		 $("#cate_gory").val(select_code);
		 break;
	 case '03':
		 $("#cont_ents").attr("placeholder","기타 요청사항 문제 셀프체크");
		 $("#cate_gory").val(select_code);
		 break;
	 }
 }
</script>

<sec:authentication var="principal" property="principal"/>


<div class="container" style="width: 100%; margin-top: 90px;">
	<div class="mdl-card__title" style="height:60px;">
			<img class="main-image" style="margin-top: -20px;"
				src="${contextPath}/resources/images/question.png" />
				<h2 class="mdl-card__title-text" style="display: inline-block;">요청사항</h2>
		</div>
	<div class="mdl-card__supporting-text" style="width: 100%; font-size: 12px;">
		<form id="insert_form" class="form-group" action="/insertProc" method="post" enctype="multipart/form-data">
			
			<table class="mdl-data-table mdl-js-data-table mdl-shadow--2dp" style="width: 100%;">
				<thead>
					<tr align = "center">
						<th class="mdl-data-table__cell--non-numeric" width="10%">제목</th>
						<td class="mdl-data-table__cell--non-numeric" width="90%"><input type="text" class="form-control" id="titl_name" name="titl_name"></td>
	
					</tr>
					<tr>
						<th class="mdl-data-table__cell--non-numeric" width="10%">문제상황</th>
						<td class="mdl-data-table__cell--non-numeric" width="90%">
							<select id="select_category" style="border:0" onchange="changePlaceholder()">
								<option value="cate_all">카테고리</option>
								<c:forEach var="item" items="${category_list }">
									<option value="${item.cate_gory }">${item.cate_name }</option>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr align = "center">
						<th class="mdl-data-table__cell--non-numeric" width="10%">작성자</th>
						<td class="mdl-data-table__cell--non-numeric">${principal.username }</td>
		
					</tr>
					<tr align = "center">
						<th class="mdl-data-table__cell--non-numeric" width="10%" style="vertical-align : middle;">내용</th>
						<td class="mdl-data-table__cell--non-numeric"><textarea class="form-control" id="cont_ents" name="cont_ents" rows="10" style="resize: none;"></textarea></td>
					</tr>
					<tr align = "center">
						<th class="mdl-data-table__cell--non-numeric" width="10%" style="vertical-align : middle;">파일 첨부</th>
						<td class="mdl-data-table__cell--non-numeric" width="10%" style="vertical-align : middle;">
							<div class="file_input">
								
								<input type="text" readonly="readonly" title="File Route" id="files">
								<label>
									파일첨부
									<input multiple="multiple" type="file" name="files "onchange="javascript:document.getElementById('files').value=this.value">
								</label>
							</div>
						</td>
					</tr>
				</thead>
			</table>
	

			<input type="hidden" name="${_csrf.parameterName}" value = "${_csrf.token}"/>
			<input type="hidden" id="cate_gory"name="cate_gory"/>
		</form>
		<div class="detail_btn_group">
			<button type="button" class="mdl-button mdl-js-button" onclick="insert()">작성</button>
			<button type="button" class="mdl-button mdl-js-button" onclick="location.href='/list/${cate_gory}'">목록</button>
		</div>
	</div>
</div>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>   
</body>
</html>