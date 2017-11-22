<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<!--  ///////////////////////// JavaScript ////////////////////////// -->
	
	<script type="text/javascript"> 
	
		var sessionId = "${user.userId}";
		var purchaseNo;
		
		//============= "파티 티켓 구매"  Event 처리 및  연결 =============
		function fncGetPurchaseNo(sessionId, partyNo) {
			
			console.log("purchaseNo얻기"+sessionId+","+partyNo);
			$.ajax({
				
				url : "/purchaseRest/json/getPurchaseNo/"+sessionId+"/"+partyNo,
				method : "GET",
				dataType : "json",
				success : function(JSONData, status) {
					
					console.log("purchaseNo--->"+JSON.stringify(JSONData));
					purchaseNo = JSONData.purchaseNo;
					
				}
				
			});
			
		}
	
		
		//============= "Button Html"  Event 처리 및  연결 =============
		function fncButtonHtml(buttonFlag){
			
			console.log("\nbuttonFlag ==>"+buttonFlag);
			
			if(sessionId !=""){
			
				if(buttonFlag == 'ap'){
					
					/* 애프터 파티 참여 버튼 */
	  				var joinParty = "<button type='button' class='btn btn-info btn-block' id='afterPartyBtn'>애프터파티 참여</button>" 
	  					
	  				$("#partyButtonDiv").html(joinParty).on("click", function() {
	  					
	  					swal({
		    				  title: '애프터 파티 참여!',
							  text: "파티에 참여하시겠습니까?",
							  type: 'warning',
							  showCancelButton: true,
							  confirmButtonColor: '#9adbf9',
							  cancelButtonColor: '#b5bcbf',
							  confirmButtonText: '네!',
							  cancelButtonText: '아니오',
							 
							}).then(function () {
							  	
								self.location="/party/joinParty?partyNo=${party.partyNo}";
							 
							}) 
	  					
	  				}); 
				}else if(buttonFlag == 'ccap'){
					
					/* 애프터 파티 취소 버튼 */
		    		var cancelParty = "<button type='button' class='btn btn-info btn-block'>파티참여취소</button>"; 
		    		
		    		$("#partyButtonDiv").html(cancelParty).on("click", function() {
		    			
		    			swal({
		    				  title: '애프터 파티 취소!',
							  text: "파티 참여를 취소하시겠습니까?",
							  type: 'warning',
							  showCancelButton: true,
							  confirmButtonColor: '#9adbf9',
							  cancelButtonColor: '#b5bcbf',
							  confirmButtonText: '네!',
							  cancelButtonText: '아니오',
							 
							}).then(function () {
							  	
								self.location='/party/cancelParty?partyNo=${party.partyNo}'
							 
							}) 
							
					
		    			
					});
				}else if(buttonFlag == "p"){
					
					/* 파티 티켓 구매 버튼 */
		    		var purchaseTicket = "<button type='button' class='btn btn-info btn-block'>파티티켓구매</button>"
	    			
		    		$("#partyButtonDiv").html(purchaseTicket).on("click", function() {
					
						swal({
		  				  title: '파티 참여!',
							  text: "파티 티켓을 구매하시겠습니까?",
							  type: 'warning',
							  showCancelButton: true,
							  confirmButtonColor: '#9adbf9',
							  cancelButtonColor: '#b5bcbf',
							  confirmButtonText: '네!',
							  cancelButtonText: '아니오',
							 
							}).then(function () {
							  	
								self.location = '/purchase/addPurchase?partyNo=${party.partyNo}'
							 
							}) 
							
		    		});
		    		
				}else if(buttonFlag == "ccp"){
					
					/* 파티 참여 취소 버튼 */
		    		var cancelPurchase = "<button type='button' class='btn btn-info btn-block'>티켓구매취소</button>";
		    		var partyNo = $("#partyNo").val(); 
		    		
		    			
	    			/// ajax 호출 함수
	    			fncGetPurchaseNo(sessionId, partyNo); 
	    			/// 파티참여취소 버튼 클릭 시 바로 getPurchase로 이동
	    			$("#partyButtonDiv").html(cancelPurchase).on("click", function(){
	    			
						swal({
		  				  title: '파티 참여 취소!',
							  text: "파티 티켓 구매를 취소하시겠습니까?",
							  type: 'warning',
							  showCancelButton: true,
							  confirmButtonColor: '#9adbf9',
							  cancelButtonColor: '#b5bcbf',
							  confirmButtonText: '네!',
							  cancelButtonText: '아니오',
							 
							}).then(function () {
							  	
								self.location = "/purchase/getPurchase?purchaseNo="+purchaseNo;
							 
							}) 
							
	    			});
				}
			
			}else{
				
				/* 로그인 하지 않은 경우 */
				var defaultButton = "<button type='button' class='btn btn-info btn-block'>파티참여</button>";
				
				$("#partyButtonDiv").html(defaultButton).on("click", function(){
					console.log("로그인 후 이용 가능한 서비스 실행");
				
					swal({
						  title: '로그인 후 이용 가능',
						  text: "로그인하면 다양한 서비스를 이용할 수 있어요",	  
						  type: 'info',
						  confirmButtonColor: '#9adbf9',
						  confirmButtonText: 'ok',
						})
				});
			}
			
		}	
			
		
		//============= "파티멤버보기"  Event 처리 및  연결 =============
		$(function(){
				console.log(">>> getPartyMemberList.jsp 로딩.....");
				console.log("partyNo :: "+$("#partyNo").val());
				console.log("sessionId :: "+sessionId);
				
				
				console.log(">>> 파티 멤버 리스트 불러오기.....");
						
				$.ajax(
						{ url : "/partyRest/json/getPartyMemberList/${party.partyNo}",
						  method : "GET",
						  dataType : "json",
						  success : function(JSONData, status){
							  		console.log(status);
							 		console.log("JSONData : "+JSON.stringify(JSONData));
							  		
							  		for(i=0 ; i<JSONData.list.length ; i++){
							  			console.log("for문 안");
							  			
							  			/* 파티 멤버 리스트 출력*/
							  			var partyMemberList =/* "<p class='userDiv'>" */
							  								"<div class='row' id='userDiv'>"
															/* +"<div class='col-xs-2' id='userImage'>" */
															+"<div class='col-xs-2 userImageProfile' id='userImage'>"
																+"<img class='img-circle' src='/resources/uploadFile/"+JSONData.list[i].user.profileImage+"' width='50' height='50'>"
																/* +"<input type='hidden' id='userId' name='userId' value='"+JSONData.list[i].user.userId+"'>" */
																+"<input type='hidden' id='userId' name='userMemberId' value='"+JSONData.list[i].user.userId+"'>"
															+"</div>"
															+"<div class='col-xs-7' id='userNick'>"
															+JSONData.list[i].user.nickname
															+"</div>"
															+"<div class='col-xs-3' id='userRole'>"
														 	+JSONData.list[i].role 
															+"</div>"
															+"</div>"
															+"<hr>"
															/* +"</p>" */;
											
										$("form.form-horizontal-1").append(partyMemberList).find(".userImageProfile").on("click" , function() {	
											 //alert("click");
											 
											 //var userId = $('input[name=userId]', $(this)).val();
											 var userId = $(this).find('input[name=userMemberId]').val();
											alert(userId);
											
											self.location="/myPage/getMyPage?requestId="+userId;
									
										});
										console.log(partyMemberList);
										
										
							  		}
						  }
						});
					
			
				$.ajax(
						{ url : "/partyRest/json/getPartyMemberList/${party.partyNo}",
						  method : "GET",
						  dataType : "json",
						  success : function(JSONData, status){
							  		console.log(status);
							 		console.log("JSONData : "+JSON.stringify(JSONData));
							  		
							  		for(i=0 ; i<JSONData.list.length ; i++){
							  			console.log("for문 안");
							  			
							  			
							  			/* 파티 멤버 리스트 보기 버튼 */
										if(sessionId !=""){
											if (sessionId == JSONData.list[i].user.userId){
												/* 파티에 참여한 경우 */
												console.log("if문 안 파티 멤버 리스트 보기 실행");
									  			
								  				var getPartyMemberList = "<div class='hover01 column'>"
																		+"<div>"
																		+"<figure id='memberLock'><img src='../../resources/image/buttonImage/member_lock_icon.png' width='35%' height='35%' data-toggle='modal' data-target='#exampleModal'></figure>"
																		+"</div>"
																		+"</div>";			 
															 
											    $("#partyMemberListButtonDiv").html(getPartyMemberList);
											    console.log($("#partyMemberListButtonDiv").html(getPartyMemberList));
											    
											    return;
											    
											}else{
												
												/* 파티에 참여하지 않은 경우 */
												$("#memberLock").on("click", function(){
													
													if("${party.festival.festivalNo}" != ""){
														/* 애프터 파티 */
														console.log("애프터 파티 참여 후 이용 가능한 서비스 실행");
														swal({
															  title: '파티 참여 후 이용 가능한 서비스에요!',
															  text: "애프터 파티에 참여하시겠습니까?",
															  type: 'info',
															  showCancelButton: true,
															  confirmButtonColor: '#9adbf9',
															  cancelButtonColor: '#b5bcbf',
															  confirmButtonText: '네!',
															  cancelButtonText: '아니오' 
															})
															/* .then(function () {
															  	'Welcome!',
															    '애프터 파티에 참여하셨습니다.',
															    'success'
															    
															}) */
															.then(function () {
																self.location = '/party/joinParty?partyNo=${party.partyNo}'
															})
									  				}else{
									  					/*파티 */	
									  					console.log("파티 참여 후 이용 가능한 서비스 실행");
									  					swal({
															  title: '파티 참여 후 이용 가능한 서비스에요!',
															  text: "파티에 참여하시겠습니까?",
															  type: 'info',
															  showCancelButton: true,
															  confirmButtonColor: '#9adbf9',
															  cancelButtonColor: '#b5bcbf',
															  confirmButtonText: '네!',
															  cancelButtonText: '아니오' 
															}).then(function () {
															  
																self.location = '/purchase/addPurchase?partyNo=${party.partyNo}'
															 
															})
									  				}
												});
												
											}
													
										}else{
											/* 로그인 하지 않은 경우 */
											$("#memberLock").on("click", function(){
												console.log("로그인 후 이용 가능한 서비스 실행");
											
												swal({
													  title: '파티 멤버 리스트',
													  text: "로그인 후 이용할 수 있어요!",	  
													  type: 'info',
													  confirmButtonColor: '#9adbf9',
													  confirmButtonText: 'ok',
													})
											});
										}
										
										
							  		}//for문
						  }
						});
				
				var buttonFlag = 'df';
				$.ajax(
						{ url : "/partyRest/json/getPartyMemberList/${party.partyNo}",
						  method : "GET",
						  dataType : "json",
						  success : function(JSONData, status){
							  		console.log(status);
							 		console.log("JSONData : "+JSON.stringify(JSONData));
							  		
							  		for(i=0 ; i<JSONData.list.length ; i++){
							  			console.log("for문 안");
							  			
							  			if(sessionId != "${party.user.userId}"){
							  				/* 애프터 파티 */
							  				if("${party.festival.festivalNo}" != ""){
										   		console.log("애프터 파티 참여 버튼");	
									  			buttonFlag = 'ap';
									  			console.log('buttonFlag ==> '+buttonFlag);
								  				
							  						
						  						if(sessionId == JSONData.list[i].user.userId){	
						  							console.log("애프터 파티 참여 취소 버튼");
						  							
							  						buttonFlag = 'ccap';
													console.log('buttonFlag ==> '+buttonFlag);
										    		break;
							  					
							  					}
										    	    
										    /* 파티 */		
										    }else if("${party.festival.festivalNo}" == ""){
										    		
										    	if(sessionId != JSONData.list[i].user.userId){	
										    		
										    		console.log("파티 티켓 구매 버튼");
										    		
										    			buttonFlag = 'p';
														console.log('buttonFlag ==> '+buttonFlag);
													
													
										    		
										    	}else if(sessionId == JSONData.list[i].user.userId){
										    		
										    		console.log("파티 참여 취소 버튼");
										    		
										    		buttonFlag = 'ccp';
									    			console.log('buttonFlag ==> '+buttonFlag);
										    		break;
										    		
										    	}
										    	
										    } //else if문 end
										    
							  			}  
							  			
							  		} //for문 end
									
							  		fncButtonHtml(buttonFlag);
							  		
							  		/*현채 참여중인 파티 인원*/
									var currentMemberCount = "&nbsp;&nbsp;&nbsp;&nbsp;MOANA 회원 중&nbsp;<strong>"+JSONData.currentMemberCount+"</strong> 명 참여중";
																						
									$("#currentMemberCountDiv").html(currentMemberCount); 
		
							} // success function end
						}); // ajax end
						
		});
		
		
		
		//============= "주최자"  Event 처리 및  연결 =============
		$(function(){
			 $(".userImageProfile" ).each(function(){}).on("click" , function() {	
				 alert("click");
			 
				 var userId = $('input[name=userId]', $(this)).val();
			
				
				self.location="/myPage/getMyPage/"+"${user.userId}";
		
			});
		});
		
	
		//============= "그룹 채팅"  Event 처리 및  연결 =============
		/* function groupChatPopup(frm) {
			
			var url = "/chat/getGroupChatting";
			var title = "groupChatPop";
			var status = "toolbar=no,directories=no,scrollbars=yes,resizable=yes,status=no,menubar=no,width=440, height=520, top=0,left=20";
			window.open("", title, status); //window.open(url,title,status); window.open 함수에 url을 앞에와 같이
			//인수로  넣어도 동작에는 지장이 없으나 form.action에서 적용하므로 생략
			//가능합니다.
			frm.target = title; //form.target 이 부분이 빠지면 form값 전송이 되지 않습니다. 
			frm.action = url; //form.action 이 부분이 빠지면 action값을 찾지 못해서 제대로 된 팝업이 뜨질 않습니다.
			frm.method = "post";
			frm.submit();
		} */
		
		$(function(){
			
		
			$("#groupChat").on("click", function() {
				var url = "/chat/getGroupChatting";
				var title = "groupChatPop";
				var status = "toolbar=no,directories=no,scrollbars=yes,resizable=yes,status=no,menubar=no,width=440, height=520, top=0,left=20";
				window.open("", title, status); //window.open(url,title,status); window.open 함수에 url을 앞에와 같이
				//인수로  넣어도 동작에는 지장이 없으나 form.action에서 적용하므로 생략
				//가능합니다.
				frm.target = title; //form.target 이 부분이 빠지면 form값 전송이 되지 않습니다. 
				frm.action = url; //form.action 이 부분이 빠지면 action값을 찾지 못해서 제대로 된 팝업이 뜨질 않습니다.
				frm.method = "post";
				frm.submit();
			});
			
		})
	</script> 
	
  

<!--  화면구성 div Start /////////////////////////////////////-->
<!-- Button trigger modal -->
<!-- <div class="col-md-offset-4 col-md-4" id="partyMemberListButtonDiv"></div> -->


<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
        <h1 class="modal-title text-center" id="exampleModalLabel" >${ party.partyName }</h1>
        <div><h4 align="center">현재 파티에 참여중인 멤버 리스트에요!</h4></div>
        
        <!-- 파티 그룹 채팅 -->
        <form name="form">
			<input type="hidden" name="partyNo" value="${party.partyNo}">
			<input type="hidden" name="sender" value="${user.userId}">
			<!-- <button type='button' class='btn-sm btn-default pull-right'
				onclick="javascript:groupChatPopup(this.form);">채팅하기</button> -->
				<figure id="groupChat" class="text-right">
					<img src='../../resources/image/chat/chat-bubble-icon.png' width='10%' height='10%' >
				</figure>
		</form>
        
        
      </div>
      <div class="modal-body">
        <form class="form-horizontal-1" enctype="multipart/form-data">
			
			
		</form>
      </div>
      <div class="footer" align="center">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div> 
	
		 