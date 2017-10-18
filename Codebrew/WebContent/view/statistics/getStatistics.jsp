<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>getStatistics</title>

<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"/>
<!-- Bootstrap Optional theme -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css"/>
<!-- Bootstrap JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
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
<!-- jQuery -->
<script type="text/javascript" src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
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
			success : function(JSONData){
				console.log(JSON.stringify(JSONData));
				
				//JSON data 만큼 datas에 push
				for(var i = 0; i < JSONData.length; i++) {
					datas.push({
						totalPrice : JSONData[i].totalPrice,
						totalCount : JSONData[i].totalCount,
						statDate : JSONData[i].statDate
					});
				}
				
			}
		});
		
		console.log(datas);
		return datas;
	}
	
	////////////////////////////////////////amChart////////////////////////////////////////////////////
	/* AmCharts.addInitHandler(function(chart) {
	  //check if legend is enabled and custom generateFromData property
	  //is set before running
	  if (!chart.legend || !chart.legend.enabled || !chart.legend.generateFromData) {
	    return;
	  }
	  
	  var categoryField = chart.categoryField;
	  var legendData =  chart.dataProvider.map(function(data) {
	    var markerData = {
	      "title": data[categoryField] + ": " + data[chart.graphs[0].valueField]
	    };
	    if (!markerData.color) {
	      markerData.color = chart.graphs[0].lineColor;
	    }
	    return markerData;
	  });
	  
	  chart.legend.data = legendData;
	  
	}, ["serial"]); */
	
	//막대차트 - 일단위
	var chart = AmCharts.makeChart("chartDiv", {
	    "theme": "light",
	    "type": "serial",
	   "legend": { 
	        "generateFromData": true //custom property for the plugin
	     },  
		"startDuration": 1,
	    "dataLoader" : {
	    	"url" : "C:\\Users\\GJ\\git\\Codebrew\\Codebrew\\WebContent\\data\\statistics\\test.json",
	    	"format" : "json"
	    }, //serial chart의 데이터셋
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
	        "balloonText": "[[category]]: <b>[[value]]원</b>",
	        "fillColorsField": "color",
	        "fillAlphas": 0.8,
	        "lineAlpha": 0,
	        "type": "column",
	        "valueField": "totalPrice",
	        "valueAxis" : "priceAxis"
	    }, {
	    	"bullet": "round",
	    	"lineThickness" : 2,
	    	"lineColor" : "#000000",
	        "bulletBorderAlpha": 1,
	        "bulletBorderThickness": 1,
	        "bulletColor" : "#FFFFFF",
	        "balloonText": "[[value]]장",
	        "useLineColorForBulletBorder": true,
	        "title" : "count",
	        "fillAlpha": 0,
	        "valueField": "totalCount",
	        "valueAxis" : "countAxis"
	    }],
	    "depth3D": 20,
		"angle": 30,
	    "chartCursor": {
	        "categoryBalloonEnabled": false,
	        "cursorAlpha": 0,
	        "zoomable": false
	    },
	    "categoryField": "statDate",
	    "categoryAxis": {
	        "gridPosition": "start",
	        "labelRotation": 0
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
		"dataProvider" : datas,
		"valueField" : "totalPrice",
		"titleField" : "statDate",
		"export" : {
			"enabled" : true
		}
	});
	
	
	var chartLine = AmCharts.makeChart("chartLine", {
	    "type": "serial",
	    "theme": "light",
	    "dataProvider": datas,
	    "marginRight": 40,
	    "marginLeft": 40,
	    "autoMarginOffset": 20,
	    "mouseWheelZoomEnabled":true,
	    "dataDateFormat": "YYYY-MM-DD", 
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
	        "title": "red line",
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
	        "parseDates": true,
	        "dashLength": 1,
	        "minorGridEnabled": true
	    },
	    "export": {
	        "enabled": true
	    }
	}); 
	
	/* chartLine.addListener("rendered", zoomChart);

	zoomChart();

	function zoomChart() {
		console.log(chart.dataProvider.length);
	    chartLine.zoomToIndexes(chartLine.dataProvider.length - 40, chartLine.dataProvider.length - 1);
	}  */
	
	////////////////////////////////////////chart.js////////////////////////////////////////////////////
	//차트 옵션
	var options = {
			   maintainAspectRatio: false,
			   scales: {
			     yAxes: [{
			       stacked: true,
			       gridLines: {
			         display: true
			       }
			     }],
			     xAxes: [{
			       gridLines: {
			         display: false
			       }
			     }]
			   }
		};


	//차트만들기
	function makeChart(){
		   var chart = new Chart('chartBar', {
			   type : "bar",
			   options : options,
			   data : chartData
		   });
		  var myPieChart = new Chart('chartPie', {
				type: 'doughnut',
				data: chartData,
				options: options
		   }); 
	} 
	
	var chartDataSet = [];
	//차트데이터	   
	var chartData = function(statFlag) {
		
		console.log("statFlag => "+statFlag);
		
		$.ajax({
			url : "/statisticsRest/json/getStatistics/"+statFlag,
			method : "get",
			dataType : "json",
			success : function(JSONData){
				
				console.log(JSON.stringify(JSONData));
				
				var date = [];
				var price = [];
				var count = []; 
				
				for(var i = 0; i < JSONData.length; i++) {
					date[i] = JSONData[i].statDate;
					price[i] = JSONData[i].totalPrice;
					count[i] = JSONData[i].totalCount;
					console.log("date : "+date+", price : "+price+", count : "+count);
					
				}
				chartData = {
					labels: [date[0]+"",date[1]+"",date[2]+""],
					datasets: [{
					label : "총 판매 금액",					   
					backgroundColor: [
					 	"rgba(168, 145, 253, 0.4)",
					 	"rgba(253, 166, 160, 0.4)",
					 	"rgba(253, 215, 165, 0.4)",
					 ], 
					borderColor : [ 
						"rgba(168, 145, 253, 1)",
						"rgba(253, 166, 160, 1)",
						"rgba(253, 215, 165, 1)", 
					],
					borderWidth : 1,
					hoverBackgroundColor : [
						"rgba(168, 145, 253, 0.8)",
						"rgba(253, 166, 160, 0.8)",
						"rgba(253, 215, 165, 0.8)", ],
					hoverBorderColor : [
						"rgba(168, 145, 253, 1)",
						"rgba(253, 166, 160, 1)",
						"rgba(253, 215, 165, 1)", 
					],
					data : [ price[0] + "", price[1] + "", price[2]+""],
					}]
				}; 
				
				makeChart();
			}
		});
	}

	$(function() {
	
		
		//차트만들기 default는 월단위
		var statFlag = $("input:hidden[name='statFlag']").val();
		
		if(statFlag == '1') { //일단위
			$("#chartLine").css("display", "block");
		} else if(statFlag == '2') { //월단위
			$("#chartDiv").css("display", "block");
		} else { //분기단위
			$("#chartPie").css("display", "block");
		}
		getChartData(statFlag);
		//chartData(statFlag);
		//chartData(2);
		//chartData(3);

		$("button").each(function(){}).on("click", function() {
			
			var statFlag = $(this).val();
			console.log("클릭클릭 val = " + statFlag);
			self.location = "/statistics/getStatistics?statFlag="+statFlag;
			
		});
		
	});
</script>
<style type="text/css">
	#chartDiv {
		width: 100%;
		height: 500px;
		display: none;
	}
	
	#chartPie {
		width: 100%;
		height: 500px;
		display: none;
	}
	
	 #chartLine {
		width: 100%;
		height: 500px;
		display: none;
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
</style>
</head>
<body>
	
	<jsp:include page="/view/statistics/clock.jsp"></jsp:include>
	
	<input type="hidden" name="statFlag" value="${statistics.statFlag}">
	<h3>chart.js</h3>
	<button type="button" value="1">일단위</button>
	<button type="button" value="2">월단위</button>
	<button type="button" value="3">분기단위</button>
	
	<hr>
	
	<!-- chart.js -->
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
	
	<!-- amChart -->
	<div id="chartDiv"></div>
	<div id="chartLine"></div>
	<div id="chartPie"></div>
	
</body>
</html>