<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript"> 
	
		var sessionId = "${user.userId}";
		
		var purchaseNo;
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
	
		
		//============= "파티멤버보기"  Event 처리 및  연결 =============
		$(function(){
			
			
			
			/* $("button:contains('파티멤버보기')").on("click", function() { */
				console.log("파티멤버보기 버튼 클릭.....");
				console.log("partyNo :: "+$("#partyNo").val());
				
				console.log("sessionId :: "+sessionId);
				/* var searchCondition = $(".form-control[name=searchCondition]").val();
				var searchKeyword = $(".form-control[name=searchKeyword]").val(); */
				
				
				//============= "파티멤버보기"  Event 처리 및  연결 =============
				$(function(){
					/* $("button:contains('파티멤버보기')").on("click", function() {  */
						console.log("파티멤버보기 버튼 클릭.....");
						console.log("partyNo :: "+$("#partyNo").val());
						
						var sessionId = "${user.userId}";
						console.log("sessionId :: "+sessionId);
						/* var searchCondition = $(".form-control[name=searchCondition]").val();
						var searchKeyword = $(".form-control[name=searchKeyword]").val(); */
						
						$.ajax(
								{ url : "/partyRest/json/getPartyMemberList/${party.partyNo}",
								  method : "GET",
								  /* data : { searchCondition : searchCondition, 
								  		   searchKeyword : searchKeyword,
								  		   currentPage : currentPage}, */
								  dataType : "json",
								  success : function(JSONData, status){
									  		console.log(status);
									 		console.log("JSONData : "+JSON.stringify(JSONData));
									  		
									  		for(i=0 ; i<JSONData.list.length ; i++){
									  			console.log("for문 안");
									  			
									  			
									  			/* 파티 멤버 리스트 */
									  			var partyMemberList ="<p>"
									  								+"<div class='row' id='userDiv'>"
																	+"<input type='hidden' id='userId' name='userId' value='"+JSONData.list[i].user.userId+"'>"
																	+"<div class='col-xs-2' id='userImage'>"
																		+"<img class='img-circle' src='/resources/uploadFile/"+JSONData.list[i].user.profileImage+"' width='50' height='50'>"
																	+"</div>"
																	+"<div class='col-xs-7' id='userNick'>"
																	+JSONData.list[i].user.nickname+"&nbsp;"+"( "+JSONData.list[i].user.userId+" )"
																	+"</div>"
																	+"<div class='col-xs-3' id='userRole'>"
																 	+JSONData.list[i].role 
																	//if(role.indexOf('host') != -1){
																		 //+"<c:if test='${"+role+"== host}'>" 
																		//+JSONData.list[i].role	
																		//+"</c:if>" 
																	//}
																	+"</div>"
																	
																	+"</div>"
																	+"<hr>"
																	+"</p>";
													
												$("form.form-horizontal-1").append(partyMemberList); 
												console.log(partyMemberList);
												
												/* 파티 멤버 리스트 보기 버튼 */
												if (sessionId == JSONData.list[i].user.userId){
									  				console.log("if문 안 파티 멤버 리스트 보기 버튼");
										  			
									  				/* 파티 멤버 리스트 보기 버튼 */
													/* var getPartyMemberList = "<button type='button' class='btn btn-primary btn-block' data-toggle='modal' data-target='#exampleModal'>"
																 +"파티멤버보기"
																 +"</button>"; */
																 
													var getPartyMemberList = "<div class='hover01 column'>"
																			+"<div>"
																			+"<figure id='memberLock'><img src='../../resources/image/buttonImage/member_lock_icon.png' width='35%' height='35%' data-toggle='modal' data-target='#exampleModal'></figure>"
																			+"</div>"
																			+"</div>"			 
																 
												    $("#partyMemberListButtonDiv").html(getPartyMemberList);
												    
												    console.log(getPartyMemberList);
												    
												    
												 
									  			}
									  		}
								  }
								});
					/* }); */
				});
				
				
				$.ajax(
						{ url : "/partyRest/json/getPartyMemberList/${party.partyNo}",
						  method : "GET",
						  /* data : { searchCondition : searchCondition, 
						  		   searchKeyword : searchKeyword,
						  		   currentPage : currentPage}, */
						  dataType : "json",
						  success : function(JSONData, status){
							  		console.log(status);
							 		console.log("JSONData : "+JSON.stringify(JSONData));
							  		
							  		for(i=0 ; i<JSONData.list.length ; i++){
							  			console.log("for문 안");
							  			
							  			if(sessionId != "${party.user.userId}"){
							  				/* 애프터 파티 */
							  				if("${party.festival.festivalNo}" != ""){
										   		
							  					//if(sessionId != JSONData.list[i].user.userId){
							  							
							  						console.log("애프터 파티 참여 버튼");	
									  					
									  				/* 애프터 파티 참여 버튼 */
									  				var joinParty = "<button type='button' class='btn btn-primary btn-block' id='afterPartyBtn'>애프터파티 참여</button>"
									  					
									  				$("#partyButtonDiv").html(joinParty).on("click", function() {
									  					//alert("참여");
									  					self.location="/party/joinParty?partyNo=${party.partyNo}";
									  				});
							  						
						  						//}else if(sessionId == JSONData.list[i].user.userId){
							  					if(sessionId == JSONData.list[i].user.userId){	
						  							console.log("애프터 파티 참여 취소 버튼");
						  							
							  						/* 애프터 파티 취소 버튼 */
										    		var cancelParty = "<button type='button' class='btn btn-primary btn-block'>파티참여취소</button>";
										    		
										    		$("#partyButtonDiv").html(cancelParty).on("click", function() {
														
										    			self.location="/party/cancelParty?partyNo=${party.partyNo}";
										    			/* $.ajax(
																{ url : "/partyRest/json/cancelParty/${party.partyNo}",
																  method : "GET",
																  dataType : "json",
																  success : function(JSONData, status){
																	  		console.log(status);
																	 		console.log("JSONData : "+JSON.stringify(JSONData));
																  }
																}
														); */
													});
										    		
										    		return;
							  					
							  					}
										    	    
										    /* 파티 */		
										    }else if("${party.festival.festivalNo}" == ""){
										    		
										    	if(sessionId != JSONData.list[i].user.userId){	
										    		
										    		console.log("파티 티켓 구매 버튼");
										    		
										    		/* 파티 티켓 구매 버튼 */
										    		var purchaseTicket = "<button type='button' class='btn btn-primary btn-block'>파티티켓구매</button>"
									    			
										    		$("#partyButtonDiv").html(purchaseTicket).on("click", function() {
									    				//self.location="/purchase/addPurchase?partyNo=${party.partyNo}";
									    				
									    				//var result = confirm("파티 티켓을 구매하시겠습니까?");
														
														//if(result) {
															var partyNo = $("#partyNo").val();
															console.log("파티티켓구매 :: partyNo :: "+partyNo);
															
															self.location="/purchase/addPurchase?partyNo=${party.partyNo}";
														//} else {
														//	return;
														//} 
													
													});
										    		
										    	}else if(sessionId == JSONData.list[i].user.userId){
										    		
										    		console.log("파티 참여 취소 버튼");
										    		
										    		/* 파티 참여 취소 버튼 */
										    		var cancelPurchase = "<button type='button' class='btn btn-primary btn-block'>티켓구매취소</button>";
										    		
										    		/* $("#partyButtonDiv").html(cancelPurchase).on("click", function() {
														
															var partyNo = $("#partyNo").val();
															console.log("파티참여취소 :: partyNo :: "+partyNo);
														
															self.location="/purchase/getPurchaseList";
														
													}); */
										    		
										    		
										    		//$(function(){
										    			
										    			//var sessionId = "${user.userId}";
										    			var partyNo = $("#partyNo").val();
										    			//var partyNo = 10087; //일단 테스트를 위해
										    			
										    			/// ajax 호출 함수
										    			fncGetPurchaseNo(sessionId, partyNo);
										    			/// 파티참여취소 버튼 클릭 시 바로 getPurchase로 이동
										    			$("#partyButtonDiv").html(cancelPurchase).on("click", function(){
										    				self.location = "/purchase/getPurchase?purchaseNo="+purchaseNo;
										    			});
										    		//});
										    		break;
										    		
										    	}
										    	
										    } //else if문 end
										    
							  			}  
							  			
							  		} //for문 end
				
									var currentMemberCount = "&nbsp;&nbsp;&nbsp;&nbsp;MOANA 회원 중&nbsp;<strong>"+JSONData.currentMemberCount+"</strong> 명 참여중";
																						
									$("#currentMemberCountDiv").html(currentMemberCount); 
		
							} // success function end
						}); // ajax end
						
		});
		
		
		
		//============= "주최자"  Event 처리 및  연결 =============
		$(function(){
			$("#userDiv").on("click", function() {
				self.location="/myPage/getMyPage/"+"${user.userId}";
		
			});
		});
		
	
		//============= "그룹 채팅"  Event 처리 및  연결 =============
		function groupChatPopup(frm) {
			
			var url = "/chat/getGroupChatting";
			var title = "groupChatPop";
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
        <div><h4 align="center">파티 멤버</h4></div>
        
        <!-- 파티 그룹 채팅 -->
        <form name="form">
			<input type="hidden" name="partyNo" value="${party.partyNo}">
			<input type="hidden" name="sender" value="${user.userId}">
			<button type='button' class='btn-sm btn-default pull-right'
				onclick="javascript:groupChatPopup(this.form);">채팅하기</button>
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
	
		 