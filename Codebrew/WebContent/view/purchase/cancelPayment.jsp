<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title></title>
<script type="text/javascript" src="https://code.jquery.com/jquery-2.2.4.js"></script>
<script type="text/javascript">
	$(function(){
		
		$("button").bind("click", function(){
			//익스플로러경우 닫기할때 alert창 안뜨게 하기위해..
			window.open("about:blank", "_self").close();
		});
		
	});
</script>
</head>
<body>
결제가 취소 되었습니다.
<button type="button">닫기</button>
</body>
</html>