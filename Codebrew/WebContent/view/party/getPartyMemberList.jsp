 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript"> 
	
		//============= "파티멤버보기"  Event 처리 및  연결 =============
		$(function(){
			/* $("button:contains('파티멤버보기')").on("click", function() { */
				console.log("파티멤버보기 버튼 클릭.....");
				console.log("partyNo :: "+$("#partyNo").val());
				
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
							  		console.log("JSONData.list : "+JSONData.list);
							  		
							  		for(i=0 ; i<JSONData.list.length ; i++){
						  			var html = "<div class='row' id='user'>"
													+"<input type='hidden' id='userId' name='userId' value='"+JSONData.list[i].user.userId+"'>"
													+"<span>"
														+"<img class='rounded-circle' src='/resources/uploadFile/"+JSONData.list[i].user.profileImage+"' width='40' height='40'>"
													+"</span>"
													+"<span>"
													+JSONData.list[i].user.nickname+"&nbsp;"+"( "+JSONData.list[i].user.userId+" )"
													+"</span>"
													+"<span>"
													if(JSONData.list[i].role='host'){
														+"<strong>host</strong>"	
													}
													+"</span>"
												+"</div>"
																  			
												
						  			$("form.form-horizontal-1").html(html); 
							  		}			
							  		
									var currentMemberCount = "${party.partyMemberLimit} 명 중 "+JSONData.currentMemberCount+" 명 참여중";
									
									$("#currentMemberCountDiv").html(currentMemberCount); 
							  		
						  }
				
						});
			/* }); */
		});
		
		
	</script> 
	
	
<!-- Button trigger modal -->
<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal">
 	파티멤버보기
</button>    

<!--  화면구성 div Start /////////////////////////////////////-->
<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
        <h1 class="modal-title" id="exampleModalLabel" align="center">파티 멤버</h1>
        <div><h4 align="center">${ partyMember.party.partyName }</h4></div>
        
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
	
	