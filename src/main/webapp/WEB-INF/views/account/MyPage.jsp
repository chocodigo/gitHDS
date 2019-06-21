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
<title>My page</title>
	<script>
		$(document).ready(function() {
			var progressbar = $('#progress_bar');
			max = progressbar.attr('max');
			
			if(max !=0){
				time = (1000 / 100) * 5;
				
				value = progressbar.val();
				
				
				var loading = function() {
					value += 1;
					addValue = progressbar.val(value);
				
					$('.progress-value').html(value + '%');
					var $ppc = $('.progress-pie-chart'),
					deg = 360 * value / 100;
					if (value > 50) {
					$ppc.addClass('gt-50');
					}
				
					$('.ppc-progress-fill').css('transform', 'rotate(' + deg + 'deg)');
					$('.ppc-percents span').html(value + '%');
				
					if (value == max) {
					clearInterval(animate);
					}
				};
			
				var animate = setInterval(function() {
				loading();
				}, time);
			}else{
				$('.ppc-progress-fill').css('transform', 'rotate(0deg)');
			}
		});
	</script>
</head>
<body>
	<!-- 최근 요청사항 -->
	<div class="mdl-color--white mdl-shadow--2dp mdl-cell mdl-cell--12-col mdl-grid" 
		style="padding-top: 40px; padding-left: 40px; margin-top:100px; margin-bottom: 40px;">
		<div>
			<div id="pbar" class="progress-pie-chart" data-percent="0">
				<div class="ppc-progress">
					<div class="ppc-progress-fill"></div>
				</div>
				<div class="ppc-percents">
					<div class="pcc-percents-wrapper">
						<span>${stat_flag }%
		  				</span>
		  				<c:if test="${detail.stat_flag eq '0'}"></c:if>
		  				<c:if test="${detail.stat_flag eq '01'}"><p style="font-size: 15px; color: #E8C1DF;">신규작성</p></c:if>
		  				<c:if test="${detail.stat_flag eq '02'}"><p style="font-size: 15px; color: #E8C1DF;">담당자 접수</p></c:if>
		  				<c:if test="${detail.stat_flag eq '03'}"><p style="font-size: 15px; color: #E8C1DF;">진행</p></c:if>
		  				<c:if test="${detail.stat_flag eq '04'}"><p style="font-size: 15px; color: #E8C1DF;">완료</p></c:if>
					</div>
					
				</div>
			</div>
							
			<progress style="display: none;" id="progress_bar" value="0" max="${stat_flag }"></progress>
		</div>
		
		<div style="margin-bottom: 30px;">
			<div class="mdl-card__title" style="height:60px;">
			  	<img class="main-image" style="margin-top:0px;" src="${contextPath}/resources/images/target.png"/>
			    <h2 class="mdl-card__title-text" style="display: inline-block;">최근 요청사항</h2>
		  	</div>
		  	<div class="mdl-card__supporting-text" style="font-size : 15px; margin-left: 50px; width: 100%;">
		  		<c:choose>
		  			<c:when test="${stat_flag eq '0' }">
		  				최근 요청사항이 없습니다.
		  			</c:when>
		  			<c:otherwise>
		  				<p>- 요청 내역 : ${detail.titl_name}</p>
		  				<p>- 작성일 : <fmt:formatDate pattern="yyyy-MM-dd" value="${detail.crea_date}"/></p>
		  				
		  			</c:otherwise>
		  		</c:choose>
		  	</div>
		  	
		</div>
		<c:if test="${stat_flag ne '0' }">
			<div class="mdl-card__actions mdl-card--border" style="margin-top: 20px;">
				
				<a class="mdl-button mdl-button--colored mdl-js-button mdl-js-ripple-effect" style="float:right; text-decoration:none;" href="/detail/${detail.idxx_numb}">
					MORE
				</a>
				
			</div>
		</c:if>
	</div>
	
	<!-- 작성한 글 목록 -->
	<div class="mdl-color--white mdl-shadow--2dp mdl-cell mdl-cell--12-col mdl-grid">
		
		<div>
			<div class="mdl-card__title" style="height:60px; display: inline-block;">
			  	<img class="main-image" style="margin-top:-20px;" src="${contextPath}/resources/images/database.png"/>
			    <h2 class="mdl-card__title-text" style="display: inline-block;">작성한 글</h2>
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
		  	<div class="mdl-card__supporting-text" style="width: 100%;">
		  		<!-- 게시글 목록 -->
				<table class="mdl-data-table mdl-js-data-table mdl-shadow--2dp">
					<thead>
						<tr align = "center">
							<th class="mdl-data-table__cell--non-numeric" width="5%">순번</th>
							<th class="mdl-data-table__cell--non-numeric" width="50%">제목</th>
							<th class="mdl-data-table__cell--non-numeric" width="10%">이름</th>
							<th class="mdl-data-table__cell--non-numeric" width="10%">입력일자</th>
							<th class="mdl-data-table__cell--non-numeric" width="10%">수정일자</th>
							<th class="mdl-data-table__cell--non-numeric" width="10%">완료일자</th>
							<th class="mdl-data-table__cell--non-numeric" width="5%">상태</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="item" items="${list}">
							<tr align = "center">
								<td class="mdl-data-table__cell--non-numeric">${item.numb_keyx}</td>
								<td class="mdl-data-table__cell--non-numeric"><a class="boardlist_title" style="color: #223055;" href='<c:url value="/detail/${item.idxx_numb}"/>'>${item.titl_name}</a></td>
								<td class="mdl-data-table__cell--non-numeric">${item.user_name}</td>
								<td class="mdl-data-table__cell--non-numeric"><fmt:formatDate pattern="yyyy-MM-dd" value="${item.crea_date}"/></td>
								<td class="mdl-data-table__cell--non-numeric"><fmt:formatDate pattern="yyyy-MM-dd" value="${item.upda_date}"/></td>
								<td class="mdl-data-table__cell--non-numeric"><fmt:formatDate pattern="yyyy-MM-dd" value="${item.succ_date}"/></td>
								<c:choose>
									<c:when test="${item.stat_flag eq '01' }">
										<td class="mdl-data-table__cell--non-numeric"><img
											class="detail_progress_img"
											src="${contextPath}/resources/images/stat/001-new.png"></td>
									</c:when>
									<c:when test="${item.stat_flag eq '02' }">
										<td class="mdl-data-table__cell--non-numeric"><img
											class="detail_progress_img"
											src="${contextPath}/resources/images/stat/002-checkmark.png"></td>
									</c:when>
									<c:when test="${item.stat_flag eq '03' }">
										<td class="mdl-data-table__cell--non-numeric"><img
											class="detail_progress_img"
											src="${contextPath}/resources/images/stat/003-loading.png"></td>
									</c:when>
									<c:when test="${item.stat_flag eq '04' }">
										<td class="mdl-data-table__cell--non-numeric"><img
											class="detail_progress_img"
											src="${contextPath}/resources/images/stat/004-complete.png"></td>
									</c:when>
								</c:choose>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				
				
				<!-- 페이징 하단 -->
				<div class="board_pagination">
					<ul class="pagination">
						<!-- 이전 버튼 생성되면 시작 페이지의 전 페이지로 링크 걸기 -->
						<c:if test="${pageMaker.prev}">
							<li class="page-item">
								<a class="page-link" aria-label="Previous" href='<c:url value="/mypage?page=${pageMaker.startPage-1}"/>'>
									<span aria-hidden="true">&laquo;</span>
									<span class="sr-only">Previous</span>
								</a>
							</li>
						</c:if>
						<!-- 시작 페이지부터 마지막 페이지 링크 걸기 -->
						<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx" varStatus="status">
							<c:if test="${curpage == status.index}">
								<li class="page-item active">	
									<a class="page-link" href='<c:url value="/list?page=${idx}"/>'><i class="fa">${idx}</i></a>
								</li>
							</c:if>
							
							<c:if test="${curpage != status.index}">
								<li class="page-item">
									<a href='<c:url value="/mypage?page=${idx}"/>'><i class="fa">${idx}</i></a>
								</li>
							</c:if>
						</c:forEach>
						<!-- 다음 버튼 생성되면  마지막 페이지의 다음 페이지로 링크 걸기 -->
						<c:if test="${pageMaker.next && pageMaker.endPage > 0 }">
							<li class="page-item">
								<a class="page-link" aria-label="Next" href='<c:url value="/mypage?page=${pageMaker.endPage+1}"/>'>
									<span aria-hidden="true">&raquo;</span>
				       				<span class="sr-only">Next</span>
								</a>
							</li>
						</c:if>
					</ul>
				</div>
		  	</div>
		  	
		</div>
		
	</div>
	<%@ include file="/WEB-INF/views/include/footer.jsp" %>   
</body>
</html>