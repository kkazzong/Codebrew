<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<script type="text/javascript">
	////////////////////////////////////////amChart////////////////////////////////////////////////////
	//월단위
	var chart2 = AmCharts.makeChart("chartLine", {
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
	
	chartLine.addListener("rendered", zoomChart);

	zoomChart();

	function zoomChart() {
		//console.log(chart.dataProvider.length);
	    //chartLine.zoomToIndexes(chartLine.dataProvider.length - 40, chartLine.dataProvider.length - 1);
	} 
	
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
	
	//var ctx = $("#myChart")[0].getContext('2d');
	function makeChart1() {
		var myChart = new Chart('myChart', {
		    type: 'line',
		    data: chartData,
		    options: {
		    	legend : {
		    		display : true,
		    		labels : {
		    			fontColor : "#000000"
		    		}
		    	},
		        scales: {
		        	xAxes : [{
		                ticks: {
		                    beginAtZero:true
		                }
		            }],
		            yAxes: [{
		                ticks: {
		                    beginAtZero:true
		                }
		            }]
		        }
		    }
		});
	}
	
	var chartData1 = function() {
		$.ajax({
			url : "/statisticsRest/json/getStatistics/2",
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
					datas.push({
						"statDate" : JSONData[i].statDate,
						"y" : JSONData[i].totalPrice
					})
				}
				var label = [];
				for(var i = 0; i < datas.length; i++) {
					label[i] = datas[i].statDate+"";
					
				}
				console.log(label);
				chartData = {
					labels : label,	
					datasets : [{
						label : "판매금액",	
						data : datas
					}]	
				};
				console.log("gg");
				console.log(chartData);
				console.log(datas[0].statDate);
				//var obj = JSON.parse(datas);
				//console.log(obj);
				makeChart1();
			}
		});
	}
	
	
	
</script>
<style type="text/css">
	#chartLine {
		width: 100%;
		height: 500px;
		/* display: none; */
	}
</style>
<!-- <div id="chartLine"></div> -->
<canvas id="myChart" ></canvas>
