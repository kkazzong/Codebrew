<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!doctype html>
<html lang="kr">
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
    
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	
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
					$("#searchKeyword").val('');
				}
				$("#searchCondition").val('4');
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
		
		
		//=============    파티 상세조회  Event  처리 		=============
		$(function(){	
			/* 파티 상세 조회 */
			$(".gallery-item").on("click", function(){
				console.log($(this).find("input:hidden[name='partyNo']").val());
				var partyNo = $(this).find("input:hidden[name='partyNo']").val()
				self.location = "/party/getParty?partyNo="+partyNo;
			});
			
			/* 파티 삭제 */
			$(".pull-right").each(function(){}).on("click", function(){
				
				if(confirm("파티목록에서 삭제하시겠습니까?")) {
					$(this).parents("#deleteForm").attr("method", "post").attr("action", "/party/deleteMyPartyList").submit();
				} else {
					return;
				}
				
			});
			
		});
		
		
		
		
		
	</script>
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style type="text/css">

	@import url(https://fonts.googleapis.com/css?family=Open+Sans);
	
	*{
	  margin:0;
	  padding:0;
	  box-sizing: border-box;
	  font-family: 'Open Sans', Arial, sans-serif;
	}
	
	.container{
	  padding: 2rem;
	}
	.gallery{
	  width: 100%;
	  max-width: 960px;
	  min-height: 100vh;
	  margin: 2rem auto;
	  
	  display: -webkit-box;
	  display: -webkit-flex;
	  display: -ms-flexbox;
	  display: flex;
	  
	  -webkit-flex-wrap: wrap;
	      -ms-flex-wrap: wrap;
	          flex-wrap: wrap;
	  
	  -webkit-box-pack: center;
	  -webkit-justify-content: center;
	      -ms-flex-pack: center;
	          justify-content: center;
	}
	
	.gallery-item{
	  box-shadow: 2px 2px 8px -1px #001b63;
	  width: 300px;
	  height: 300px;
	  margin: 10px;
	  background: #000;
	  position: relative;
	  cursor: pointer;
	  overflow: hidden;
	}
	
	.gallery-item-image{
	  position: absolute;
	  width: 100%;
	  height: 100%;
	  background: lightblue;
	  z-index:20;
	  -webkit-transition:all .5s ease;
	  transition: all .5s ease;
	  bottom:0;
	  overflow: hidden;
	
	}
	
	.gallery-item:hover .gallery-item-image{
	  bottom: 80px;
	}
	
	.gallery-item-description{
	  color:white;
	  font-size: .8rem;
	  width: 100%;
	  height: 90px;
	  padding: .5rem .8rem;
	  background: #002484;
	  position: absolute;
	  bottom:0;
	  /* margin-bottom:10px; */
	}
	
	body {
	padding-top: 70px;
	background-color: #f2f4f6;
	}
	</style>
	
</head>

<body>

<div class="container">
	<!-- ToolBar Start /////////////////////////////////////-->
	 <%-- <jsp:include page="/toolbar/toolbar.jsp" />  --%>
   	<!-- ToolBar End /////////////////////////////////////-->


  <div class="gallery">
  	<!-- 목록 조회 Start /////////////////////////////////////-->
	 <!--  <div class="row"> -->
		
			<c:forEach var="party" items="${list}">
				<c:set var="i" value="${i+1}"></c:set>
				
					<div class="gallery-item">
				      <div class="gallery-item-image">
				        <img width="100%" height="100%" src="/resources/uploadFile/${party.partyImage}">
				      </div>
				      <div class="gallery-item-description">
				        <h3>${ party.partyName }
				        	<input type="hidden" name="partyNo" value="${party.partyNo}">
				        </h3>
				        <div class='col-xs-10'>
				        <!-- <span> -->
				        	<span class="glyphicon glyphicon-calendar" aria-hidden="true"></span>
							${party.partyDate}
							&nbsp; 
							<span class="glyphicon glyphicon-time" aria-hidden="true"></span>
							${party.partyTime}
							&nbsp;
							<c:if test="${ !empty party.festival.festivalNo}">
								<strong>#애프터 파티</strong>
							</c:if>
							<c:if test="${ empty party.festival.festivalNo}">
								<strong>#파티</strong>
							</c:if>
						<!-- </span> -->
						</div>
						<div class='col-xs-2 '>
						<!-- <span> -->
							<!-- 삭제버튼 -->
							<form id="deleteForm">
									<input type="hidden" name="partyNo" value="${party.partyNo}">
									
									<c:if test="${search.searchCondition == '3' }">
										<button class="btn btn-xs btn-warning pull-right" type="button" value="${party.partyNo}">
											<small><span class="glyphicon glyphicon-trash" aria-hidden="true"></span></small>
										</button>
									</c:if>
							</form>
							<div class="clearfix"></div>
						<!-- </span> -->
						</div>
					</div>
				  </div>
						
			</c:forEach>
		<!-- </div> -->
	</div>
</div>
		
	
		<!-- 목록 조회 End /////////////////////////////////////-->
    

    <!-- <div class="gallery-item">
      <div class="gallery-item-image">
        <img src="http://www.blueb.co.kr/SRC2/_image/v01.jpg"></div>
      <div class="gallery-item-description">
        <h3>Image title</h3><span>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Dignissimos, quia.</span></div>
    </div>
    <div class="gallery-item">
      <div class="gallery-item-image">
        <img src="http://www.blueb.co.kr/SRC2/_image/w02.jpg"></div>
      <div class="gallery-item-description">
        <h3>Image title</h3><span>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Dignissimos, quia.</span></div>
    </div>
    <div class="gallery-item">
      <div class="gallery-item-image">
        <img src="http://www.blueb.co.kr/SRC2/_image/w03.jpg"></div>
      <div class="gallery-item-description">
        <h3>Image title</h3><span>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Dignissimos, quia.</span></div>
    </div>
    <div class="gallery-item">
      <div class="gallery-item-image">
        <img src="http://www.blueb.co.kr/SRC2/_image/s_01.jpg"></div>
      <div class="gallery-item-description">
        <h3>Image title</h3><span>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Dignissimos, quia.</span></div>
    </div>
    <div class="gallery-item">
      <div class="gallery-item-image">
        <img src="http://www.blueb.co.kr/SRC2/_image/s_02.jpg"></div>
      <div class="gallery-item-description">
        <h3>Image title</h3><span>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Dignissimos, quia.</span></div>
    </div>
  </div> -->
</div>

</body>
</html>
