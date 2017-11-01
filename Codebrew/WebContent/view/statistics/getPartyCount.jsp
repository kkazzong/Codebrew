<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<!DOCTYPE html>
<html lang="ko">
<head>
	<title>getFestivalZzim</title>
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
	
	<!-- jQuery ui -->
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<script src="https://code.jquery.com/ui/1.12.0/jquery-ui.min.js"></script>
	
	<!-- Include Required Prerequisites -->
	<script type="text/javascript" src="//cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
	<!-- Include Date Range Picker -->
	<script type="text/javascript" src="//cdn.jsdelivr.net/bootstrap.daterangepicker/2/daterangepicker.js"></script>
	<link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/bootstrap.daterangepicker/2/daterangepicker.css" />

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
		
			
		});
	</script>
	<style type="text/css">
	
		body {
			padding-top : 70px;
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
		
		<!-- 통계차트 -->
		<div class="row">
			<div class="col-md-offset-3 col-md-6">
				<div class="row">
					<div class="col-md-12">
						<c:set var="i" value="0" /> 
						<c:forEach var="stat" items="${list}">
								<c:set var="i" value="${i+1}" /> 
								<h3>${i}위</h3>
								<h3>참여자수 : ${stat.totalCount}</h3>
								<h3>${stat.name}</h3>
								<img class="col-md-12" src="/resources/uploadFile/${stat.image}">
						</c:forEach>				
					</div>
				</div>
			</div>
		</div>
	</div>
	
</body>
</html>