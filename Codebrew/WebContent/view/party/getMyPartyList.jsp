<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
    
<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
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
	
	
	<!--  ///////////////////////// JavaScript ////////////////////////// -->
    <script type="text/javascript">
	
		//=============    검색 / page 두가지 경우 모두  Event  처리	 =============	
		/* function fncGetList(currentPage) {
				$("#currentPage").val(currentPage)
				$("form").attr("method" , "POST").attr("action", "/product/listProduct/${menu}").submit();
		} 
		
		$(function(){
			$("button[type=button]").bind("click", function() {
				console.log( $("button[type=button]:contains('검색')").html() );
				fncGetList(1);
			});
			
			
		}); */		
		
		
		//=============    상품상세조회(썸네일)  Event  처리 		=============
		$(function(){
			$("#partyBlock").on("click", function() {
				
				var partyNo = $( "input[name=partyNo]", $(this) ).val();
				
				console.log( $( "a.thumbnail_image img", $(this) ).val() );
				self.location="/party/getParty/"+partyNo;
		
			});
		});
		
		//=============    Select 지난 파티  Event  처리 		=============
		$(function(){
			$("button:contains('지난 파티')").on("click", function() {
				self.location="/party/getParty/3";
		
			});
		});
		
		//=============    Select 진행중인 파티  Event  처리 		=============
		$(function(){
			$("button:contains('진행중인 파티')").on("click", function() {
				self.location="/party/getParty/4";
		
			});
		});
		
		//=============    Select 진행중인 파티  Event  처리 		=============
		$(function(){
			$("button:contains('삭제')").on("click", function() {
				self.location="/party/deleteParty";
		
			});
		});
		
		
	</script>
	
</head>
<body>

	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container">
	  <div class="page-header text-info">
   		   <h2 align="center">파티 목록</h2>
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
			    
				  <div class="form-group">
				    <div class="form-select">
						<button type="button" class="btn btn-default" >진행중인 파티</button>
						<button type="button" class="btn btn-default" >지난 파티</button>
						
					</div>
				  </div>
				  
				  <div class="form-group">
				    <label class="sr-only" for="searchKeyword">검색어</label>
				    <input type="text" class="form-control" id="searchKeyword" name="searchKeyword" 
				    			 value="${! empty search.searchKeyword ? search.searchKeyword : '' }"  >
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
					<div class="col-sm-6 col-md-4" >
						<div class="thumbnail">
							<a href="#" class="thumbnail_image">
								<img src="../../images/uploadFiles/${party.fileName}" width="300" height="350"> 
								<input type="hidden" id="prodNo" name="prodNo" value="${party.partyNo }"/>
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
								<button type="button" class="btn btn-default" >삭제</button>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
		</div> 
		
		
		  
		
	 
	  
 	</div>
 	<!--  화면구성 div End /////////////////////////////////////-->
</body>
</html>