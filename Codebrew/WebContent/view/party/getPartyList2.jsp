<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

	<title>파티 목록 조회</title>

	<!-- 참조 : http://getbootstrap.com/css/   참조 -->
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <link rel="stylesheet" href="/resources/demos/style.css">
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>

	<!-- Jquery DatePicker -->
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

	
	
	<!--  ///////////////////////// JavaScript ////////////////////////// -->
    <script type="text/javascript">
	
    
    	//=============    검색 / page 두가지 경우 모두  Event  처리	 =============	
		function fncGetList(currentPage) {
				$("#currentPage").val(currentPage)
				$("form").attr("method" , "POST").attr("action", "/party/getPartyList").submit();
		} 
		
		$(function(){
			//$("button:contains('검색')").on("click", function() {
			$("#search").on("click", function() {		
				//console.log( $("button[type=button]:contains('검색')").html() );
				console.log( $("a #search").html() );
				fncGetList(1);
			});
			
			$("input[name=searchKeyword]").on('keydown',function(event){
				if(event.keyCode ==13){
					fncGetList(1);
				}
			});
			
		}); 	
		
		//=============    파티상세조회(썸네일)  Event  처리 		=============
		$(function(){
			$("a.thumbnail_image").on("click", function() {
				
				var partyNo = $( "input[name=partyNo]", $(this) ).val();
				var partyFlag = $( "input[name=partyFlag]", $(this) ).val();
				
				console.log(partyNo+" / "+partyFlag);
				/* console.log( $( "a.thumbnail_image img", $(this) ).val() ); */
				self.location="/party/getParty?partyNo="+partyNo+"&partyFlag="+partyFlag;
		
			});
		});
		
		//=============    searchCondition 파티  Event  처리 		=============
		$(function(){
			$("button:contains('파티')").on("click", function() {
				
				if( $("#searchCondition").val() != "1"){
					console.log("그냥 출력1");
					$("#searchKeyword").val("");
				}
				$("#searchCondition").val("1");
				fncGetList(1);
				
			});
			
			$("button:contains('애프터 파티')").on("click", function() {
				if( $("#searchCondition").val() != "2"){
					console.log("그냥 출력2");
					$("#searchKeyword").val("");
				}
				$("#searchCondition").val("2");
				fncGetList(1);
			});
			
			/* $("button:contains('해당 파티')").on("click", function() {
				if( $("#searchCondition").val() != "5"){
					console.log("그냥 출력3");
					$("#searchKeyword").val("");
				}
				$("#searchCondition").val("5");
				self.location="/party/getPartyList?festivalNo=2510028";
			}); */ 
		});
		
		//=============    전체 파티 목록  Event  처리 		=============
		$(function(){
			$("#title").on("click", function() {
				$("#searchKeyword").val("");
				$("#searchCondition").val("");
				fncGetList(1);
			});
		});
		
		
		//=============    전체 파티 목록  Event  처리 		=============
		$(function(){
			$("button:contains('애프터파티 등록하러 가기')").on("click", function() {
				
				self.location = "/party/addParty?festivalNo=${search.searchKeyword}";
			});
		});
		
		
		//=============    판넬  Event  처리 		=============
		$(function(){	
			
			/* 판넬 높이 조절 */
			var maxHeight = -1;
	
			$('.panel').each(function() {
				maxHeight = maxHeight > $(this).height() ? maxHeight : $(this).height();
			});
	
			$('.panel').each(function() {
				 $(this).height(maxHeight);
			});
			
			
			/* 파티 상세 조회 */
			$(".panel-body").on("click", function(){
				console.log($(this).find("input:hidden[name='partyNo']").val());
				var partyNo = $(this).find("input:hidden[name='partyNo']").val()
				self.location = "/party/getParty?partyNo="+partyNo;
			})
		});
		
	</script>
	
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
	
		body {
	            padding-top : 70px;
	    }
	   
			
		.panel {
			margin-top : 50px;
	    }
	    
		.panel-heading h3 {
		    white-space: nowrap;
		    overflow: hidden;
		    text-overflow: ellipsis;
		    line-height: normal;
		    width: 75%;
		    padding-top: 8px;
		}
		 
		.main {
			/* background-image: url(/resources/image/ui/partybanner.jpg); */
			background-color: #556180;
			/* background-size: 100% 100%; */
		} 
		
		.title {
			color: white;
		} 
		
		/* .main .search-main input[type=text] {
		
			width: 83%;
		    height: 41px;
		    padding-left: 10px;
		    float: left;
		    margin-top: 2px;
		    margin-left: 2px;
		} */
		
		/* .main .search-main {
		    background-color: black;
		    width: 100%;
		    height: 45px;
		    margin-bottom: 76px;
		    position: relative;
		} */
	
		.main .search-main img {
		    width: 40px;
		    margin-top: 2px; 
	
		}  
		
		
    </style>
    
</head>
<body>
	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/toolbar/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->

	<div class="container">
	<!-- Title -->
	<div class="main-wrapper">
		
		<div class="main">
		<!-- <div class="main"> -->
	        
	            <div class="col-md-12">
	                <div class="col-md-6 col-md-offset-3 padding-none">
	                    <div class="text-center white">
	                        <!-- <ul class="title">
	                            <li>이번 주말에</li>
	                            <li>뭐하고 놀지?</li>
	                        </ul> -->
	                        <div class="title">
	                        	<h1>이번 주말에</h1>
	                            <h1>뭐하고 놀지?</h1>
	                        </div>
	
	                        <div class="sub-title-container">
	
	                            <div class="search-main">
	                                
	                                <form class="form-inline" name="detailForm">
	                                	<div class="form-group ">
										    <div class="form-select">
												<button type="button" class="btn btn-default btn-block" >파티</button>
												<button type="button" class="btn btn-default btn-block" >애프터 파티</button>
												<!-- <button type="button" class="btn btn-default" >해당 파티</button> -->
												<input type="hidden" class="form-control" id="searchCondition" name="searchCondition" value="${ ! empty search.searchCondition ? search.searchCondition : '' }">
												
											</div>
										  </div>
										  
										  <div class="form-group">
										    <label class="sr-only" for="searchKeyword">검색어</label>
										    
											<c:if test="${ !empty search.searchCondition && search.searchCondition == '5' }">
												<input type="text" class="form-control" id="searchKeyword" name="searchKeyword" value="">
											</c:if>
											<c:if test="${ search.searchCondition != '5' }">
											<input type="text" class="form-control" id="searchKeyword" name="searchKeyword" value="${! empty search.searchKeyword ? search.searchKeyword : '' }">
											</c:if>
											<%-- <input type="text" class="form-control" id="searchKeyword" name="searchKeyword" value="${! empty search.searchKeyword ? search.searchKeyword : '' }"> --%>
										    <!-- <button type="button" class="btn btn-default btn-block">검색</button>	 -->
										    <a id="search" class="click" type="button">
		                                        <img src="/resources/image/buttonImage/btn_nav_search_white@3x.png">
		                                    </a>		 
										  </div>
	                               	</form>
	                                
	                                
	                                    <!-- <input type="text" placeholder="ex) 할로윈"> -->
	                                    <!-- <a id="search" class="click" type="button">
	                                        <img src="/resources/image/buttonImage/btn_nav_search_white@3x.png">
	                                    </a> -->
	                                </div>
	                            </div>                        
	
	                    </div>
	                </div>
	            </div>
	        </div>
	    </div>
	</div>
	
	
	<!--  화면구성 div Start /////////////////////////////////////-->
	 <div class="container_list">
	  <div class="page-header text-info">
   		   <!-- <h2 align="center" id="title">파티 리스트</h2> -->
   		   <div class="text-right">
	   		   <c:if test="${ search.searchCondition == '5' }">
	   		   		<button type="button" class="btn btn-primary" >애프터파티 등록하러 가기</button>
	   		   </c:if>
   		   </div>
   		   
   		   <div class="text-right">
		    	전체  ${resultPage.totalCount } 건
   		   </div>
   		   
   		   
	  </div>
	  
	  <!-- 목록 검색 Start /////////////////////////////////////-->
	    <div class="row">
	    
		    
		    
		    <div class="col-md-6 text-right">
			    <%-- <form class="form-inline" name="detailForm">
			    
				  <div class="form-group ">
				    <div class="form-select">
						<button type="button" class="btn btn-default btn-block" >파티</button>
						<button type="button" class="btn btn-default btn-block" >애프터 파티</button>
						<!-- <button type="button" class="btn btn-default" >해당 파티</button> -->
						<input type="hidden" class="form-control" id="searchCondition" name="searchCondition" value="${ ! empty search.searchCondition ? search.searchCondition : '' }">
						
					</div>
				  </div>
				  
				  <div class="form-group">
				    <label class="sr-only" for="searchKeyword">검색어</label>
				    
					<c:if test="${ !empty search.searchCondition && search.searchCondition == '5' }">
						<input type="text" class="form-control" id="searchKeyword" name="searchKeyword" value="">
					</c:if>
					<c:if test="${ search.searchCondition != '5' }">
					<input type="text" class="form-control" id="searchKeyword" name="searchKeyword" value="${! empty search.searchKeyword ? search.searchKeyword : '' }">
					</c:if>
					<input type="text" class="form-control" id="searchKeyword" name="searchKeyword" value="${! empty search.searchKeyword ? search.searchKeyword : '' }">
				    <button type="button" class="btn btn-default btn-block">검색</button>			 
				  </div> 		  
				  
				  <!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
				  <input type="hidden" id="currentPage" name="currentPage" value=""/>
				  
				</form>--%>
	    	</div>
	    	
		</div>
	  <!-- 목록 위 검색 End /////////////////////////////////////-->
	  
	  <br/>
	  
	  <!-- 목록 조회 Start /////////////////////////////////////-->
	  <div class="row">
		<c:if test="${empty list}">
			<%-- <jsp:include page="/view/purchase/noResult.jsp"></jsp:include> --%>
		</c:if>
			<c:forEach var="party" items="${list}">
				<c:set var="i" value="${i+1}"></c:set>
				<div class="col-md-6">
						<div class="panel panel-primary">
							<div class="panel-heading">
								
								<%-- ${ party.user.profileImage} --%>
								<h3 class="panel-title pull-left">
								<img class="rounded-circle" src="/resources/uploadFile/${party.partyImage}" width="40" height="40">
								&nbsp; ${ party.user.nickname }</h3>
								
        						<div class="clearfix"></div>
							</div>
							<div class="panel-body">
								<!-- 파티 -->
								<input type="hidden" name="partyNo" value="${party.partyNo}">
									<img width="100%" height="300" src="/resources/uploadFile/${party.partyImage}">
									
									<div class="col-md-12">
										<h4>
										<strong>
											${party.partyName}
										</strong>
										</h4>
									</div>
									<hr>
									<div class="col-md-12">
										<small>
											<span class="glyphicon glyphicon-calendar" aria-hidden="true"></span>
											${party.partyDate}
										</small>
									</div>
									<div class="col-md-12">
										<small>
											<span class="glyphicon glyphicon-time" aria-hidden="true"></span>
											${party.partyTime}
										</small>
									</div>
									<div class="col-md-12">
										<small>
											<span class="glyphicon glyphicon-map-marker" aria-hidden="true"></span>
											${party.partyPlace}
										</small>
									</div>
									<div class="col-md-12">
										<small>
											<c:if test="${ !empty party.festival.festivalName}">
												<span class="glyphicon glyphicon-flag" aria-hidden="true"></span>
												${ party.festival.festivalName }
											</c:if>
										</small>
									</div>
									<br>
									<div class="col-md-12">
										<small>
											<c:if test="${ !empty party.festival.festivalNo}">
												<strong>#애프터 파티</strong>
											</c:if>
											<c:if test="${ empty party.festival.festivalNo}">
												<strong>#파티</strong>
											</c:if>
										</small>
									</div>
								
								<br>
							</div>
						</div>
				</div>
			</c:forEach>
		</div>
		
		
		<%-- <div class="container_list">		
			<div class="row_list">
				<input type="hidden" id="currentPageList" name="currentPageList" value="${resultPage.currentPage}"/>
			
				<c:set var="i" value="0" />
				<c:forEach var="party" items="${list}">
					<c:set var="i" value="${ i+1 }" />
					<div id="partyBlock" class="col-sm-6 col-md-4" >
						<div class="thumbnail">
							<a href="#" class="thumbnail_image">
								<img src="../../resources/uploadFile/${party.partyImage}" width="250" height="350"> 
								<input type="hidden" id="partyNo" name="partyNo" value="${party.partyNo }"/>
								<input type="hidden" id="partyFlag" name="partyFlag" value="${ empty party.festival.festivalNo ? '1' : '2' }"/>
							</a> 
							<div class="caption">
								<h3 class="thumbnail_festivalName">${ !empty party.festival.festivalName ? party.festival.festivalName : '' }
								</h3>
								<h3 class="thumbnail_partyName">${ party.partyName }
									<input type="hidden" id="partyNo" name="partyNo" value="${party.partyNo }"/>
								</h3>
								<p>${ party.user.nickname }</p>
								<p>${ party.partyDate }</p>
								<p>${ party.partyPlace }</p>	
							</div>
							<input type="hidden" id="partyNo" name="partyNo" value="${party.partyNo }"/>
							<input type="hidden" id="partyFlag" name="partyFlag" value="${ empty party.festival.festivalNo ? '1' : '2' }"/>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>  --%>
		<!-- 목록 조회 End /////////////////////////////////////-->
	  
 	</div>
 	<!--  화면구성 div End /////////////////////////////////////-->
 	
 	<!-- PageNavigation Start... -->
	<jsp:include page="../../common/pageNavigator_new.jsp"/>
	<!-- PageNavigation End... -->
</body>
</html>