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


    
    <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">
	


	
	

		//============= "로그인"  Event 연결 ================================
		$( function() {
			
			$("#userId").focus();
			
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$("#login").on("click" , function() {
				var userId=$("#userId").val();
				var password=$("#password").val();
				
			
				
				if(userId == null || userId.length <1) {
					alert('ID 를 입력하지 않으셨습니다.');
					$("#userId").focus();
					return;
				}
				
				if(password == null || password.length <1) {
					alert('패스워드를 입력하지 않으셨습니다.');
					$("#password").focus();
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
				    	
				    	var pw=JSONData.password;
				
				    if(pw != password){
				     /* $("span.col-id-checkPassword").html("비밀번호가 틀렸습니다.").css("color","blue"); */
				     alert("비밀번호가 틀렸습니다.")
				     event.preventDefault();
				     return;
				    } else{
			         //$("span.col-id-checkPassword").remove();
				    	$("form").attr("method","POST").attr("action","/user/login").submit();
				      }
				    }
				    
			});
				
				//$("form").attr("method","POST").attr("action","/user/login").submit();
				
			});
		});	
	   
	 
	    
	    
	    
	    
	
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
	
	<style>
		body {
			padding-top : 70px;
    	}
       
       .form-signin
{
    max-width: 330px;
    padding: 15px;
    margin: 0 auto;
}



.form-signin .form-signin-heading, .form-signin .checkbox 
{
    margin-bottom: 10px;
}
.form-signin .checkbox 
{
    font-weight: normal;
}
.form-signin .form-control 
{
    position: relative;
    font-size: 16px;
    height: auto;
    padding: 10px;
    -webkit-box-sizing: border-box;
    -moz-box-sizing: border-box;
    box-sizing: border-box;
}
.form-signin .form-control:focus 
{
    z-index: 2;
}
.form-signin input[type="text"]
{
    margin-bottom: -1px;
    border-bottom-left-radius: 0;
    border-bottom-right-radius: 0;
}
.form-signin input[type="password"]
{
    margin-bottom: 10px;
    border-top-left-radius: 0;
    border-top-right-radius: 0;
}
.account-wall
{
    margin-top: 20px;
    padding: 40px 0px 20px 0px;
    background-color: #f7f7f7;
    -moz-box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.3);
    -webkit-box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.3);
    box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.3);
}
.login-title
{
    color: #555;
    font-size: 18px;
    font-weight: 400;
    display: block;
}
.profile-img
{
    width: 96px;
    height: 96px;
    margin: 0 auto 10px;
    display: block;
    -moz-border-radius: 50%;
    -webkit-border-radius: 50%;
    border-radius: 50%;
}
.need-help
{
    margin-top: 10px;
}
.new-account
{
    display: block;
    margin-top: 10px;
}
       
       
    </style>
	
	
	
	
	
	
</head>

<body>

	<!-- toolbar -->
	<jsp:include page="/toolbar/toolbar.jsp"></jsp:include>
	
	<div class="container">
    <div class="row">
        <div class="col-sm-6 col-md-4 col-md-offset-4">
            <h1 class="text-center login-title">Sign in to continue to Bootsnipp</h1>
            <div class="account-wall">
                <img class="profile-img" src="https://lh5.googleusercontent.com/-b0-k99FZlyE/AAAAAAAAAAI/AAAAAAAAAAA/eu7opA4byxI/photo.jpg?sz=120"
                    alt="">
                <form class="form-signin">
                <input type="text" class="form-control" placeholder="Email" required autofocus>
                <input type="password" class="form-control" placeholder="Password" required>
                <button class="btn btn-lg btn-primary btn-block" type="submit">
                    Sign in</button>
                    
         
                  <jsp:include page="/api/kakaoLogin.jsp"> </jsp:include>  
                    
                    
                <label class="checkbox pull-left">
                    <input type="checkbox" value="remember-me">
                    Remember me
                </label>
                <a href="#" class="pull-right need-help">Need help? </a><span class="clearfix"></span>
                </form>
            </div>
            <a href="#" class="text-center new-account">Create an account </a>
        </div>
    </div>
</div>
	
</body>

</html>