<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/data/party/userData.jsp"%>

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
	<div><a href = "/view/party/getPartyList_UI.jsp">getPartyList_UI.jsp</a></div>
	<div><a href = "/party/getMyPartyList">getMyPartyList.jsp</a></div>
	<div><a href = "http://127.0.0.1:8080/view/party/Sample.jsp">Sample.jsp</a></div>
	<div><a href = "http://127.0.0.1:8080/view/party/daum.jsp">daum.jsp</a></div>
	<div><a href = "http://127.0.0.1:8080/view/party/addr.jsp">addr.jsp</a></div>
	<div><a href = "http://127.0.0.1:8080/view/party/getMyPartyList3.jsp">myParty</a></div>
	
</body>
</html>