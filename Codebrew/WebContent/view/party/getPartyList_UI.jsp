<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- <%@ include file="/data/purchaseData.jsp" %> --%>
<%-- <%@ include file="/data/purchase/userData.jsp" %> --%>
<%-- <%@ include file="/data/purchase/sessionData.jsp" %> --%>
<!DOCTYPE html>
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>파티 목록 조회</title>

<!-- 참조 : http://getbootstrap.com/css/   참조 -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">

<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">

<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

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
			
		
		});
		
		//=============    전체 파티 목록  Event  처리 		=============
		$(function(){
			$("#title").on("click", function() {
				$("#searchKeyword").val("");
				$("#searchCondition").val("");
				fncGetList(1);
			});
		});
		
		
		//=============    애프터파티 등록하러 가기  Event  처리 		=============
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

<style type="text/css">
body {
	padding-top: 70px;
	/* background-color: #b5121b; 할리스커피 로고 색*/ 
	background-color: #ece5df;
}
#main {
	background-image: url(/resources/image/ui/party_banner2.jpg);
	width: 100%;
	height: 500px;
	/* height: 100%; */
	background-size: 100%;
	opacity: 1.0;
	/* background-color: #556180; */
}
.title {
		color: white;
		text-shadow:1px 1px 1px black;
} 
.search-main img {
	width: 40px;
	margin-top: 2px;
}
div.col-md-4 img {
	padding-top: 20px;
	padding-left: 20px;
	padding-right: 20px;
	transition: color 0.3s ease, background-color 0.3s ease, border-color 0.3s ease, box-shadow 0.3s ease;
}
.list-content {
	padding-left: 20px;
	padding-right: 20px;
}
#list {
	background-color: #ffffff;
}
h3.text-center {
	margin-bottom: 2rem;
}
.row margin-top-10 margin-bot-10{
	margin-top: 10px;
	margin-bottom: 10px;
}
.col-md-12 margin-top-30{
	margin-top: 30px;
}

</style>
</head>
<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/toolbar/toolbar.jsp" />
	<!-- ToolBar End /////////////////////////////////////-->

	<div class="container-fluid">
		<!-- page header -->
		<div class="row" id="main">
			<div class="col-md-12">
				<div>
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
										<!-- <div class="form-select"> -->
										<div class="col-md-12 control-label">
											<span class="col-md-3 control-label"><button
													type="button" class="btn btn-default">파티</button></span> <span
												class="col-md-6 control-label"><button type="button"
													class="btn btn-default">애프터 파티</button></span> <input
												type="hidden" class="form-control" id="searchCondition"
												name="searchCondition"
												value="${ ! empty search.searchCondition ? search.searchCondition : '' }">
											<input type="hidden" id="currentPage" name="currentPage"
												value="" />
										</div>

										<!-- </div> -->
									</div>
									<br>
									<div class="form-group">
										<label class="sr-only" for="searchKeyword">검색어</label>

										<c:if
											test="${ !empty search.searchCondition && search.searchCondition == '5' }">
											<input type="text" class="form-control" id="searchKeyword"
												name="searchKeyword" value="">
										</c:if>
										<c:if test="${ search.searchCondition != '5' }">
											<input type="text" class="form-control" id="searchKeyword"
												name="searchKeyword"
												value="${! empty search.searchKeyword ? search.searchKeyword : '' }">
										</c:if>
										<%-- <input type="text" class="form-control" id="searchKeyword" name="searchKeyword" value="${! empty search.searchKeyword ? search.searchKeyword : '' }"> --%>
										<!-- <button type="button" class="btn btn-default btn-block">검색</button>	 -->
										<a id="search" class="click" type="button"> <img
											src="/resources/image/buttonImage/btn_nav_search_white@3x.png">
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

	<!-- 데이터 수 -->
	<div class="row">
		<div class="col-md-12">
			<h5>총 ${resultPage.totalCount} 건 (${resultPage.currentPage} 페이지
				/ ${resultPage.maxPage} 페이지)</h5>
		</div>
	</div>

	<!-- 애프터파티 파티 조회시 출력 -->
	<div class="row">
		<div class="col-md-2">

			<div class="form-group">
				<c:if test="${ search.searchCondition == '5' }">
					<button type="button" class="btn btn-default">
						<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>
						&nbsp;애프터파티 등록하러 가기
					</button>
				</c:if>
			</div>

		</div>
	</div>


	<div class="container-fluid">
		<div class="container">
			<div class="row margin-top-10 margin-bot-10">
				<div class="col-md-12 margin-top-30">

					<div class="events">
						<h3 class="text-center">다가오는 이벤트</h3>
						<div class="list-wrap grid row">

							<c:if test="${empty list}">
								<%-- <jsp:include page="/view/purchase/noResult.jsp"></jsp:include> --%>
							</c:if>
							<c:forEach var="party" items="${list}">
								<c:set var="i" value="${i+1}"></c:set>


								<div class="col-md-4">

									<!-- 목록 조회 Start /////////////////////////////////////-->

									<div class="row">
										<div id="list">
											<div class="list-thumbnail">
												<!-- 파티 -->
												<input type="hidden" name="partyNo" value="${party.partyNo}">
												<img width="100%" height="100%"
													src="/resources/uploadFile/${party.partyImage}">
											</div>
											<div class="list-content">
												<div class="list-name">
													<h4>
														<strong> ${party.partyName} </strong>
													</h4>
												</div>
												<div class="list-date">
													<small> <span class="glyphicon glyphicon-calendar"
														aria-hidden="true"></span> ${party.partyDate}
													</small>
												</div>
												<div class="list-time">
													<small> <span class="glyphicon glyphicon-time"
														aria-hidden="true"></span> ${party.partyTime}
													</small>
												</div>
												<div class="list-addr">
													<small> <span
														class="glyphicon glyphicon-map-marker" aria-hidden="true"></span>
														${party.partyPlace}
													</small>
												</div>
												<div class="list-festival">
													<small> <c:if
															test="${ !empty party.festival.festivalName}">
															<span class="glyphicon glyphicon-flag" aria-hidden="true"></span>
																				${ party.festival.festivalName }
																			</c:if>
													</small>
												</div>
												<br>
												<div class="list-festival-tag">
													<small> <c:if
															test="${ !empty party.festival.festivalNo}">
															<strong>#애프터 파티</strong>
														</c:if> <c:if test="${ empty party.festival.festivalNo}">
															<strong>#파티</strong>
														</c:if>
													</small>
												</div>

												<br>
											</div>
										</div>
									</div>
									<!-- 목록 조회 End /////////////////////////////////////-->
								</div>

							</c:forEach>
						</div>
					</div>

					<!-- <div class="text-center margin-bot-30">
						<a class="btn-primary" href="/ko/events">전체 이벤트 보기</a>
					</div> -->

				</div>
			</div>
		</div>
	</div>

	<div class="row">
		<!-- 내가 만든 페이지네비게이터 -->
		<jsp:include page="../../common/pageNavigator_new.jsp" />
		<%-- <jsp:include page="../../common/pageNavigator.jsp"/> --%>
	</div>



</body>
</html>