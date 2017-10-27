<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>

<html lang="ko">
	
<head>
	<meta charset="UTF-8">
	
	<!-- 참조 : http://getbootstrap.com/css/   참조 -->
	

	

 <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>

	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script> 

	<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width" />
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
	
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>



	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
		body {
			padding-top : 70px;
    	}
       #loginBox { 
        	border: 3px solid #fbbc05;
            margin-top: 10px;
        } 
        #login {
		    /* position: absolute; */
		    /* left: 165px; */
		    /* z-index: 1; */
		    width: 67px;
		    height: 67px;
        }
        #addUserBtn {
        	margin-top : 30px;
        }
    </style>
    
    <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">
	


	
	

		//============= "로그인"  Event 연결 =============
		$( function() {
			
			$("#userId").focus();
			
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$("button").on("click" , function() {
				var id=$("input:text").val();
				var pw=$("input:password").val();
				
			
				
				if(id == null || id.length <1) {
					alert('ID 를 입력하지 않으셨습니다.');
					$("#userId").focus();
					return;
				}
				
				if(pw == null || pw.length <1) {
					alert('패스워드를 입력하지 않으셨습니다.');
					$("#password").focus();
					return;
				}
				
				
				$("form").attr("method","POST").attr("action","/user/login").submit();
			});
		});	
	   
	/* 	
	    //가입된 아이디로 로그인 하나 안하나 알려주는 ajax
		 $(function(){
				
				$("input:text[name='userId']").on("keyup",function(){
					
					var userId=$("input[name='userId']").val();
					
					$.ajax({
						type:"POST",
						url:"/userRest/json/checkUserId", 
						data :{userId:$(this).val()},//요청과 함께 서버에 보내는 string 또는 map
						dataType:"json",//서버에서 받는 데이터형식
					    success: function(JSONData,status){
					    	console.log(status);
					    	console.log(JSON.stringify(JSONData)); //json string 형식으로 변환해주는거
					    	
				    	  if(JSONData == true){
					    		$("span.col-id-checkUserId").html("존재하지 않는 아이디 입니다.").css("color","blue");
				    	  }else{
				    		  $("span.col-id-checkUserId").remove();
				    	  }
					    }
					});		
				});						
		 }); 
	     */
	    
		/* //입력한 아이디랑 비밀번호가 같은지 알려주는 ajax */
		/*  $(function(){
				
				$("input:password[name='password']").on("keyup",function(){//띄었을때
					
					var userId=$("input[name='userId']").val();
					var password=$("input[name='password']").val();
					
					
					$.ajax({
						type:"POST",
						url:"/userRest/json/getUser", 
						/* headers: {
							"Accept":"application/json;charset=UTF-8",
							"Content-Type" : "application/json"
						},
					
					    data : JSON.stringify({
						userId : userId,//보내는 정보				
					    }), */
					    
					 /*    
						data :{userId:userId},//요청과 함께 서버에 보내는 string 또는 map
						dataType:"json",//서버에서 받는 데이터형식
					    success: function(JSONData,status){
					    	console.log(status);
					    	console.log(JSON.stringify(JSONData)); //json string 형식으로 변환해주는거
					    	
					    	var pw=JSONData.password;
					    	
				    	  if(pw != password){
					    		$("span.col-id-checkPassword").html("비밀번호가 틀렸습니다.").css("color","blue");
				    	  }else{
				    		  $("span.col-id-checkPassword").remove();
				    	  }
					    }
					});		
				});						
		 });  
		 */
	    
	    
	    
	    
	
		//============= 회원가입화면이동 =============
		$( function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$("a[href='#' ]").on("click" , function() {
				self.location = "/user/confirmUser"
			});
		});
		
	    
		//============= 아이디찾기 비밀번호찾기 =============	
		$( function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$("#findUser").on("click" , function() {
				self.location = "/user/findUser"
			});
		});
		
		
	
		  
	</script>		
	
</head>

<body>

	<!-- toolbar -->
	<jsp:include page="/toolbar/toolbar.jsp"></jsp:include>
	
	<div class="container">
		<div class="row">
			<div id="loginBox" class="col-md-offset-3 col-md-6">
				<!-- 로그인폼 -->
				<form class="form-horizontal">
					<h1 class="text-center">로 &nbsp;&nbsp;그 &nbsp;&nbsp;인</h1>
					<div class="col-md-offset-1 col-md-10">
						<div class="input-group">
							<input type="text" class="form-control" name="userId" id="userId"  placeholder="아이디" >
							<input type="password" class="form-control" name="password" id="password" placeholder="패스워드">
							<span class="input-group-btn">
								<button id="login" type="button" class="btn btn-primary btn-block"  >로그인</button>
							</span>
						</div>
					</div>
					 <span class="col-id-checkUserId"></span>
					 <span class="col-id-checkPassword"></span>
					
					<div class="form-group">
						<div class="col-md-offset-3 col-md-6 text-center">
						 	<a id="addUserBtn" class="btn btn-default btn btn-block" href="#" role="button">회 &nbsp;원 &nbsp;가 &nbsp;입</a>
						 </div>
					</div>
					
					<div class="form-group">
						<div class="col-md-offset-3 col-md-6 text-center">
						 	<a id="findUser" class="btn btn-default btn btn-block" href="#" role="button">아이디찾기/비밀번호찾기</a>
						 </div>
					</div>
					
					
					<div class="col-md-offset-3">
					<jsp:include page="/api/kakaoLogin.jsp" />
				</div>
				
				</form>
				<!-- 카카오 로그인 -->
			
			</div>
		</div>
	</div>

	<!-- ToolBar Start /////////////////////////////////////-->
	<!-- <div class="navbar  navbar-default">
        <div class="container">
        	<a class="navbar-brand" href="/index.jsp">Model2 MVC Shop</a>
   		</div>
   	</div> -->
   	<!-- ToolBar End /////////////////////////////////////-->	
	
	
	<!--  화면구성 div Start /////////////////////////////////////-->
	<!-- <div class="container"> -->
		<!--  row Start /////////////////////////////////////-->
		<!-- <div class="row"> -->
		

			<!-- <div class="col-md-6">
					<img src="/images/logo-spring.png" class="img-rounded" width="100%" />
			</div> -->


	   	 	
	 	 	<%-- <div class="col-md-6">
	 	 	
		 	 	<br/><br/>
				
				<div class="jumbotron">	 	 	
		 	 		<h1 class="text-center">로 &nbsp;&nbsp;그 &nbsp;&nbsp;인</h1>

			        <form class="form-horizontal">
		  
					  <div class="form-group">
					    <label for="userId" class="col-sm-4 control-label">아 이 디</label>
					    <div class="col-sm-6">
					      <input type="text" class="form-control" name="userId" id="userId"  placeholder="아이디" >
					    </div>
					  </div>
					  
					  <div class="form-group">
					    <label for="password" class="col-sm-4 control-label">패 스 워 드</label>
					    <div class="col-sm-6">
					      <input type="password" class="form-control" name="password" id="password" placeholder="패스워드" >
					    </div>
					  </div>
					  
					  <div class="form-group">
					    <div class="col-sm-offset-4 col-sm-6 text-center">
					      <button type="button" class="btn btn-primary"  >로 &nbsp;그 &nbsp;인</button>
					      <a class="btn btn-primary btn" href="#" role="button">회 &nbsp;원 &nbsp;가 &nbsp;입</a>
					    </div>
					   
            	      
	

			<jsp:include page="/api/kakaoLogin.jsp" /> 

					    
					  </div>
			
					</form>
			   	 </div>
			
			</div>
			
  	 	</div> --%>
  	 	<!--  row Start /////////////////////////////////////-->
  	 	
 	<!-- </div> -->
 	<!--  화면구성 div end /////////////////////////////////////-->

</body>

</html>