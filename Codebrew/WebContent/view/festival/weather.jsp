<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

	<meta name="viewport" content="width=device-width, initial-scale=1.0" />

	<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<link
	href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/3.0.0/css/bootstrap-datetimepicker.min.css"
	rel="stylesheet" />
	<script
	src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.8.2/moment-with-locales.min.js"></script>
	<script
	src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/3.0.0/js/bootstrap-datetimepicker.min.js"></script>
	<link rel="stylesheet"
	href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css"
	type="text/css" />
	<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
	<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=a6419e542017d8fd315556f745f29fcf"></script>
	
	<!-- Bootstrap Dropdown Hover CSS -->
<link href="/resources/css/animate.min.css" rel="stylesheet">
<link href="/resources/css/bootstrap-dropdownhover.min.css" rel="stylesheet">

<!-- Bootstrap Dropdown Hover JS -->
<script src="/resources/javascript/bootstrap-dropdownhover.min.js"></script>
	
	<script type="text/javascript">
		
	$(function() {
		$("button[type='button']").on("click", function() {
			
			self.location = "/festival/weather?festivalLongitude=126&festivalLatitude=35";

		});
	});


		
		</script>		
	
</head>
<body>

<jsp:include page="/toolbar/toolbar.jsp"></jsp:include>


	<input type = "hidden" class="form-control" id="festivalLongitude" name="festivalLongitude" value= "126.7044055224">
	<input type = "hidden" class="form-control" id="festivalLatitude" name="festivalLatitude" value= "35.4303280891">
	
		<div class="form-group">
				<div class="col-sm-offset-4  col-sm-4 text-center">
					<button type="button" class="btn btn-primary">날씨</button>
					<input type = "button" id = "back" name = "back" value = "뒤로"/>
				</div>
			</div>
	
	<br/><br/><br/><br/>
	<br/><br/><br/><br/>
				

		<c:forEach var = "weather" items="${list }">
		
					
					baseDate : ${weather.baseDate }
					<br/><br/>
					fcstTime : ${weather.fcstTime }
					<br/><br/>
					fcstValue : ${weather.fcstValue }
					<br/><br/>
					nx : ${weather.nx }
					<br/><br/>
					ny : ${weather.ny }
					<br/><br/>
					category : ${weather.category }
					<br/><br/>
					<br/><br/>
					<br/><br/>
					<br/><br/>
					<br/><br/>
					
	
	
	</c:forEach>
	
	
	<input type = "hidden" class="form-control" id="festivalLongitude" name="festivalLongitude" value= "126.7044055224">
	<input type = "hidden" class="form-control" id="festivalLatitude" name="festivalLatitude" value= "35.4303280891">
	
		<div class="form-group">
				<div class="col-sm-offset-4  col-sm-4 text-center">
					<button type="button" class="btn btn-primary">날씨</button>
					<input type = "button" id = "back" name = "back" value = "뒤로"/>
				</div>
			</div>
	
	

	
	
</body>
</html>