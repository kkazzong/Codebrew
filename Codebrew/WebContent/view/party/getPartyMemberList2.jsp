
 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript"> 
	
		var sessionId = "${user.userId}";
	
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
							  			var partyMemberList = "<div class='row' id='userDiv'>"
															+"<input type='hidden' id='userId' name='userId' value='"+JSONData.list[i].user.userId+"'>"
															+"<span>"
																+"<img class='img-circle' src='/resources/uploadFile/"+JSONData.list[i].user.profileImage+"' width='50' height='50'>"
															+"</span>"
															+"<span>"
															+JSONData.list[i].user.nickname+"&nbsp;"+"( "+JSONData.list[i].user.userId+" )"
															+"</span>"
															+"<span>"
															//if(JSONData.list[i].role = 'host'){
																+"<c:if test='"+JSONData.list[i].role+"==host'>"
																+"<strong>host</strong>"	
																+"</c:if>"
															//}
															+"</span>"
															+"</div>"
															+"<hr/>";
											
										$("form.form-horizontal-1").append(partyMemberList); 
										console.log(partyMemberList);
										
										
							  			if (sessionId == JSONData.list[i].user.userId){
							  				console.log("if문 안 파티 멤버 리스트 보기 버튼");
								  			
							  				/* 파티 멤버 리스트 보기 버튼 */
											var getPartyMemberList = "<button type='button' class='btn btn-primary btn-block' data-toggle='modal' data-target='#exampleModal'>"
														 +"파티멤버보기"
														 +"</button>";
														 
										    //$("#partyMemberListButtonDiv").html(button);
										    $("#partyMemberListButtonDiv").append(getPartyMemberList);
										    
										    console.log(getPartyMemberList);
										 
							  			}
							  			
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
														
										    			self.location="/party/cancelParty/${party.partyNo}";
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
														
									    				self.location="/purchase/addPurchase?partyNo=${party.partyNo}";
									    				
									    				/* var result = confirm("파티 티켓을 구매하시겠습니까?");
														
														if(result) {
															var partyNo = $("#partyNo").val();
															console.log("파티티켓구매 :: partyNo :: "+partyNo);
															
															self.location="/purchase/addPurchase?partyNo=${party.partyNo}";
														} else {
															return;
														} */
													
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
										    		
										    		
										    	}
										    	
										    } //else if문 end
										    
							  			}  
							  			
							  		} //for문 end
				
									var currentMemberCount = "&nbsp;&nbsp;&nbsp;&nbsp;"+JSONData.currentMemberCount+" 명 참여중";
																						
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
		
	
		
	</script> 
	
  

<!--  화면구성 div Start /////////////////////////////////////-->
<!-- Button trigger modal -->
<div class="col-md-offset-4 col-md-4" id="partyMemberListButtonDiv"></div>

<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
        <h1 class="modal-title" id="exampleModalLabel" align="center">파티 멤버</h1>
        <div><h4 align="center">${ party.partyName }</h4></div>
        
      </div>
      <div class="modal-body">
        <form class="form-horizontal-1" enctype="multipart/form-data">
			
			
		</form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div> 
	
	