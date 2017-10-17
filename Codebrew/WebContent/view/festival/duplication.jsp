<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
	
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=a6419e542017d8fd315556f745f29fcf"></script>
	
	<script type="text/javascript">
	
	 $(function(){
		 $( "button:contains('리스트로 돌아가기')" ).on("click" , function() {
			 
			 self.location = "/festival/getFestivalList?pageNo=1";
		});
});
	
	
		
	
		</script>		
	
</head>
<body>
<h1><Strong>이미등록된 축제임</Strong></h1>

<button type="button" class="btn btn-default">리스트로 돌아가기</button>

	
</body>
</html>