<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>


<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width" />
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>


<!-- <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>  -->

</head>
<body>

<div class="panel-body">
<a id="custom-login-btn" href="javascript:loginWithKakao()">
<img src="//k.kakaocdn.net/14/dn/btqbjxsO6vP/KPiGpdnsubSq3a0PHEGUK1/o.jpg" width="300"/>
</a>
</div>

<script type='text/javascript'>
 
    Kakao.init('9f9b09052da56dddc3bc66e8a1632a69');
    function loginWithKakao() {
      // 로그인 창을 띄웁니다.
      Kakao.Auth.login({
        success: function(authObj) {
          //alert(JSON.stringify(authObj)); {"name":"value", }<----이렇게 눈에 보이는 형식으로 나옴
          //alert(authObj);/*  [object Object] <----이렇게 나옴*/
          //var authorize_code=Kakao.Auth.getAcessToken();
          var authorize_code = authObj.access_token;
          //alert(authorize_code);
          //Kakao.Auth.setAccessToken(accessToken); 
          
          self.location="/user/kakaoLogin?authorize_code="+authorize_code;
          },
          
        fail: function(err) {
          alert(JSON.stringify(err));
        }
          
      })
      
   
    };
 
   
    
    
    
    
   /*  $(function(){
    	$("a:contains('로그아웃')").bind("click",function(){
    		
    		fncLogOut();
    	});
    });
    
    
    function fncLogOut(){
    	
    	var authorize_code =Kakao.Auth.getAcessToken();
    	
    	if(authorize_code == null || authorize_code.length <1){
    		
    	self.location="/user/logout";
    	}
    	
    	Kakao.Auth.logout(function(authObj) {
    		
    		
       self.location="/user/logout";
    	alet("카카오로그아웃이 되었습니다.");
    	
    	})
    }
     */
    
        
 /*    $(function(){
    	$("a:contains('로그아웃')").bind("click",function(){
    		
    		Kakao.Auth.logout(function(authObj) {
    			
    		self.location="/user/logout";
    		})
    		
    	})
    	
    }) */
   
    $(function(){
    	$("a:contains('kakaoLogout')").on("click", function() {
    		
    		Kakao.Auth.logout(function(data) {
    			//alert(data);
    			if(data) {
    				alert("카카오로그아웃이 되었습니다.");
    				
    				//$("#profile").html("logout ok")
    			 }		
    	       })
    		})
     });
    
     
    
    
    
</script>
     <div class="form-group">
	    <a id="kakao-logout-btn">kakaoLogout</a><!--한글로 쓰면 안 안먹힘..a contains가 잘안먹힘  -->
	</div> 



</body>
</html>