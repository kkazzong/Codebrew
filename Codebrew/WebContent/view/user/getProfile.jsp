<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
	<script src="https://use.fontawesome.com/04438b50a5.js"></script>
	
	<script type="text/javascript">
	
	 $(function() {
		 
			$( "#profileFollow" ).on("click" , function() {
				var targetUserId = $("#userId").val();
				targetUserId=targetUserId.split(".");
				/* self.location="/user/addFollow?targetUserId="+targetUserId; */
				
				$.ajax(
					{
						url : '/user/addFollow/'+targetUserId,
						method : "GET",
						dataType : "json",
						headers : {
							 "Accept" : "application/json",
							 "Content-Type" : "application/json"
						 },
						 context : this,
						 success : function(JSONData, status) {
							/*  $("#follow").val("following").css('background-color', '#3897f0').css('color', '#fff'); */
							/* location.reload(); */
							$(this).val('following');
							 
						 }
					}		
				)
			});
		});	
	 
	 $(function() {
		 
		 var travUserId = $("#userId").val();
		 console.log("travUserIdddddddddddddd :: " + travUserId);
			 
			$( "#listLikeTravel" ).on("click" , function() {
				self.location="/user/listLikeTravel?travUserId="+travUserId;
			});
		 
			$( "#listTravel" ).on("click" , function() {
				self.location="/user/getListTravel?travUserId="+travUserId;
			});
		 
			$( "#listFollow" ).on("click" , function() {
				
				/* alert("travUserID 更艦びびびびびびびびびび? " + travUserId); */
				self.location="/user/listFollow?travUserId="+travUserId;
			});
			
			$( "#listFollowing" ).on("click" , function() {
				self.location="/user/listFollowing?travUserId="+travUserId;
			});
			
			$( "#update" ).on("click" , function() {
				var userId = $("#userId").val();
				self.location="/user/updateUser?userId="+userId;
			});
			
			$( "#getUser" ).on("click" , function() {
				var userId = $("#userId").val();
				self.location="/user/getUser?userId="+userId;
			});
			
			$( "#sendMsg" ).on("click" , function() {
				var receiver = $("#userId").val();
				self.location="/message/sendMsg?receiver="+receiver;
			});
			
		});
	 
	</script>
	
	<style>
			html, body {
			width: 100%;
			height:100%;
		}
	
		/* Profile container */
		.profile {
		  margin: 20px 0;
		}
		/* Profile sidebar */
		.profile-sidebar {
		  padding: 20px 0 10px 0;
		  background: #F1F3FA;
		  border-radius : 4px;
		  /* background: #fff; */
		}
		.profile-userpic img {
		  float: none;
		  margin: 0 auto;
		  width: 50%;
		  height: 120px;
		  -webkit-border-radius: 50% !important;
		  -moz-border-radius: 50% !important;
		  border-radius: 50% !important;
		}
		.profile-usertitle {
		  text-align: center;
		  margin-top: 20px;
		}
		.profile-usertitle-name {
		  color: #5a7391;
		  font-size: 16px;
		  font-weight: 600;
		  margin-bottom: 7px;
		}
		.profile-usertitle-job {
		  text-transform: uppercase;
		  color: #5b9bd1;
		  font-size: 12px;
		  font-weight: 600;
		  margin-bottom: 15px;
		}
		.profile-userbuttons {
		  text-align: center;
		  margin-top: 10px;
		}
		.profile-userbuttons .btn {
		  text-transform: uppercase;
		  font-size: 11px;
		  font-weight: 600;
		  padding: 6px 15px;
		  margin-right: 5px;
		}
		.profile-userbuttons .btn:last-child {
		  margin-right: 0px;
		}
		.profile-usermenu {
		  margin-top: 30px;
		}
		.profile-usermenu ul li {
		  border-bottom: 1px solid #f0f4f7;
		}
		.profile-usermenu ul li:last-child {
		  border-bottom: none;
		}
		.profile-usermenu ul li a {
		  color: #93a3b5;
		  font-size: 14px;
		  font-weight: 400;
		}
		.profile-usermenu ul li a i {
		  margin-right: 8px;
		  font-size: 14px;
		}
		.profile-usermenu ul li a:hover {
		  background-color: #fafcfd;
		  color: #5b9bd1;
		}
		.profile-usermenu ul li.active {
		  border-bottom: none;
		}
		.profile-usermenu ul li.active a {
		  color: #5b9bd1;
		  background-color: #f6f9fb;
		  border-left: 2px solid #5b9bd1;
		  margin-left: -2px;
		}
		
		button {
			color : white;
		}
	
	</style>
		 <input type="hidden" id="sessionId" value="${sessionScope.user.userId}">
		
		<div class="col-md-3">
			<div class="profile-sidebar">
				<!-- SIDEBAR USERPIC -->
					<div class="profile-userpic">

						<c:if test="${ user.profileImage != null}">
							<img src="/images/upload/profile/${user.profileImage}" class="img-responsive" alt="">
						</c:if>
						<c:if test="${ user.profileImage == null}">
							<img class="img-responsive" src="https://ssl.gstatic.com/accounts/ui/avatar_2x.png">
						 </c:if> 
					</div>
					<!-- END SIDEBAR USERPIC -->
					
					
					
					<!-- SIDEBAR USER TITLE -->
					<div class="profile-usertitle">
						<div class="profile-usertitle-name">
							${user.nickname}
						</div>
						<div class="profile-usertitle-job">
							${user.userId}
						</div>
					</div>
				<!-- END SIDEBAR USER TITLE -->
				
				<!-- SIDEBAR BUTTONS -->                                                                                                                                                                                                                                                                                                                    
				<div class="profile-userbuttons">
					<c:if test="${ not empty sessionScope.user.userId }">
						<c:if test="${sessionScope.user.userId != user.userId }">  
							 <c:choose >
								 <c:when test="${ empty follow.targetUserId }">
									<button type="button" class="btn btn-sm" id="profileFollow" value="follow">Follow</button>
									<button type="button" class="btn btn-sm" id="sendMsg" >楕走左鎧奄</button>
								</c:when>
								<c:otherwise >
									<button type="button" class="btn btn-sm" id="profileFollowing" value="following">Following</button>
									<button type="button" class="btn btn-sm" id="sendMsg" >楕走左鎧奄</button>
								</c:otherwise>
							</c:choose>
						</c:if>
					</c:if> 
				</div>
				<div class="profile-userbuttons">
				<c:if test="${ not empty sessionScope.user.userId }">
						<c:if test="${sessionScope.user.userId == user.userId }">  
							<button type="button" class="btn btn-sm" id="update">噺据舛左呪舛</button>
							<button type="button" class="btn btn-sm" id="getUser">噺据舛左繕噺</button>
						</c:if> 
					</c:if> 
				</div>
				<!-- END SIDEBAR BUTTONS -->
				<!-- SIDEBAR MENU -->
				<div class="profile-usermenu">
					<ul class="nav">
						<li class="test active" id="listTravel">
							<a href="#">
							<i class="fa fa-plane" aria-hidden="true"></i>
							去系廃 食楳 </a>
						</li>
						<li  class="test" id="listLikeTravel">
							<a href="#">
							<i class="fa fa-heart" aria-hidden="true"></i>
							疏焼推廃 食楳</a>
						</li >
						<li id="listFollow" class="test">
							<input type="hidden" id="userId" name="userId" value="${user.userId}">
							<a href="#">
							<i class="fa fa-user-circle" aria-hidden="true" ></i>
							独稽酔 </a>
						</li>
						<li id="listFollowing" class="test">
							<a href="#">
							<i class="fa fa-user-circle-o" aria-hidden="true"></i>
							独稽跡 </a>
						</li>
					</ul>
				</div>
				<!-- END MENU -->
			</div>
		</div>
		
