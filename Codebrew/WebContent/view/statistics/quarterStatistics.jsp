<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<script type="text/javascript">
	
	///////////////////////////////////////////chart.js이용해 차트그리기/////////////////////////////////////////////////////
	
	var quarterChart;
	
	function fncQuarterChart() {

		quarterChart = new Chart('quarterChart', {
		    type: 'doughnut',
		    data: quarterChartData,
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
	
	///////////////////////////////////////////차트 데이터 세팅/////////////////////////////////////////////////////
	
	function fncQuarterChartDrow(JSONData) {

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
			label[i] = datas[i].statDate+"분기";
			datas2[i] = datas[i].totalPrice;
		}
		
		quarterChartData = {
			labels : label,
			datasets : [{
				backgroundColor: ["#3e95cd", "#8e5ea2","#3cba9f","#e8c3b9","#c45850"],
				data : datas2
			}]
		};
		
		console.log("분기별 차트그리기 데이터 ");
		console.log(quarterChartData);
		
		//차트그리기 call
		fncQuarterChart();
		
	}
	
	
	///////////////////////////////////////////Ajax로 차트 데이터 겟겟/////////////////////////////////////////////////////
	
	var quarterChartData = function() {

		$.ajax({
			url : "/statisticsRest/json/getStatistics/3",
			method : "get",
			dataType : "json",
			headers : {
				"Accept" : "application/json"//,
			//"Content-Type" : "application/json"
			},
			success : function(JSONData){
				
				console.log("쿼터차트=> "+JSON.stringify(JSONData));
				
				fncQuarterChartDrow(JSONData);
				
				//JSON data 만큼 datas에 push
				/* var datas = [];
				
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
					label[i] = datas[i].statDate+"";
					datas2[i] = datas[i].totalPrice;
				}
				
				chartData = {
					labels : label,
					datasets : [{
						data : datas2
					}]
				};
				
				console.log("분기별 차트그리기 데이터 ");
				console.log(chartData);
				
				//차트그리기 call
				fncQuarterChart(); */
				
			}
			
		});
		
	}
	
	///////////////////////////////////////////onLoad/////////////////////////////////////////////////////
	
 	$(function() {
 		
 		//// select 현재 년도 기준으로 100년전까지 생성
		var date = new Date();
		var year = date.getFullYear();
		var selectValue = $("#year");
		var optionIndex = 0;
		
		for(var i = year; i >= year-100; i--){
				$("select[name='statDate']").append("<option value="+i+">"+i+"년</option>");                        
		}
		
	  $("select[name='statDate']").on("change", function(){
		  alert($(this).val());
			fncSearchChartData(3, $(this).val());
		});
		
 	});



	
</script>
<style type="text/css">
	#quarterChart {
		width: 100%;
		height: 100%;
		/* display: none; */
	}
</style>

	<!-- 기간별 검색 -->
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
	
	<!-- 차트도화지 -->
	<canvas id="quarterChart" ></canvas>
