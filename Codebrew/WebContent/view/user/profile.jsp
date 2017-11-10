<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html lang="ko">

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<meta name="description"
	content="chart created using amCharts live editor" />
<!-- amCharts javascript sources -->
<script type="text/javascript"
	src="https://www.amcharts.com/lib/3/amcharts.js"></script>
<script type="text/javascript"
	src="https://www.amcharts.com/lib/3/pie.js"></script>

<title>Profile</title>


<script src="/resources/javascript/jquery.js"></script>

<!-- Latest compiled and minified JavaScript -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"
	integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa"
	crossorigin="anonymous"></script>

<!-- Bootstrap Core JavaScript -->
<!-- 
<script src="/resources/javascript/bootstrap.min.js"></script> -->

<!-- 아이콘 - fontawesome -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">


<link href="/resources/css/nonstop.css" rel="stylesheet">
<style>
#main-wrapper {
	width: 100%;
}

.left-sidebar {
	overflow: auto;
	position: fixed;
	width: 240px;
	height: 100%;
	top: 0px;
	z-index: 20;
	padding-top: 45px;
	background: #fff;
	box-shadow: 1px 0px 20px rgba(0, 0, 0, 0.08);
}

.scroll-sidebar {
	padding-top: 50px;
}

.user-profile {
	text-align: center;
	position: relative;
}

.user-profile .profile-img {
	width: 150px;
	margin: 0 auto;
	border-radius: 100%;
}

.user-profile .profile-img img {
	width: 100%;
	border-radius: 100%;
}

.user-profile .profile-text {
	padding: 5px 0;
	position: relative;
}

#sidebarnav {
	padding-left: 0;
}

.sidebar-nav ul li {
	list-style: none;
}

.sidebar-nav li>div {
	height: 20px;
	margin-right: 5px;
	display: inline-block;
	text-align: center;
	vertical-align: middle;
	color: #cccccc;
	/*border-radius: 100%; */
}

.sidebar-nav span>i {
	float: right;
	width: auto;
	font-size: 20px;
	margin-top: 0px;
	color: #cccccc;
}

.sidebar-nav a>i {
	float: right;
	width: auto;
	font-size: 14px;
	margin-top: 4px;
	margin-right: 18px;
	color: #cccccc;
}

.sidebar-nav ul li.nav-small-cap {
	font-size: 13.5px;
	padding: 14px 14px 14px 20px;
	color: #666666;
	font-weight: 500;
	text-align: center;
}

.sidebar-nav ul li.nav-small {
	font-size: 14px;
	padding: 14px 14px 14px 20px;
	/* color: #90a4ae;
    font-weight: 500; */
	/* border-top: 1px solid #ebebeb; */
	border-bottom: 1px solid #ebebeb;
}

.sidebar-nav hr {
	margin-top: 30px;
	margin-bottom: 0px;
	border-top: 3px solid #ff6600;
	width: 20px;
}

.page-wrapper {
	background: #f1f1f1;
	min-height: 760px;
	margin-left: 240px;
}

.container-fluid {
	padding-right: 30px;
	padding-left: 30px;
}

.card {
	position: relative;
	margin-top: 20px;
	display: -webkit-box;
	display: -webkit-flex;
	display: -ms-flexbox;
	display: flex;
	-webkit-box-orient: vertical;
	-webkit-box-direction: normal;
	-webkit-flex-direction: column;
	-ms-flex-direction: column;
	flex-direction: column;
	background-color: #fff;
	border: 1px solid #eee;
	border-radius: .25rem;
}

/* Tabs panel */
.tabbable-panel {
	border: 1px solid #eee;
	padding: 10px;
}

/* Default mode */
.tabbable-line>.nav-tabs {
	border: none;
	margin: 0px;
}

.tabbable-line>.nav-tabs>li {
	margin-right: 2px;
}

.tabbable-line>.nav-tabs>li>a {
	border: 0;
	margin-right: 0;
	color: #737373;
}

.tabbable-line>.nav-tabs>li>a>i {
	color: #a6a6a6;
}

.tabbable-line>.nav-tabs>li.open, .tabbable-line>.nav-tabs>li:hover {
	border-bottom: 4px solid #fbcdcf;
}

.tabbable-line>.nav-tabs>li.open>a, .tabbable-line>.nav-tabs>li:hover>a
	{
	border: 0;
	background: none !important;
	color: #333333;
}

.tabbable-line>.nav-tabs>li.open>a>i, .tabbable-line>.nav-tabs>li:hover>a>i
	{
	color: #a6a6a6;
}

.tabbable-line>.nav-tabs>li.open .dropdown-menu, .tabbable-line>.nav-tabs>li:hover .dropdown-menu
	{
	margin-top: 0px;
}

.tabbable-line>.nav-tabs>li.active {
	border-bottom: 4px solid #ff6600;
	position: relative;
}

.tabbable-line>.nav-tabs>li.active>a {
	border: 0;
	color: #333333;
	font-weight: 500;
}

.tabbable-line>.nav-tabs>li.active>a>i {
	color: #404040;
}

.tabbable-line>.tab-content {
	margin-top: -3px;
	background-color: #fff;
	border: 0;
	border-top: 1px solid #eee;
	padding: 15px 0;
}

.portlet .tabbable-line>.tab-content {
	padding-bottom: 0;
}

/* Below tabs mode */
.tabbable-line.tabs-below>.nav-tabs>li {
	border-top: 4px solid transparent;
}

.tabbable-line.tabs-below>.nav-tabs>li>a {
	margin-top: 0;
}

.tabbable-line.tabs-below>.nav-tabs>li:hover {
	border-bottom: 0;
	border-top: 4px solid #fbcdcf;
}

.tabbable-line.tabs-below>.nav-tabs>li.active {
	margin-bottom: -2px;
	border-bottom: 0;
	border-top: 4px solid #f3565d;
}

.tabbable-line.tabs-below>.tab-content {
	margin-top: -10px;
	border-top: 0;
	border-bottom: 1px solid #eee;
	padding-bottom: 15px;
}

.table>thead>tr>th {
	border-bottom: 2px solid #ebebeb;
}

.table>tbody>tr>td, .table>tbody>tr>th, .table>tfoot>tr>td, .table>tfoot>tr>th,
	.table>thead>tr>td, .table>thead>tr>th {
	border-top: 1px solid #ebebeb;
	padding: 10px;
	line-height: 1.42857143;
	font-size: 13px;
}

.table i {
	color: #a5a5a5;
}
</style>

<script type="text/javascript">
	//그래프 생성 시작

	var dataSet = [];

	var userId = "${user.userId}";
	var role = "${user.role}";
	$.ajax("/statistics/getUserStatisticsList/" + userId + "/" + role, {
		method : "GET",
		dataType : "json",
		headers : {
			"Accept" : "application/json"//,
		//"Content-Type" : "application/json"
		},
		success : function(aaa) {
			for (var i = 0; i < aaa.dataList.length; i++) {

				dataSet.push({
					TechName : aaa.dataList[i].techName,
					UseTerm : aaa.dataList[i].careerUseTerm
				});
			}
		}
	});
	AmCharts
			.makeChart(
					"chartdiv",
					{
						"type" : "pie",
						"angle" : 12,
						"balloonText" : "[[title]]<br><span style='font-size:14px'><b>[[value]]</b> ([[percents]]%)</span>",
						"depth3D" : 15,
						"titleField" : "TechName",
						"valueField" : "UseTerm",
						"allLabels" : [],
						"balloon" : {},
						"legend" : {
							"enabled" : true,
							"align" : "center",
							"markerType" : "circle"
						},
						"titles" : [],
						"dataProvider" : dataSet
					});
	//그래프 생성 끝

	$(function() {

		
		
		
		//팔로우한 회원 프로필로 이동
		$(".followProfile").on("click", function() {
			var userId = $(this).text().trim();
			self.location = "/profile/getOtherProfile?userId=" + userId;
		});
		
		
		
		
		
		

		$(".fa-envelope").on('click', function() {
			var userId = $(this).text().trim();
			$(this).val(userId);
		})

		//글자수 표시
		$('textarea').keyup(function() {
			var maxLength = 2000;
			var length = $(this).val().length;
			var length = maxLength - length;
			$('#chars').text(length);
		});

		//메일전송
		$("#send").on(
				"click",
				function() {
					var receiveId = $("input[name='receiveId']").val();
					var title = $("input[name='letTitle']").val();
					var letDetail = $("input[name='letDetail']").val();

					if (receiveId == null || receiveId.length < 1) {
						alert("수신자는 반드시 입력하셔야 합니다.");
						return false;
					}
					if (title == null || title.length < 1) {
						alert("제목은 반드시 입력하셔야 합니다.");
						return false;
					}
					if(url != ""){
						var contentArea = $("textarea[name='letDetail']");
						contentArea.val(contentArea.val()+"\r\n채팅주소: "+url);
					}
					$("form").attr("method", "POST").attr("action",
							"/letter/addLetter").submit();
				});

		var url = ""
		$("#addChatUrl").on(
				"click",
				function() {
					var urlArea = $('#chatUrl');
					url = "https://192.168.0.16:8444/#"+Math.random().toString(16).substr(2);
					$("#addChatUrl").css("display","none");
					urlArea.css("display","block");
					urlArea.attr("href", url);
					urlArea.text("채팅주소: "+url);
				});
		
		$(".fa-envelope").parent().on(
				"click",
				function(){
					$("#inputEmail1").val($(this).parent().find(".followProfile").text().trim());
				});
		
		//팔로우 add /delete
		$(document).on("click", "#follow", function() {

			var flag = $(this).text().trim();
			var requestTarget;

			if (flag == "팔로우") {
				requestTarget = "addJsonFollow";
			} else {
				requestTarget = "deleteJsonFollow";
			}
			var targetUserId = $(this).attr('targetUserId');

			$.ajax({
				url : "/profile/" + requestTarget + "/" + targetUserId,
				method : "GET",
				dateType : "json",
				headers : {
					"Accept" : "application/json",
					"Content-Type" : "application/json"
				},
				success : function(JSONData, status) {

					if (flag == "팔로우") {
						$("#followflag").text("언팔로우");
					} else {
						$("#followflag").text("팔로우");
					}
				}
			});
		});

		$("span i.glyphicon")
				.on(
						'click',
						function() {
							var flag = $(this).attr('class').trim();
							var targetUserId = $(this).attr('targetUserId');
							var target;
							if (flag == 'glyphicon glyphicon-remove-circle') {
								target = "deleteJsonFollow";
							} else {
								target = "addJsonFollow";
							}
							$
									.ajax({
										url : "/profile/" + target + "/"
												+ targetUserId,
										method : "GET",
										dateType : "json",
										headers : {
											"Accept" : "application/json",
											"Content-Type" : "application/json"
										},
										context : this,
										success : function(JSONData, status) {
											if (flag == 'glyphicon glyphicon-remove-circle') {
												$(this)
														.removeClass(
																'glyphicon glyphicon-remove-circle')
														.addClass(
																'glyphicon glyphicon-plus-sign');
											} else {
												$(this)
														.removeClass(
																'glyphicon glyphicon-plus-sign')
														.addClass(
																'glyphicon glyphicon-remove-circle');
											}
										}
									});
						});
	});
</script>

</head>
<body>
	<div id="main-wrapper">
		<header>
		<%-- 	<jsp:include page="/view/common/toolbar.jsp" /> --%>
		</header>

		<aside class="left-sidebar">
			<div class="slimScrollDiv"
				style="position: relative; overflow: visible; width: auto; height: 100%;">
				<div class="scroll-sidebar"
					style="overflow-x: visible; overflow-y: auto; width: auto; height: 100%;">
					<div class="user-profile">
						<div class="profile-img">
						<c:if test="${user.image != null }">
							<img src="/resources/images/upload/${user.image}" id="profileImg" class="img-circle" width="160px">
							</c:if>
							<c:if test="${user.image == null }">
							<img src="/resources/images/upload/user_img.jpg" id="profileImg" class="img-circle" width="160px">
							</c:if>
							
						</div>
						<div class="profile-text">
							<h5 style="font-size: 16px">${user.userId}</h5>
							<p style="margin-top: 10px; margin-bottom: 5px; font-size: 14px">
								<i class="fa fa-map-marker" aria-hidden="true"
									style="color: #cccccc; font-size: 16px"></i>
								&nbsp;&nbsp;${user.addr}
							</p>

							<c:if test="${user.role=='3'}">
								<h5 style="font-size: 16px">기업대표자 : ${user.companyName}</h5>
								<h5 style="font-size: 16px">직원수 : ${user.empNum}</h5>
								<h5 style="font-size: 16px">설립일 : ${user.pubDate}</h5>
							</c:if>
						</div>
					</div>
					
					
					
					
					
					
					<!-- user-profile -->
					<c:if test="${session.user.userId  == param.userId}">
						<nav class="sidebar-nav active">

							<ul id="sidebarnav">
								<hr/>
								<li class="nav-small-cap">FOLLOW</li>
								<c:set var="i" value="0" />
								<c:forEach var="follow" items="${follow}">
									<c:set var="i" value="${ i+1 }" />
									<li class="nav-small">
										<div class="icon">
											<span class="glyphicon glyphicon-user" aria-hidden="true"></span>
										</div> 
										<span class="followProfile" title="클릭하시면 해당 회원의 프로필로 이동합니다.">
											${follow.targetUserId}
										</span> 
										<span> <i class="glyphicon glyphicon-remove-circle" targetUserId="${follow.targetUserId}" followNo="${follow.followNo}" title="클릭하시면  해당 회원을 팔로우 및 언팔로우 하실 수 있습니다."></i></span>
										<a href="#followLetter" data-toggle="modal"><i class="fa fa-envelope"  title="클릭하시면 해당 회원에게 쪽지를 작성 할 수 있습니다." aria-hidden="true"></i></a>
									</li>


								</c:forEach>

							</ul>

						</nav>
					</c:if>
					<c:if test="${user.userId != sessionScope.user.userId }">
						<c:if
							test="${follow.reqUserId==sessionScope.user.userId && career.careerUserId==targetUserId }">
							<div class="col-sm-12 text-center">
								<span class="follow" targetUserId="${user.userId}" id="follow">
									<button type="button" class="btn btn-primary" id="followflag">언팔로우</button>
								</span>
							</div>
						</c:if>

						<c:if test="${follow.reqUserId != sessionScope.user.userId}">
							<div class="col-sm-12 text-center">
								<span class="follow" targetUserId="${user.userId}" id="follow">
									<button type="button" class="btn btn-primary" id="followflag">팔로우</button>
								</span>
							</div>
						</c:if>
					</c:if>
				</div>
			</div>
		</aside>
	</div>

	<div class="page-wrapper">
		<div class="container-fluid">
			<div class="row">
				<!-- Column -->
				<div class="col-md-12">
					<div class="card">

						<div class="tabbable-panel">
							<div class="tabbable-line">
								<ul class="nav nav-tabs ">
									<li class="active"><a href="#Myprofile" data-toggle="tab">Profile
									</a></li>
									<li><c:if test="${user.role=='2'}">
											<a href="#portfolio" data-toggle="tab">My Portfolio </a>
										</c:if></li>
									<li><c:if test="${user.role=='3'}">
											<a href="#project" data-toggle="tab">My Project </a>
										</c:if></li>
									<li><c:if
											test="${user.userId  == sessionScope.user.userId}">
											<a href="#portfolioScrap" data-toggle="tab">Portfolio
												Scrap </a>
										</c:if></li>
									<li><c:if
											test="${user.userId  == sessionScope.user.userId}">
											<a href="#projectScrap" data-toggle="tab">Project Scrap </a>
										</c:if></li>
								</ul>
								<div class="tab-content">

									<%-- <div class="tab-pane active" id="Myprofile">
										<c:if test="${user.role=='2'}">
											<div class="row">
												<!-- Column -->
												<div class="col-md-12">
													<div class="card">
														<div class="col-md-12">
															<div class="page-header text-center">
																<h5 class=" text-left"
																	style="padding-left: 10px; font-size: 16px">사용가능
																	기술 그래프</h5>
															</div>

															<div id="chartdiv"
																style="width: 100%; height: 400px; background-color: #FFFFFF;"></div>
														</div>
													</div>
												</div>
											</div>
											<jsp:include page="/view/profile/listCareer.jsp" />
										</c:if>
										<c:if test="${user.role=='3'}">
											<p>사용 기술 그래프</p>
											<div id="chartdiv"
												style="width: 100%; height: 400px; background-color: #FFFFFF;"></div>
										</c:if>

										<jsp:include page="/view/profile/listRecordProject.jsp" />

									</div>
									<div class="tab-pane" id="portfolio">
										<p>이 회원이 게시한 포트폴리오</p>
										<jsp:include page="/view/profile/listMyPort.jsp" />
									</div>

									<div class="tab-pane" id="project">
										<p>이 기업이 게시한 프로젝트 구인공고</p>
										<jsp:include page="/view/profile/listMyProj.jsp" />
									</div>

									<div class="tab-pane" id="projectScrap">
										<p>프로젝트 스크랩 목록</p>
										<jsp:include page="/view/profile/listProjScrap.jsp" />
									</div>

									<div class="tab-pane" id="portfolioScrap">
										<p>포트폴리오 스크랩 목록</p>
										<jsp:include page="/view/profile/listPortScrap.jsp" />
									</div> --%>
								</div>
							</div>
						</div>

					</div>
				</div>
				<!-- Column -->
			</div>

		</div>

	</div>


	<div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog"
		tabindex="-1" id="followLetter" class="modal fade"
		style="display: none;">
		<div class="modal-dialog">

			<div class="modal-content">
				<div class="modal-header">
					<button aria-hidden="true" data-dismiss="modal" class="close"
						type="button">×</button>
					<h4 class="modal-title">Send to mail your partner</h4>
				</div>
				<div class="modal-body">
					<form role="form" id="addMail" class="form-horizontal">

						<div class="form-group">
							<label class="col-lg-2 control-label">From</label>
							<div class="col-lg-10">
								<input type="text" class="form-control" name="sendId"
									value="${sessionScope.user.userId}" readOnly>
							</div>
						</div>

						<div class="form-group">
							<label class="col-lg-2 control-label">To</label>
							<div class="col-lg-10">
								<input type="text" name="receiveId" readonly
									id="inputEmail1" class="form-control">
							</div>
						</div>

						<div class="form-group">
							<label class="col-lg-2 control-label">Title</label>
							<div class="col-lg-10">
								<input type="text" name="letTitle" placeholder="메일 제목을 입력하세요"
									class="form-control">
							</div>
						</div>

						<div class="form-group">
							<label class="col-lg-2 control-label">Mail</label>
							<div class="col-lg-10">
								<textarea maxlength="2000" rows="10" cols="30" name="letDetail"
									placeholder="2000자까지 입력가능" class="form-control"></textarea>
								<br /> 2000/<span id="chars">2000</span>
								<br/><a id="chatUrl" target="_blank"></a>
							</div>
						</div>

						<div class="form-group">
							<div class="col-lg-offset-2 col-lg-10">
								<span>
									<button class="btn btn-send" type="button" id="addChatUrl">채팅 주소 추가</button>
									<button class="btn btn-send" type="submit" id="send"
										receiveId="${sessionScope.user.userId}">send</button>
								</span>
							</div>
						</div>
					</form>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- /.modal -->



</body>
</html>