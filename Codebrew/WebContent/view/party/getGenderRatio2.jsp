<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- sweet alert -->
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.11.2/sweetalert2.all.min.js"></script>
	<!-- Include a polyfill for ES6 Promises (optional) for IE11 and Android browser -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/core-js/2.4.1/core.js"></script>
	
<!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript"> 
		
		//============= "파티 비율 확인하기"  Event 처리 및  연결 =============
		$(function(){
			$("#ratioLock").on("click", function() {
				//self.location="/partyRest/json/getGenderRatio/${party.partyNo}";
				console.log("파티 비율 확인하기 버튼 클릭.....");
				var partyNo = $("#partyNo").val();
				console.log("partyNo :: "+partyNo);
				
					$.getJSON( "/partyRest/json/getGenderRatio/"+partyNo,
								//{ partyNo : $("#partyNo").val() },
								function(JSONData, status){
									console.log(status);
									console.log("JSONData : "+JSON.stringify(JSONData));
									
									console.log("JSONData.femalePercentage : "+JSONData.femalePercentage);
									console.log("JSONData.femaleAgeAverage : "+JSONData.femaleAgeAverage);
									console.log("JSONData.malePercentage : "+JSONData.malePercentage);
									console.log("JSONData.maleAgeAverage : "+JSONData.maleAgeAverage);
									console.log("JSONData.partyName : "+JSONData.partyName);
									
									var html =  "<div><h1 align='center'>"+JSONData.partyName+"</h1></div>"
												+"<div>여자 비율 "+JSONData.femalePercentage+"%</div>"
												+"<div>여자 나이 평균 "+JSONData.femaleAgeAverage+"살</div>"
												+"<hr>"
												+"<div>남자 비율 "+JSONData.malePercentage+"%</div>"
												+"<div>남자 나이 평균"+JSONData.maleAgeAverage+"살</div>";
									swal({
									//$("form.form-horizontal-2").html(html);
										title: '회원님의 코코넛을 이용하여 참여자 비율을 확인하시겠습니까?',
										  text: "확인시 코코넛 3개 차감!",
										  type: 'warning',
										  //showCancelButton: true,
										  confirmButtonColor: '#3085d6',
										  cancelButtonColor: '#d33',
										  confirmButtonText: '확인',
										  cancelButtonText: '취소',
										  showLoaderOnConfirm: true,
										  preConfirm : function(){
											  return new Promise(function(resolve, reject) {
												  
												  $.ajax({
														
														url : "/userRest/json/updateCoconut/1",
														mehtod : "POST",
														headers : {
															"Accept" : "application/json",
															"Content-Type" : "application/json"
														},
														dataType : "json",
														
												}).done(function(JSONData){
													if(JSONData.message != null) {
														resolve();
														swal({
															  html: html
														  })
													} else {
														reject('Error!');
													}
												})
												  
											 });
											  
										  }
										
								}); // ajax
							
							
					
						});
				});
		});	
		
	</script> 
	
	<div id="chartdiv"></div>		
	   
<!--  화면구성 div Start /////////////////////////////////////-->

<!-- Button trigger modal -->
<!-- <div class="col-md-offset-4 col-md-4 text-center" > -->
	<!-- <button type="button" class="btn btn-primary btn-block" data-toggle="modal" data-target="#exampleModal2">
	  확인하기
	</button> -->
	<!-- <img src="../../resources/image/buttonImage/ratio_lock_icon.png" width="20%" height="20%" data-toggle="modal" data-target="#exampleModal2"> -->
	
	
	
<!-- </div> -->

<!-- Modal -->
<!-- <div class="modal fade" id="exampleModal2" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">파티 성별 비율</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <form class="form-horizontal-2" enctype="multipart/form-data">
			
			
			
		</form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div> -->
	
