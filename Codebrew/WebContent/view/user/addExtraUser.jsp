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
	
	
	
	<!-- Bootstrap Dropdown Hover CSS -->
   <link href="/css/animate.min.css" rel="stylesheet">
   <link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
   
    <!-- Bootstrap Dropdown Hover JS -->
   <script src="/javascript/bootstrap-dropdownhover.min.js"></script>
   <style type="text/css">
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
			$( "button.btn.btn-primary" ).on("click" , function() {
				fncAddExtraUser();
			});
		});	
		
		
		
		///////////////////////////////////////////////////////////////////////
		function fncAddExtraUser() {
			var nickname=$("input[name='nickname']").val();
			var phone=$("input[name='phone']").val();
			var birth=$("input[name='birth']").val();
			var gender=$("input[name='gender']").val();
			
			if(nickname == null || nickname.length <1){
				alert("닉네임은  반드시 입력하셔야 합니다.");
				return;
			}
				
			if(phone == null || phone.length <1){
				alert("핸드폰 번호는 반드시 입력하셔야 합니다.");
				return;
			}
		
			if(birth == null || birth.length <1){
				alert("생년월일은 반드시 입력하셔야 합니다.");
				return;
			}
			
			if(gender == null || gender.length <1){
				alert("생별을 반드시 선택하셔야 합니다.");
				return;
			}
				
			$("form").attr("method" , "POST").attr("action" , "/user/addExtraUser").submit();
		}
	
		
		
		
		  $( function() {
		       $( "#datepicker" ).datepicker({
		    	   changeMonth: true, 
		           changeYear: true,
			       dateFormat: 'yy-mm-dd',
			       monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
			       monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
			       dayNames: ['일', '월', '화', '수', '목', '금', '토'],
			       dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
			       dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
			       showMonthAfterYear: true,
			       yearSuffix: '년',
			       changeMonth: true,
			       changeYear : true,
			       buttonImageOnly: true,
			       buttonText: "Select date",
			       showOn: "button",
			       buttonImage: "/resources/image/ui/small_cal.jpg",
			       yearRange : "1970:2017"
		       });   
		    });
			
			
			
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
					<h3 class="text-info"><span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>추가정보</h3>
				     <small class="text-muted">추가정보를  등록해주세요</small>
				</div>
			</div>
		</div>
	    
	    <!-- form Start /////////////////////////////////////-->
		<form class="form-horizontal">
		
		 <div class="form-group">
		    <label for="userId" class="col-sm-offset-1 col-sm-3 control-label">아이디</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="userId" name="userId" value="${user.userId}">     
		    </div>
		  </div>
		<!--userId(pk)가 없으면 addUser도 getUser를 못하니깐 히든으로 넣든 input으로 넣든 userId를 넣어야 함!! -->
		
		
		  <div class="form-group">
		    <label for="userName" class="col-sm-offset-1 col-sm-3 control-label">이름</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="userName" name="userName" value="${user.userName}">   
		    </div>
		  </div>
		
		  <div class="form-group">
		    <label for="nickname" class="col-sm-offset-1 col-sm-3 control-label">닉네임</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="nickname" name="nickname" placeholder="닉네임">
		    </div>
		    <span class="col-id-check"></span>
		  </div>
		  
		   	  
		<div class="form-group">
     		<label for="gender" class="col-sm-offset-1 col-sm-3 control-label">성별</label>
	   			<span class="col-sm-2">
           			<label><input type="radio" id="gender" name="gender" value="m">남자</label>
      			 </span>
     			 <span class="col-sm-2">
         			<label><input type="radio" id="gender" name="gender" value="f">여자</label>
       			</span><!--class="form-control"를 빼주면 버튼이 적당해짐   -->
		</div>
		  
		  
		  <div class="form-group">
		    <label for="phone" class="col-sm-offset-1 col-sm-3 control-label">핸드폰 번호</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="phone" name="phone" placeholder="핸드폰 번호">
		    </div>
		  </div>
		  
		    <div class="form-group">
		    <label for="birth" class="col-sm-offset-1 col-sm-3 control-label">생년월일</label>
		    <div class="col-sm-4">
		    <input type="text" id="datepicker" class="form-control" readonly="readonly" name="birth" >
		    </div>
		  </div>
		  
		 
		  
		  
		    <div class="form-group">
		    <label for="profileImage" class="col-sm-offset-1 col-sm-3 control-label">프로필사진</label>
		    <div class="col-sm-4">
		      <input type="file" class="form-control" id="profileImage" name="profileImage"  value="${user.profileImage}"  placeholder="사진을 올려주세요" >
		    </div>
		  </div>
		  
		  
		    <input type="hidden" name="password" value="${user.password}"><!--name=value 제대로 써주자  -->
		     <input type="hidden" name="coconutCount" value="${user.coconutCount}">
		      <input type="hidden" name="locationFlag" value="${user.locationFlag}">
		        <input type="hidden" name="age" value="${user.age}">
		  
		 
		  
		  
		  
		  <div class="form-group">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		      <button type="button" class="btn btn-primary"  >등 &nbsp;록</button>
			  
		    </div>
		  </div>
		</form>
		<!-- form Start /////////////////////////////////////-->
	    
 	</div>
	<!--  화면구성 div Start /////////////////////////////////////-->
 	
</body>

</html>