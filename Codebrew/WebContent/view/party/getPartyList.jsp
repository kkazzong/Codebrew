<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
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
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <!-- <link rel="stylesheet" href="/resources/demos/style.css"> -->
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>

	<!-- Jquery DatePicker -->
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

	<!-- card css -->
	<link rel="stylesheet" href="/resources/css/card.css">

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
		
		
		//=============    애프터파티 등록하러 가기  Event  처리 		=============
		$(function(){
			$("button:contains('애프터파티 등록하러 가기')").on("click", function() {
				
				self.location = "/party/addParty?festivalNo=${search.searchKeyword}";
			});
		});
		
		
		//=============    판넬  Event  처리 		=============
		$(function(){	
			
			/* 카드 높이 조절 */
			var maxHeight = -1;
	
			$('.card').each(function() {
				maxHeight = maxHeight > $(this).height() ? maxHeight : $(this).height();
			});
	
			$('.card').each(function() {
				 $(this).height(maxHeight);
			});
			
			
			/* 파티 상세 조회 */
			$(".card").on("click", function(){
				console.log($(this).find("input:hidden[name='partyNo']").val());
				var partyNo = $(this).find("input:hidden[name='partyNo']").val()
				self.location = "/party/getParty?partyNo="+partyNo;
			})
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
    .panel-primary {
    	border-color : #3e3e3d;
    }
    .panel-primary > .panel-heading {
    	background-image :linear-gradient(to bottom,#333 0,#333 100%);
    }
    .panel {
    	box-shadow : 9px 7px 10px rgba(154, 143, 143, 0.98);
    }
    .section {
    	margin-top : 400px;
    }
	#banner {
		background: url(https://cdnstrgcu01.azureedge.net/web/banners/banner_1.jpg) center center no-repeat;
	    background-size: cover;
	    height: 21.75rem;
	    text-align: center;
	    -ms-flex-align: center;
	    align-items: center;
	    display: -ms-flexbox;
	    display: flex;
	    -ms-flex-flow: column;
	    flex-flow: column;
	    -ms-flex-pack: center;
	    justify-content: center;
	    /* opacity: 0; */
	    /* pointer-events: none; */
	    transition: opacity .5s ease-out;
	    color: #FFF;
	    /* width: 100%; */
	}
	.title {
		color: white;
		text-shadow:1px 1px 1px black;
	} 
	.text-center white {
		line-height: 500px; 
		/* top: 25%;
		position: relative;
		text-align: center; */
	}
	a > img {
	    width: 40px;
	    margin-top: 2px; 
	    /* background-color: gray; */

	}
	/* span.input-group-btn {
		background-color: gray;
	} */
	
	/* 파티 플래그 버튼 */
	.button-3d {
	  position:relative;
	  width: auto;
	  display:inline-block;
	  color:#ecf0f1;
	  text-decoration:none;
	  border-radius:5px;
	  border:solid 1px #f39c12;
	  background:#e67e22;
	  text-align:center;
	  padding:16px 18px 14px;
	  margin: 12px;
	  
	  -webkit-transition: all 0.1s;
		-moz-transition: all 0.1s;
		transition: all 0.1s;
		
	  -webkit-box-shadow: 0px 6px 0px #d35400;
	  -moz-box-shadow: 0px 6px 0px #d35400;
	  box-shadow: 0px 6px 0px #d35400;
	}
	
	.button-3d:active{
	    -webkit-box-shadow: 0px 2px 0px #d35400;
	    -moz-box-shadow: 0px 2px 0px #d35400;
	    box-shadow: 0px 2px 0px #d35400;
	    position:relative;
	    top:4px;
	}
	.searchbar {background: none;}
	.searchbar input, .d5 button {
	  outline: none;
	  background: transparent;
	}
	.searchbar input {
	  width: 50%;
	  height: 42px;
	  padding-left: 15px;
	  border: 3px solid #F9F0DA;
	}
	.searchbar button {
	  border: none;
	  height: 42px;
	  width: 42px;
	  position: absolute;
	  top: 0;
	  right: 0;
	  cursor: pointer;
	}
	.searchbar button:before {
	  content: "\f002";
	  font-family: FontAwesome;
	  font-size: 20px;
	  color: #F9F0DA;
	}
	.searchbar input:focus {
	  border-color: #6dc6ed;
	}
</style>
</head>
<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/toolbar/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
   	
	
	<div class="container">
	
		<!-- <div class="row">
			<div class="col-md-offset-4 col-md-4">
				<button class="btn btn-primary">마이티켓</button>
			</div>
		</div> -->
		
		<!-- page header -->
		<div class="row" id="banner">
			<div class="col-md-12">
				<div>
					<div>
						<div class="text-center white">
							<!-- <ul class="title">
	                            <li>이번 주말에</li>
	                            <li>뭐하고 놀지?</li>
	                        </ul> -->
							<div class="title">
								<h2>파티의 즐거움을 찾아보세요</h2>
							</div>
							<div class="subtitle">
								<h4>파티를 통해 다양한 사람을 만나고 경험하세요!</h4>
								<br>
							</div>

							<div class="sub-title-container">
								<!-- 검색 -->
								<div class="searchbar">
									<form>
										<input type="hidden" class="form-control" id="searchCondition"
											name="searchCondition"
											value="${ ! empty search.searchCondition ? search.searchCondition : '' }">
										<input type="hidden" id="currentPage" name="currentPage"
											value="" />

										<c:if
											test="${ !empty search.searchCondition && search.searchCondition == '5' }">
											<input type="text" id="searchKeyword" name="searchKeyword"
												value="" placeholder="파티 이름으로 검색">
										</c:if>
										<c:if test="${ search.searchCondition != '5' }">
											<input type="text" id="searchKeyword" name="searchKeyword"
												value="${! empty search.searchKeyword ? search.searchKeyword : '' }"
												placeholder="파티 이름으로 검색">
										</c:if>
										<span class="input-group-btn"> <a id="search"
											class="btn btn-xs btn-link" type="button"><img
												src="/resources/image/buttonImage/btn_nav_search_white@3x.png"></a>
										</span>
									</form>
									<%-- <form class="form form-inline" id="searchForm" name="searchForm">
										
										<input type="hidden" class="form-control" id="searchCondition" name="searchCondition" value="${ ! empty search.searchCondition ? search.searchCondition : '' }">
										<input type="hidden" id="currentPage" name="currentPage" value=""/>
										
										<div class="input-group">
											<c:if test="${ !empty search.searchCondition && search.searchCondition == '5' }">
												<input type="text" class="form-control input-lg" size="40" id="searchKeyword" name="searchKeyword" value="" placeholder="파티 이름으로 검색">
											</c:if>
											<c:if test="${ search.searchCondition != '5' }">
												<input type="text" class="form-control input-lg" size="40" id="searchKeyword" name="searchKeyword" value="${! empty search.searchKeyword ? search.searchKeyword : '' }" placeholder="파티 이름으로 검색">
											</c:if>
											<span class="input-group-btn">
										    	<button id="search" class="btn btn-info btn-xs" type="button">
		                                       		<img src="/resources/image/buttonImage/btn_nav_search_white@3x.png">
		                                    	</button>
		                                    	
										    </span>
										</div>
																				
									</form> --%>

								</div>
							</div>
						</div>


					</div>

				</div>
			</div>
		</div>
	</div>
		<%-- <div class="form-group ">
			<div class="col-md-12 control-label">
				<span class="col-md-3 control-label"><button type="button" class="button-3d">파티</button></span> 
				<span class="col-md-6 control-label"><button type="button" class="button-3d">애프터 파티</button></span> 
				<input type="hidden" class="form-control" id="searchCondition" name="searchCondition" value="${ ! empty search.searchCondition ? search.searchCondition : '' }">
				<input type="hidden" id="currentPage" name="currentPage" value="" />
			</div>
		</div> --%>
	<!-- </div> -->
	<div class="container">
		<br><br><br>
		
		
		<div class="row">
			<!-- 데이터 수 -->
			<div class="col-md-6">
				<h5><small>${resultPage.totalCount} 건 (${resultPage.currentPage} 페이지 / ${resultPage.maxPage} 페이지)</small></h5>
			</div>
			<!-- 애프터 파티 등록하러 가기 버튼 출력 -->
			<div class="col-md-6">
				<div class="form-group pull-right">
					<c:if test="${ search.searchCondition == '5' }">
						<button type="button" class="btn btn-default" ><span class="glyphicon glyphicon-plus" aria-hidden="true"></span>
						&nbsp;애프터파티 등록하러 가기</button>
					</c:if>
				</div>
			</div>
		</div>
		<hr><br>
		<div class="page-header text-info">
   		   <h3 align="center">다가오는 파티</h3>
	    </div>
		<div class="input-group-btn text-center">
	    	Buttons
	    	<button type="button" class="btn btn-info btn-lg" >파티</button>
	    	<button type="button" class="btn btn-info btn-lg" >애프터 파티</button>
		</div>
											
		<!-- 목록 조회 Start /////////////////////////////////////-->
		<section>
		<div class="row">
		<c:if test="${empty list}">
			<%-- <jsp:include page="/view/purchase/noResult.jsp"></jsp:include> --%>
		</c:if>
			<c:forEach var="party" items="${list}">
				<c:set var="i" value="${i+1}"></c:set>
				<div class="col-md-6">
						<div class="card">
							<input type="hidden" name="partyNo" value="${party.partyNo}">
							<img class="card-img-top" width="100%" height="500" src="/resources/uploadFile/${party.partyImage}">
								
							<div class="card-body">
								<!-- 파티 -->
									<div class="col-md-12">
										<h4>
										<strong>
											${party.partyName}
										</strong>
										</h4>
									</div>
									
									<div class="col-md-12">
										<span class="glyphicon glyphicon-calendar" aria-hidden="true"></span>
											${party.partyDate}
									</div>
									<div class="col-md-12">
										<span class="glyphicon glyphicon-time" aria-hidden="true"></span>
											${party.partyTime}
									</div>
									<div class="col-md-12">
									<span class="glyphicon glyphicon-map-marker" aria-hidden="true"></span>
											${party.partyPlace}
									</div>
									<div class="col-md-12">
										<c:if test="${ !empty party.festival.festivalName}">
											<span class="glyphicon glyphicon-flag" aria-hidden="true"></span>
											${ party.festival.festivalName }
										</c:if>
									</div>
									<div class="col-md-12">
										<c:if test="${ !empty party.user.nickname}">
											<span class="glyphicon glyphicon-user" aria-hidden="true"></span>
											${ party.user.nickname }
										</c:if>
									</div>
									<div class="col-md-12">
										<h4>
										<strong>
											<c:if test="${ !empty party.festival.festivalNo}">
												<span class="label label-info"># 애프터파티</span>
											</c:if>
											<c:if test="${ empty party.festival.festivalNo}">
												<span class="label label-warning"># 파티</span>
											</c:if>
										</strong>
										</h4>
									</div>
									<%-- <div class="col-md-12">
										
											<c:if test="${ !empty party.festival.festivalNo}">
												<div class="col-md-12">
													<h3>
														<strong>${purchase.ticket.party.partyName}</strong>
														<span class="label label-warning"># 애프터파티</span>
													</h3>
												</div>
											</c:if>
											<c:if test="${ empty party.festival.festivalNo}">
												<div class="col-md-12">
													<h3>
														<strong>${purchase.ticket.party.partyName}</strong>
														<span class="label label-warning"># 파티</span>
													</h3>
												</div>
											</c:if>
										
									</div> --%>
								
								
							</div>
						</div>
				</div>
			</c:forEach>
		</div>
		</section>
		<!-- 목록 조회 End /////////////////////////////////////-->
		
		<!-- 내가 만든 페이지네비게이터 -->
		<jsp:include page="../../common/pageNavigator_new.jsp"/>
		<%-- <jsp:include page="../../common/pageNavigator.jsp"/> --%>
		
	</div>
	
</body>
</html>