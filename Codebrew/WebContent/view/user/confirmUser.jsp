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
	
	
		<!--datePicker-->
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
   
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
		
	
    <!-- Jquery DatePicker -->
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	


<style type="text/css">
	body {
		padding-top : 70px;
    }
    .btn {
		/*링크 클릭시 파란색 안남도록 */
		text-decoration : none;
		border : 0;
		outline : 0;
	}
 
	.glyphicon {
		font-size: 20px;
	}
	form > img {
		width : 100%;
		height : 300px
	}
	
	
	


</style>
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
<!-- 	<style>
       body > div.container{
        	border: 3px solid #D6CDB7;
            margin-top: 10px;
        }
    </style> 테두리선-->
    
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">
	

		//============= "취소"  Event 처리 및  연결 =============
		$(function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$("a[href='#' ]").on("click" , function() {
				$("form")[0].reset();
			});
		});	

		
		
		
	
	
	 $(function(){
		$(".btn:contains('확인')").on("click", function(){
			
		 //var authId=$("input[name='authId']").val();
		 //self.location = "/user/addUser";
		//self.location = "/user/addUser?authId="+authId;//@@@@@@@@@@@@
	    $("form").attr("method","POST").attr("action","/user/confirmUser").submit();
		}) 	
		
	});
		
	var authCode = ""; //인증번호 전역변수.. 전역변수를 지정하면 메소드 안을 실행하고 나서 바뀐 값으로 또 쓸수 있다.
	
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
			
			dataType:"json",
			success: function(JSONData,status){
				alert("인증번호를 전송했습니다.");
				console.log(JSON.stringify(JSONData));//받는정보
				
				var authCode = JSONData.authCode;
				 if(authCode != JSONData.authCode){
					$("span.col-id-checkAuthCode").html("인증번호를 다시 확인해주세요").css("color","red");
					event.preventDefault();
					return;
				}else{
					/* $("span.col-id-checkAuthCode").remove(); */
					$("span.col-id-checkAuthCode").html("인증번호가 일치합니다.").css("color","blue");
				} 
				//{"authId":"skale83@naver.com","authCode":"c067bf517dcf47aab5fff3cc3d22f79e"}
			//콘솔에 이렇게 옴
			
			}
				
			})
			
		})
			
		});
		 
   
     $(function(){
    	 $(".btn:contains('확인')").on("click", function(event){
    		 
    		 var authId=$("input[name='authId']").val();
    		 var authCodeUser=$("input[name='authCode']").val();
    		 
    		 
    		 if(authCode != authCodeUser){
					$("span.col-id-checkAuthCode").html("인증번호를 다시 확인해주세요").css("color","red");
					event.preventDefault();
					return;
				}else{
					$("span.col-id-checkAuthCode").remove();
					$("form").attr("method","POST").attr("action","/user/confirmUser").submit();
				}
    		
    		 
    		 
 	 });
     }); 
     /* if(authCode != JSONData.authCode){
			$("span.col-id-checkAuthCode").html("인증번호를 다시 확인해주세요").css("color","red");
		}else{
			$("span.col-id-checkAuthCode").remove();
		}
	 */
	 
		 //이미 가입된 아디로 본인인증을 하려고 할 경우 ajax
	/*    $(function(){
			
			$("input:text[name='authId']").on("keyup",function(){
				var userId=$("input[name='authId']").val();
				/* alert("userId : "+userId); */
				/* $.ajax({
					type:"POST",
					url:"/userRest/json/checkUserId/"+userId,//만약 이런식으로 데이터를 보내면 data:를 안써줘도 됨
					//pathVariable과 GET POST 방식은 상관이 없다.
					  headers : {
						"Accept" : "application/json;charset=UTF-8", ///utf 설정 빼도 에러
						"Content-Type" : "application/json"
					}, */ 
					/* data :JSON.stringify({ //이런식으로 쓰면 제이슨으로 간다 그래서 headers 설정이랑 매치해줘야함
						userId : userId	
					}), ///{userId:userId} 이런식으로 쓰면 스트링 타입으로 가고
					dataType:"json",//서버에서 받는 데이터형식
				    success: function(JSONData,status){
				    	console.log(status);
				    	console.log(JSON.stringify(JSONData)); //json string 형식으로 변환해주는거 */
	/* 			    	
			    	  if(JSONData == false){
				    		$("span.col-id-check").html("이미 가입된 아이디입니다.").css("color","blue");
			    	  } //.MissingServletRequestParameterException
				    }	
				});		
			});					
		});   */
		 
		  
		 //이미 가입된 아디로 본인인증을 하려고 할 경우 ajax
		  $(function(){
				
				$("input:text[name='authId']").on("keyup",function(){
					var userId=$("input[name='authId']").val();
					
					$.ajax({
						type:"POST",
						url:"/userRest/json/checkUserId", 
						data :{userId:userId},//요청과 함께 서버에 보내는 string 또는 map
						dataType:"json",//서버에서 받는 데이터형식
					    success: function(JSONData,status){
					    	console.log(status);
					    	console.log(JSON.stringify(JSONData)); //json string 형식으로 변환해주는거
					    	
					    	
				    	   if(JSONData == true){
				    		  $(".col-id-check").text("사용가능 아이디입니다.").css("color","blue");
				    	  }else{
				    		   /* $(".col-id-check").remove(); */
				    		   
					    		$(".col-id-check").text("이미 가입된 아이디입니다.").css("color","red");
				    	  }
					    }
					});		
				});						
		 }); 

	</script>		
    
</head>

<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/toolbar/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->

		<div class="container">
	
		<div class="row">
			<div class="col-md-offset-4 col-md-4">
				<div class="page-header text-center">
					<h3 class="text-info"><span class="glyphicon glyphicon-envelope" aria-hidden="true"></span>본인인증</h3>
				     <small class="text-muted">본인명의의 이메일로 인증번호를 받은 후 가입할 수 있습니.</small>
				</div>
			</div>
		</div>
	    
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
		  
		  <span class="col-id-checkAuthCode"></span>
		  
		  <span class="col-id-check"></span>
		
		</form>
		
	
		<!-- form End /////////////////////////////////////-->
		
 	</div>
 	
	<!--  화면구성 div end /////////////////////////////////////-->
</body>
</html>
	      
