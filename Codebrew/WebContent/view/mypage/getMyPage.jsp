<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> --%>
	
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet">  
	 

<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	
	 <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css"> 
      
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>

	  
<title>마이페이지</title>
</head>

<script type="text/javascript">
	
	  $(function() {
		 
			$("#profileFollow").on("click" , function() {
				var requestId = $("#userId").val();
			
			 console.log("requestId는????"+requestId);
			 
				
				$.ajax({
					    type:'POST',
						url : '/myPageRest/json/addFollow',
						data: {requestId:requestId},
						dataType : "json",
					 /* headers : {
							 "Accept" : "application/json",
							 "Content-Type" : "application/json"
						 }, */
						 /* async:false; */
						 /* context : this, */
						 success : function(JSONData, status) {
							/*  $("#follow").val("following").css('background-color', '#3897f0').css('color', '#fff'); */
							/* location.reload(); */
							//console.log(this);
							//console.log(JSON.stringify(JSONData));
							//$(this).val('following');
							//alert(status);
							//alert(JSON.stringify(JSONData));
							 //location.reload();
							/* 팔로잉 됐다고 버튼이  바뀜 follow(팔로잉 안한거)--> following(팔로잉된거) */
							//$("#profileFollow").text("Following").css('background-color', '#3897f0').css('color', '#fff');
							
							$("#profileFollow").removeClass("btn btn-sm").addClass("btn btn-info").text("Following");
							
							//$(this).val("Following");
							
							
							
							location.reload();
						     //window.location.reload(true);
						     //$('#reload').load("/myPage/getMyPage?requestId=${sessionScope.user.userId}");
							// window.location.reload(true);
							//$('#content').html(JSON.stringify(JSONData));
						 } 
					})
			  });
			
	 });	
	 
	 
	 
	 $(function() {
		 
			$("#profileFollowing").on("click" , function() {
				var requestId = $("#userId").val();
			
			 console.log("requestId는????"+requestId);
			 
				
				$.ajax({
						/* url : '/myPageRest/json/deleteFollow/'+requestId,
						method : "GET",
						dataType : "json",
						headers : {
							 "Accept" : "application/json;charset=UTF-8",
							 "Content-Type" : "application/json"
						 },
						 context : this, */
						 type:'POST',
						 url : '/myPageRest/json/deleteFollow',
						 data: {requestId:requestId},
						 dataType : "json",
						 
						 success : function(JSONData, status) {
							/*  $("#follow").val("following").css('background-color', '#3897f0').css('color', '#fff'); */
							/* location.reload(); */
							//$(this).val('follow');
							//alert(JSON.stringify(JSONData));
							
							//$("#profileFollowing").text("Follow").css('background-color', '#3897f0').css('color', '#fff');
							$("#profileFollowing").removeClass("btn btn-info").addClass("btn btn-sm").text("Follow");
							 
							 //$(this).val("Follow");
							 location.reload();
						  }
					})
			  });
	
	 });	 
	  
	

	 
	//============= "일대일 채팅"  Event 처리 및  연결 =============
		function chatPopup(frm) {
			/* var url = "http://127.0.0.1:3000/public/client05.html"; */
			var url = "/chat/getChatting";
			var title = "chatPop";
			var status = "toolbar=no,directories=no,scrollbars=yes,resizable=no,status=no,menubar=no,width=440, height=520, top=0,left=20";
			window.open("", title, status); //window.open(url,title,status); window.open 함수에 url을 앞에와 같이
			//인수로  넣어도 동작에는 지장이 없으나 form.action에서 적용하므로 생략
			//가능합니다.
			frm.target = title; //form.target 이 부분이 빠지면 form값 전송이 되지 않습니다. 
			frm.action = url; //form.action 이 부분이 빠지면 action값을 찾지 못해서 제대로 된 팝업이 뜨질 않습니다.
			frm.method = "post";
			frm.submit();
		} 
	 
	 
	 
	 
	</script>

<style>
  body {
    font-family: 'Roboto', sans-serif;
    font-weight: 400;
    background-color: #f0f3f5; 
    margin-top:40px;
}  
/*==============================*/
/*====== siderbar user profile =====*/
/*==============================*/
.nav>li>a.userdd {
    padding: 5px 15px
}
.userprofile {
    width: 100%;
	float: left;
	clear: both;
	margin: 40px auto
}
.userprofile .userpic {
	height: 100px;
	width: 100px;
	clear: both;
	margin: 0 auto;
	display: block;
	border-radius: 100%;
	box-shadow: 0px 3px 10px 0 rgba(0, 0, 0, 0.15);
	-moz-box-shadow: 0px 3px 10px 0 rgba(0, 0, 0, 0.15);
	-webkit-box-shadow: 0px 3px 10px 0 rgba(0, 0, 0, 0.15);
	-ms-box-shadow: 0px 3px 10px 0 rgba(0, 0, 0, 0.15);
	position: relative; 
}
.userprofile .userpic .userpicimg {
	height: auto;
	width: 100%;
	border-radius: 100%;
}
.username {
	font-weight: 400;
	font-size: 20px;
	line-height: 20px;
	color: #000000;
	margin-top: 20px;
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
}
.username+p {
	color: #607d8b;
	font-size: 13px;
	line-height: 15px;
	white-space: nowrap;
	text-overflow: ellipsis;
	overflow: hidden;
}
.settingbtn {
	height: 30px;
	width: 30px;
	border-radius: 30px;
	display: block;
	position: absolute;
	bottom: 0px;
	right: 0px;
	line-height: 30px;
	vertical-align: middle;
	text-align: center;
	padding: 0;
	box-shadow: 0px 2px 5px 0 rgba(0, 0, 0, 0.15);
	-moz-box-shadow: 0px 2px 5px 0 rgba(0, 0, 0, 0.15);
	-webkit-box-shadow: 0px 2px 5px 0 rgba(0, 0, 0, 0.15);
	-ms-box-shadow: 0px 2px 5px 0 rgba(0, 0, 0, 0.15);
}
.userprofile.small {
	width: auto;
	clear: both;
	margin: 0px auto;
}
.userprofile.small .userpic {
	height: 40px;
	width: 40px;
	margin: 0 10px 0 0;
	display: block;
	border-radius: 100%;
	box-shadow: 0px 3px 10px 0 rgba(0, 0, 0, 0.15);
	-moz-box-shadow: 0px 3px 10px 0 rgba(0, 0, 0, 0.15);
	-webkit-box-shadow: 0px 3px 10px 0 rgba(0, 0, 0, 0.15);
	-ms-box-shadow: 0px 3px 10px 0 rgba(0, 0, 0, 0.15);
	position: relative;
	float: left;
}
.userprofile.small .textcontainer {
	float: left;
	max-width: 100px;
	padding: 0
}
.userprofile.small .userpic .userpicimg {
	min-height: 100%;
	width: 100%;
	border-radius: 100%;
}
.userprofile.small .username {
	font-weight: 400;
	font-size: 16px;
	line-height: 21px;
	color: #000000;
	margin: 0px;
	float: left;
	width: 100%;
}
.userprofile.small .username+p {
	color: #607d8b;
	font-size: 13px;
	float: left;
	width: 100%;
	margin: 0;
}
/*==============================*/
/*====== Social Profile css =====*/
/*==============================*/
.countlist h3 {
	margin: 0;
	font-weight: 400;
	line-height: 28px;
}
.countlist {
	text-transform: uppercase
}
.countlist li {
	padding: 15px 30px 15px 0;
	font-size: 14px;
	text-align: left;
}
.countlist li small {
	font-size: 12px;
	margin: 0
}
.followbtn {
	float: right;
	margin: 22px;
}
 .userprofile.social {
    background: url(/resources/uploadFile/f424d0ed-341f-4c47-9670-cd959a19ba2f1510036321585.jpg) no-repeat top center; 
	background-size: 100%;
	padding: 50px 0;
	margin: 0
} 
.userprofile.social .username {
	color: #ffffff
}
.userprofile.social .username+p {
	color: #ffffff;
	opacity: 0.8
}
.postbtn {
	position: absolute;
	right: 5px;
	top: 5px;
	z-index: 9
}
.status-upload {
	width: 100%;
	float: left;
	margin-bottom: 15px
}
.posttimeline .panel {
	margin-bottom: 15px
}
.commentsblock {
	background: #f8f9fb;
}
.nopaddingbtm {
	margin-bottom: 0
}

.panel-default>.panel-heading {
    color: #607D8B;
    background-color: #ffffff;
    font-weight: 400;
    font-size: 15px;
    border-radius: 0;
    border-color: #e1eaef;
} 


/*  
.btn-circle {
    width: 40px;
    height: 40px;
    padding: 10px 3;
    border-radius: 10px;
    text-align: center;
    font-size: 15px;
    line-height: 2;
    position: center;
}  */

.followbtn{
  
	float: right;
	margin: 22px;
	margin-bottom: 20px;
	
	width: 200px;
    height: 50px;
  
   
  }


#userDiv {
	height: 40px;
}
#userRole {
	padding: 10px;
}
#userNick {
	padding: 10px;
}


.modal-body {
	background-color : #fff8d6;
}
 
 
 
 
.page-header.small {
    position: relative;
    line-height: 22px;
    font-weight: 400;
    font-size: 20px;
}

.favorite i {
    color: #eb3147;
    text-align: center;
    position: center;
}

.btn i {
    font-size: 21px;
    position: center;
}

.i{
  text-aligh: center;
}

.panel {
    box-shadow: 0px 2px 10px 0 rgba(0, 0, 0, 0.05);
    -moz-box-shadow: 0px 2px 10px 0 rgba(0, 0, 0, 0.05);
    -webkit-box-shadow: 0px 2px 10px 0 rgba(0, 0, 0, 0.05);
    -ms-box-shadow: 0px 2px 10px 0 rgba(0, 0, 0, 0.05);
    transition: all ease 0.5s;
    -moz-transition: all ease 0.5s;
    -webkit-transition: all ease 0.5s;
    -ms-transition: all ease 0.5s;
    margin-bottom: 35px;
    border-radius: 0px;
    position: relative;
    border: 0;
    display: inline-block;
    width: 100%;
}

.panel-footer {
    padding: 10px 15px;
    background-color: #ffffff;
    border-top: 1px solid #eef2f4;
    border-bottom-right-radius: 0;
    border-bottom-left-radius: 0;
    color: #607d8b;
}

.panel-blue {
    color: #ffffff;
    background-color: #03A9F4;
}

.panel-red.userlist .username, .panel-green.userlist .username, .panel-yellow.userlist .username, .panel-blue.userlist .username {
    color: #ffffff;
}

.panel-red.userlist p, .panel-green.userlist p, .panel-yellow.userlist p, .panel-blue.userlist p {
    color: rgba(255, 255, 255, 0.8);
}

.panel-red.userlist p a, .panel-green.userlist p a, .panel-yellow.userlist p a, .panel-blue.userlist p a {
    color: rgba(255, 255, 255, 0.8);
}

.progress-bar-success, .status.active, .panel-green, .panel-green > .panel-heading, .btn-success, .fc-event, .badge.green, .event_green {
    color: white;
    background-color: #8BC34A;
}

.progress-bar-warning, .panel-yellow, .status.pending, .panel-yellow > .panel-heading, .btn-warning, .fc-unthemed .fc-today, .badge.yellow, .event_yellow {
    color: white;
    background-color: #FFC107;
}

.progress-bar-danger, .panel-red, .status.inactive, .panel-red > .panel-heading, .btn-danger, .badge.red, .event_red {
    color: white;
    background-color: #F44336;
}

.media-object {
    max-width: 50px;
    border-radius: 50px;
    box-shadow: 0px 3px 10px 0 rgba(0, 0, 0, 0.15);
    -moz-box-shadow: 0px 3px 10px 0 rgba(0, 0, 0, 0.15);
    -webkit-box-shadow: 0px 3px 10px 0 rgba(0, 0, 0, 0.15);
    -ms-box-shadow: 0px 3px 10px 0 rgba(0, 0, 0, 0.15);
}

.media:first-child {
    margin-top: 15px;
}

.media-object {
    display: block;
}

.dotbtn {
    height: 40px;
    width: 40px;
    background: none;
    border: 0;
    line-height: 40px;
    vertical-align: middle;
    padding: 0;
    margin-right: -15px;
}

.dots {
    height: 4px;
    width: 4px;
    position: relative;
    display: block;
    background: rgba(0,0,0,0.5);
    border-radius: 2px;
    margin: 0 auto;
}

.dots:after, .dots:before {
    content: " ";
    height: 4px;
    width: 4px;
    position: absolute;
    display: inline-block;
    background: rgba(0,0,0,0.5);
    border-radius: 2px;
    top: -7px;
    left: 0;
}

.dots:after {
    content: " ";
    top: auto;
    bottom: -7px;
    left: 0;
}

.photolist img {
    width: 100%;
}

.photolist {
    background: #e1eaef;
    padding-top: 15px;
    padding-bottom: 15px;
}

.profilegallery .grid-item a {
    height: 100%;
    display: block;
}

.grid a {
    width: 100%;
    display: block;
    float: left;
}

 .media-body {
    color: #607D8B;
    overflow: visible;
} 

/* 
#mask {  
  position:absolute;  
  left:0;
  top:0;
  z-index:9000;  
  background-color:#000;  
  display:none;  
} */
</style>

<body>
<jsp:include page="/toolbar/toolbar.jsp"/> 



<div class="container" >
<input type="hidden" id="sessionId" value="${sessionScope.user.userId}">
         
<div class="row"> 
      <div class="col-md-12 text-center "><!-- col-xs-12 -->
        <div class="panel panel-default">
          <div class="userprofile social" ><!--background="/resources/uploadFile/light22.jpeg"  -->
            <div class="userpic"> 
            
            <c:if test="${user.password !='null' }">
            <img src="/resources/uploadFile/${user.profileImage}" alt="" class="userpicimg">
            </c:if>
            <c:if test="${user.password == 'null' }">
            <img src="${user.profileImage}" alt="" class="userpicimg">
            </c:if>
            
             </div>
            <h3 class="username">${user.nickname}</h3>
           <%--  <h3 class="username">${user.userId}</h3> --%>
           
           <c:if test="${! empty sessionScope.user.userId}">
             <c:if test="${sessionScope.user.userId == user.userId }">
           
              <h3 class="username">
               <c:if test="${user.gender == 'm'}">
               <i class="fa fa-mars" aria-hidden="true"></i>
               </c:if>
               <c:if test="${user.gender == 'f'}">
               <i class="fa fa-venus" aria-hidden="true"></i>
               </c:if>
               </h3>
             </c:if>
            </c:if>
            
            <%-- <h3 class="username">${user.age}</h3> --%>
            <h3 class="username"><i class="fa fa-lemon-o" aria-hidden="true"></i>${user.coconutCount}</h3>
            
          
            <div class="socials text-center"> 
             <form name="form">
             <c:if test="${! empty sessionScope.user.userId}">
              <c:if test="${sessionScope.user.userId == user.userId }">
            <a href="/user/updateUser?userId=${sessionScope.user.userId }" class="btn btn-circle btn-primary" title="회원정보수정"><i class="fa fa-cog" aria-hidden="true"></i></a> 
             </c:if>
             </c:if>
            <button type="button" class="btn btn-circle btn-danger" title="채팅" onclick="javascript:chatPopup(this.form);"><i class="fa fa-weixin"aria-hidden="true"></i></button>
            
            
            <input type="hidden" name="recipient" value="${user.userId}">
			<input type="hidden" name="sender" value="${sessionScope.user.userId}">
			<%-- <c:if test="${user.userId != party.user.userId }">
			<button type='button' class='btn-sm btn-default pull-right' onclick="javascript:chatPopup(this.form);">채팅하기</button>
			</c:if>  --%>
           </form>
            
           <!--  <a href="" class="btn btn-circle btn-info "><i class=""></i></a>  -->
            <!-- <a href="" class="btn btn-circle btn-warning "><i class="fa fa-envelope" aria-hidden="true"></i></a> -->
            </div>
          </div>
          
          
          
          
          
          <div class="col-md-12 border-top border-bottom" id="reload">
            <ul class="nav nav-pills pull-left countlist" role="tablist">
             
              <li role="presentation">
                <h3>${totalCount1}<br>
                  <small>
                  <input type="hidden" id="userId" name="userId" value="${user.userId}">
                  <a href="#">
                  <button type="button" class="btn btn-secondary" aria-hidden="true" 
				   data-toggle="modal" data-target="#following">Following</button></a>
                 <jsp:include page="/view/mypage/getFollowingList.jsp"/>
                 </small> </h3>
              </li>
              
              <li role="presentation">
                <h3>${totalCount2}<br>
                  <small>
                  <input type="hidden" id="userId" name="userId" value="${user.userId}">
                  <a href="#">
                  <button type="button" class="btn btn-secondary" aria-hidden="true" 
				  data-toggle="modal" data-target="#follower">Follower</button></a>	
				 <jsp:include page="/view/mypage/getFollowerList.jsp"/>
                 </small> </h3>
              </li>
              
              <li role="presentation">
                <h3>${resultPage.totalCount}<br>
                  <middle>Party Activity</middle> </h3>
              </li>
            </ul>
            
            
            
            
            
               
            	<c:if test="${! empty sessionScope.user.userId }">
						<c:if test="${sessionScope.user.userId != user.userId }">  <!--내가 딴 사람 마이페이지에 들어갔을때만 follow 버튼이 뜨는  조건  -->
							 <c:choose>
							 <c:when test="${empty follow.requestId }">
								
								 <!--나(sessionId) 이사람 requestId면 (팔로잉 목록에 없다면)-->
									<button type="button" class="btn btn-sm followbtn" id="profileFollow" style="font-size:20px">Follow</button>			
								</c:when>
							     <c:otherwise>
							      <!--나(sessionId) 이사람 requestId면 (팔로잉 목록에 있다면)-->
								     <button type="button" class="btn btn-info followbtn" id="profileFollowing" style="font-size:20px">Following</button>
							     </c:otherwise>
						</c:choose>
					</c:if> 
				</c:if>
            
           <!-- <button class="btn btn-primary followbtn">Follow</button> -->
         
          </div>
          <div class="clearfix"></div> 
        
        </div>
      </div>
      <!-- /.col-md-12 -->
   
       <%-- <jsp:include page="/view/mypage/getMyPartyList3.jsp"/>  --%>
        
          
        </div>
       <%-- <jsp:include page="/view/mypage/getMyPartyList3.jsp"/>  --%>
   </div> 
      
      
 
   <!-- Status Upload  --> 
       
      <!--   <div class="panel panel-default">
          <div class="btn-group pull-right postbtn">
            <button type="button" class="dotbtn dropdown-toggle" data-toggle="dropdown" aria-expanded="false"> <span class="dots"></span> </button>
            <ul class="dropdown-menu pull-right" role="menu">
              <li><a href="javascript:void(0)">Hide this</a></li>
              <li><a href="javascript:void(0)">Report</a></li>
            </ul>
          </div> -->
      
  <%-- <jsp:include page="/view/mypage/getMyPartyList3.jsp"/>   --%>
       <jsp:include page="/view/mypage/getMyPartyList3.jsp"/>
              
  
</body>
  
</html>