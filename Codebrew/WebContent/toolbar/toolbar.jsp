<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


	

<!-- autocomplete -->
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.0/jquery-ui.min.js"></script>

<!-- Bootstrap Dropdown Hover CSS -->
<link href="/resources/css/animate.min.css" rel="stylesheet">
<link href="/resources/css/bootstrap-dropdownhover.min.css" rel="stylesheet">

<!-- Bootstrap Dropdown Hover JS -->
<script src="/resources/javascript/bootstrap-dropdownhover.min.js"></script>


<!-- ToolBar Start /////////////////////////////////////-->

<div id="custom-menu" class="navbar navbar-default navbar-fixed-top">
	
	<div class="container">
		
		<a class="navbar-brand" href="/index.jsp">
			<!-- <img src="/resources/image/toolbarImage/pumpkin.png" alt="MOANA"> -->
			<img src="/resources/image/toolbarImage/santa-claus-64.png" alt="MOANA" height="45">
		</a>
		
		<!-- toolBar Button Start //////////////////////// -->
		<div class="navbar-header">
		    <button class="navbar-toggle collapsed" data-toggle="collapse" data-target="#target">
		        <span class="sr-only">Toggle navigation</span>
		        <span class="icon-bar"></span>
		        <span class="icon-bar"></span>
		        <span class="icon-bar"></span>
		    </button>
		    <!-- <a class="navbar-brand" href="#">Login dropdown</a> -->
		</div>
		
		<!-- toolBar Button End //////////////////////// -->
		
	    <!--  dropdown hover Start -->
		<div 	class="collapse navbar-collapse" id="target" 
	       			data-hover="dropdown" data-animations="fadeInDownNew fadeInRightNew fadeInUpNew fadeInLeftNew">
	         
	         	<!-- Tool Bar 를 다양하게 사용하면.... -->
	             <ul class="nav navbar-nav">
	             
	                 
	              <!-- 축제관리 DrowDown  -->
		          <li class="dropdown">
		             <a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
		                <span>Festival</span>
		                <span class="caret"></span>
		              </a>
			              <ul class="dropdown-menu toolbar">
							<li><a href="#">축제목록</a></li>
							<!-- <li><a href="#">my찜</a></li> -->
		                 <c:if test="${sessionScope.user.role == 'a'}">
			                       <li class="divider"></li>
			                       <li><a href="#">축제직접등록</a></li>
			                       <li><a href="#">축제등록</a></li>
	                       </c:if>  
		                   </ul>
		           </li>
		           
		          <!-- 파티관리 DrowDown  -->
		          <li class="dropdown">
		             <a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
		                 <span>Party</span>
		                 <span class="caret"></span>
		              </a>
		              <ul class="dropdown-menu toolbar">
		                  <!-- <li><a href="#">my파티</a></li> -->
		                  <li><a href="#">파티등록</a></li>
		                  <li><a href="#">파티목록</a></li>
		                  <!-- <li><a href="#">애프터파티</a></li>
		                  <li><a href="#">아모르파티</a></li> -->
		               </ul>
		           </li>
		           
		          <!-- 후기관리 DrowDown  -->
		          <li class="dropdown">
		             <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
		             	<span>Review</span>
		             	<span class="caret"></span>
		             </a>
		             <ul class="dropdown-menu toolbar">
						<li><a href="#">후기등록</a></li>
						<li><a href="#">후기목록</a></li>
						<c:if test="${sessionScope.user.role == 'a'}">
		                       <li class="divider"></li>
		                       <li><a href="#">후기심사목록</a></li>
	                     </c:if>
	                     <!-- <li><a href="#">my후기</a></li> -->
		             </ul>
		          </li>
	                 
	              <!-- 구매관리 DrowDown -->
	                     <c:if test="${sessionScope.user.role == 'a'}">
	              <li class="dropdown">
	                <a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
	                    <span >Manage</span>
	                    <span class="caret"></span>
	                </a>
	                <ul class="dropdown-menu toolbar">
	                       <!-- <li><a href="#">my티켓</a></li> -->
	                     <!--   <li><a href="#">축제통계</a></li>
	                       <li><a href="#">평점통계</a></li>
	                       <li><a href="#">참여자수통계</a></li> -->
		                      <!--  <li class="divider"></li> -->
		                      
		                       <li><a href="#">판매통계</a></li>
		                       <li><a href="#">판매목록</a></li>
		                       <li class="divider"></li>
		                       <li><a href="#">회원목록</a></li>
	                   </ul>
	                 </li>
	                    </c:if>  
	                 
	               </ul>
	               
	               
	              <!--검색창 수정중 -->
	              	
	    <!--           		<li>
				
				<div class="navbar-form navbar-left" role="search">
				  <div class="form-group" >
				    <input type="text" class="form-control" id="searchKey" name="searchKeyword" 
					value="" placeholder="축제를 검색해보세요.">
				  </div>
				  <button id="sc" class="btn btn-default">
				  	<span class="glyphicon glyphicon-search" aria-hidden="true"></span>
				  </button>
				</div>
	              		
	              			
	              		</li>
	              	
	              
	              
	             </ul>   
	                  -->
	                 
	             
	             <!-- 가정추가부분 회원검색-->
	              <form class="navbar-form navbar-left form-inline">
	              	<input type="hidden" id="mainSearchCurrentPage" name="mainSearchCurrentPage" value=""/>
						<select id="mainSearchSelect" name="mainSearchSelect" class="form-control">
							<option value="1">회원</option>
							<option value="2">축제</option>
							<option value="3">파티</option>
							<option value="4">후기</option>
						</select>												        
			        <div class="input-group">
				          <input type="text" id="mainSearchKeyword" name="mainSearchKeyword" class="form-control" placeholder="검색어 입력">
				          <span class="input-group-btn">
						    	<button id="mainSearchButton" class="btn btn-info btn-block" type="button">
						    		<span class="glyphicon glyphicon-search" aria-hidden="true"></span>
						    	</button>
						    </span>
			        </div>
			      </form>
			      
	             
	             <ul class="nav navbar-nav navbar-right">
	             	<c:if test="${!empty user}">
		             	<!-- 마이페이지 -->
		             	<li class="dropdown">
			             <a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
			                 <span>MyPage</span>
			                 <span class="caret"></span>
			              </a>
			              <ul class="dropdown-menu toolbar">
			                    <li><a href="#">마이페이지</a></li> 
			                    <li><a href="#">my찜</a></li>
			                    <!-- <li><a href="#">my파티</a></li> -->
			                    <li><a href="#">my후기</a></li>
			                    <li><a href="#">my티켓</a></li>
			                     <li><a href="#">my채팅</a></li>
			                    
			                    <!-- <li><a href="#">회원검색</a></li> -->
			                    
			              </ul>
			           </li>

		             	<li><a href="#">${sessionScope.user.nickname}님</a></li>
		             	<li><img id="coconut" src="/resources/image/toolbarImage/571497.png" alt="MOANA" height="30">
		             	<b id="coconutCount">${sessionScope.user.coconutCount}</b></li>
		             	<li><a href="#">LogOut</a></li>
	             	</c:if>
	             	<c:if test="${empty user}">
		               <!--  <li><a href="#">LogIn</a></li> -->
		    
		    
		               
		  <li class="dropdown">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown"><b>Login</b> <span class="caret"></span></a>
			  <ul id="login-dp" class="dropdown-menu toolbar">
				<li>
					 <div class="row">
							<div class="col-md-12">
								Login via
								<div class="social-buttons">
									<!-- <a href="#" class="btn btn-fb"> --><jsp:include page="/api/kakaoLogin.jsp"></jsp:include><!-- </a> -->
									<!-- <a href="#" class="btn btn-tw"><i class="fa fa-twitter"></i> Twitter</a> -->
								</div>
                                or
								 <form class="form" id="loginForm" role="form" method="post" action="/user/login" accept-charset="UTF-8" id="login-nav">
										<div class="form-group">
											 <label class="sr-only" for="exampleInputEmail2">Email address</label>
											 <input type="email" class="form-control" id="loginUserId" name="loginUserId"  placeholder="Email address" required>
										</div>
										<div class="form-group">
											 <label class="sr-only" for="exampleInputPassword2">Password</label>
											 <input type="password" class="form-control" id="loginPassword" name="loginPassword" placeholder="Password" required>
                                             <div class="help-block text-right"><a href="/user/findUser" id="findUser"><b style="color:gray;">Forget the id or password?</b></a></div>
										</div>
										<div class="form-group">
											 <button type="submit" class="btn btn-primary btn-block" id="sign">Sign in</button>
										</div>
									
								 </form>
							</div>
							<div class="bottom text-center">
					    <b style="color:gray;">new here?</b> <a href="#"><b style="color:gray;">Join</b></a>
							</div>
					 </div>
				</li>
			</ul>
        </li>
	             	</c:if>
	            </ul>
	            
	            
	            
	 
	            
	            
	            
	            
	            
		</div>
		<!-- dropdown hover END -->	       
	    
	</div>
</div>
					<!-- <input type="hidden" id="currentPage" name="currentPage" value=""/>
					<input type="hidden" id="fNo" name="festivalNo" value=""/> -->
					

		<!-- ToolBar End /////////////////////////////////////-->
   	
   	
   	<script type="text/javascript">
   		
   		var mainSearchSelect;
		var mainSearchKeyword;
		
		function fncMainSearchAll(select, keyword) {
			//alert("fnc콜")
			var formHtml = '<form id="mainSearchForm">'
					+'<input type="hidden" name="searchKeyword" value="'+keyword+'">'
					+'<input type="hidden" name="searchCondition" value="'+select+'">'
					+'</form>';
			$("body").append(formHtml);
			$("#mainSearchForm").attr("method", "POST").attr("action", "/search/getSearchList").submit();
						
		}
   		
   		///////////////////////////메인 검색 function/////////////////////////////////////
   		$(function(){
   			
   			$("#mainSearchButton").on("click", function(){
   				console.log("[[[툴바검색]]]"+$("#mainSearchSelect").val()+",,"+$("#mainSearchKeyword").val());
   				mainSearchSelect = $("#mainSearchSelect").val();
   				mainSearchKeyword = $("#mainSearchKeyword").val();
   				fncMainSearchAll(mainSearchSelect, mainSearchKeyword);
   			});
   			
   			$("#mainSearchKeyword").on("keydown", function(e){
   				
   				if(e.keyCode == '13') {
   					if($(this).val() == '') {
   						alert("검색어를 입력해주세요");
   						e.preventDefault();
   						return;
   					} else {
   						
	   					//alert("엔터클릭");
	   					mainSearchSelect = $("#mainSearchSelect").val();
	   					mainSearchKeyword = $("#mainSearchKeyword").val();
	   					fncMainSearchAll(mainSearchSelect, mainSearchKeyword);
	   					e.preventDefault();
   					}
   				}
   				
   			})
   			
   		});
   	
		
   		$(".dropdown").hover(function(){
   			$(this).toggleClass("mouse-on");
   		})
   		
   		//////로그인, 로그아웃//////
		$(function(){
		 /* 	$("a:contains('LogIn')").on("click" , function() {
				self.location = "/user/login";
			});  */
		 	$("a:contains('LogOut')").on("click" , function() {
				self.location = "/user/logout";
			}); 
		 	
		 	$("a:contains('마이페이지')").on("click" , function() {

		self.location = "/myPage/getMyPage?requestId=${sessionScope.user.userId}";

			}); 
		 	
		});
   		
  		//////축제관리//////
   		$(function(){
			$( "li > a:contains('축제목록')" ).on("click" , function() {
				self.location = "/festival/getFestivalListDB?menu=db";
			});
			
			$("li > a:contains('축제등록')").bind('click', function(){
				self.location = "/festival/getFestivalList";
			});
			
			$("li > a:contains('축제직접등록')").bind('click', function(){
				self.location = "/view/festival/writeFestival.jsp";
			});
			
			$("li > a:contains('my찜')").bind('click', function(){
				self.location = "/festival/getMyZzimList";
			});
   		});
  		
  		//////후기관리//////
   		$(function(){
			$( "a:contains('Review')" ).on("click" , function() {
				//self.location = "/review/getReviewList";
				//self.location = "/review/getReviewList";
			});
   		});
  		
  		
 		//////후기관리//////
   		$(function(){
			$( "a:contains('후기목록')" ).on("click" , function() {
				self.location = "/review/getReviewList";
			});
			
			$("li > a:contains('후기등록')").bind('click', function(){
				self.location = "/review/addReview";
			});
			
			$("li > a:contains('my후기')").bind('click', function(){
				self.location = "/review/getMyReviewList";
			});
			
			$("li > a:contains('후기심사목록')").bind('click', function(){
				self.location = "/review/getCheckReviewList";
			});
   		});
   		
  		//////구매관리//////
		$(function(){
			
			$("a:contains('my티켓')").bind('click', function(){
				self.location = "/purchase/getPurchaseList";
			});
			
			$("a:contains('축제통계')").bind('click', function(){
				self.location = "/statistics/getFestivalZzim";
			});
			
			$("a:contains('평점통계')").bind('click', function(){
				self.location = "/statistics/getFestivalRating";
			});
			
			$("a:contains('참여자수통계')").bind('click', function(){
				self.location = "/statistics/getPartyCount";
			});
			
			$("li > a:contains('판매목록')").bind('click', function(){
				self.location = "/purchase/getSaleList";
			});
			
			$("li > a:contains('판매통계')").bind('click', function(){
				self.location = "/statistics/getStatistics";
			});
			
		});
  		
	//////채팅관리//////
		$(function(){
			
		
			$("li > a:contains('my채팅')").bind('click', function(){
				self.location = "/chat/getChattingList";
			});
			
		});
  		
		//////채팅관리//////
		$(function(){
			
			$("a:contains('나의채팅방')").bind('click', function(){
				self.location = "/chat/getChattingList";
			});
		});
  		
		//////파티관리//////
		$(function(){
			
			$("li > a:contains('my파티')").bind('click', function(){
				self.location = "/party/getMyPartyList";
			});
			
			$("li > a:contains('파티등록')").bind('click', function(){
				self.location = "/party/addParty";
			});
			
			$("li > a:contains('파티목록')").bind('click', function(){
				self.location = "/party/getPartyList";
			});
			
			$("li > a:contains('애프터파티')").bind('click', function(){
				
			});
			
			$("li > a:contains('아모르파티')").bind('click', function(){
				
			});
			
		});
		
		
		///////툴바 MANAGE////////
   		$(function(){
   			
   			$("a:contains('회원목록')").on("click" , function() {
				self.location = "/user/getUserList";
			}); 
   			
		 	$("a:contains('축제등록')").on("click" , function() {
				self.location = "/festival/getFestivalList?pageNo=1";
			}); 
		 	
		 	$("a:contains('후기심사목록')").on("click" , function() {
				//self.location = "";
			}); 
			
   		});
		
		
  		///////파티관리////////
   		$(function(){
   			
		 	$("a:contains('파티등록')").on("click" , function() {
				self.location = "/party/addParty"
			}); 
		 	
			$("a[href='#']:contains('파티목록')").bind('click', function(){
				self.location = "/party/getPartyList";
			});
			
   		});
  		
  		
  		
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
   		
		
		
$( function() {
			
			$("#loginUserId").focus();
			
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$("#sign").on("click" , function() {
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
				    }
				    
			      });
			});
		});
	   
			
		
   		
	</script>  

	<style>
		
		#coconut{
			padding-top: 18px; 
		}
		
		#coconutCount {
			padding-top: 48px; 
		}
		
		
		* {
			box-sizing: border-box;
		}
		 
		.navbar-brand > img {
				padding-bottom: 15px;
		}
		
		.navbar-default {
		    background-image: linear-gradient(to bottom,black 0,black 100%)  !important; 
		    box-shadow: inset 0 1px 0 rgba(255,255,255,.15), 0 1px 5px rgba(0,0,0,.075);
		}
		
		.dropdown-menu.toolbar {
			background-color: black;
			color: white;
		}
		 
		.dropdown-menu.toolbar {
			background-color: black;
			color: white;
		}
		 
		.dropdown-menu.toolbar li a {
			color: #eee;
		}
		
		.navbar-nav>li>a {
			line-height: 35px;
			padding-top: 10px;
			padding-bottom: 10px;
		}
		
		.navbar-toggle {
			margin-top: 20px;
		}
		
		.navbar-default .navbar-nav>li>a {
			color: #cecece;
		}
		
	/*주영이가 추가함  */	
  
  #login-dp{
    min-width: 250px;
    padding: 14px 14px 0;
    overflow:hidden;
    background-color:rgba(255,255,255,.8);
}
#login-dp .help-block{
    font-size:12px    
}
#login-dp .bottom{
    background-color:rgba(255,255,255,.8);
    border-top:1px solid #ddd; 
    clear:both;
    padding:14px;
}
#login-dp .social-buttons{
    margin:12px 0    
}
#login-dp .social-buttons a{
    width: 49%;
}
#login-dp .form-group {
    margin-bottom: 10px;
}
.btn-fb{
    color: #fff;
    background-color:#3b5998;
}
.btn-fb:hover{
    color: #fff;
    background-color:#496ebc 
}
.btn-tw{
    color: #fff;
    background-color:#55acee;
}
.btn-tw:hover{
    color: #fff;
    background-color:#59b5fa;
}

@media(max-width:768px){
    #login-dp{
        background-color: inherit;
        color: #fff;
    }
     #login-dp .bottom{
        background-color: inherit;
        border-top:0 none;
    } 
}

		
	</style>
	