<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!-- Bootstrap Dropdown Hover CSS -->
<link href="/resources/css/animate.min.css" rel="stylesheet">
<link href="/resources/css/bootstrap-dropdownhover.min.css" rel="stylesheet">

<!-- Bootstrap Dropdown Hover JS -->
<script src="/resources/javascript/bootstrap-dropdownhover.min.js"></script>


<!-- ToolBar Start /////////////////////////////////////-->
<div id="custom-menu" class="navbar navbar-default navbar-fixed-top">
	
	<div class="container">
	       
		<a class="navbar-brand" href="/index.jsp">
			<!-- <img src="/resources/image/toolbarImage/pumpkin.png" alt="MOANA"> -->
			<img src="/resources/image/toolbarImage/logo4.png" alt="MOANA">
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
		                 Festival
		              </a>
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
		                  <li><a href="#">애프터파티</a></li>
		                  <li><a href="#">아모르파티</a></li>
		               </ul>
		           </li>
		           
		          <!-- 후기관리 DrowDown  -->
		          <li class="dropdown">
		             <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
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
	                       <li><a href="#">my티켓</a></li>
	                       <c:if test="${sessionScope.user.role == 'a'}">
		                       <li class="divider"></li>
		                       <li><a href="#">판매목록</a></li>
		                       <li><a href="#">판매통계</a></li>
	                       </c:if>  
	                   </ul>
	                 </li>
	                 
	                <!-- 관리자일때 -->
	                <c:if test="${sessionScope.user.role == 'a'}">
		                <li class="dropdown">
			                <a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
			                    <span >Manage</span>
			                    <span class="caret"></span>
			                </a>
			                <ul class="dropdown-menu">
			                    <li><a href="#">회원목록</a></li>
			                    <li><a href="#">축제등록</a></li>
			                    <li><a href="#">후기심사목록</a></li>
			                    <!-- <li><a href="#">티켓판매목록</a></li>
			                    <li><a href="#">판매통계</a></li> -->
			                 </ul>
		                 </li>
	                 </c:if>
	                 
	             </ul>
	             
	             
	             <ul class="nav navbar-nav navbar-right">
	             	<c:if test="${!empty user}">
		             	<li><a href="#">${user.nickname}님</a></li>
		             	<li><a href="#">로그아웃</a></li>
	             	</c:if>
	             	<c:if test="${empty user}">
		                <li><a href="#">로그인</a></li>
	             	</c:if>
	            </ul>
		</div>
		<!-- dropdown hover END -->	       
	    
	</div>
	
	<!-- <div id="custom-bootstrap-menu" class="navbar navbar-default " role="navigation">
	    <div class="container-fluid">
	        <div class="navbar-header"><a class="navbar-brand" href="#">Brand</a>
	            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-menubuilder"><span class="sr-only">Toggle navigation</span><span class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span>
	            </button>
	        </div>
	        <div class="collapse navbar-collapse navbar-menubuilder">
	            <ul class="nav navbar-nav navbar-left">
	                <li><a href="#">Festival</a>
	                </li>
	                <li><a href="#">Party</a>
	                </li>
	                <li><a href="#">Review</a>
	                </li>
	                <li><a href="#">Purchase</a>
	                </li>
	                <li><a href="#">Manage</a>
	                </li>
	                <li><a href="#">MyPage</a>
	                </li>
	                <li><a href="#">Login</a>
	                </li>
	                <li><a href="#">Logout</a>
	                </li>
	            </ul>
	        </div>
	    </div>
	</div> -->
	
	
	
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
				self.location = "/user/logout";
			}); 
		});
   		
  		//////축제관리//////
   		$(function(){
			$( "a:contains('Festival')" ).on("click" , function() {
				self.location = "/festival/getFestivalListDB?menu=db";
			});
   		});
  		
  		//////후기관리//////
   		$(function(){
			$( "a:contains('Review')" ).on("click" , function() {
				//self.location = "/review/getReviewList";
			});
   		});
  		
  		
 		//////축제관리//////
   		$(function(){
			$( "a:contains('후기목록')" ).on("click" , function() {
				self.location = "/review/getReviewList";
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
  		
		//////파티관리//////
		$(function(){
			
			$("li > a:contains('파티등록')").bind('click', function(){
				self.location = "/party/addParty";
			});
			
			$("li > a:contains('파티목록')").bind('click', function(){
				self.location = "/party/getPartyList";
			});
			
			$("li > a:contains('애프터파티')").bind('click', function(){
				
			});
			
			$("li > a:contains('아모르파티')").bind('click', function(){
				
			});
			
		});
		
		
		///////툴바 MANAGE////////
   		$(function(){
   			
   			$("a:contains('회원목록')").on("click" , function() {
				self.location = "/user/getUserList";
			}); 
   			
		 	$("a:contains('축제등록')").on("click" , function() {
				self.location = "/festival/getFestivalList?pageNo=1";
			}); 
		 	
		 	$("a:contains('후기심사목록')").on("click" , function() {
				//self.location = "";
			}); 
			
   		});
		
		
  		///////파티관리////////
   		$(function(){
   			
		 	$("a:contains('파티등록')").on("click" , function() {
				self.location = "/party/addParty"
			}); 
		 	
			$("a[href='#']:contains('파티목록')").bind('click', function(){
				self.location = "/party/getPartyList";
			});
			
   		});
   		
	</script>  

	<style>
		.navbar-brand > img {
				width : 45%;
				heigth : 45%;
				padding-bottom: 3px;
		}
	</style>