<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        
<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>My파티 목록 조회</title>

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
	
	<!-- <script src="date.js" type="text/javascript"></script>
	<script src="time.js" type="text/javascript"></script> -->
	
	<!--  ///////////////////////// JavaScript ////////////////////////// -->
    <script type="text/javascript">
	
		//=============    검색 / page 두가지 경우 모두  Event  처리	 =============	
		function fncGetList(currentPage) {
				$("#currentPage").val(currentPage)
				$("form").attr("method" , "POST").attr("action", "/party/getMyPartyList").submit();
		} 
		
		$(function(){
			$("#search").on("click", function() {
				console.log( $("button[type=button]:contains('검색')").html() );
				fncGetList(1);
			});
			
			$("input[name=searchKeyword]").on('keydown',function(event){
				if(event.keyCode ==13){
					fncGetList(1);
				}
			});
			
		});	
		
		
		//=============    파티상세조회(썸네일)  Event  처리 		=============
		/* $(function(){
			$("a.thumbnail_image").on("click", function() {
				
				var partyNo = $( "input[name=partyNo]", $(this) ).val();
				var partyFlag = $( "input[name=partyFlag]", $(this) ).val();
				
				console.log(partyNo+" / "+partyFlag);
				//console.log( $( "a.thumbnail_image img", $(this) ).val() );
				self.location="/party/getParty?partyNo="+partyNo+"&partyFlag="+partyFlag;
		
			});
		}); 
		*/
		
		
		//=============    searchCondition 파티  Event  처리 		=============
		$(function(){
			
			$("button:contains('지난 파티')").on("click", function() {
				if( $("#searchCondition").val() != "3"){
					console.log("지난 파티 버튼");
					$("#searchKeyword").val("");
				}
				$("#searchCondition").val("3");
				fncGetList(1);
			});
			
			$("button:contains('진행중인 파티')").on("click", function() {
				
				if( $("#searchCondition").val() != "4"){
					console.log("진행중인 파티 버튼");
					$("#searchKeyword").val("");
				}
				$("#searchCondition").val("4");
				fncGetList(1);
				
			});
			
		});
		
		
		//=============    전체 파티 목록  Event  처리 		=============
		$(function(){
			$("#title").on("click", function() {
				$("#searchKeyword").val("");
				$("#searchCondition").val("");
				fncGetList(1);
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
		
		//=============    파티 삭제  Event  처리 		=============
		/* $(function(){
			$("button:contains('파티 삭제')").on("click", function() {
				var partyNo = $( "input[name=partyNo]", $(this) ).val();
				self.location="/party/deleteParty?partyNo=";
		
			});
		}); */
		
		
		//=============    파티 참여 취소  Event  처리 		=============
		/* $(function(){
			$("button:contains('파티 참여 취소')").on("click", function() {
				
				var partyNo = $(this).val();
				console.log("파티 참여 취소 :: partyNo :: "+partyNo);
				self.location="/party/cancelParty?partyNo="+partyNo;
		
			});
		}); */
		
		
		//=============    티켓 구매 취소  Event  처리 		=============
		/* $(function(){
			$("button:contains('티켓 구매 취소')").on("click", function() {
				var partyNo = $( "input[name=partyNo]", $(this) ).val();
				self.location="/purchase/cancelPurchase";
		
			});
		}); */
		
		
		//=============    현재 시간  Event  처리 		=============
		 /* function time(){
		
		    var today = new Date();
		    var y = today.getFullYear();
		    console.log("y = "+y);
		    var m = today.getMonth()+1;
		    console.log("m = "+m);
		    var d = today.getDate();
		    console.log("d = "+d);
		    m = checkTime(m);
		    d = checkTime(d);
		    
		    var t = setTimeout(time, 500);
		    console.log(y + "/" + m + "/" + d);
		    return y + "/" + m + "/" + d;
		}
		
		function checkTime(i){
		
		    if (i < 10) {i = "0" + i}; // 숫자가 10보다 작을 경우 앞에 0을 붙여줌
		    console.log("i = "+i);
		    return i;
		} 

		*/
		/*
		$(function compareTime(){
			
			var partyDate = $( "partyDate", $(this) ).text();
			var now = time();
			console.log("partyDate = "+partyDate);
			console.log("now = "+now);
			//var parPartyDate = Date.parse(partyDate);
			var result = now - partyDate;
			console.log("now - partyDate = "+result)
			/* var result = time().compareTo(partyDate); 
			var deleteButton = "<button type='button' class='btn btn-default' >삭제</button>";
			var cancelButton = "<button type='button' class='btn btn-default' >참여취소</button>";

			if(result > 0){
				
				$(".caption").append(deleteButton);
			}else{
				$(".caption").append(cancelButton);
			}
		}); */
		
		
		
	</script>
	
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style type="text/css">
		
		body {
	     	padding-top : 70px;
	    }
	    
	    .panel {
			margin-top : 50px;
	    }
	    
	    .panel-primary>.panel-heading {
    		background-color: #000000;
    	}
	    
		.panel-heading h2 {
		    white-space: nowrap;
		    overflow: hidden;
		    text-overflow: ellipsis;
		    line-height: normal;
		    width: 75%;
		    padding-top: 8px;
		}
	    
	</style>
	
</head>
<!-- <body onload="startTime()"> -->
<body>
	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/toolbar/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
   	
	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container">
	  <div class="row">
			<div class="col-md-12">
				<div class="page-header text-center">
					<h2 class="text-info">MY파티 리스트</h2>
				</div>
			</div>
		</div>
	  
	  <!-- 목록 위 검색 Start /////////////////////////////////////-->
	    <div class="row">
	    
		    <!-- 데이터 수 -->
			<div class="row">
				<div class="col-md-12">
					<h5>총 : ${resultPage.totalCount} 건 (${resultPage.currentPage} / ${resultPage.maxPage})</h5>
				</div>
			</div>
		    
		    <!-- 검색 -->
			<div class="col-md-12 text-right">
				<form class="form form-inline" id="searchForm" name="searchForm">
					
					<button type="button" class="btn btn-default" >진행중인 파티</button>
					<button type="button" class="btn btn-default" >지난 파티</button>
					<input type="hidden" class="form-control" id="searchCondition" name="searchCondition" value="${ ! empty search.searchCondition ? search.searchCondition : '' }">
					<!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
					<input type="hidden" id="currentPage" name="currentPage" value=""/>
					<div class="input-group">
						<input class="form-control" id="searchKeyword" name="searchKeyword" type="text" 
									value="${!empty search.searchKeyword ? search.searchKeyword : ''}"
									placeholder="파티 이름으로 검색">
						<span class="input-group-btn">
					    	<button id="search" class="btn btn-primary btn-block" type="button">
					    		<span class="glyphicon glyphicon-search" aria-hidden="true"></span> 
					    	</button>
					    </span>
					</div>
				</form>
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
								<img class="img-circle" src="/resources/uploadFile/${party.user.profileImage}" width="50" height="50">
								&nbsp; ${ party.user.nickname }</h3>
								
        						<div class="clearfix"></div>
							</div>
							<div class="panel-body">
								<!-- 파티 -->
								<input type="hidden" name="partyNo" value="${party.partyNo}">
									<img width="100%" height="300" src="/resources/uploadFile/${party.partyImage}">
									<!-- <hr> -->
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
				
				<div id="clock"></div>
				
				<c:set var="i" value="0" />
				<c:forEach var="party" items="${list}">
					<c:set var="i" value="${ i+1 }" />
					<div id="partyBlock" class="col-sm-6 col-md-4" >
						<div class="thumbnail">
							<a href="#" class="thumbnail_image">
								<img src="../../resources/uploadFile/${party.partyImage}" width="300" height="350"> 
								<input type="hidden" id="partyNo" name="partyNo" value="${party.partyNo }"/>
							</a> 
							<div class="caption">
								<h3 class="thumbnail_festivalName">${ !empty party.festival.festivalName ? party.festival.festivalName : '' }	
								</h3>
								<h3 class="thumbnail_partyName">${ party.partyName }</h3>
								<p>${ party.user.nickname }</p>
								<p id = partyDate>${ party.partyDate }</p>
								<p>${ party.partyPlace }</p>
								<p>
								
								<c:if test="${ !empty search.searchCondition }">
									<c:if test="${ party.user.userId != user.userId }">
										<c:choose>
											<c:when test="${ search.searchCondition == '3' }">
												<button type="button" class="btn btn-primary" value="${party.partyNo }">파티 삭제</button>
											</c:when>
											<c:when test="${ search.searchCondition == '4' }">
												<c:if test="${ empty party.festival.festivalNo }">
													<button type="button" class="btn btn-primary" value="${party.partyNo }">티켓 구매 취소</button>
												</c:if>
												<c:if test="${ !empty party.festival.festivalNo }">
													<button type="button" class="btn btn-primary" value="${party.partyNo }">파티 참여 취소</button>
												</c:if>
											</c:when>
										</c:choose>
									</c:if>	
								</c:if>
								<c:if test="${ !empty search.searchCondition && search.searchCondition == '3' }">
									<button type="button" class="btn btn-primary" value="${party.partyNo }">파티 삭제</button>
	
								</c:if>
								<c:if test="${ !empty search.searchCondition && search.searchCondition == '4' }">
									<c:if test="${ empty party.festival.festivalNo }">
										<button type="button" class="btn btn-primary" value="${party.partyNo }">티켓 구매 취소</button>
										
									</c:if>
									<c:if test="${ !empty party.festival.festivalNo }">
										<button type="button" class="btn btn-primary" value="${party.partyNo }">파티 참여 취소</button>
										
									</c:if>
								</c:if>
								</p>
							</div>
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