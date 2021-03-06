<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="http://code.jquery.com/jquery-3.2.1.min.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<script type="text/javascript">
   function fncGetList(currentPage) {
	   
	    $("#currentPage").val(currentPage)
	   
	   $("form").attr("method" , "POST").attr("action" , "/festival/getFestivalListDB?menu=pop").submit();
	   
	}  
   
   $(function(){
		 $( "button:contains('검색')" ).on("click" , function() {
			/* alert("검색누름"); */
			fncGetList(1);
		});
});
	
$(function(){
		
		$("input:text[name='searchKeyword']").on('keydown',function(event){
			
			if(event.keyCode ==13){
				event.preventDefault();
				$( "button:contains('검색')" ).click();
			}
		});
	
	});
	
	
$(function() {
	/* $(".panel-body").on("click", function() { */
		$(".getDB").on("click", function() {
		var festivalNo = $("p", this).text();
		 
			$.ajax( 
					{
						url : "/festivalRest/json/getFestivalDB/"+festivalNo,
						method : "GET" ,
						dataType : "json" ,
						headers : {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
						},
						success : function(JSONData , status) {
							/* alert("festivalNo..." + JSONData.festivalNo); */
							
							$("#returnFestivalNo").val(JSONData.festivalNo);							
							$("#returnFestivalName").val(JSONData.festivalName); 
							$("#returnStartDate").val(JSONData.startDate);
							$("#returnEndDate").val(JSONData.endDate);
							$("#returnAddr").val(JSONData.addr);
							
							opener.document.getElementById("festivalNo").value = document.getElementById("returnFestivalNo").value
						    opener.document.getElementById("festivalName").value = document.getElementById("returnFestivalName").value
						    opener.document.getElementById("addr").value = document.getElementById("returnAddr").value
						    
							window.close();
							
						}
				});
		});
	
});
	
$(function() {
	
	$("#searchKeyword").autocomplete({
		source: function( request, response ) {
	        $.ajax( {
	          url: "/festivalRest/json/getKeyword",
	          method : "POST",
	          headers : {
					"Accept" : "application/json",
					"Content-Type" : "application/json"
			  },
	          dataType: "json",
	          data: JSON.stringify({
	        	currentPage : "1",
		        searchKeyword : $("#searchKeyword").val(),
		        searchCondition : ""
	          }),
	          success: function( JSONData ) {
	            response($.map(JSONData, function(value, key){
	            	console.log(value.festivalNo);
	            	
	            	var festivalNo = value.festivalNo;
	            	
	            	$("#festivalNo").val(festivalNo);
	            	
	            		return {
	            			label :  value.festivalName,
	            			value : value.festivalName
	            		}
		        	}));
		          }
	        });
	    }
	});
});
	
</script>

<style type="text/css">
	body {
			padding-top : 70px;
			background-color: #f2f4f6;
	    }
	    
	    .card {
			margin-top : 50px;
	    }
	    
	    .panel-primary>.panel-heading {
	    	background-color: #000000;
	    }
	    
	    .text-info {
	    	color: #333333; 
	    }
	    
	    .page-header {
	    	border-bottom : 1px solid #f2f4f6;
	    }
	    
	    
	    .section {
	    	margin-top : 400px;
	    }
	    
	    em {
	    	font-family: tahoma;
	    }
	    
</style>

</head>
<body>
	<div class="container">
	
  	<div class="row">
  	
  	<div class="col-md-12">
  	
  		<div class="page-header text-center">
					<h3 class="text-info">축제를 검색해주세요.</h3>
				</div>


	<form>
	
	전체 게시물 수 : ${resultPage.totalCount }
		<br/>
		현재 페이지 : ${resultPage.currentPage }
		
		<br/>
		<br/>
		<br/>
			    지역검색
				  <div class="form-group">
				    <select class="form-control" name="searchCondition" >
					<option value="" ${ ! empty search.searchCondition && search.searchCondition=="" ? "selected" : "" }>전체지역</option>
					<option value="1" ${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>>서울</option>
					<option value="2" ${ ! empty search.searchCondition && search.searchCondition==2 ? "selected" : "" }>>인천</option>
					<option value="3" ${ ! empty search.searchCondition && search.searchCondition==3 ? "selected" : "" }>>대전</option>
					<option value="4" ${ ! empty search.searchCondition && search.searchCondition==4 ? "selected" : "" }>>대구</option>
					<option value="5" ${ ! empty search.searchCondition && search.searchCondition==5 ? "selected" : "" }>>광주</option>
					<option value="6" ${ ! empty search.searchCondition && search.searchCondition==6 ? "selected" : "" }>>부산</option>
					<option value="7" ${ ! empty search.searchCondition && search.searchCondition==7 ? "selected" : "" }>>울산</option>
					<option value="8" ${ ! empty search.searchCondition && search.searchCondition==8 ? "selected" : "" }>>세종특별자치시</option>
					<option value="31" ${ ! empty search.searchCondition && search.searchCondition==31 ? "selected" : "" }>>경기도</option>
					<option value="32" ${ ! empty search.searchCondition && search.searchCondition==32 ? "selected" : "" }>>강원</option>
					<option value="33" ${ ! empty search.searchCondition && search.searchCondition==33 ? "selected" : "" }>>충정북도</option>
					<option value="34" ${ ! empty search.searchCondition && search.searchCondition==34 ? "selected" : "" }>>충청남도</option>
					<option value="35" ${ ! empty search.searchCondition && search.searchCondition==35 ? "selected" : "" }>>경상북도</option>
					<option value="36" ${ ! empty search.searchCondition && search.searchCondition==36 ? "selected" : "" }>>경상남도</option>
					<option value="37" ${ ! empty search.searchCondition && search.searchCondition==37 ? "selected" : "" }>>전라북도</option>
					<option value="38" ${ ! empty search.searchCondition && search.searchCondition==38 ? "selected" : "" }>>전라남도</option>
					<option value="39" ${ ! empty search.searchCondition && search.searchCondition==39 ? "selected" : "" }>>제주도</option>
					
				</select>
				</div>
				정렬
				  <div class="form-group">
				    <select class="form-control" name="arrange" >
					<option value="" ${ ! empty search.arrange && search.arrange=="" ? "selected" : "" }>>정렬</option>
					<option value="A" ${ ! empty search.arrange && search.arrange=="A" ? "selected" : "" }>>제목</option>
					<option value="B" ${ ! empty search.arrange && search.arrange=="B" ? "selected" : "" }>>조회순</option>
					<option value="C" ${ ! empty search.arrange && search.arrange=="C" ? "selected" : "" }>>최근시작일순</option>
					<option value="D" ${ ! empty search.arrange && search.arrange=="D" ? "selected" : "" }>>축제종료일순</option>
				</select>
				</div>
				
				
				 <div class="form-group">
				    <label class="sr-only" for="searchKeyword">검색어</label>
				    <input type="text" class="form-control" id="searchKeyword" name="searchKeyword"  placeholder="검색어"
				    			 value="${! empty search.searchKeyword ? search.searchKeyword : '' }"  >
				  </div>

		<button type="button" class="btn btn-default btn-block">검색</button>
		
		<br/>
		<br/>
		
		
		<section>
		<div class="row">
		
		<c:forEach var="festival" items="${list}">
		
			<c:if test="${festival.deleteFlag == null }">
			
			<div class="col-md-6">
						<!-- <div class="panel panel-primary"> -->
						<div class="card">
							<div class="getDB">
								<c:if test="${festival.festivalImage.contains('http://')==true }">
									<img class="card-img-top" src="${festival.festivalImage }" width="100%" height="423" />
								</c:if>
								
								<c:if test="${festival.festivalImage.contains('http://')==false }">
									<img class="card-img-top" src="../../resources/uploadFile/${festival.festivalImage }" width="100%" height="423" />
								</c:if>
								
								<div id="festivalNo" style="display: none">
											<p>${festival.festivalNo }</p>
								</div> 
								</div>
					<div class="card-body">
					
						<div class="festivalInfo">
									
									<div class="col-md-12">
											<h5><Strong>${festival.festivalName}</Strong></h5>
									</div>
									
									<div class="col-md-12">
										<span class="glyphicon glyphicon-calendar" aria-hidden="true"></span>
										<Strong>${festival.startDate} ~ ${festival.endDate}</Strong>
									</div>
									
									<div class="col-md-12">
										 <span class="glyphicon glyphicon-map-marker" aria-hidden="true"></span>
										 <Strong>${festival.addr } </Strong>
									</div>
									
									
									</div>
									
							</div>
						</div>
				</div>	
			
			
			</c:if>
			
			</c:forEach>
		</div>
		</section>
		
		<input type = hidden id="currentPage" name = "currentPage" value = ${i } />
			
			<jsp:include page="../../common/pageNavigator_new.jsp"/>
			
			
				</form>
	</div>
	</div>
	</div>
	
	<input type="hidden" id="returnFestivalName">
	<input type="hidden" id="returnFestivalNo">
	<input type="hidden" id="returnAddr">
	<input type="hidden" id="returnStartDate">
	<input type="hidden" id="returnEndDate">


    


	</body>
</html>