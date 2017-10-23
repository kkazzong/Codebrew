<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>getStatistics</title>
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
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


<script type="text/javascript">
	
	/////////////////////////////////////////////amChart getData////////////////////////////////////////////////////////
	var datas = [];
	
	function getChartData(statFlag) {
		
		//var statFlag2 = $("input:hidden[name='statFlag']").val();
		console.log("amChart data ajax");
		
		$.ajax({
			url : "/statisticsRest/json/getStatistics/"+statFlag,
			method : "get",
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
	
	////////////////////////////////////////amChart////////////////////////////////////////////////////
	//막대차트 - 일단위
	var chart = AmCharts.makeChart("chartDiv", {
	    "theme": "light",
	    "type": "serial",
	    "legend" : {
	    	"useGraphSettings": true,
	    	"generateFromData": true,
			"position" : "bottom",
			"marginRight" : 100,
			"autoMargins" : false,
			"color" : "#000000"
		},
	    "dataProvider" : datas,
	   /*  "dataLoader" : {
	    	"url" : "http://127.0.0.1:8080/data/statistics/test.json"
	    }, */
	     "mouseWheelZoomEnabled":true, //마우스로 확대, 축소
	     "dataDateFormat": "YY-MM-DD", //데이터의 날짜 포맷
		"startDuration": 1,
	    "valueAxes": [{
	    	"id" : "priceAxis",
	        "position": "left",
	        "title": "총판매금액",
	        "titleRotation" : 0 //타이틀 90도 회전
	    }, {
	    	"id" : "countAxis",
	    	"position" : "right",
	    	"title" : "총판매수량",
	    	"titleRotation" : 0 
	    }],
	    "graphs": [{
	    	"id": "gp",
	    	"balloonText": "[[category]]: <b>[[value]]원</b>",
	        "fillColorsField": "color",
	        "fillAlphas": 0.8,
	        "lineAlpha": 0,
	        "type": "column",
	        "title" : "총판매금액",
	        "valueField": "totalPrice",
	        "valueAxis" : "priceAxis"
	    }, {
	    	"id": "gc",
	    	"bullet": "round",
	    	"lineThickness" : 2,
	    	"lineColor" : "#000000",
	        "bulletBorderAlpha": 1,
	        "bulletBorderThickness": 1,
	        "bulletColor" : "#FFFFFF",
	        "balloonText": "[[value]]장",
	        "useLineColorForBulletBorder": true,
	        "title" : "총판매수량",
	        "fillAlpha": 0,
	        "valueField": "totalCount",
	        "valueAxis" : "countAxis"
	    }],
	    "chartScrollbar": { //가로축 스크롤(날짜)
	        "graph": "gc",
	        "oppositeAxis":false,
	        "offset":30,
	        "scrollbarHeight": 80,
	        "backgroundAlpha": 0,
	        "selectedBackgroundAlpha": 0.1,
	        "selectedBackgroundColor": "#888888",
	        "graphFillAlpha": 0,
	        "graphLineAlpha": 0.5,
	        "selectedGraphFillAlpha": 0,
	        "selectedGraphLineAlpha": 1,
	        "autoGridCount":true,
	        "color":"#AAAAAA"
	    },
	    "depth3D": 20,
		"angle": 30,
	    "chartCursor": { //차트 위에 나타나는 커서
	        "categoryBalloonEnabled": false,
	        "cursorAlpha": 0,
	        "zoomable": false,
	        "pan": true,
	        "valueLineEnabled": true,
	        "valueLineBalloonEnabled": true,
	        "cursorAlpha":1,
	        "cursorColor":"#258cbb",
	        "limitToGraph":"gp",
	        "valueLineAlpha":0.2,
	        "valueZoomable":true
	    },
	   /*  "valueScrollbar":{
		      "oppositeAxis":false,
		      "offset":50,
		      "scrollbarHeight":10
		}, */
	    "categoryField": "statDate",
	    "categoryAxis": {
	        "gridPosition": "start",
	        "labelRotation": 0
	    },
	    "export": {
	    	"enabled": true
	     }
	}); 
	
	
	//월단위
	var chartLine = AmCharts.makeChart("chartLine", {
	    "type": "serial",
	    "theme": "light",
	    /* "dataProvider": datas, */
	    "legend" : {
	    	"useGraphSettings": true,
	    	"generateFromData": true,
			"position" : "right",
			"marginRight" : 100,
			"autoMargins" : false
		},
	    "marginRight": 40,
	    "marginLeft": 40,
	    "autoMarginOffset": 20,
	    "mouseWheelZoomEnabled":true,
	    "valueAxes": [{
	        "id": "v1",
	        "axisAlpha": 0,
	        "position": "left",
	        "ignoreAxisWidth":true
	    }],
	    "balloon": {
	        "borderThickness": 1,
	        "shadowAlpha": 0
	    },
	    "graphs": [{
	        "id": "g1",
	        "balloon":{
	          "drop":true,
	          "adjustBorderColor":false,
	          "color":"#ffffff"
	        },
	        "bullet": "round",
	        "bulletBorderAlpha": 1,
	        "bulletColor": "#FFFFFF",
	        "bulletSize": 5,
	        "hideBulletsCount": 50,
	        "lineThickness": 2,
	        "title": "총판매금액",
	        "useLineColorForBulletBorder": true,
	        "valueField": "totalPrice",
	        "balloonText": "<span style='font-size:18px;'>[[value]]</span>"
	    }],
	    "chartScrollbar": {
	        "graph": "g1",
	        "oppositeAxis":false,
	        "offset":30,
	        "scrollbarHeight": 80,
	        "backgroundAlpha": 0,
	        "selectedBackgroundAlpha": 0.1,
	        "selectedBackgroundColor": "#888888",
	        "graphFillAlpha": 0,
	        "graphLineAlpha": 0.5,
	        "selectedGraphFillAlpha": 0,
	        "selectedGraphLineAlpha": 1,
	        "autoGridCount":true,
	        "color":"#AAAAAA"
	    },
	    "chartCursor": {
	        "pan": true,
	        "valueLineEnabled": true,
	        "valueLineBalloonEnabled": true,
	        "cursorAlpha":1,
	        "cursorColor":"#258cbb",
	        "limitToGraph":"g1",
	        "valueLineAlpha":0.2,
	        "valueZoomable":true
	    },
	    "valueScrollbar":{
	      "oppositeAxis":false,
	      "offset":50,
	      "scrollbarHeight":10
	    },
	    "categoryField": "statDate",
	    "categoryAxis": {
	        "dashLength": 1,
	        "minorGridEnabled": true
	    },
	    "export": {
	        "enabled": true
	    }
	}); 
	
	//도넛차트 - 분기단위
	
	var chartPie = AmCharts.makeChart("chartPie", {
		"type" : "pie", //타입은 파이
		"theme" : "light", //테마는 라이트
		"startDuration" : 1, //시작 애니메이션
		"addClassNames" : true,
		"legend" : {
			"useGraphSettings": true,
	    	"generateFromData": true,
			"position" : "right",
			"marginRight" : 100,
			"autoMargins" : false
		},
		"innerRadius" : "40%", //동그라미 안의 비율
		"defs" : {
			"filter" : [ {
				"id" : "shadow",
				"feBlend" : {
					"mode" : "normal"
				} 
			} ]
		}, 
		"dataProvider" : [{
			"statDate" : 4,
			"totalPrice" : 1000
		}],
		"valueField" : "totalPrice",
		"titleField" : "statDate",
		"export" : {
			"enabled" : true
		}
	});
	
	chartLine.addListener("rendered", zoomChart);

	zoomChart();

	function zoomChart() {
		//console.log(chart.dataProvider.length);
	    //chartLine.zoomToIndexes(chartLine.dataProvider.length - 40, chartLine.dataProvider.length - 1);
	} 
	

	$(function() {
	
		//차트만들기 default는 월단위
		var statFlag = $("input:hidden[name='statFlag']").val();
		
		//page header 클릭시
		$(".page-header").on("click", function(){
			self.location = "/statistics/getStatistics";
		});
		
		getChartData(statFlag);
		chartData3();
		// tab 선택시
		$("li[role='presentation'] > a").on("click", function(){
			
			var statFlag = $(this).html().trim();
			
			if(statFlag.indexOf('Daily') != -1) {
				console.log("daily click");
				getChartData(1);
				chart.validateData();
				chartData3();
			} else if(statFlag.indexOf('Monthly') != -1) {
				console.log("monthly click");
				getChartData(2);
				chartLine.validateData();
				chartData1();
			} else if(statFlag.indexOf('Quarterly') != -1) {
				console.log("quarterly click");
				getChartData(3);
				chartData2();
			} 
			
		});
		
	});
</script>
<style type="text/css">

	body {
		padding-top : 70px;
    }
    
	#chartDiv {
		width: 100%;
		height: 500px;
		/* display: none; */
	}
	
	#chartPie {
		width: 100%;
		height: 500px;
		/* display: none; */
	}
	
	 #chartLine {
		width: 100%;
		height: 500px;
		/* display: none; */
	}
	
	.amcharts-pie-slice {
		transform: scale(1);
		transform-origin: 50% 50%;
		transition-duration: 0.3s;
		transition: all .3s ease-out;
		-webkit-transition: all .3s ease-out;
		-moz-transition: all .3s ease-out;
		-o-transition: all .3s ease-out;
		cursor: pointer;
		box-shadow: 0 0 30px 0 #000;
	}
	
	.amcharts-pie-slice:hover {
		transform: scale(1.1);
		filter: url(#shadow);
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
						<!-- <div class="col-md-12 btn-group" role="group">
							<button class="btn btn-default btn-lg" type="button" value="1">Daily</button>
							<button class="btn btn-default btn-lg" type="button" value="2">Monthly</button>
							<button class="btn btn-default btn-lg" type="button" value="3">Quarter</button>
						</div> -->
					<!-- <div class="col-md-12 btn-group" data-toggle="buttons">
						<label class="btn btn-default active">
							<input type="radio" name="options" value="daily" autocomplete="off" checked> Daily
						</label>
						<label class="btn btn-default">
							 <input type="radio" name="options" value="monthly" autocomplete="off"> Monthly
						</label>
						<label class="btn btn-default">
							<input type="radio" name="options" value="quarter" autocomplete="off"> Quarterly
						</label>
					</div> -->
					<!-- Tab -->
					<ul class="nav nav-tabs" role="tablist">
					    <li role="presentation" class="active">
					    	<a href="#daily" aria-controls="home" role="tab" data-toggle="tab">Daily</a>
					    </li>
					    <li role="presentation">
					    	<a href="#monthly" aria-controls="profile" role="tab" data-toggle="tab">Monthly</a>
					    </li>
					    <li role="presentation">
					    	<a href="#quarter" aria-controls="messages" role="tab" data-toggle="tab">Quarterly</a>
					    </li>
					 </ul>
				</div>
			</div>
		</div>		
		
		<input type="hidden" name="statFlag" value="${statistics.statFlag}">
		
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
								  <h4>일단위 판매통계</h4>
								</div>
								<!-- <div id="chartDiv"></div> -->
								<jsp:include page="/view/statistics/dailyStatistics.jsp"></jsp:include>
						    </div>
						    <!-- 월단위 판매통계 -->
						    <div role="tabpanel" class="tab-pane" id="monthly">
						    	<div class="page-header">
								  <h4>월단위 판매통계</h4>
								</div>
								<!-- <div id="chartLine"></div> -->
								<jsp:include page="/view/statistics/monthlyStatistics.jsp"></jsp:include>
						    </div>
						    <!-- 분기단위 판매통계 -->
						    <div role="tabpanel" class="tab-pane" id="quarter">
						    	<div class="page-header">
								  <h4>분기단위 판매통계</h4>
								</div>
						    	<!-- <div id="chartPie"></div> --> 
						    	<jsp:include page="/view/statistics/quarterlyStatistics.jsp"></jsp:include>
						    </div>
 						 </div>
					</div>
				</div>
			</div>
		</div>
	
	</div>
	
	<%-- <input type="hidden" name="statFlag" value="${statistics.statFlag}">
	<h3>chart.js</h3>
	<button type="button" value="1">일단위</button>
	<button type="button" value="2">월단위</button>
	<button type="button" value="3">분기단위</button>
	
	<hr>
	
	<div class="chart-container">
		<canvas id="chartBar"></canvas>
	</div>
		
	<hr>
	<hr>
	<hr>
	<h3>amChart</h3>
	<button type="button" value="1">일단위</button>
	<button type="button" value="2">월단위</button>
	<button type="button" value="3">분기단위</button>
	
	<hr>
	
	<div id="chartDiv"></div>
	<div id="chartLine"></div>
	<div id="chartPie"></div> --%>
	
</body>
</html>