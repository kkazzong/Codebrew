<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!-- ToolBar Start /////////////////////////////////////-->
<div class="navbar navbar-default navbar-fixed-top">
	
	<div class="container">
	       
		<!-- <a class="navbar-brand" href="/index.jsp">Model2 MVC Shop</a> -->
		<a class="navbar-brand" href="/index.jsp">
			<img src="/resources/image/toolbarImage/monster.png" alt="MOANA">
		</a>
		
		<!-- toolBar Button Start //////////////////////// -->
		<div class="navbar-header">
		    <button class="navbar-toggle collapsed" data-toggle="collapse" data-target="#target">
		        <span class="sr-only">Toggle navigation</span>
		        <span class="icon-bar"></span>
		        <span class="icon-bar"></span>
		        <span class="icon-bar"></span>
		    </button>
		</div>
		
		<!-- toolBar Button End //////////////////////// -->
		
	    <!--  dropdown hover Start -->
		<div 	class="collapse navbar-collapse" id="target" 
	       			data-hover="dropdown" data-animations="fadeInDownNew fadeInRightNew fadeInUpNew fadeInLeftNew">
	         
	         	<!-- Tool Bar 를 다양하게 사용하면.... -->
	             <ul class="nav navbar-nav">
	             
	                 
	              <!-- 축제관리 DrowDown  -->
		          <li class="dropdown">
		             <a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
		                 <span>Festival</span>
		                 <span class="caret"></span>
		              </a>
		              <ul class="dropdown-menu">
		                  <li><a href="#">축제리스트 (서버DB) 회원 / 비회원</a></li>
		               </ul>
		           </li>
		           
		          <!-- 파티관리 DrowDown  -->
		          <li class="dropdown">
		             <a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
		                 <span>Party</span>
		                 <span class="caret"></span>
		              </a>
		              <ul class="dropdown-menu">
		                  <li><a href="#">파티등록</a></li>
		                  <li><a href="#">파티목록</a></li>
		               </ul>
		           </li>
		           
		          <!-- 후기관리 DrowDown  -->
		          <li class="dropdown">
		             <a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
		                 <span>Review</span>
		                 <span class="caret"></span>
		              </a>
		              <ul class="dropdown-menu">
		                  <li><a href="#">후기목록</a></li>
		               </ul>
		           </li>
	                 
	              <!-- 구매관리 DrowDown -->
	              <li class="dropdown">
	                <a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
	                    <span >Purchase</span>
	                    <span class="caret"></span>
	                </a>
	                <ul class="dropdown-menu">
	                       <c:if test="${sessionScope.user.role == 'u'}">
	                      		<li><a href="#">my티켓</a></li>
	                       </c:if>
	                       
	                       <c:if test="${sessionScope.user.role == 'a'}">
		                       <li><a href="#">판매목록</a></li>
		                       <li><a href="#">판매통계</a></li>
	                       </c:if>  
	                        
	                   </ul>
	                 </li>
	                 
	                <!-- 관리자일때 -->
	                <c:if test="${sessionScope.user.role == 'a'}">
		                <li class="dropdown">
			                <a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
			                    <span >MANAGE</span>
			                    <span class="caret"></span>
			                </a>
			                <ul class="dropdown-menu">
			                    <li><a href="#">회원목록</a></li>
			                    <li><a href="#">축제등록</a></li>
			                    <li><a href="#">후기심사목록</a></li>
			                    <li><a href="#">티켓판매목록</a></li>
			                    <li><a href="#">판매통계</a></li>
			                 </ul>
		                 </li>
	                 </c:if>
	                 
	             </ul>
	             
	             
	             <ul class="nav navbar-nav navbar-right">
	             	<c:if test="${!empty user}">
		             	<li><a href="#">${user.nickname}님</a></li>
		             	<li><a href="#">로그아웃</a></li>
	             	</c:if>
	             	<c:if test="${empty user }">
		                <li><a href="#">로그인</a></li>
	             	</c:if>
	            </ul>
		</div>
		<!-- dropdown hover END -->	       
	    
	</div>
</div>

		<!-- ToolBar End /////////////////////////////////////-->
   	
   	
   	<script type="text/javascript">
		
   		$(".dropdown").hover(function(){
   			$(this).toggleClass("mouse-on");
   		})
   		
   		//////로그인, 로그아웃//////
		$(function(){
		 	$("a:contains('로그인')").on("click" , function() {
				self.location = "/user/login";
			}); 
		 	$("a:contains('로그아웃')").on("click" , function() {
				self.location = "/user/logut";
			}); 
		});
   		
  		//////축제관리//////
   		$(function(){
			$( "a:contains('축제리스트 (서버DB) 회원 / 비회원')" ).on("click" , function() {
				self.location = "/festival/getFestivalListDB?menu=db";
			});
   		});
   		
  		//////구매관리//////
		$(function(){
			
			$("a:contains('my티켓')").bind('click', function(){
				self.location = "/purchase/getPurchaseList";
			});
			
			$("li > a:contains('판매목록')").bind('click', function(){
				self.location = "/purchase/getSaleList";
			});
			
			$("li > a:contains('판매통계')").bind('click', function(){
				self.location = "/statistics/getStatistics";
			});
			
		});
		
		
		///////툴바 MANAGE////////
   		$(function(){
   			
		 	$("a:contains('축제등록')").on("click" , function() {
				self.location = "/festival/getFestivalList?pageNo=1"
			}); 
		 	
			$("li > a:contains('티켓판매목록')").bind('click', function(){
				self.location = "/purchase/getSaleList";
			});
			
			$("a[href='#']:contains('판매통계')").bind('click', function(){
				self.location = "/statistics/getStatistics";
			});
			
   		});
   		
	</script>  

	<style>
	.navbar-brand > img {
			width : 30px;
			heigth : 30px;
	}
	</style>