<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>


<!DOCTYPE html>
<html lang="ko">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	
	<title>��Ƽ ���� ȭ��</title>

	<!-- ���� : http://getbootstrap.com/css/   ���� -->
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <link rel="stylesheet" href="/resources/demos/style.css">
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>

	<!-- Jquery DatePicker -->
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    
    <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">
		
		//============= "����"  Event ���� =============
		 $(function() {
			//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$( "button.btn.btn-primary" ).on("click" , function() {
				fncAddProduct();
			});
		});	
		
		
		//============= "���"  Event ó�� ��  ���� =============
		$(function() {
			//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$("a[href='#']").on("click" , function() {
				history.go(-1);
			});
		});
		
		//============= "DatePicker"  Event ó�� ��  ���� =============
		$(function() {
	      $( "#datepicker" ).datepicker({
	   	   changeMonth: true, 
	          changeYear: true,
		       dateFormat: "yy/mm/dd" 
	      });   
	    });

		//============= "Ƽ�ϼ���"  Event ó�� ��  ���� =============
		$(function(){
			$("#partyMemberCount").on("keyup", function(){
				var ticketCount = $("#partyMemberCount").val();
				$("#ticketCount").val(ticketCount);
			});
		})
		
		
	</script>
</head>
<body>
	
	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
	<div class="container">
		<hr/>
		<h1 class="bg-primary text-center">��Ƽ ����</h1>
		<br>
		<!-- form Start /////////////////////////////////////-->
		<form class="form-horizontal" enctype="multipart/form-data">
		
		  <div class="form-group">
		    <label for="partyFlag" class="col-sm-offset-1 col-sm-3 control-label">��Ƽ����</label>
		    <div class="col-sm-4">
		      <input type="radio" name="partyFlag" value="party" checked />��Ƽ
		      <input type="radio" name="partyFlag" value="afterParty" />��������Ƽ		  		      
		    </div>
		  </div>
	
		  <div class="form-group">
		    <label for="festivalName" class="col-sm-offset-1 col-sm-3 control-label">������</label>
		    <div class="col-sm-4">
		      <input type="text" readonly="readonly" class="form-control" id="festivalName" name="festivalName" placeholder="������ �˻����ּ���.">
		      <input type="hidden" class="form-control" id="festivalNo" name="festivalNo">
		    </div>
		    <div>
		      <button type="button" class="btn btn-primary" id="search-festival"  >�����˻�</button>
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="host" class="col-sm-offset-1 col-sm-3 control-label">������</label>
		    <div class="col-sm-4">
		      <input type="text" readonly="readonly" class="form-control" id="host" name="nickName" >
		    </div>
		   	
		  </div>
		  
		  <div class="form-group">
		    <label for="partyName" class="col-sm-offset-1 col-sm-3 control-label">��Ƽ�̸�</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="partyName" name="partyName" >
			</div>
		  </div>
		  
		  <div class="form-group">
		    <label for="partyDate" class="col-sm-offset-1 col-sm-3 control-label">��Ƽ��¥</label>
		    <div class="col-sm-4">
		      <input type="text" readonly="readonly" class="form-control" id="datepicker" name="partyDate" placeholder="��Ƽ��¥�� �������ּ���.">
		    </div> 	
		  </div>
		  
		  <div class="form-group">
		    <label for="partyDetail" class="col-sm-offset-1 col-sm-3 control-label">��Ƽ����</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="partyDetail" name="partyDetail" >
			</div>
		  </div>
		  
		  <div class="form-group">
		    <label for="partyDetail" class="col-sm-offset-1 col-sm-3 control-label">��Ƽ�ο�</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="partyMemberCount" name="partyMemberCount" >
			</div>
		  </div>
		  
		  <div class="form-group">
		    <label for="partyPlace" class="col-sm-offset-1 col-sm-3 control-label">��Ƽ���(�����Է�)</label>
		    <div class="col-sm-4">
		      <input type="text" readonly="readonly" class="form-control" id="partyPlace" name="partyPlave" placeholder="��Ƽ��Ҹ� �˻����ּ���.">
		    </div>
		    <div>
		      <button type="button" class="btn btn-primary" id="search-partyPlace"  >�˻�</button> 	
		    </div>
		  </div>
		  		  	  
		  <div class="form-group">
		    <label for="partyImage" class="col-sm-offset-1 col-sm-3 control-label">��Ƽ����(�����Է�)</label>
		    <div class="col-sm-4">
		      <input type="file" class="form-control" id="partyImage" name="partyImage" placeholder="��Ƽ������ �÷��ּ���.">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="ticketCount" class="col-sm-offset-1 col-sm-3 control-label">Ƽ�ϼ���</label>
		    <div class="col-sm-4">
		      <input type="text" readonly="readonly" class="form-control" id="ticketCount" name="ticketCount" >
			</div>
		  </div>
		  
		  <div class="form-group">
		    <label for="ticketPrice" class="col-sm-offset-1 col-sm-3 control-label">Ƽ�ϰ���</label>
		    <div class="col-sm-2">
		      <input type="text" class="form-control" id="ticketPrice" name="ticketPrice" > 
			</div>
			<div class="col-sm-1">
			   ����<input type="radio" class="form-control" id="ticketPrice" name="ticketPrice" value="0">
			</div>
		  </div>
		 		  
		  <div class="form-group">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		      <button type="button" class="btn btn-primary"  >��&nbsp;��</button>
			  <a class="btn btn-primary btn" href="#" role="button">��&nbsp;��</a>
		    </div>
		  </div>
		</form>
		
		
		<!-- form End /////////////////////////////////////-->
		
 	</div>
	<!--  ȭ�鱸�� div end /////////////////////////////////////-->
	
</body>
</html>