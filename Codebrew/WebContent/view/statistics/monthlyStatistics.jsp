<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<script type="text/javascript">
	
	///////////////////////////////////////////chart.js이용해 차트그리기/////////////////////////////////////////////////////
	
	var monthlyChart;
	
	function fncMonthlyChart() {
		
		monthlyChart = new Chart('monthlyChart', {
		    type: 'line',
		    data: monthlyChartData,
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
	
	function fncMonthlyChartDrow(JSONData) {
		
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
		
		monthlyChartData = {
			labels : label,	
			datasets : [{
				label : "판매금액",	
				backgroundColor : "rgba(179,181,198,0.7)",
				borderColor : "rgba(179,181,198,1)",
				pointBorderColor : "#fff",
				pointBackgroundColor : "rgba(179,181,198,1)",
				data : datas
			} ]
		};

		console.log("월별 차트그리기 데이터 ");
		console.log(monthlyChartData);
		
		//차트그리기 call
		fncMonthlyChart();

	}

	///////////////////////////////////////////Ajax로 차트 데이터 겟겟/////////////////////////////////////////////////////

	var monthlyChartData = function() {

		$.ajax({

			url : "/statisticsRest/json/getStatistics/2",
			method : "get",
			dataType : "json",
			headers : {
				"Accept" : "application/json"//,
			//"Content-Type" : "application/json"
			},
			success : function(JSONData) {

				console.log("먼슬리차트=> " + JSON.stringify(JSONData));

				fncMonthlyChartDrow(JSONData);

				/* //JSON data 만큼 datas에 push
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
				
				monthlyChartData = {
					labels : label,	
					datasets : [{
						label : "판매금액",	
						data : datas
					}]	
				};
				
				console.log("월별 차트그리기 데이터 ");
				console.log(monthlyChartData);
				
				//차트그리기 call
				fncMonthlyChart(); */

			}
		});

	}

	///////////////////////////////////////////onLoad/////////////////////////////////////////////////////

	$(function() {

		//// datepicker설정
		$.datepicker.setDefaults({

			dateFormat : 'yy-mm',
			monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월',
					'9월', '10월', '11월', '12월' ],
			monthNamesShort : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월',
					'9월', '10월', '11월', '12월' ],
			dayNames : [ '일', '월', '화', '수', '목', '금', '토' ],
			dayNamesShort : [ '일', '월', '화', '수', '목', '금', '토' ],
			dayNamesMin : [ '일', '월', '화', '수', '목', '금', '토' ],
			showMonthAfterYear : true,
			yearSuffix : '년',
			changeMonth : true,
			changeYear : true,
			closeText : "선택",
			showButtonPanel : true

		});

		//// input태그 2개에 datepicker
		//$("#monthStartDate, #monthEndDate").datepicker();

		//// daterangepicker 설정
		$("#monthlySelect").daterangepicker(
				{
					dateLimit : {
						months : 1
					},
					locale : {
						format : "YYYY-MM-DD",
						daysOfWeek : [ '일', '월', '화', '수', '목', '금', '토' ],
						monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월',
								'7월', '8월', '9월', '10월', '11월', '12월' ],
						firstDay : 1,
						cancelLabel : "취소",
						applyLabel : "적용"
					},
					minDate : "1990-01-01",
					showDropdowns : true,
					applyClass : "btn-primary",
					showCustomRangeLabel : false,
					ranges : {
						/*  '오늘': [moment(), moment()],
						 '어제': [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
						 '지난 7일': [moment().subtract(6, 'days'), moment()],
						 '지난 30일': [moment().subtract(29, 'days'), moment()], */
						'이번 달' : [ moment().startOf('month'),
								moment().endOf('month') ],
						'이번달 ~ 1개월 전' : [
								moment().subtract(1, 'month').startOf('month'),
								moment().endOf('month') ],
						'이번달 ~ 2개월 전' : [
								moment().subtract(2, 'month').startOf('month'),
								moment().endOf('month') ],
						'이번달 ~ 3개월 전' : [
								moment().subtract(3, 'month').startOf('month'),
								moment().endOf('month') ]
					}
				});

		//// 날짜 골랐을때
		$("#monthlySelect").on("apply.daterangepicker", function(picker) {
			console.log($(this).val());
			fncSearchChartData(2, $(this).val());
		});

		$("#monthlySelect").on("cancel.daterangepicker", function(picker) {
			$(this).val('');
		});

	})
</script>

<style type="text/css">
	#monthlyChart {
		width: 100%;
		height: 100%;
		/* display: none; */
	}
	table.ui-datepicker-calendar { 
		display:none;
	}
</style>

	<!-- 기간별 검색 -->
	<form class="form form-inline">
		<div class="form-group">
			<label for="월별 선택">월별 선택</label>
			<div class="input-group">
				<input id="monthlySelect" class="form-control" type="text" name="startDate">
				<div class="input-group-addon">
					<span class="glyphicon glyphicon-calendar"></span>
				</div>
				<!-- <input id="monthEndDate" class="form-control" type="text" name="endDate">
				<div class="input-group-addon">
					<span class="glyphicon glyphicon-calendar"></span>
				</div> -->
			</div>
		</div>
	</form>
	
	<!-- 차트도화지 -->
	<canvas id="monthlyChart" ></canvas>
