<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org" xmlns:sec="http://www.thymeleaf.org/extras/spring-security">
<head>
<meta charset="UTF-8">

<!-- Google Material Design Lite -->
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:regular,bold,italic,thin,light,bolditalic,black,medium&amp;lang=en">
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<link rel="stylesheet" href="https://code.getmdl.io/1.3.0/material.indigo-pink.min.css">
<link rel="stylesheet" href="${contextPath}/resources/css/styles.css">

	<style>
	    #view-source {
	      position: fixed;
	      display: block;
	      right: 0;
	      bottom: 0;
	      margin-right: 40px;
	      margin-bottom: 40px;
	      z-index: 900;
	    }
    </style>
<title></title>

</head>
<body>

	

	<div class="mdl-layout mdl-js-layout mdl-layout--fixed-header">	
		
	      <div class="hds-header mdl-layout__header mdl-layout__header--waterfall">
	      	<div class="mdl-layout__header-row" style="color: black; padding-right: 40px; height: 20px; background-color: #E8C1DF">
	      		 
	      		 
	      		 <span class="mdl-layout-title" style="font-size: 15px; width: 95%; text-align: right; color: white;">
	      		 	<img src="${contextPath}/resources/images/account.png" style="width:15px; margin-top: -3px; margin-right: 5px;">
	      		 	안녕하세요 <sec:authentication property="principal.username"/> 님
	      		 </span>
	      		 
	      		 <form action="/logout" method="post" style="margin-left: 10px;">
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
					<button class="HDSbtn" type="submit">로그아웃</button>
				 </form>
	      		 
	      	</div>
	      	
	        <div class="mdl-layout__header-row" style="padding-left: 20px; apdding-right: 20px;">
	          <span class="hds-title mdl-layout-title">
	          
	            <img class="hds-logo-image" src="${contextPath}/resources/images/SM_logo.png" onclick="location.href='/'" style="cursor: pointer;">
	          </span>
	          <!-- Add spacer, to align navigation to the right in desktop -->
	          <div class="hds-header-spacer mdl-layout-spacer"></div>
	  			
	  			     
	          <!-- Navigation -->
	          <div class="hds-navigation-container">
	            <nav class="hds-navigation mdl-navigation">
	           	  
	           	  <a class="mdl-navigation__link mdl-typography--text-uppercase" href='<c:url value="/notice_list"/>'>공지사항</a>
	           	  <a class="mdl-navigation__link mdl-typography--text-uppercase" href='<c:url value="/faq_list"/>'>FAQ</a>
	              <a class="mdl-navigation__link mdl-typography--text-uppercase" href='<c:url value="/list"/>'>요청사항</a>


	              
	              <sec:authorize access="hasAuthority('001')">
	              	<a class="mdl-navigation__link mdl-typography--text-uppercase" href='<c:url value="/admin"/>'>관리자페이지</a>
	              </sec:authorize>
	              <sec:authorize access="hasAuthority('002')">	
	              	<a class="mdl-navigation__link mdl-typography--text-uppercase" href='<c:url value="/mypage"/>'>마이페이지</a>
	              </sec:authorize>
	            </nav>
	          </div>
	          
	        </div>
	        
	      </div>
	     
      </div>

</body>
</html>