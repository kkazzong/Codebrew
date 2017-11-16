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
   
	
	
	    <!-- Jquery DatePicker -->
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	
	<!--캘린더  -->
	<script type="text/javascript" src="/resources/javascript/calendar.js"></script>
	
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

	
	
	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/toolbar/toolbar.jsp" /><!--툴바 바디에 있던걸 올려봄  -->
   	<!-- ToolBar End /////////////////////////////////////-->

    
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">
	
		//============= "가입"  Event 연결 =============
		 $(function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$( "#addUser" ).on("click" , function() {
				fncAddUser();
			});
		});	
		
		
		//============= "취소"  Event 처리 및  연결 =============
		$(function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$("#cancel").on("click" , function() {
				$("addUserForm")[0].reset();
			});
		});	
		
		
		
		
		
		
		function fncAddUser() {
			
			var nickname=$("input[name='nickname']").val();
			var pw=$("#password").val();
			var pw_confirm=$("input[name='passwordCheck']").val();
			var name=$("input[name='userName']").val();
			
			
			if(nickname == null || nickname.length <1){
				alert("닉네임은 반드시 입력하셔야 합니다.");
				return;
			}
			if(pw == null || pw.length <1){
				alert("패스워드는  반드시 입력하셔야 합니다.");
				return;
			}
			if(pw_confirm == null || pw_confirm.length <1){
				alert("패스워드 확인은  반드시 입력하셔야 합니다.");
				return;
			}
			if(name == null || name.length <1){
				alert("이름은  반드시 입력하셔야 합니다.");
				return;
			}
			
			if( pw != pw_confirm ) {				
				alert("비밀번호 확인이 일치하지 않습니다.");
				$("input:text[name='passwordCheck']").focus();
				return;
			}
				
	       
			
			$("#addUserForm").attr("method" , "POST").attr("action" , "/user/addUser").submit();
		};
		
		
		
		/*  $(function() {
				//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
				$( "#gender" ).on("change", function() {
					
					$("#addUser").removeAttr("disabled");//가입버튼 활성화
						
				});
			});	
			 */
		

		
		
		//==>"이메일" 유효성Check  Event 처리 및 연결
	/* 	 $(function() {
			 
			 $("input[name='userId']").on("change" , function() {
				
				 var userId=$("input[name='userId']").val();
			    
				 if(userId != "" && (userId.indexOf('@') < 1 || userId.indexOf('.') == -1) ){
			    	alert("이메일 형식이 아닙니다.");
			     }
			});
			 
		 }); */
			 /* $( "input[name='birth']" ).datepicker(); */
			 
	/* 	});	 */
	
		
		function getAge(){
			
		    var bbirthday=$("input[name='birth']").val();
		
			var birthday=new Date(bbirthday);
			
			var today=new Date();
		
			var year=today.getFullYear()-birthday.getFullYear();
			
			age=Number(year)
			
			console.log(age)
			
			$("input[name='age']").val(age)
		};
	   
 
	    $( function() {
	       $("#datepicker").datepicker({
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
	
	   
	  
	   $( function() {
	        $( "input[name='birth']" ).datepicker(); 
			$.datepicker.setDefaults({
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
		           yearRange : "1900:2017"
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
	    
	    
	  //============= "사진 미리보기"  Event 처리 및  연결 =============
		function getUploadFilePrivew(html, $target) {
		    if (html.files && html.files[0]) {
		        var reader = new FileReader();
		        reader.onload = function (e) {
		            $target.css('display', '');
		            //$target.css('background-image', 'url(\"' + e.target.result + '\")'); // 배경으로 지정시
		            $target.html('<img src="' + e.target.result + '"width="30%" border="0" alt="" />');
		        	console.log("사진미리보기 출력=====> "+e.target.result);
		        }
		        reader.readAsDataURL(html.files[0]);
		    }
		}
	    
	    
	    
	    
	    
	    
	    
	    
		
	</script>
	
	
	
	
	
	
			
    
</head>

<body bgcolor="#ffffff" text="#000000">

<!--    @RenderBody()
   
   @Scripts.Render("~/bundles/jquery")
   
   @RenderSection("scripts", required: false) -->








	<!-- ToolBar Start /////////////////////////////////////-->
	<%-- <jsp:include page="/toolbar/toolbar.jsp" /> --%>
   	<!-- ToolBar End /////////////////////////////////////-->
  
   
	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container">
	
		<div class="row">
			<div class="col-md-offset-4 col-md-4">
				<div class="page-header text-center">
					<h3 class="text-info"><span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>회원가입</h3>
					
				</div>
			</div>
		</div>
		
		<!-- form Start /////////////////////////////////////-->
		<form name="detailForm" class="form-horizontal" id="addUserForm" enctype="multipart/form-data">
		
		  <div class="form-group">
		    <label for="userId" class="col-sm-offset-1 col-sm-3 control-label">아 이 디</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="userId" name="userId" value="${auth.authId}" readonly>  
		    </div>
		 </div>
		 
		 
		  
		  <div class="form-group">
		    <label for="password" class="col-sm-offset-1 col-sm-3 control-label">비밀번호</label>
		    <div class="col-sm-4">
		      <input type="password" class="form-control" id="password" name="password" placeholder="비밀번호">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="passwordCheck" class="col-sm-offset-1 col-sm-3 control-label">비밀번호 확인</label>
		    <div class="col-sm-4">
		      <input type="password" class="form-control" id="passwordCheck" name="passwordCheck" placeholder="비밀번호 확인">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="userName" class="col-sm-offset-1 col-sm-3 control-label">이름</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="userName" name="userName" placeholder="회원이름">
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
		    <label for="phone" class="col-sm-offset-1 col-sm-3 control-label">휴대전화번호</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="phone" name="phone" placeholder="휴대전화번호">
		    </div>
		  </div>
		  
		  
		    <div class="form-group text-center" id="previewImage">
            <img src="../../resources/uploadFile/${user.profileImage }" width="30%">
             <br>
           </div> 
		  
		  <div class="form-group">
		    <label for="uploadFile" class="col-sm-offset-1 col-sm-3 control-label">프로필사진</label>
		    <div class="col-sm-4">
		      <input type="file" class="form-control" id="uploadFile" name="uploadFile"onchange="getUploadFilePrivew(this,$('#previewImage'))" />
		    </div>
		  </div>
		  
	      <div class="form-group">
		    <label for="birth" class="col-sm-offset-1 col-sm-3 control-label">생년월일</label>
		    <div class="col-sm-4">
		    <input type="text" id="datepicker" class="form-control" readonly="readonly" name="birth" onchange="getAge();">
		    </div>
		  </div>
		  
		<!--     <div class="form-group">
		    <label for="birth" class="col-sm-offset-1 col-sm-3 control-label">생년월일</label>
		    <div class="col-sm-4">
		    <input type="text" id="datepicker" class="form-control"  readonly="readonly" name="birth" onchange="getAge();" >
		    <img src="/resources/image/buttonImage/ct_icon_date.gif" width="15" height="15" 
			onclick="show_calendar('document.detailForm.birth', document.detailForm.birth.value)"/>
		    
		    </div>
		  </div>  -->
		  
		  
		
		
		  
	<div class="form-group">
     <label for="gender" class="col-sm-offset-1 col-sm-3 control-label">성별</label>
	   <span class="col-sm-2">
         <label><input type="radio" id="gender" name="gender" value="m">남자</label>
       </span>
      <span class="col-sm-2">
         <label><input type="radio" id="gender" name="gender" value="f">여자</label>
        </span>
	</div>
	
	<!--   <input type="hidden" name="age"> -->
	
	  

	
		 
		  <div class="form-group">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		      <button id= "addUser" type="button" class="btn btn-primary btn-block">가 &nbsp;입</button>
			  <!-- <a class="btn btn-primary btn" href="#" role="button">취&nbsp;소</a>  나중에  disabled="disabled" 연구-->
		    <button id= "cancel" type="button" class="btn btn-primary btn-block">취&nbsp;소</button>
		    </div>
		  </div>
		</form>
		<!-- form Start /////////////////////////////////////-->
		
 	</div>
	<!--  화면구성 div end /////////////////////////////////////-->
	
</body>

</html>