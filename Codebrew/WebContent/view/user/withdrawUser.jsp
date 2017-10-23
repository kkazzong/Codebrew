<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>

<html lang="ko">
	
<head>
	<meta charset="UTF-8">

	
	<!-- 참조 : http://getbootstrap.com/css/   참조 -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	

   
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
		body {
            padding-top : 50px;
        }
    </style>
    
    	
	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/toolbar/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
    
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">
	
	//============= "수정"  Event 연결 =============
	 $(function() {
		 
		 
		 
		//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		$( "button.btn.btn-primary").on("click" , function() {
			fncWithdrawUser();
		});
	});	
	
	
	//============= "취소"  Event 처리 및  연결 =============
	$(function() {
		//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		$("a[href='#' ]").on("click" , function() {
			
			self.location = "/index.jsp"
			
			//$("form")[0].reset();
			//history.go(-1);
		});
	});	
	
	
	
		 
	
	//=============이메일" 유효성Check  Event 처리 =============
/* 	 $(function() {
		 
		 $("input[name='email']").on("change" , function() {
				
			 var email=$("input[name='email']").val();
		    
			 if(email != "" && (email.indexOf('@') < 1 || email.indexOf('.') == -1) ){
		    	alert("이메일 형식이 아닙니다.");
		     }
		});
		 
	});	 */
	
	///////////////////////////////////////////////////////////////////////
	function fncWithdrawUser() {
	/* 	var name=$("input[name='userName']").val();
		
		if(name == null || name.length <1){
			alert("이름은  반드시 입력하셔야 합니다.");
			return;
		}
			
		var value = "";	
		if( $("input[name='phone2']").val() != ""  &&  $("input[name='phone3']").val() != "") {
			var value = $("option:selected").val() + "-" 
								+ $("input[name='phone2']").val() + "-" 
								+ $("input[name='phone3']").val();
		}
		
		//Debug...
		//alert("phone : "+value);
		$("input:hidden[name='phone']").val( value ); */
			
		$("form").attr("method" , "POST").attr("action" , "/user/withdrawUser").submit();
	}


	</script>
</head>
<body>
	
<div class="container">
	<h2 align="center">회원탈퇴</h2><br>
	
		<form class="form-horizontal">

		<div class="form-group">
		  <label class="col-md-4 control-label" for="userId">I D</label>  
		  <div class="col-md-4"><!--네임이 없었구나  -->
		  		${user.userId}
		 <input type="hidden" class="form-control" id="userId" name="userId" value="${user.userId}">
		<%--  <input type="hidden" name="role" value="${user.role}">  --%>
		  </div>
		</div>
		
		<div class="form-group">
		  <label class="col-md-4 control-label" for="password">비밀번호</label>  
		  <div class="col-md-4">
		  	<input type="password" id="password" name="password" class="form-control input-md">
		  </div>
		</div>
		
	  <div class="form-group">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		      <button type="button" class="btn btn-primary"  >탈퇴</button>
			  <a class="btn btn-primary btn" href="#" role="button">취소</a>
		    </div>
		  </div>
		</form>
</div>

</body>
</html>