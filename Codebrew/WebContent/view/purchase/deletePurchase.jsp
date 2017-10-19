<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>deletePurchase</title>
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
<script type="text/javascript">
	$(function(){
		
		$(".btn").on("click", function(){
			self.location = "/purchase/getPurchaseList";
		});
		
	});
</script>
<style type="text/css">
	body {
		padding-top : 70px;
    }
    .glyphicon {
    	font-size: 50px;
	}
</style>
</head>
<body>
	
	<jsp:include page="/toolbar/toolbar.jsp"></jsp:include>
	
	<div class="container">
		<div class="jumbotron">
			<span class="glyphicon glyphicon-ok-circle" aria-hidden="true"></span>
		  <h3>구매내역이 삭제되었습니다</h3>
		  <p><a class="btn btn-default btn-lg" href="#" role="button">돌아가기</a></p>
		</div>
	</div>

</body>
</html>