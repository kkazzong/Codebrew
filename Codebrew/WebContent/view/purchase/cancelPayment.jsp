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
			//�ͽ��÷η���� �ݱ��Ҷ� alertâ �ȶ߰� �ϱ�����..
			window.open("about:blank", "_self").close();
		});
		
	});
</script>
</head>
<body>
������ ��� �Ǿ����ϴ�.
<button type="button">�ݱ�</button>
</body>
</html>