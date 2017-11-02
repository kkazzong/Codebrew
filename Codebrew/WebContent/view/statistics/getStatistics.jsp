<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<!DOCTYPE html>
<html lang="ko">
<head>

	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	
	<title>getStatistics</title>
	
	<!-- Bootstrap, jQuery CDN -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	
	<!-- Bootstrap Dropdown Hover CSS -->
	<link href="/resources/css/animate.min.css" rel="stylesheet">
	<link href="/resources/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
	
	<!-- Bootstrap Dropdown Hover JS -->
	<script src="/resources/javascript/bootstrap-dropdownhover.min.js"></script>
	
	<!-- chart.js -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.6.0/Chart.min.js" type="text/javascript"></script>
	
	<!-- Amchart Resources -->
	<script src="https://www.amcharts.com/lib/3/amcharts.js"></script>
	<script src="https://www.amcharts.com/lib/3/serial.js"></script>
	<!-- Amchart pie chart -->
	<script src="https://www.amcharts.com/lib/3/pie.js"></script>
	<script src="https://www.amcharts.com/lib/3/themes/light.js"></script>
	<!-- Amchart dataloader plugin -->
	<script src="//www.amcharts.com/lib/3/plugins/dataloader/dataloader.min.js" type="text/javascript"></script>
	
	<!-- jQuery ui -->
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<script src="https://code.jquery.com/ui/1.12.0/jquery-ui.min.js"></script>
	
	<!-- Include Required Prerequisites -->
	<script type="text/javascript" src="//cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
	<!-- Include Date Range Picker -->
	<script type="text/javascript" src="//cdn.jsdelivr.net/bootstrap.daterangepicker/2/daterangepicker.js"></script>
	<link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/bootstrap.daterangepicker/2/daterangepicker.css" />

	<!-- 자바스크립트 -->
	<script type="text/javascript">
		
		/////////////////////////////////////////////amChart getData////////////////////////////////////////////////////////
		var datas = [];
		
		function fncSearchChartData(statFlag, statDate) {
			////alert(statDate);
			$.ajax({
				
				url : "/statisticsRest/json/getStatistics",
				method : "POST",
				data : JSON.stringify({
					statFlag : statFlag,
					statDate : statDate
				}),
				dataType : "json",
				headers : {
					"Accept" : "application/json",
					"Content-Type" : "application/json"
				},
				success : function(JSONData, status){
					//alert(status+","+statFlag);
					console.log(status);
					console.log(JSON.stringify(JSONData));
					
					switch(statFlag) {
						
						case 1 :
						case "1" :
							dailyChart.destroy();
							fncDailyChartDrow(JSONData);
							dailyChart.update();
							break;
						
						case 2 :
						case "2" :
							monthlyChart.destroy();
							fncMonthlyChartDrow(JSONData);
							break;
						
						case 3 :
						case "3" :
							//alert("분기");
							quarterChart.destroy();
							fncQuarterChartDrow(JSONData);
							break;
							
					}
					
					$("input:hidden[name='statFlag']").val(JSONData[0].statFlag);
					
					//JSON data 만큼 datas에 push
					/* datas = [];
					label = [];
					
					for(var i = 0; i < JSONData.length; i++) {
						datas[i] = JSONData[i].totalPrice;
						label[i] = JSONData[i].statDate+"";
					}
					
					dailyChartData = {
						labels : label,	
						datasets : [{
							label : "판매금액",	
							data : datas
						}]	
					};
					
					console.log("날짜 조회 후 다시 차트그리기 데이터 ");
					console.log(dailyChartData);
					
					//원래 차트 destroy후 차트그리기 call
					dailyChart.destroy();
					fncDailyChart(); */
					
				}
				
			});
			
		}
		
		function getChartData(statFlag) {
			
			//var statFlag2 = $("input:hidden[name='statFlag']").val();
			console.log("amChart data ajax");
			
			$.ajax({
				url : "/statisticsRest/json/getStatistics/"+statFlag,
				method : "GET",
				dataType : "json",
				headers : {
					"Accept" : "application/json"//,
				//"Content-Type" : "application/json"
				},
				success : function(JSONData){
					console.log(JSON.stringify(JSONData));
					datas = [];
					//JSON data 만큼 datas에 push
					for(var i = 0; i < JSONData.length; i++) {
						datas.push({
							totalPrice : JSONData[i].totalPrice,
							totalCount : JSONData[i].totalCount,
							statDate : JSONData[i].statDate
						});
					}
					console.log(datas);
				}
			});
			return datas;
		}
		
		
	
		$(function() {
		
			//차트만들기 default는 월단위
			var statFlag = $("input:hidden[name='statFlag']").val();
			
			//page header 클릭시
			$(".page-header").on("click", function(){
				self.location = "/statistics/getStatistics";
			});
			
			//getChartData(statFlag);
			//chartData3();
			dailyChartData();
			
			
			// tab 선택시
			$("li[role='presentation'] > a").on("click", function(){
				
				var statFlag = $(this).html().trim();
				
				if(statFlag.indexOf('Daily') != -1) {
					console.log("daily click");
					$("input:hidden[name='statFlag']").val(1);
					fncDailyChart();
					//getChartData(1);
					//chart.validateData();
					//chartData3();
				} else if(statFlag.indexOf('Monthly') != -1) {
					console.log("monthly click");
					$("input:hidden[name='statFlag']").val(2);
					monthlyChartData();
					//getChartData(2);
					//chartLine.validateData();
					//chartData1();
				} else if(statFlag.indexOf('Quarter') != -1) {
					console.log("quarter click");
					$("input:hidden[name='statFlag']").val(3);
					quarterChartData();
					//getChartData(3);
					//chartData2();
				} 
				
			});
			
			//datepicker 설정
			/* $.datepicker.setDefaults({
		        dateFormat: 'yy-mm-dd',
		        monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
		        monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
		        dayNames: ['일', '월', '화', '수', '목', '금', '토'],
		        dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
		        dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
		        showMonthAfterYear: true,
		        yearSuffix: '년',
		        changeMonth: true,
				changeYear : true,
				buttonImageOnly: true,
			    buttonText: "Select date",
			    showOn: "button",
			    buttonImage: "/resources/image/ui/cal.png",
			    yearRange : "1990:2017"
	    	}); */
			
			/* $("input:text").each(function(){}).datepicker().bind('change', function(){
				$(this).val($(this).datepicker().val());
			}); */
			
			//daterangepicker
			$("#dailySelect").daterangepicker({
				/* autoApply: true, */
			    dateLimit: {
			        months : 1
			    },
				locale: {
					format : "YYYY-MM-DD",
				    daysOfWeek : ['일', '월', '화', '수', '목', '금', '토'],
				    monthNames : ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
				    firstDay : 1,
				    cancelLabel: "취소",
				    applyLabel : "적용"
				 },
				 minDate : "1990-01-01",
				 showDropdowns: true,
				 applyClass: "btn-primary",
				 ranges: {
			           '오늘': [moment(), moment()],
			           '어제': [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
			           '지난 7일': [moment().subtract(6, 'days'), moment()],
			           '지난 30일': [moment().subtract(29, 'days'), moment()],
			           '이번 달': [moment().startOf('month'), moment().endOf('month')],
			           '저번 달': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')]
			      },
				  function(start, end, label) {
			    	console.log(start)
			    	//alert("A new date range was chosen: " + start.format('YYYY-MM-DD') + ' to ' + end.format('YYYY-MM-DD'));
			      }
			});
			
			//날짜 골랐을때
			$("#dailySelect").on("apply.daterangepicker", function(picker) {
				console.log($(this).val());
				fncSearchChartData(1, $(this).val());
			});
			
			$("#dailySelect").on("cancel.daterangepicker", function(picker) {
				$(this).val('');
			});
			
			/// 새로고침 눌렀을때
			$("#refresh").on("click", function(){
				
				////alert("새로고침")
				var statFlag2 = $("input:hidden[name='statFlag']").val();
				
				fncSearchChartData(statFlag2, '');
				
				printClock();
				
			});
			
		});
	</script>
	
	<!-- CSS -->
	<style type="text/css">
	
		body {
			padding-top : 70px;
			background-color: #f2f4f6;
	    }
	    
		.ui-datepicker-trigger {
			width : 20px;
			height : 20px;
		}
		
		.text-info {
	    	color: #333333; 
	    }
	    
	    .page-header {
	    	border-bottom : 1px solid #f2f4f6;
	    }
	    
	   #refreshClock {
	    	margin-top: 50px;
	    }
		
		/* div {
			border : 3px solid #D6CDB7;
			margin0top : 10px;
		} */
		
	</style>
	
</head>

<body>

	<!-- 툴바 -->
	<jsp:include page="/toolbar/toolbar.jsp"></jsp:include>	
	
	
	<div class="content">
		
		<!-- page header -->
		<div class="row">
			<div class="col-md-offset-4 col-md-4">
				<div class="page-header text-center">
					<h3 class="text-info"><span class="glyphicon glyphicon-object-align-bottom" aria-hidden="true"></span> 판매통계</h3>
				</div>
			</div>
		</div>
		
		<!-- 현재날짜, 시각 -->
		<%-- <div class="row">
			<div class="col-md-offset-3 col-md-6">
				<div class="row">
					<div class="col-md-12">
						<jsp:include page="/view/statistics/clock.jsp"></jsp:include>
					</div>
				</div>
			</div>
		</div>		 --%>
		
		<!-- 버튼 1: 일단위, 2: 월단위, 3:분기단위 -->
		<div class="row">
			<div class="col-md-offset-3 col-md-6">
				<div class="row">
					<!-- Tab -->
					<ul class="nav nav-tabs" role="tablist">
					    <li role="presentation" class="active">
					    	<a href="#daily" aria-controls="home" role="tab" data-toggle="tab">Daily</a>
					    </li>
					    <li role="presentation">
					    	<a href="#monthly" aria-controls="profile" role="tab" data-toggle="tab">Monthly</a>
					    </li>
					    <li role="presentation">
					    	<a href="#quarter" aria-controls="messages" role="tab" data-toggle="tab">Quarter</a>
					    </li>
					 </ul>
				</div>
			</div>
		</div>		
		
		<input type="hidden" name="statFlag" value="${statistics.statFlag}">
		
		<div id="refreshClock" class="row">
			<div class="col-md-offset-3 col-md-6">
				<div class="row">
					<div class="col-md-12">
						<button id="refresh" class="btn btn-default">
							<span class="glyphicon glyphicon-refresh" aria-hidden="true"></span> 
						</button>
						<small>최근 새로고침 : <jsp:include page="/view/statistics/clock.jsp"></jsp:include> </small>
					</div>
				</div>			
			</div>
		</div>
		
		<!-- 통계차트 -->
		<div class="row">
			<div class="col-md-offset-3 col-md-6">
				<div class="row">
					<div class="col-md-12">
						<!-- Tab 내용 -->
						<div class="tab-content">
							<!-- 일단위 판매통계 -->
						    <div role="tabpanel" class="tab-pane active" id="daily">
						    	<div class="page-header">
								</div>
								<!-- <div id="chartDiv"></div> -->
								<jsp:include page="/view/statistics/dailyStatistics.jsp"></jsp:include>
						    </div>
						    <!-- 월단위 판매통계 -->
						    <div role="tabpanel" class="tab-pane" id="monthly">
						    	<div class="page-header">
								</div>
								<!-- <div id="chartLine"></div> -->
								<jsp:include page="/view/statistics/monthlyStatistics.jsp"></jsp:include>
						    </div>
						    <!-- 분기단위 판매통계 -->
						    <div role="tabpanel" class="tab-pane" id="quarter">
						    	<div class="page-header">
								</div>
						    	<!-- <div id="chartPie"></div> --> 
						    	<jsp:include page="/view/statistics/quarterStatistics.jsp"></jsp:include>
						    </div>
 						 </div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
</body>
</html>