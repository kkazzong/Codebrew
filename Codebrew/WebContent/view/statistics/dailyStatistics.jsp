<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<script type="text/javascript">

	///////////////////////////////////////////chart.js이용해 차트그리기/////////////////////////////////////////////////////
	
	var dailyChart;
	
	function fncDailyChart() {
		
		dailyChart = new Chart('dailyChart', {
		    type: 'bar',
		    data: dailyChartData,
		    options: {
		        legend: { 
		        	display: true 
		        },
		        title: {
		          display: true,
		          text: ' 판매통계'
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
	
	var colors = [];
	function getRandomColor(count) {
		//alert("랜덤컬러"+count);
	    var letters = '0123456789ABCDEF'.split('');
	    var color = '#';
	    for(var i = count; i > 0; i--) {
		    for (var i = 0; i < 6; i++ ) {
		        color += letters[Math.floor(Math.random() * 16)];
		    }
		    colors[i] = color;
	    }
	    return colors;
	    
	}
	
	///////////////////////////////////////////차트 데이터 세팅/////////////////////////////////////////////////////
	
	function fncDailyChartDrow(JSONData) {
		
		//JSON data 만큼 datas에 push
		datas = [];
		label = [];
		
		for(var i = 0; i < JSONData.length; i++) {
			datas[i] = JSONData[i].totalPrice;
			label[i] = JSONData[i].statDate+"";
		}
		
		//// 색깔 랜덤~~
		var letters = '0123456789ABCDEF'.split('');
	    var count = JSONData.length;
	    for(var i = count; i > 0; i--){
		    var color = '#';
		    for (var j = 0; j < 6; j++ ) {
		        color += letters[Math.floor(Math.random() * 16)];
		    }
		    colors[i] = color;
	    }
		
		
		dailyChartData = {
			labels : label,	
			datasets : [{
				label : "판매금액",	
				backgroundColor : colors,
				data : datas
			}]	
		};
		
		console.log("차트그리기 데이터 ");
		console.log(dailyChartData);
		
		//원래 차트 destroy후 차트그리기 call
		fncDailyChart();
		
	}
	
	///////////////////////////////////////////Ajax로 차트 데이터 겟겟/////////////////////////////////////////////////////

	var label = [];
	
	var dailyChartData = function() {
		
		$.ajax({
			
			url : "/statisticsRest/json/getStatistics/1",
			method : "GET",
			dataType : "json",
			headers : {
				"Accept" : "application/json"//,
			//"Content-Type" : "application/json"
			},
			success : function(JSONData){
				
				console.log("데일리차트=> "+JSON.stringify(JSONData));
				
				fncDailyChartDrow(JSONData);
				
				//JSON data 만큼 datas에 push
				/* var datas = [];
				
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
				
				console.log("일별 차트그리기 데이터 ");
				console.log(dailyChartData);
				
				//차트그리기 call
				fncDailyChart(); */
			}
			
		});
		
	}
	
	
</script>
<style type="text/css">
	#dailyChart {
		width: 100%;
		height: 100%;
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
							<!-- <div class="form-group">
								<button class="btn btn-default" type="button">조회하기</button>
							</div> -->
						</form>
					</div>
				</div>			
			</div>
		</div>
		
		<!-- 차트도화지 -->
		<canvas id="dailyChart"></canvas>
