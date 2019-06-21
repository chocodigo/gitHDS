<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<%@ include file="../common/bootstrap.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Board List</title>
<script src="https://code.getmdl.io/1.3.0/material.min.js"></script>
<script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="/resources/vendor/jquery/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="/resources/script/common.js"></script>

<style>
.pagination{
	display: inline-block;
}

.pagination .page-item a{
	color: #223055;
	float: left;
	padding: 8px 16px;
	text-decoration: none;
	border-radius: 5px;
	border: white;
}

.pagination .active .page-link
{
	background-color: #223055; 
	color: white;
}

</style>
</head>
<body>
<script>
/***************************************************************************************************
 * # Program: 	BoardList.jsp 게시글 리스트 조회 페이지
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
		//엔터할 경우 검색
		$("#search-field").keydown(function(key){
			if(key.keyCode==13){
				//공통 ajax로바꾸기
				location.href="/list?search="+$(this).val();
			}
		});
		
		//자동완성기능
		$("#search-field").keyup(function(key){
			if ($(this).val() == '' || $(this).val() == null) {
				$("#autoCompleteBox").empty();
				return;
			}
			
			$.ajax({
				type : "post",
				url : "/board/autoComplete",
				data : {
					search: $(this).val(),
					cate_gory: "${cate_gory}"
				},
				dataType : "html",
				beforeSend : function(xhr){
					xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
				},
				success : function(data) {
					$("#autoCompleteBox").html(data);
				},
				error: function(request, status, error){
					alert("code : " + request.status + "\nmessage : "+request.responseText);
				}
			});
		});	
	});
 
 /*-----------------------------------+
 |  02.셀렉트박스 변경 시 게시판 변경 처리  |
 +------------------------------------*/
 function changeList(){
	 var select_code =  $("#select_category option:selected").val();	//선택한 값의 code 가져오기
	 
	 switch(select_code){
	 case 'cate_all':
		 location.href="/list";
		 break;
	 default:
		 location.href="/list?cate_gory="+select_code;
		 break;
	 }
 }
 
</script>

	<div class="container" style="width: 100%;">
		<div style="width: 100%; margin-top: 90px;">
			<div class="mdl-card__title"
				style="height: 60px; display: inline-block;">
				
				
				<img class="main-image" style="margin-top: -20px;"
				src="${contextPath}/resources/images/question.png" />
				<h2 class="mdl-card__title-text" style="display: inline-block; cursor: pointer;" onclick="location.href='/list'">요청사항</h2>
				
			</div>
			<!-- 검색버튼 -->
			<div style="float: right;">
				<div class="hds-header-spacer mdl-layout-spacer"
					style="display: inline-block;"></div>
				<div
					class="hds-search-box mdl-textfield mdl-js-textfield mdl-textfield--expandable mdl-textfield--floating-label mdl-textfield--align-right mdl-textfield--full-width"
					style="display: inline-block;">
					<label class="mdl-button mdl-js-button mdl-button--icon"
						for="search-field"> <i class="material-icons">search</i>
					</label>
					<div class="mdl-textfield__expandable-holder">
						<input class="mdl-textfield__input" type="text" id="search-field">
						<!-- 자동완성부분 -->
						<div id="autoCompleteBox" style="position: absolute; z-index: 1;"></div>
					</div>
				</div>
			</div>
		</div>
		<div class="mdl-card__supporting-text" style="width: 100%;">
			<!-- 게시글 목록 -->
			<table class="mdl-data-table mdl-js-data-table mdl-shadow--2dp">
				<thead>
					<tr align="center">
						<th class="mdl-data-table__cell--non-numeric" width="5%">순번</th>
						<th class="mdl-data-table__cell--non-numeric" width="5%">상태</th>
						<th class="mdl-data-table__cell--non-numeric" width="10%">
							<select id="select_category" style="border:0" onchange="changeList()">
								<option value="cate_all">카테고리</option>
								<c:forEach var="item" items="${category_list }">
									<option value="${item.cate_gory }">${item.cate_name }</option>
								</c:forEach>
							</select>
						</th>
						<th class="mdl-data-table__cell--non-numeric" width="40%">제목</th>
						<th class="mdl-data-table__cell--non-numeric" width="10%">이름</th>
						<th class="mdl-data-table__cell--non-numeric" width="10%">작성일자</th>
						<th class="mdl-data-table__cell--non-numeric" width="10%">완료일자</th>
						
					</tr>
				</thead>
				<tbody>
					<c:forEach var="item" items="${list}">
						<tr align="center">
							<td class="mdl-data-table__cell--non-numeric">${item.numb_keyx}</td>
							<c:choose>
								<c:when test ="${item.stat_flag eq '01' }">
									<td class="mdl-data-table__cell--non-numeric">신규</td>
								</c:when>
								<c:when test ="${item.stat_flag eq '02' }">
									<td class="mdl-data-table__cell--non-numeric">접수</td>
								</c:when>
								<c:when test ="${item.stat_flag eq '03' }">
									<td class="mdl-data-table__cell--non-numeric">진행</td>
								</c:when>
								<c:when test ="${item.stat_flag eq '04' }">
									<td class="mdl-data-table__cell--non-numeric">완료</td>
								</c:when>
							</c:choose>
							<td class="mdl-data-table__cell--non-numeric">
								${item.cate_name }
							</td>
							<td class="mdl-data-table__cell--non-numeric"><a
								class="boardlist_title" style="color: #223055;"
								href='<c:url value="/detail/${item.idxx_numb}"/>'>${item.titl_name}</a></td>
							<td class="mdl-data-table__cell--non-numeric">${item.user_name}</td>
							<td class="mdl-data-table__cell--non-numeric"><fmt:formatDate
									pattern="yyyy-MM-dd HH:mm" value="${item.crea_date}" /></td>
							<td class="mdl-data-table__cell--non-numeric"><fmt:formatDate
									pattern="yyyy-MM-dd HH:mm" value="${item.succ_date}" /></td>
							
						</tr>
					</c:forEach>
				</tbody>
			</table>

			<div style="width: 100%; text-align: center;">
				<!-- 페이징 하단 -->
				<div class="board_pagination" style="display: inline-block;">
					<ul class="pagination">
						<!-- 이전 버튼 생성되면 시작 페이지의 전 페이지로 링크 걸기 -->
						<c:if test="${pageMaker.prev}">
							<li class="page-item"><a class="page-link"
								aria-label="Previous"
								href='<c:url value="/list/${cate_gory }?page=${pageMaker.startPage-1}"/>'>
									<span aria-hidden="true">&laquo;</span> <span class="sr-only">Previous</span>
							</a></li>
						</c:if>
						<!-- 시작 페이지부터 마지막 페이지 링크 걸기 -->
						<c:forEach begin="${pageMaker.startPage}"
							end="${pageMaker.endPage}" var="idx" varStatus="status">
							<c:if test="${curpage == status.index}">
								<li class="page-item active"><a class="page-link"
									href='<c:url value="/list/${cate_gory }?page=${idx}"/>'><i class="fa">${idx}</i></a>
								</li>
							</c:if>

							<c:if test="${curpage != status.index}">
								<li class="page-item"><a
									href='<c:url value="/list/${cate_gory }?page=${idx}"/>'><i class="fa">${idx}</i></a>
								</li>
							</c:if>
						</c:forEach>
						<!-- 다음 버튼 생성되면  마지막 페이지의 다음 페이지로 링크 걸기 -->
						<c:if test="${pageMaker.next && pageMaker.endPage > 0 }">
							<li class="page-item"><a class="page-link" aria-label="Next"
								href='<c:url value="/list?page=${pageMaker.endPage+1}"/>'> <span
									aria-hidden="true">&raquo;</span> <span class="sr-only">Next</span>
							</a></li>
						</c:if>
					</ul>
				</div>
				<div class="insert_btn">
					<button class="mdl-button mdl-js-button"
						onclick="location.href='/insert/${cate_gory}'">글쓰기</button>
				</div>
			</div>
		</div>
	</div>

<%@ include file="/WEB-INF/views/include/footer.jsp" %>   
</body>
</html>