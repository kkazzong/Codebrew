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
	
	<!-- Bootstrap Dropdown Hover CSS -->
   <link href="/css/animate.min.css" rel="stylesheet">
   <link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
   
    <!-- Bootstrap Dropdown Hover JS -->
   <script src="/javascript/bootstrap-dropdownhover.min.js"></script>
   
	<!--  ///////////////////////// CSS ////////////////////////// -->
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
   
	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/toolbar/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
    
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">
	
		//============= "수정"  Event 연결 =============
		 $(function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$( "button.btn.btn-primary" ).on("click" , function() {
				fncUpdateUser();
			});
		});	
		
		
		//============= "취소"  Event 처리 및  연결 =============
		$(function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$("a[href='#' ]").on("click" , function() {
				
				
					
				self.location = "/user/withdrawUser?userId=${sessionScope.user.userId}";
				
				//$("form")[0].reset();
				//history.go(-1);
			});
		});	
		
		
		
			 
		
		//=============이메일" 유효성Check  Event 처리 =============
		 $(function() {
			 
			 $("input[name='email']").on("change" , function() {
					
				 var email=$("input[name='email']").val();
			    
				 if(email != "" && (email.indexOf('@') < 1 || email.indexOf('.') == -1) ){
			    	alert("이메일 형식이 아닙니다.");
			     }
			});
			 
		});	
		
		///////////////////////////////////////////////////////////////////////
		function fncUpdateUser() {
			var pw=$("input[name='password']").val();
			var pw_confirm=$("input[name='passwordCheck']").val();
			
			if(pw == null || pw.length <1){
				alert("패스워드는  반드시 입력하셔야 합니다.");
				return;
			}
			
			if(pw_confirm == null || pw_confirm.length <1){
				alert("패스워드 확인은  반드시 입력하셔야 합니다.");
				return;
			}
				
			
			if( pw != pw_confirm ) {				
				alert("비밀번호 확인이 일치하지 않습니다.");
				$("input:text[name='passwordCheck']").focus();
				return;
			}
		
				
			$("form").attr("method" , "POST").attr("action" , "/user/updateUser").submit();
		}
	
		
		//ajax 닉네임 중복확인
		$(function(){
			
			$("input:text[name='nickname']").on("keyup",function(){
				var nickname=$(this).val();//getNickname
				
				$.ajax({
					type:'POST',
				    url: '/userRest/json/checkNickname',
				    data:{nickname:nickname},//보내는 정보
				    dataType:"json",
				    success:function(JSONData,status){
				    	console.log(status);
				    	console.log("JSONData:"+JSONData);
				    	
				    	if(JSONData==true){
				    		$("span.col-id-check").html("사용가능한 닉네임입니다.").css("color","blue");
				    		
				    	}else{
				    		
				    		$("span.col-id-check").html("존재하는 닉네임입니다.").css("color","red");
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
	
	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container">
	
		<div class="row">
			<div class="col-md-offset-4 col-md-4">
				<div class="page-header text-center">
					<h3 class="text-info"><span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>회원정보수정</h3>
					<small class="text-muted">내정보를<strong class="text-danger">최신정보로 관리</strong>해주세요 </small>
				</div>
			</div>
		</div>
	       
	   
	    
	    <!-- form Start /////////////////////////////////////-->
		<form class="form-horizontal">
		
		  <div class="form-group">
		    <label for="userId" class="col-sm-offset-1 col-sm-3 control-label">아 이 디</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="userId" name="userId" value="${user.userId }" placeholder="중복확인하세요"  readonly>
		       <span id="helpBlock" class="help-block">
		      	<strong class="text-danger">아이디는 수정불가</strong>
		      </span>
		    </div>
		  </div>
		
		  <div class="form-group">
		    <label for="password" class="col-sm-offset-1 col-sm-3 control-label">비밀번호</label>
		    <div class="col-sm-4">
		      <input type="password" class="form-control" id="password" name="password" placeholder="변경비밀번호">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="passwordCheck" class="col-sm-offset-1 col-sm-3 control-label">비밀번호 확인</label>
		    <div class="col-sm-4">
		      <input type="password" class="form-control" id="passwordCheck" name="passwordCheck" placeholder="변경비밀번호 확인">
		    </div>
		  </div>
		  <input type="hidden" name="coconutCount" value="${user.coconutCount}">
		   <input type="hidden" name="role" value="${user.role}">
		    <input type="hidden" name="age" value="${user.age}">
		     <input type="hidden" name="regDate" value="${user.regDate}">
		      <input type="hidden" name="locationFlag" value="${user.locationFlag}">
		   
		  
		  <div class="form-group">
		    <label for="nickname" class="col-sm-offset-1 col-sm-3 control-label">닉네임</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="nickname" name="nickname" value="${user.nickname}" placeholder="변경회원이름">
		    </div>
		  </div>
		  
		  
		   <div class="form-group">
		    <label for="userName" class="col-sm-offset-1 col-sm-3 control-label">이름</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="userName" name="userName" value="${user.userName}" placeholder="변경회원이름" readOnly>
		       <span id="helpBlock" class="help-block">
		      <strong class="text-danger">이름은 수정불가</strong>
		      </span>
		   
		    </div>
		  </div>
		  
		  		  
	<div class="form-group">
    <label for="gender" class="col-sm-offset-1 col-sm-3 control-label">성별</label>
	 <span class="col-sm-2">
    <label>
      <input type="radio" id="gender" name="gender" value="m" readOnly>남자
    </label>
    </span>
    <span class="col-sm-2">
    <label>
      <input type="radio" id="gender" name="gender" value="f" readOnly >여자
    </label>
    
  </span>
	</div>
	
		  
		  <div class="form-group">
		    <label for="profileImage" class="col-sm-offset-1 col-sm-3 control-label">프로필사진</label>
		    <div class="col-sm-4">
		      <input type="file" class="form-control" id="profileImage" name="profileImage"  value="${user.profileImage}"  placeholder="사진을 올려주세요" >
		    </div>
		  </div>
		  
		 
		   <div class="form-group">
		    <label for="age" class="col-sm-offset-1 col-sm-3 control-label">나이</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="age" name="age" value="${user.age}" placeholder="${user.age}" readonly>
		       <span id="helpBlock" class="help-block">
		      <strong class="text-danger">나이는 수정불가</strong>
		      </span>
		      
		    </div>
		  </div>
		  
		     <div class="form-group">
		    <label for="phone" class="col-sm-offset-1 col-sm-3 control-label">휴대폰번호</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="phone" name="phone" value="${user.phone}" placeholder="${user.phone}">
		    </div>
		  </div>
		  
		  
		  
		  
		  <div class="form-group">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		      <button type="button" class="btn btn-primary"  >수 &nbsp;정</button>
			  <a class="btn btn-primary btn" href="#" role="button">탈&nbsp;퇴</a>
		    </div>
		  </div>
		</form>
		<!-- form Start /////////////////////////////////////-->
	    
 	</div>
	<!--  화면구성 div Start /////////////////////////////////////-->
 	
</body>

</html>