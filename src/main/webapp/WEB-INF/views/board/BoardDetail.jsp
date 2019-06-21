<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../common/bootstrap.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Board Detail</title>
<script type="text/javascript" src="/resources/vendor/jquery/jquery-1.9.1.min.js"></script>
<script type="text/jsavascript" src="${contextPath}/resources/script/progUpdate"></script>
<script src="https://code.getmdl.io/1.3.0/material.min.js"></script>
</head>
<body>

<script type="text/javascript">

/***************************************************************************************************
 * # Program: 	BoardDetail.jsp 게시글 상세 내용페이지
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
 		var idxx_numb = '${detail.idxx_numb}';			//게시글 번호
 		var user_name = $("#user_name").val();		//로그인된 사용자 이름
 		var data_name = '${detail.user_name }';			//게시글 작성자 이름
 		var cate_gory = '${cate_gory }';				//게시글 카테고리
 		
 		//수정 버튼 클릭 시
 		$('#update_btn').click(
 			function(){
 				if(user_name != data_name){
 					alert("user_name : "+user_name);
 					alert("data_name : "+data_name);
 					alert('작성자만 수정할 수 있습니다.');
 				 }
 				else{
 					location.href="/update/"+idxx_numb;	
 				}
 				
 			}		
 		);
 		
 		//삭제 버튼 클릭 시
 		$('#delete_btn').click(
 	 			function(){
 	 				if(user_name != data_name){
 	 					 alert('작성자만 삭제할 수 있습니다.');
 	 				 }
 	 				else{
 	 					$.ajax({
 	 						type : "post",
 	 						url : "/delete",
 	 						data : {
 	 							'idxx_numb' : idxx_numb
 	 						},
 	 						beforeSend : function(xhr){
 	 							xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
 	 						},
 	 						success : function(data) {
 	 							//alert("/list/"+cate_gory);
 	 							location.href="/list/"+cate_gory;
 	 						},
 	 						error: function(request, status, error){
 	 							alert("code : " + request.status + "\nmessage : "+request.responseText);
 	 						}
 	 					});
 	 				}
 	 				
 	 			}		
 	 	);
 		
 		
 		
 	});

 /*-----------------------------------+
 |  02. 상태 수정 아이콘 클릭 시 처리  |
 +------------------------------------*/
 	function check_stat(stat_flag,idxx_numb){
	 	var stat_str="";
	 	switch(stat_flag){
	 	case '01':
	 		stat_str = "신규";
	 		break;
	 	case '02':
	 		stat_str = "접수";
	 		break;
	 	case '03':
	 		stat_str = "진행";
	 		break;
	 	case '04':
	 		stat_str = "완료";
	 		break;
	 	}
		if(confirm("상태를 "+stat_str+"(으)로 바꾸시겠습니까?")){
			update_stat(stat_flag,idxx_numb);
		}else{
			
		}
	}
 /*-----------------------------------+
 |  03. 상태 변경을 위한 ajax통신  |
 +------------------------------------*/
 	function update_stat(stat_flag, idxx_numb){
 		$.ajax({
			type : "post",
			url : "/updateStatProc",
			data : {
				'idxx_numb' : idxx_numb,
				'stat_flag' : stat_flag 
			},
			dataType : "html",
			beforeSend : function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			},
			success : function(data) {
				location.reload();
			},
			error: function(request, status, error){
				alert("code : " + request.status + "\nmessage : "+request.responseText);
			}
		});
 	}


</script>


<sec:authentication var="principal" property="principal"/>
<div class="container" style="width: 100%;">

	<!-- 상단 -->
	<div style=" margin-top: 90px; margin-bottom: 10px;">
		<div class="mdl-card__title" style="height:60px; display: inline-block;">
			<img class="main-image" style="margin-top: -20px;"
				src="${contextPath}/resources/images/question.png" />
				<h2 class="mdl-card__title-text" style="display: inline-block;">요청사항</h2>
		</div>
		
		<!-- 진행상황 수정 버튼 -->
		<div style="margin-top: 20px; float: right;margin-right: 16px; ">
			<sec:authorize access="hasAuthority('001')">
				<button class="mdl-button mdl-js-button admin_btn" onclick="location.href='/comment/insert'">답글달기</button>
				<button class="mdl-button mdl-js-button admin_btn" data-toggle="modal" data-target="#progress_Modal">진행상황 수정</button>
				
				
				<!-- Modal -->
				<div class="modal fade" id="progress_Modal" role="dialog">
				    <div class="modal-dialog" style="height: auto;">
				    
				      <!-- Modal content-->
				      <div class="modal-content">
				        <div class="modal-header">
				          <button type="button" class="close" data-dismiss="modal">&times;</button>
				          <h4 class="modal-title">수정할 진행상황을 선택해주세요.</h4>
				        </div>
				        <div class="modal-body" style="text-align: center;">

							<figure class="snip1141">
								<img id="stat_img" width="100" src="${contextPath}/resources/images/stat/001-new.png" onclick="check_stat('01','${detail.idxx_numb}');">
								<figcaption>
									<h3>신규</h3>
								</figcaption>
							</figure>
							
							<figure class="snip1141">
								<img class="stat_img" width="100" src="${contextPath}/resources/images/stat/002-checkmark.png" onclick="check_stat('02','${detail.idxx_numb}');">
								<figcaption>
									<h3>접수</h3>
								</figcaption>
							</figure>
							
							<figure class="snip1141">
								<img class="stat_img" width="100" src="${contextPath}/resources/images/stat/003-loading.png" onclick="check_stat('03','${detail.idxx_numb}');">
								<figcaption>
									<h3>진행</h3>
								</figcaption>
							</figure>
	 
	 						<figure class="snip1141">
								<img class="stat_img" width="100" src="${contextPath}/resources/images/stat/004-complete.png" onclick="check_stat('04','${detail.idxx_numb}');">
								<figcaption>
									<h3>완료</h3>
								</figcaption>
							</figure>

						 </div>
				        </div>
				       
				      </div>
				      
				    </div>
				
				
			</sec:authorize>
		</div>
		
		
	</div>
	
	<!-- 글내용 -->
	<div class="mdl-card__supporting-text" style="width: 100%;">
		<table class="mdl-data-table mdl-js-data-table mdl-shadow--2dp">
			<thead>
				<tr align = "center">
					<th class="mdl-data-table__cell--non-numeric" style="vertical-align: middle;" width="10%">문서번호</th>
					<td class="mdl-data-table__cell--non-numeric">${detail.idxx_numb}</td>
					<th class="mdl-data-table__cell--non-numeric" style="vertical-align: middle;" width="10%">작성자</th>
					<td class="mdl-data-table__cell--non-numeric">${detail.user_name}</td>
				</tr>
				<tr align = "center">
					<th class="mdl-data-table__cell--non-numeric" style="vertical-align: middle;" width="10%">제목</th>
					<td class="mdl-data-table__cell--non-numeric">${detail.titl_name}</td>
					<th class="mdl-data-table__cell--non-numeric" style="vertical-align: middle;" width="10%">작성일</th>
					<td class="mdl-data-table__cell--non-numeric"><fmt:formatDate pattern="yyyy-MM-dd" value="${detail.crea_date}"/></td>
				</tr>
				<tr align = "center">
					<th class="mdl-data-table__cell--non-numeric" style="vertical-align: middle;" width="10%">진행상태</th>
						<c:choose>
							<c:when test="${detail.stat_flag eq '01' }">
								<td class="mdl-data-table__cell--non-numeric">신규</td>
							</c:when>
							<c:when test="${detail.stat_flag eq '02' }">
								<td class="mdl-data-table__cell--non-numeric">접수</td>
							</c:when>
							<c:when test="${detail.stat_flag eq '03' }">
								<td class="mdl-data-table__cell--non-numeric">진행중</td>
							</c:when>
							<c:when test="${detail.stat_flag eq '04' }">
								<td class="mdl-data-table__cell--non-numeric">완료</td>
							</c:when>
						</c:choose>
					<th class="mdl-data-table__cell--non-numeric" style="vertical-align: middle;" width="10%">문제상황</th>
					<td class="mdl-data-table__cell--non-numeric">${detail.cate_name}</td>
				</tr>
				<tr align = "center">
					<th class="mdl-data-table__cell--non-numeric" width="10%" style="vertical-align : middle; height: 300px;">내용</th>
					<td class="mdl-data-table__cell--non-numeric" colspan="3" style=" white-space:pre; vertical-align: top;">${detail.cont_ents}</td>
				</tr>
				<tr align = "center">
					<th class="mdl-data-table__cell--non-numeric" width="10%">첨부파일</th>
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
		
		<!-- user_name : 로그인된 사용자 이름 -->
		<input type="hidden" id="user_name" value="${principal.username}"/>
		
		
		
		<div>
			<div id="comment"></div>
		</div>
		
		<!-- 수정 삭제 목록 버튼 -->
		<div class="detail_btn_group" style="display: center;">
			<c:if test="${principal.username eq detail.user_name }">
				<button id="update_btn" class="mdl-button">수정</button>
				<button id="delete_btn" class="mdl-button mdl-js-button">삭제</button>
			</c:if>
			<button class="mdl-button mdl-js-button" onclick="location.href='/list/${cate_gory}'">목록</button>
		</div>
		
		
	</div>
</div>

<%@ include file="/WEB-INF/views/include/footer.jsp" %>   
</body>
</html>