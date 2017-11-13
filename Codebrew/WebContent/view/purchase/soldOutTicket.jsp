<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- Bootstrap, jQuery CDN -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<title>Sold Out</title>
<style type="text/css">
	body {
			padding-top : 70px;
			background-color: #f2f4f6;
	    }
</style>
</head>
<body>
	<jsp:include page="/toolbar/toolbar.jsp"></jsp:include>
	<div class="content">
		<div class="row">
			<div class="col-md-offset-2 col-md-8">
				<img alt="soldout" src="../../resources/image/ui/soldout.gif">
				<h1>아쉽게도 티켓 수량이 없습니다. 다음 기회에 구매해주세요</h1>
				<button class="btn btn-info" type="button" onclick="history.go(-1)">뒤로가기</button>
			</div>
		</div>
	</div>
</body>
</html>