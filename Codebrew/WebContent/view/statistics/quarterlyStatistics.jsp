<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<script type="text/javascript">
	////////////////////////////////////////amChart////////////////////////////////////////////////////
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
	
	
	
	
	function makeChart2() {
		var myChart = new Chart('quater', {
		    type: 'doughnut',
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
		                scaleLabel : {
		                	display : true,
		                	labelString : "분기"
		                }
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
	
	var chartData2 = function() {
		$.ajax({
			url : "/statisticsRest/json/getStatistics/3",
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
						statDate : JSONData[i].statDate * 1,
						totalPrice : JSONData[i].totalPrice,
						totalCount : JSONData[i].totalCount
					})
				}
				var label = [];
				var datas2 = [];
				for(var i = 0; i < datas.length; i++) {
					/* label.push({
						"label" : [datas[i].x],
						"data" : [datas[i]]
					}) bubble*/
					label[i] = datas[i].statDate+"";
					datas2[i] = datas[i].totalPrice;
				}
				console.log(label);
				chartData = {
					labels : label,
					datasets : [{
						data : datas2
					}]
				};
				console.log("gg");
				console.log(chartData);
				console.log(datas[0].statDate);
				//var obj = JSON.parse(datas);
				//console.log(obj);
				makeChart2();
			}
		});
	}
	
 	$(function() {
 		
		var date = new Date();

		var year = date.getFullYear();

		var selectValue = $("#year");

		var optionIndex = 0;
		

		for(var i = year; i >= year-100; i--){
				console.log(i);
				$("select[name='statDate']").append("<option value="+i+">"+i+"년</option>");                        

		}
		
	  $("select[name='statDate']").on("change", function(){
		  alert($(this).val());
			fncSearchChartData(3, $(this).val());
		});
		
 	});



	
</script>
<style type="text/css">
	#chartPie {
		width: 100%;
		height: 500px;
		/* display: none; */
	}
</style>

	<form class="form form-inline">
		<div class="form-group">
			<label for="년도 선택">년도 선택</label>
			<div class="input-group">
				<select class="form-control" name="statDate">
					<option>년도선택</option>
				</select>
			</div>
		</div>
	</form>
	
	<canvas id="quater" ></canvas>
