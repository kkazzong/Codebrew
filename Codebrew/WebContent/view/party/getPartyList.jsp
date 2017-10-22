<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">

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
			$("button:contains('검색')").on("click", function() {
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
		});
		
		//=============    전체 파티 목록  Event  처리 		=============
		$(function(){
			$("#title").on("click", function() {
				$("#searchKeyword").val("");
				$("#searchCondition").val("");
				fncGetList(1);
			});
		});
		
	</script>
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
	  body {
            padding-top : 50px;
          }
      
      .thumbnail a {
    	display: block;
   		width:300px; height:200px;
   		overflow:hidden;
   		margin:auto;
   		vertical-align:middle;
		}    
    </style>
</head>
<body>
	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/toolbar/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->

	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container">
	  <div class="page-header text-info">
   		   <h2 align="center" id="title">파티 목록</h2>
	  </div>
	  
	  <!-- table 위쪽 검색 Start /////////////////////////////////////-->
	    <div class="row">
	    
		    <div class="col-md-6 text-left">
		    	<p class="text-primary">
		    		전체  ${resultPage.totalCount } 건수
   		
		    	</p>
		    </div>
		    
		    <div class="col-md-6 text-right">
			    <form class="form-inline" name="detailForm">
			    
				  <div class="form-group ">
				    <div class="form-select">
						<button type="button" class="btn btn-default" >파티</button>
						<button type="button" class="btn btn-default" >애프터 파티</button>
						<input type="hidden" class="form-control" id="searchCondition" name="searchCondition" value="${ ! empty search.searchCondition ? search.searchCondition : '' }">
						
					</div>
				  </div>
				  
				  <div class="form-group">
				    <label class="sr-only" for="searchKeyword">검색어</label>
				    <input type="text" class="form-control" id="searchKeyword" name="searchKeyword" value="${! empty search.searchKeyword ? search.searchKeyword : '' }">

				    <button type="button" class="btn btn-default">검색</button>			 
				  </div>		  
				  
				  <!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
				  <input type="hidden" id="currentPage" name="currentPage" value=""/>
				  
				</form>
	    	</div>
	    	
		</div>
	  <!-- table 위쪽 검색 End /////////////////////////////////////-->
	  
	  <br/>
	  
	  <!-- table 목록 조회 Start /////////////////////////////////////-->
		<div class="container_list">		
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
									<%-- <input type="hidden" id="partyNo" name="partyNo" value="${party.partyNo }"/> --%>
								</h3>
								<p>${ party.user.nickname }</p>
								<p>${ party.partyDate }</p>
								<p>${ party.partyPlace }</p>	
							</div>
							<%-- <input type="hidden" id="partyNo" name="partyNo" value="${party.partyNo }"/>
							<input type="hidden" id="partyFlag" name="partyFlag" value="${ empty party.festival.festivalNo ? '1' : '2' }"/> --%>
						</div>
					</div>
				</c:forEach>
			</div>
		</div> 
		<!-- table 목록 조회 End /////////////////////////////////////-->
	  
 	</div>
 	<!--  화면구성 div End /////////////////////////////////////-->
 	
 	<!-- PageNavigation Start... -->
	<jsp:include page="../../common/pageNavigator_new.jsp"/>
	<!-- PageNavigation End... -->
</body>
</html>