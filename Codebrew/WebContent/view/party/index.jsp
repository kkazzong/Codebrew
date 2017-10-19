<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<title>index 화면</title>
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script>
		
		/* $(function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			 $( "a[href='#' ]" ).on("click" , function() {
					self.location = "/Codebrew/party/addParty?userId=user01"
				});
		}); */
	</script>
</head>
<body>
	여기있음 하이퍼링크
	<div><a href = "/party/addParty?userId=user01@naver.com">addParty.jsp</a></div>
	<div><a href = "/party/getParty?partyNo=10000">getParty.jsp</a></div>
	<div><a href = "/party/getPartyList">getPartyList.jsp</a></div>
	<div><a href = "/party/getMyPartyList?user">getMyPartyList.jsp</a></div>
	<div><a href = "http://127.0.0.1:8080/view/party/Sample.jsp">Sample.jsp</a></div>
	<div><a href = "http://127.0.0.1:8080/view/party/addr.jsp">addr.jsp</a></div>
	
</body>
</html>