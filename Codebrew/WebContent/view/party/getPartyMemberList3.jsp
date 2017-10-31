
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
			$("button:contains('파티멤버보기')").on("click", function() {
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
										
							  		}
						  }
										
				});
				
			});
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
	
	