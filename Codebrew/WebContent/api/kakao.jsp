<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
 	<title>카카오톡 로그인</title>
	<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width" />
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
   	<script type="text/javascript">
	
	Kakao.init('9f9b09052da56dddc3bc66e8a1632a69');
	function loginWithKakao() {
	//로그인 창을 띄웁니다.
		Kakao.Auth.login({
	 		success: function(authObj) {
	   			/* alert("dddddddd :: "+JSON.stringify(authObj)); */
	   			var accessToken = Kakao.Auth.getAccessToken();
	    		Kakao.Auth.setAccessToken(accessToken);
	    		
	    	    
	 	
	    		
	    		Kakao.API.request({
	    			url: '/v1/user/me',
	       			success: function(res) {
		        		console.log("ressssss :: " + res);
		           	    var Id= res.id;  
                        var nickName=res.properties.nickname;
                        var userId=res.kaccount_email;
                        var image=res.properties.profile_image;
		           	var tempId = userId.replace(".", ","); 
		           		console.log("userId :: " + Id);
		           		console.log("nickName :: " + nickName);
		           		console.log("email :: " + userId);
		           		console.log("image :: "+ image);
 		
		           /* $("#image").append($("<img/>",{"src":+image})); */  
		           		
		           	/* 	console.log("tempId :: " + tempId); */
		          	/* $.ajax(
		            		{
		                   		url : "/user/checkUserId/"+userId,
		                      	method : "GET",
		                      	dataType : "json",
		                      	headers : {
		                       		"Accept" : "application/json",
		                       		"Content-Type" : "application/json"
		                      	},
		                      	success : function(JSONData, status) {     
		                       		if(JSONData.user ==null ) {
		                       			alert("계정이 없습니다. 회원가입을 해주시기 바랍니다.");
		                       			self.location="/view/user/addUserView.jsp?userId="+userId;                 
		                         	}else if(JSONData.user.role == 4){
		                       			alert("탈퇴한 계정입니다.");  
		                       			$(self.location).attr("href","/user/logout");
		
		                       	  		location.reload();
		                         	}else{
		                       	  		location.reload();
		                         	}
		                      	}
		                });  */
	       			}
	    		
	      		}); 
		  	},
		   	fail: function(err) {
		   		alert(JSON.stringify(err));
		   	}
		  	
	  	});
	
	}
	 function kakaoLogout(){
	  $("#kakao-logout-btn").click(function(){
	Kakao.Auth.logout( function(res){
		
		if(res){
			$("#profile").html("logout")
		}
	});
		
	});
	} 
	
	 https://accounts.kakao.com/login?continue=https%3A%2F%2Fkauth.kakao.com%2Foauth%2Fauthorize%3Fredirect_uri%3Dkakaojs%26response_type%3Dcode%26state%3Dy68aordrj4n%26client_id%3D8a0eb548cc8e4502f32642ba5c48cb47
	
	  /*    // 사용할 앱의 JavaScript 키를 설정해 주세요.
	     Kakao.init('8a0eb548cc8e4502f32642ba5c48cb47');
	     // 카카오 로그인 버튼을 생성합니다.
	     Kakao.Auth.createLoginButton({
	       container: '#kakao-login-btn',
	       success: function(authObj) {
	         alert(JSON.stringify(authObj));
	       },
	       fail: function(err) {
	          alert(JSON.stringify(err));
	       }
	     });
	
	 
	 
	  */
		/* $(document).ready(function() {
			Kakao.init("9f9b09052da56dddc3bc66e8a1632a69");
			function getKakaotalkUserProfile(){
				Kakao.API.request({
					url: '/v1/user/me',
					success: function(res) {
						$("#kakao-profile").append(res.properties.nickname);
						$("#kakao-profile").append($("<img/>",{"src":res.properties.profile_image,"alt":res.properties.nickname+"���� ��濡��� �ъ�"}));
					},
					fail: function(error) {
						console.log(error);
					}
				});
			}
			function createKakaotalkLogin(){
				$("#kakao-logged-group .kakao-logout-btn,#kakao-logged-group .kakao-login-btn").remove();
				var loginBtn = $("<a/>",{"class":"kakao-login-btn","text":"濡�洹몄��"});
				loginBtn.click(function(){
					Kakao.Auth.login({
						persistAccessToken: true,
						persistRefreshToken: true,
						success: function(authObj) {
							getKakaotalkUserProfile();
							createKakaotalkLogout();
						},
						fail: function(err) {
							console.log(err);
						}
					});
				});
				$("#kakao-logged-group").prepend(loginBtn)
			}
			function createKakaotalkLogout(){
				$("#kakao-logged-group .kakao-logout-btn,#kakao-logged-group .kakao-login-btn").remove();
				var logoutBtn = $("<a/>",{"class":"kakao-logout-btn","text":"濡�洹몄����"});
				logoutBtn.click(function(){
					Kakao.Auth.logout();
					createKakaotalkLogin();
					$("#kakao-profile").text("");
				});
				$("#kakao-logged-group").prepend(logoutBtn);
			}
			if(Kakao.Auth.getRefreshToken()!=undefined&&Kakao.Auth.getRefreshToken().replace(/ /gi,"")!=""){
				createKakaotalkLogout();
				getKakaotalkUserProfile();
			}else{
				createKakaotalkLogin();
			}
		}); */
	</script>
</head>
<body>
	             <div class="form-group">
	                  	  	<a id="kakao-login-btn" href="javascript:loginWithKakao()">
								<img src="//mud-kage.kakao.com/14/dn/btqbjxsO6vP/KPiGpdnsubSq3a0PHEGUK1/o.jpg" width="50%"/>
							</a>
								</div>
								
								
				<div class="form-group">
								<a id="kakao-logout-btn" href="javascript:kakaoLogout()">logout</a>
						</div>
						
							<div id="profile"></div>
							
							<div id="image"></div>
					  	</div>					
								
								
							
</body>
</html>