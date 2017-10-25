<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<script type="text/javascript">
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
	
	
	
	
	var ctx = $("#daily");
	
	function makeChart3() {
		var myChart = new Chart('dailyChart', {
		    type: 'bar',
		    data: chartData3,
		    options: {
		        legend: { display: true },
		        title: {
		          display: true,
		          text: 'Sale in 2017'
		        },
		        scales: {
		            xAxes: [{
		                type : "category",
		                labels : label
		            }],
		            yAxes: [{
		            	scaleLabel : {
			                display : true,
			                labelString : "판매금액"
			            }
		            }]
		        }
		     }
		});
	}
	
	var label = [];
	var chartData3 = function() {
		$.ajax({
			url : "/statisticsRest/json/getStatistics/1",
			method : "get",
			dataType : "json",
			headers : {
				"Accept" : "application/json"//,
			//"Content-Type" : "application/json"
			},
			success : function(JSONData){
				console.log(JSON.stringify(JSONData));
				//JSON data 만큼 datas에 push
				var datas = [];
				
				for(var i = 0; i < JSONData.length; i++) {
					datas[i] = JSONData[i].totalPrice;
					label[i] = JSONData[i].statDate+"";
				}
				for(var i = 0; i < datas.length; i++) {
				}
				console.log(label);
				chartData3 = {
					labels : label,	
					datasets : [{
						label : "판매금액",	
						data : datas
					}]	
				};
				console.log("gg");
				console.log(chartData3);
				console.log(datas[0].statDate);
				//var obj = JSON.parse(datas);
				//console.log(obj);
				makeChart3();
			}
		});
	}
	
	
</script>
<style type="text/css">
	#chartDiv {
		width: 100%;
		height: 500px;
		/* display: none; */
	}
</style>

		<!-- 기간별 검색 -->
		<div class="row">
			<div class="col-md-offset-3 col-md-6">
				<div class="row">
					<div class="col-md-12">
						<form class="form form-inline">
							<div class="form-group">
								<label for="기간 선택">기간 선택</label>
								<!-- <input class="form-control" type="text" name="startDate">
								<input class="form-control" type="text" name="endDate"> -->
								<div class="input-group">
									<input id="dailySelect" class="form-control" type="text" name="statDate">
									<div class="input-group-addon">
									<span class="glyphicon glyphicon-calendar"></span>
									</div>
								</div>
							</div>
							<div class="form-group">
								<button class="btn btn-default" type="button">조회하기</button>
							</div>
						</form>
					</div>
				</div>			
			</div>
		</div>
		
		<canvas id="dailyChart"></canvas>
<!-- <div id="chartDiv"></div> -->
