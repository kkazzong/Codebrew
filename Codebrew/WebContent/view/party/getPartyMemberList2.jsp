 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript"> 
	
		//============= "파티멤버보기"  Event 처리 및  연결 =============
		$(function(){
			/* $("button:contains('파티멤버보기')").on("click", function() { */
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
								  		var partyMemberList = "<div class='row' id='userDiv'>"
															+"<input type='hidden' id='userId' name='userId' value='"+JSONData.list[i].user.userId+"'>"
															+"<span>"
																+"<img class='rounded-circle' src='/resources/uploadFile/"+JSONData.list[i].user.profileImage+"' width='40' height='40'>"
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
															+"</div>";
											
										$("form.form-horizontal-1").append(partyMemberList); 
										console.log(partyMemberList);
										
										
							  			if (sessionId == JSONData.list[i].user.userId){
							  				console.log("if문 안");
								  			
							  				/* 파티 멤버 리스트 보기 버튼 */
											var getPartyMemberList = "<button type='button' class='btn btn-primary btn-block' data-toggle='modal' data-target='#exampleModal'>"
														 +"파티멤버보기"
														 +"</button>";
														 
										    //$("#partyMemberListButtonDiv").html(button);
										    $("#partyMemberListButtonDiv").append(getPartyMemberList);
										    
										    console.log(getPartyMemberList);
										    
										    /*파티 참여 취소 버튼 */
										    if(sessionId != "${party.user.userId}"){
										    	console.log("if문 안 파티 참여 취소 버튼");
										    	
										    	if("${party.festival.festivalNo}" != ""){
										    		
										    		/* 애프터 파티 취소 버튼 */
										    		var cancelParty = "<button type='button' class='btn btn-primary btn-block'>파티참여취소</button>";
										    		
										    		$("#partyButtonDiv").html(cancelParty);
										    		
										    	}else if("${party.festival.festivalNo}" == ""){
										    		
										    		/* 파티 취소 버튼 */
										    		var cancelPurchase = "<button type='button' class='btn btn-primary btn-block'>티켓구매취소</button>";
										    		
										    		$("#partyButtonDiv").html(cancelPurchase);
										    	}
										    }
										    
							  			}else if(sessionId != JSONData.list[i].user.userId) {
							  				console.log("else if문 안");
							  				if("${party.festival.festivalNo}" != ""){
							  				//if( ${ !empty party.festival.festivalNo } ){	
							  					console.log("else if문 안 애프터 파티 참여 버튼");	
							  					
							  					/* 애프터 파티 참여 버튼 */
							  					var joinParty = "<button type='button' class='btn btn-primary btn-block'>애프터파티 참여</button>"
							  					
							  					$("#partyButtonDiv").html(joinParty);
							  				}
							  				
							  				
							  				
							  			}						  			
										
							  		}			
							  		
									var currentMemberCount = "${party.partyMemberLimit} 명 중 "+JSONData.currentMemberCount+" 명 참여중";
																						
									$("#currentMemberCountDiv").html(currentMemberCount); 
							  		
						  }
				
						});
			/* }); */
			
			
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
<div id="partyMemberListButtonDiv"></div>

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
	
	