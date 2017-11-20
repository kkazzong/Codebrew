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
	
	
	<link href="//netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.css" rel="stylesheet">
	
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script> 

	<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width" />
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
	
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>


    
    <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">
	


	
	

	$( function() {
		//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		$("a[href='#' ]:contains('Join')").on("click" , function() {
			self.location = "/user/confirmUser"
		});
	});
		
		
	
	$( function() {
		//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		$("#findUser").on("click" , function() {
			self.location = "/user/findUser"
		});
	});
		
	
$(function(){
	
	//$("#loginPassword").on("keydown", function(event){
		
     $("#loginPassword").focus(function(){

		var userId=$("#loginUserId").val();
		
	   //if(event.keyCode == '9'){ //tab 9
	
		 $.ajax({
		   type: "POST",
		   url:"/userRest/json/checkUserId",
		   data:{userId:userId},
		   dataType:"json",
		   success: function(JSONData,status){
			   console.log(status);
			   console.log(JSON.stringify(JSONData));
			   
			   if(JSONData == true){
				 alert("존재하지 않는아이디 입니다. 회원가입 후 로그인 해주세요"); 
				 event.preventDefault();
				 $("#loginUserId").focus();
				 return;
				 //return false;
			    // event.stopPropagation();
			    //event.stopImmediatePropagation();
			   }else if(JSONData == false){
				  fncLogin();
			   }
		   }//success
		})//ajax
	  // }//keyCode
	});//keyDown
 });
	
function fncLogin() {
		
		//$("#loginPassword").blur( function(){
		
		//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		$("#sign").on("click" , function(event) {
			var userId=$("#loginUserId").val();
			var password=$("#loginPassword").val();
			
		
			
			if(userId == null || userId.length <1) {
				alert('ID 를 입력하지 않으셨습니다.');
				$("#loginUserId").focus();
				return;
			}
			
			if(password == null || password.length <1) {
				alert('패스워드를 입력하지 않으셨습니다.');
				$("#loginPassword").focus();
				return;
			}
			
			
			
			$.ajax({
				type:"POST",
				url:"/userRest/json/getUser", 
		        data :{userId:userId},//요청과 함께 서버에 보내는 string 또는 map
				dataType:"json",//서버에서 받는 데이터형식
			    success: function(JSONData,status){
			    	console.log(status);
			    	console.log(JSON.stringify(JSONData)); //json string 형식으로 변환해주는거
			    	
			    	var id=JSONData.userId;
			    	var pw=JSONData.password;
			
			 
			    if(pw != password){
			     /* $("span.col-id-checkPassword").html("비밀번호가 틀렸습니다.").css("color","blue"); */
			     alert("비밀번호가 틀렸습니다.")
			     event.preventDefault();
			     return;
			    }else{
		         //$("span.col-id-checkPassword").remove();
		       /*   alert("여기옴") */
			    	$("#loginForm").attr("method","POST").attr("action","/user/login").submit();
		      /*    alert("저기옴") */
		      //form에 아디를 지정해 findUser.jsp의 폼과 중복되지 않게 하고, findUser.jsp에 id=userId인걸 id=email로 바꿈
		      
		      
			      }
			    }//success
			})//비번체크 ajax 
				  
			
			
		});//click event
		
		//}
		
	}//fncLogin()
   

	
		
</script>  
	
		  
			
	
	<style>
		body {
			padding-top : 70px;
    	}
     
     
      @media (min-width: 768px) {
    .omb_row-sm-offset-3 div:first-child[class*="col-"] {
        margin-left: 25%;
    }
}

.omb_login .omb_authTitle {
    text-align: center;
	line-height: 200%;
}
	
.omb_login .omb_socialButtons a {
	color: white; // In yourUse @body-bg 
	opacity:1;
}
/* .omb_login .omb_socialButtons a:hover {
    color: white;
	opacity:1;    	
} */
/* .omb_login .omb_socialButtons .omb_btn-facebook {background: #3b5998;}
.omb_login .omb_socialButtons .omb_btn-twitter {background: #00aced;}
.omb_login .omb_socialButtons .omb_btn-google {background: #c32f10;} */


 .omb_login .omb_loginOr {
	position: relative;
	font-size: 1.5em;
	color: #aaa;
	margin-top: 1em;
	margin-bottom: 1em;
	padding-top: 0.5em;
	padding-bottom: 0.5em;
} 
.omb_login .omb_loginOr .omb_hrOr {
	background-color: #cdcdcd;
	height: 1px;
	margin-top: 0px !important;
	margin-bottom: 0px !important;
}
.omb_login .omb_loginOr .omb_spanOr {
	display: block;
	position: absolute;
	left: 50%;
	 top: -0.6em; 
	margin-left: -1.5em;
	background-color: white;
	width: 3em;
	text-align: center;
}			

.omb_login .omb_loginForm .input-group.i {
	width: 2em;
}
.omb_login .omb_loginForm  .help-block {
    color: red;
}

	
@media (min-width: 768px) {
    .omb_login .omb_forgotPwd {
        text-align: right;
		margin-top:10px;
 	}		
}
    </style>
	
	
	
	
	
	
</head>

<body>

	<!-- toolbar -->
	<jsp:include page="/toolbar/toolbar.jsp"></jsp:include>
	
	

<div class="container">
    

    <div class="omb_login">
    	<h3 class="omb_authTitle">Login or <a href="#">Sign up</a></h3>
		<div class="row omb_row-sm-offset-3 omb_socialButtons">
    	   <!--  <div class="col-xs-4 col-sm-2"> -->
    	   <div class="col-xs-12 col-sm-6">
    	    
    	    <jsp:include page="/api/kakaoLogin.jsp"></jsp:include>
		       <!--  <a href="#" class="btn btn-lg btn-block omb_btn-facebook">
			        <i class="fa fa-facebook visible-xs"></i>
			        <span class="hidden-xs">Facebook</span>
		        </a> -->
	        </div>
        	
        	
		</div>

		<div class="row omb_row-sm-offset-3 omb_loginOr">
			<div class="col-xs-12 col-sm-6">
				<hr class="omb_hrOr">
				<span class="omb_spanOr">or</span>
			</div>
		</div>

		<div class="row omb_row-sm-offset-3">
			<div class="col-xs-12 col-sm-6">	
			    <form class="omb_loginForm" action="" autocomplete="off" method="POST">
					<div class="input-group">
						<span class="input-group-addon"><i class="fa fa-user"></i></span>
						<input type="text" class="form-control" name="username" placeholder="email address">
					</div>
					<span class="help-block"></span>
										
					<div class="input-group">
						<span class="input-group-addon"><i class="fa fa-lock"></i></span>
						<input  type="password" class="form-control" name="password" placeholder="Password">
					</div>
                    <span class="help-block">Password error</span>

					<button class="btn btn-lg btn-primary btn-block" type="submit">Login</button>
				</form>
			</div>
    	</div>
		<div class="row omb_row-sm-offset-3">
			<div class="col-xs-12 col-sm-3">
				<label class="checkbox">
					<input type="checkbox" value="remember-me">Remember Me
				</label>
			</div>
			<div class="col-xs-12 col-sm-3">
				<p class="omb_forgotPwd">
					<a href="#">Forgot password?</a>
				</p>
			</div>
		</div>	    	
	</div>



      </div>
	
</body>

</html>