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


	
	    
	    
	    
	
		
	
		
	
</head>

<style>
 body {
    padding-top: 70px;
    font-size: 15px
  }
  .main {
    max-width: 320px;
    margin: 0 auto;
  }
  .login-or {
    position: relative;
    font-size: 18px;
    color: #aaa;
    margin-top: 5px;
            margin-bottom: 5px;
    padding-top: 5px;
    padding-bottom: 5px;
  }
  .span-or {
    display: block;
    position: absolute;
    left: 50%;
    top: -2px;
    margin-left: -25px;
    background-color: #fff;
    width: 50px;
    text-align: center;
  }
  .hr-or {
    background-color: #cdcdcd;
    height: 1px;
    margin-top: 0px !important;
    margin-bottom: 0px !important;
  }
  h3 {
    text-align: center;
    line-height: 300%;
  }
  
</style>

<body>

	<!-- toolbar -->
	<jsp:include page="/toolbar/toolbar3456.jsp"></jsp:include>
	
	<div class="container">
  <div class="row">

    <div class="main">

      <h3>Please Log In, or <a href="#">Sign Up</a></h3>
      <div class="row">
        <div class="col-xs-6 col-sm-6 col-md-6">
      <jsp:include page="/api/kakaoLogin.jsp"/>  
        </div>
       <!--  <div class="col-xs-6 col-sm-6 col-md-6">
          <a href="#" class="btn btn-lg btn-info btn-block">Google</a>
        </div> -->
      </div>
      <div class="login-or">
        <hr class="hr-or">
        <span class="span-or">or</span>
      </div>

      <form role="form" id="loginForm">
        <div class="form-group">
          <label for="inputUsernameEmail">email</label>
          <input type="text" class="form-control" id="loginUserId" name="loginUserId" placeholder="Email address" required>
        </div>
        <div class="form-group">
          <a class="pull-right" href="/user/findUser" id="findUser"><b style="color:gray;">Forgot id or password?</b></a>
          <label for="inputPassword">Password</label>
          <input type="password" class="form-control" id="loginPassword" name="loginPassword" placeholder="Password" required>
        </div>
        
        
       <div class="form-group">
		<button type="submit" class="btn btn-primary btn-block" id="sign">Sign in</button>
		</div> 
        
        
        
        <div class="checkbox pull-right">
         <!--  <label>
            <input type="checkbox">
            Remember me </label> -->
         <b style="color:gray;">new here?</b> <a href="#"><b style="color:gray;">Join</b></a>
        </div>
        
     
      <!--   <button type="submit" class="btn btn btn-primary" id="sign">
          Sign In
        </button> -->
       
      
      
      </form>
    
    </div>
    
  </div>
</div>
	
</body>

</html>