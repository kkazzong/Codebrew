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
	    
	    @import url("http://fonts.googleapis.com/css?family=Lato:100,300,400,700,900,400italic");
    @import url("//netdna.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.css");
    body {
		padding: 60px 0px;
		background-color: rgb(220, 220, 220);
	}
    
    .event-list {
		list-style: none;
		font-family: 'Lato', sans-serif;
		margin: 0px;
		padding: 0px;
	}
	.event-list > li {
		background-color: rgb(255, 255, 255);
		box-shadow: 0px 0px 5px rgb(51, 51, 51);
		box-shadow: 0px 0px 5px rgba(51, 51, 51, 0.7);
		padding: 0px;
		margin: 0px 0px 20px;
	}
	.event-list > li > time {
		display: inline-block;
		width: 100%;
		color: rgb(255, 255, 255);
		background-color: rgb(197, 44, 102);
		padding: 5px;
		text-align: center;
		text-transform: uppercase;
	}
	.event-list > li:nth-child(even) > time {
		background-color: rgb(165, 82, 167);
	}
	.event-list > li > time > span {
		display: none;
	}
	.event-list > li > time > .day {
		display: block;
		font-size: 40pt;
		font-weight: 100;
		line-height: 1;
	}
	.event-list > li time > .month {
		display: block;
		font-size: 18pt;
		font-weight: 500;
		line-height: 1;
	}
	.event-list > li time > .year {
		display: block;
		font-size: 24pt;
		font-weight: 500;
		line-height: 1;
	}
	.event-list > li > img {
		width: 100%;
	}
	.event-list > li > .info {
		padding-top: 5px;
		text-align: center;
	}
	.event-list > li > .info > .title {
		font-size: 17pt;
		font-weight: 700;
		margin: 0px;
	}
	.event-list > li > .info > .desc {
		font-size: 13pt;
		font-weight: 300;
		margin: 0px;
	}
	.event-list > li > .info > ul,
	.event-list > li > .social > ul {
		display: table;
		list-style: none;
		margin: 10px 0px 0px;
		padding: 0px;
		width: 100%;
		text-align: center;
		
	}
	.event-list > li > .social > ul {
		margin: 0px;
	}
	.event-list > li > .info > ul > li,
	.event-list > li > .social > ul > li {
		display: table-cell;
		cursor: pointer;
		color: rgb(30, 30, 30);
		font-size: 11pt;
		font-weight: 300;
        padding: 3px 0px;
	}
    .event-list > li > .info > ul > li > a {
		display: block;
		width: 100%;
		color: rgb(30, 30, 30);
		text-decoration: none;
	} 
    .event-list > li > .social > ul > li {    
        padding: 0px;
    }
    .event-list > li > .social > ul > li > a {
        padding: 3px 0px;
	} 
	.event-list > li > .info > ul > li:hover,
	.event-list > li > .social > ul > li:hover {
		color: rgb(30, 30, 30);
		background-color: rgb(200, 200, 200);
	}
	.edit a,
	.confirm a,
	.delete a {
		display: block;
		width: 100%;
		color: rgb(75, 110, 168) !important;
	}
	.confirm a {
		color: rgb(79, 213, 248) !important;
	}
	.delete a {
		color: rgb(221, 75, 57) !important;
	}
	.edit:hover a {
		color: rgb(255, 255, 255) !important;
		background-color: rgb(75, 110, 168) !important;
	}
	.confirm:hover a {
		color: rgb(255, 255, 255) !important;
		background-color: rgb(79, 213, 248) !important;
	}
	.delete:hover a {
		color: rgb(255, 255, 255) !important;
		background-color: rgb(221, 75, 57) !important;
	}

	@media (min-width: 768px) {
		.event-list > li {
			position: relative;
			display: block;
			width: 100%;
			height: 120px;
			padding: 0px;
		}
		.event-list > li > time,
		.event-list > li > img  {
			display: inline-block;
		}
		.event-list > li > time,
		.event-list > li > img {
			width: 120px;
			float: left;
		}
		.event-list > li > .info {
			background-color: rgb(245, 245, 245);
			overflow: hidden;
		}
		.event-list > li > time,
		.event-list > li > img {
			width: 120px;
			height: 120px;
			padding: 0px;
			margin: 0px;
		}
		.event-list > li > .info {
			position: relative;
			height: 120px;
			text-align: left;
			padding-right: 40px;
		}	
		.event-list > li > .info > .title, 
		.event-list > li > .info > .desc {
			padding: 0px 10px;
		}
		.event-list > li > .info > ul {
			position: absolute;
			left: 0px;
			bottom: 0px;
		}
		.event-list > li > .social {
			position: absolute;
			top: 0px;
			right: 0px;
			display: block;
			width: 40px;
		}
        .event-list > li > .social > ul {
            border-left: 1px solid rgb(230, 230, 230);
        }
		.event-list > li > .social > ul > li {			
			display: block;
            padding: 0px;
		}
		.event-list > li > .social > ul > li > a {
			display: block;
			width: 40px;
			padding: 10px 0px 9px;
		}
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
			<c:if test="${empty list}">
				<%-- <jsp:include page="/view/purchase/noResult.jsp"></jsp:include> --%>
			</c:if>
				<c:forEach var="party" items="${list}">
					<c:set var="i" value="${i+1}"></c:set>
					
			<div class="[ col-xs-12 col-sm-offset-2 col-sm-6 ]">
				<ul class="event-list">
					<li>
						<time datetime="2014-07-31 1600">
							<span class="day">04</span>
							<span class="month">Mayıs</span>
							<span class="year">2017</span>
							<span class="time">13:57</span>
						</time>
						<img alt="Duyar Kimya Ziyaret" src="http://scontent.cdninstagram.com/t51.2885-19/s150x150/16229470_1105297716245462_9037530429749460992_n.jpg" />
						<div class="info">
							<h2 class="title">Duyar Kimya Ziyaret</h2>
							<p class="desc">Crm Programı Kurulum</p>
							<ul>
								<li style="width:33%;">100  <span class="fa fa-male"></span></li>
								<li style="width:34%;">80 <span class="fa fa-child"></span></li>
							</ul>
						</div>
						<div class="social">
							<ul>
								<li class="edit" style="width:33%;"><a href="#"><span class="fa fa-pencil-square-o"></span></a></li>
								<li class="confirm" style="width:34%;"><a href="#"><span class="fa fa-check"></span></a></li>
								<li class="delete" style="width:33%;"><a href="#"><span class="fa fa-trash-o"></span></a></li>
							</ul>
						</div>
					</li>
				</ul>
			</div>
			</c:forEach>
		</div>
	</div>
	
	
 	<!--  화면구성 div End /////////////////////////////////////-->
 	
 	<!-- PageNavigation Start... -->
	<jsp:include page="../../common/pageNavigator_new.jsp"/>
	<!-- PageNavigation End... -->
</body>
</html>