<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>



<!DOCTYPE html>
<html lang="ko">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width" />
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<!-- Bootstrap Dropdown Hover CSS -->
<link href="/resources/css/animate.min.css" rel="stylesheet">
<link href="/resources/css/bootstrap-dropdownhover.min.css" rel="stylesheet">

<!-- Bootstrap Dropdown Hover JS -->
<script src="/resources/javascript/bootstrap-dropdownhover.min.js"></script>



<style type="text/css">
	body {
		padding-top : 70px;
    }
    
    section {
    	/* background: url(/resources/image/toolbarImage/bg2.jpg) no-repeat center center; */
    	background: url(/resources/image/ui/main.gif) no-repeat center center;
		width: 100%;
	   	height: 500px;
	   background-size: 100%;
	   opacity: 0.8;
    }
    
    #box {
		padding-top: 187px;
		text-align: center;
	}
     
		
	.title {
		color: black;
		text-shadow:1px 1px 1px black;
	} 
</style>


	<script type="text/javascript">

	    
</script>
<title>Moana</title>
<!-- 타이틀 수정하지마세용 -->
</head>
<body onload="alert('시작한다');">
	<jsp:include page="/toolbar/toolbar.jsp"></jsp:include>	

	
	<!-- 배경 이미지 -->
	<section>
	
	<div class="row">
		<div class="col-md-12 text-center">
			<div class="title">
			</div>
		</div>
	</div>
	
	<div id="box" class="row">
		<div class="col-md-12 text-center">
			<div class="col-md-offset-4 col-md-4">
				<form class="form form-inline">
					<div class="form-group">
						<input class="form-control input-lg" type="text" placeholder="축제명 or 파티명 검색">
					</div>
					<div class="form-group">
						 <button class="btn btn-primary btn-block" type="button">검색</button> 
					</div>
				</form>
			</div>
		</div>
	</div>
	
<a href="/festival/getMyZzimList">getZzimlist</a>
	</section>
</body>
</html>