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
	
	


<style type="text/css">
	body {
       padding-top : 50px;
    }
</style>
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
       body > div.container{
        	border: 3px solid #D6CDB7;
            margin-top: 10px;
        }
    </style>
    
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">
	
		//============= "가입"  Event 연결 =============
	/* 	 $(function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			 $( "button.btn.btn-primary" ).on("click" , function() {
				$("form").attr("method" , "POST").attr("action" , "/user/findPwd").submit(); 
			});
		});	 
		
		*/
		//============= "취소"  Event 처리 및  연결 =============
		$(function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$("a[href='#' ]").on("click" , function() {
				$("form")[0].reset();
			});
		});	
	
		
		
		

		//==>"이메일" 유효성Check  Event 처리 및 연결??????
		 $(function() {
			 
			 $("input[name='authId']").on("change" , function() {//change 이벤트는 요소의 값들이 변경될때 이벤트 발생 , 예를 들면 input text가 변화하면  감지함
				
				 var authId=$("input[name='authId']").val();
			    
				 if(authId != "" && (authId.indexOf('@') < 1 || authId.indexOf('.') == -1) ){
			    	alert("이메일 형식이 아닙니다.");
			     }
			});
			 
		});	
	
	
	/* 	 
		//==>"ID중복확인" Event 처리 및 연결
		 $(function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			 $("btn.btn-primary").on("click" , function() {
				popWin 
				= window.open("/user/checkDuplication.jsp",
											"popWin", 
											"left=300,top=200,width=780,height=130,marginwidth=0,marginheight=0,"+
											"scrollbars=no,scrolling=no,menubar=no,resizable=no");
			});
		});	 */
		
		
		
		
	
	
	 $(function(){
		$(".btn:contains('확인')").on("click", function(){
			
		 //var authId=$("input[name='authId']").val();
		 //self.location = "/user/addUser";
		//self.location = "/user/addUser?authId="+authId;//@@@@@@@@@@@@
	    $("form").attr("method","POST").attr("action","/user/confirmUser").submit();
		}) 
		
		
		
		
	});
		
		
		 $(function(){
			
		$(".btn:contains('인증하기')")	.on("click", function(){
			
			var authId=$("input[name='authId']").val();
			//var authCode=$("input[name='auchCode']").val();
			
			alert(authId);
			
			$.ajax({
				type:"POST",
				url:"/userRest/json/confirmUser",
				headers: {
					"Accept":"application/json;charset=UTF-8",
					"Content-Type" : "application/json"
				},
			
			data : JSON.stringify({
				authId : authId,//보내는 정보
				//authCode : authCode
				
			}),
			
			dataTpe:"json",
			success: function(JSONData,status){
				alert("인증번호를 전송했습니다.");
				console.log(JSON.stringify(JSONData));//받는정보
				//{"authId":"skale83@naver.com","authCode":"c067bf517dcf47aab5fff3cc3d22f79e"}
			//콘솔에 이렇게 옴
			
			}
				
			})
			
		})
			
		});
		 
		
	/*
	
		 //존재하지도 않은 아이디 찾을려고 할때 알려주는 ajax
	    $(function(){
			
			$(".btn:contains('아이디찾기')").on("click",function(){
				
				var userName=$("input[name='userName']").val();
				var phone=$("input[name='phone']").val();
				alert(userName+","+phone);
				
				$.ajax({
					
					type:"POST",
					url:"/userRest/json/findUserId",
					headers : {
						"Accept" : "application/json;charset=UTF-8",
						"Content-Type" : "application/json"//바디
					}, 
					data : JSON.stringify({
						userName : userName, /* name: $("#name").val() */
						/*phone: phone
					}),//보낼정보
					dataType:"json",//서버에서 받는 데이터형식
				    success: function(JSONData,status){
				    	alert(status); //성공하면 success
				    	console.log(JSON.stringify(JSONData)); //json string 형식으로 변환해주는거
				    	//console.log(JSONData); //[Object objecㅅ]
			    	/* if(JSONData == null){
				    		$("span.col-id-check").html("존재하는 아이디가 없습니다").css("color","blue");
				    	}else{
				    		$("span.col-id-check").html("고객님의 아이디는"+JSONData+"입니다").css("color","red");
				    		
				    	} */
				    	//JSONData로 오는건 map으로 오기때문에  userId만 따로 뺌
				    	/*if(JSONData.userId == null) {
				    		alert("존재하는 아이디 없음");
				    		$("span.col-id-check").html("존재하는 아이디가 없습니다").css("color","red");
				    	} else {
				    		alert("아디 존재함");
				    		$("span.col-id-check").html("회원님의 아이디는"+JSONData.userId+"입니다").css("color","blue");
				    	}
				    	
				    }
					
				});
						
				
			});
				
		
		});
		
		*/
		

	</script>		
    
</head>

<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	
   	<!-- ToolBar End /////////////////////////////////////-->

<!-- </hr>흰줄이구나...-->
		
		<!-- form Start /////////////////////////////////////-->
	
		<div class="container">
		
		<h1 class="bg-primary text-center">본인인증</h1>
		
		<!-- form Start /////////////////////////////////////-->
		


		<form class="form-horizontal" >
		
		  <div class="form-group">
		    <label for="authId" class="col-sm-offset-1 col-sm-3 control-label">이메일주소</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="authId" name="authId" placeholder="이메일주소를 입력해주세요">
		    </div>
		
		  </div>
		  
		    <div class="form-group">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		      <button type="button" class="btn btn-primary"  >인증하기</button>
		  </div>
		</div>
		  
		  <span class="col-id-check"></span>
		  
	  
		  	
		  
		  	

		  
		   <div class="form-group">
		    <label for="authCode" class="col-sm-offset-1 col-sm-3 control-label">인증번호</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="authCode" name="authCode" placeholder="인증번호">
		    </div>
		</div>
		  
		 
		  		  
		 		  
		  <div class="form-group">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		      <button type="button" class="btn btn-primary">확인</button>
			 
		  </div>
		  
		  </div>
		  
		  
		
		</form>
		
	
		<!-- form End /////////////////////////////////////-->
		
 	</div>
 	
	<!--  화면구성 div end /////////////////////////////////////-->
</body>
</html>
	      
