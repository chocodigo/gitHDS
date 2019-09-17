<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% pageContext.setAttribute("LF", "\n"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Notice detail</title>
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

 /*-----------------------------------+
  |  02.삭제 버튼 클릭 時 처리 할 사항  |
  +------------------------------------*/
 	function notice_delete(idxx_numb){
 	    if(confirm("게시 글을 삭제하시겠습니까?")){
 	        data={'idxx_numb':idxx_numb};
 	        ajaxJsonCallSync("/notice_delete", data, noticeSuccessCallBack,"${_csrf.headerName}", "${_csrf.token}");     //공지사항 수정 페이지로 이동
 	    }else{}
 	}

 /*-----------------------------------+
  |  03.수정 버튼 클릭 時 처리 할 사항  |
  +------------------------------------*/
 	function notice_update(idxx_numb){
 	    data={'idxx_numb':idxx_numb};
 	    ajaxJsonCallSync("/notice_update", data, noticeSuccessCallBack,"${_csrf.headerName}", "${_csrf.token}");     //공지사항 수정 페이지로 이동
 	}

/*-----------------------------------+
|  00. 통신 성공 시 처리할 사항|
+------------------------------------*/
    function noticeSuccessCallBack(data){
        $("#box").html(data);     //box에 필요한 페이지 출력
    }
 
</script>
<div class="table_box">
    <img class="back_img" src="${contextPath}/resources/images/back.png" onclick="back('notice');">
    <table>
        <colgroup>
            <col width="10%">
            <col width="40%" >
            <col width="10%" >
            <col width="20%">
        </colgroup>
        <tbody>
            <tr>
                <td>제목</td>
                <td>${detail.titl_name}</td>
                <td>작성자</td>
                <td>${detail.crea_user}</td>
            </tr>
            <tr>
                <td>내용</td>
                <td colspan="3"><c:out value="${fn:replace(detail.cont_ents,LF,'<br>')}" escapeXml="false"/></td>
            </tr>
            <tr>
                <td>첨부파일</td>
                <td colspan="3"><a href="/fileDown/${files.idxx_numb}">${files.file_orig}</a></td>
            </tr>
            <c:forTokens var="token" items="${files.file_orig }" delims="." varStatus="status">
				<c:if test="${status.last }">
					<c:choose>
						<c:when test="${token eq 'png' || token eq 'jpg' || token eq 'jpeg' || token eq 'gif' || token eq 'bmp'}">
							<tr class="detail_th">
								<td>첨부파일 이미지</td>
								<td colspan="3">
									<img class="file_img" src="/resources/img/${files.file_name}">
								</td>
							</tr>
						</c:when>
					</c:choose>
				</c:if>
			</c:forTokens>
        </tbody>
    </table>
    <div class="btn_group">
        <button type="button" class="btn" onclick="notice_update('${detail.idxx_numb}');">수정</button>
        <button type="button" class="btn" onclick="notice_delete('${detail.idxx_numb}');">삭제</button>
    </div>
    <div class="clear_fix"></div>
</div>
</body>
</html>