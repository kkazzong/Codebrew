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
	
		
		
		
/* 
		//==>"이메일" 유효성Check  Event 처리 및 연결??????
		 $(function() {
			 
			 $("input[name='userId']").on("change" , function() {
				
				 var userId=$("input[name='userId']").val();
			    
				 if(userId != "" && (userId.indexOf('@') < 1 || userId.indexOf('.') == -1) ){
			    	alert("이메일 형식이 아닙니다.");
			     }
			});
			 
		});	
		 */
	
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
		
		
		
		
	//비밀번호 찾기 event 연결
	
	$(function(){
		$(".btn:contains('비밀번호찾기')").on("click", function(){
			
			$("#findPwd").attr("method","POST").attr("action","/user/findPwd").submit();
		})
		
		
		
		
	});
	
	
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
						phone: phone
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
				    	if(JSONData.userId == null) {
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
		
		
		

	</script>		
    
</head>

<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	
   	<!-- ToolBar End /////////////////////////////////////-->

<!-- </hr>흰줄이구나...-->
		
		<!-- form Start /////////////////////////////////////-->
	
		<div class="container">
		
		<h1 class="bg-primary text-center">아이디찾기 비밀번호 찾기</h1>
		
		<!-- form Start /////////////////////////////////////-->
		


		<form class="form-horizontal">
		
		  <div class="form-group">
		    <label for="userName" class="col-sm-offset-1 col-sm-3 control-label">이름</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="userName" name="userName" placeholder="이름을쓰세요">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="phone" class="col-sm-offset-1 col-sm-3 control-label">휴대폰번호</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="phone" name="phone" placeholder="휴대폰번호를  입력해주세요">
		    </div>
		    
		  </div><!-- </div>로 닫아줘야 다음행이 됨 -->
		  
		    <div class="form-group">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		      <button type="button" class="btn btn-primary"  >아이디찾기</button>
		  </div>
		  </div>
		  
		  <span class="col-id-check"></span>
		  
	
		  	</form>
		  
		  	
		  	<form class="form-horizontal" id="findPwd" name="findPwd" >
		  
		   <div class="form-group">
		    <label for="userName" class="col-sm-offset-1 col-sm-3 control-label">이름</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="userName" name="userName" placeholder="이름을 입력해주세요">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="userId" class="col-sm-offset-1 col-sm-3 control-label">아이디</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="userId" name="userId" placeholder="이메일주소로 입력해주세요">
			</div>
		  </div>
		  		  	  
		   
		  <div class="form-group">
		    <label for="phone" class="col-sm-offset-1 col-sm-3 control-label">휴대폰번호</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="phone" name="phone" placeholder="휴대폰번호를 입력해주세요">
		    </div>
		  </div>
		 		  
		  <div class="form-group">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		      <button type="button" class="btn btn-primary"  >비밀번호찾기</button>
			 
		  </div>
		  
		  <span class="col-password-check"></span>
		</form>
		
		
		<!-- form End /////////////////////////////////////-->
		
 	</div>
	<!--  화면구성 div end /////////////////////////////////////-->
</body>
</html>








