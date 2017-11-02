 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript"> 
	
		/* var sessionId = "${user.userId}";
		var festivalNo = "${party.festival.festivalNo}";
		var partyNo = "${party.partyNo}";
		var list = eval("${list}"); */
		
		//$(function(){
			 
// 			for( i=0 ; i<eval(list).length ; i++){
// 				if(sessionId != list.user.userId){
// 					/* 애프터 파티 */
// 					if("${party.festival.festivalNo}" != ""){
			   		
// 						//if(sessionId != JSONData.list[i].user.userId){
								
// 							console.log("애프터 파티 참여 버튼");	
		  					
// 		  				/* 애프터 파티 참여 버튼 */
// 		  				var joinParty = "<button type='button' class='btn btn-primary btn-block' id='afterPartyBtn'>애프터파티 참여</button>"
		  					
// 		  				$("#partyButtonDiv").html(joinParty).on("click", function() {
// 		  					//alert("참여");
// 		  					self.location="/party/joinParty?partyNo=${party.partyNo}";
// 		  				});
							
// 						//}else if(sessionId == JSONData.list[i].user.userId){
// 						if(sessionId == list.user.userId){	
// 							console.log("애프터 파티 참여 취소 버튼");
							
// 							/* 애프터 파티 취소 버튼 */
// 				    		var cancelParty = "<button type='button' class='btn btn-primary btn-block'>파티참여취소</button>";
				    		
// 				    		$("#partyButtonDiv").html(cancelParty).on("click", function() {
								
// 				    			self.location="/party/cancelParty/${party.partyNo}";
				    			
// 							});
			    		
// 			    			return;
						
// 						}
			    	    
// 				    /* 파티 */		
// 				    }else if("${party.festival.festivalNo}" == ""){
				    		
// 				    	if(sessionId != list.user.userId){	
				    		
// 				    		console.log("파티 티켓 구매 버튼");
				    		
// 				    		/* 파티 티켓 구매 버튼 */
// 				    		var purchaseTicket = "<button type='button' class='btn btn-primary btn-block'>파티티켓구매</button>"
				    		
// 			    			$("#partyButtonDiv").html(purchaseTicket).on("click", function() {
								
// 			    				self.location="/purchase/addPurchase?partyNo=${party.partyNo}";
			    				
// 			    			});
				    		
// 				    	}else if(sessionId == list.user.userId){
				    		
// 				    		console.log("파티 참여 취소 버튼");
				    		
// 				    		/* 파티 참여 취소 버튼 */
// 				    		var cancelPurchase = "<button type='button' class='btn btn-primary btn-block'>티켓구매취소</button>";
				    		
// 				    		/// ajax 호출 함수
// 			    			fncGetPurchaseNo(sessionId, partyNo);
			    			
// 			    			/// 파티참여취소 버튼 클릭 시 바로 getPurchase로 이동
// 			    			$("#partyButtonDiv").html(cancelPurchase).on("click", function(){
// 			    				self.location = "/purchase/getPurchase?purchaseNo="+purchaseNo;
// 			    			});
				    		
// 				    	}
				    	
// 				    } //else if문 end
			    
// 				}  
				
// 				}
				
				//}); //each문 end
		
		//});
		
		
		//============= "파티수정"  Event 연결 =============
		$(function(){
			$("button:contains('파티수정')").on("click", function() {
				console.log($( "td.ct_btn01:contains('파티수정')" ).html());
				
				var partyFlag = $( "input[name=partyFlag]", $(this) ).val();
				
				self.location="/party/updateParty?partyNo=${party.partyNo}&partyFlag="+partyFlag;
		
			});
		});
		
		
		//============= "파티티켓구매"  Event 처리 및  연결 =============
		$(function(){
			$("button:contains('파티티켓구매')").on("click", function() {
		
					var result = confirm("파티 티켓을 구매하시겠습니까?");
					
					if(result) {
						var partyNo = $("#partyNo").val();
						console.log("파티티켓구매 :: partyNo :: "+partyNo);
						
						self.location="/purchase/addPurchase?partyNo=${party.partyNo}";
					} else {
						return;
					}
				
			});
		});
		
		
		//============= "티켓 구매 취소"  Event 처리 및  연결 =============
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
		
		$(function(){
			/// ajax 호출 함수
			fncGetPurchaseNo(sessionId, partyNo);
			
			$("#getPurchase").on("click", function(){
				self.location = "/purchase/getPurchase?purchaseNo="+purchaseNo;
			});
		});
		
		
		
		//============= "애프터파티 참여"  Event 처리 및  연결 =============
		$(function(){
			$("button:contains('애프터파티 참여')").on("click", function() {
				alert("참여");
				var result = confirm("애프터 파티에 참여하시겠습니까?");
				
				if(result) {
					var partyNo = $("#partyNo").val();
					console.log("애프터파티 참여 :: partyNo :: "+partyNo);
					
					self.location="/party/joinParty?partyNo=${party.partyNo}";
				} else {
					return;
				}
				
			});
		});
		
		
		//============= "파티참여취소"  Event 처리 및  연결 =============
		$(function(){
			$("button:contains('파티참여취소')").on("click", function() {
				
				var result = confirm("파티참여를 취소하시겠습니까?");
				
				if(result) {
					
					var partyNo = $("#partyNo").val();
					console.log("파티참여취소 :: partyNo :: "+partyNo);
				
					var festivalNo = $("#festival.festivalNo").val();
					console.log("파티참여취소 :: festivalNo :: "+festivalNo);
					
					if(festivalNo != null){
						
						self.location="/party/cancelParty?partyNo=${party.partyNo}";
					}else{
						
						self.location="/party/cancelParty?partyNo=${party.partyNo}";
					}
					
					
	    		} else {
					return;
				}
				
		
			});
		});
	
		
		
	</script> 
	
  

<!--  화면구성 div Start /////////////////////////////////////-->
	<span id="partyButtonDiv"></span>	
	
	<!-- 파티 & 애프터 파티 -->
	<c:if test="${ party.user.userId==user.userId }">
		<button type="button" class="btn btn-primary btn-block" id='updateParty'>파티수정</button>
	</c:if>
	
	
	<c:set var="i" value="0" />
	<c:set var="doneLoop" value="false"/> 
	<c:forEach var="partyMember" items="${list}">
		<c:set var="i" value="${i+1}"/>
		
		<c:if test="${user.userId == partyMember.user.userId}">
			파티 멤버 리스트 보기 버튼
			<button type='button' class='btn btn-primary btn-block' data-toggle='modal' data-target='#exampleModal'>파티멤버보기</button>
		</c:if>
			
		<c:if test="${user.userId != party.user.userId}">	
			
<%-- 			<c:choose> --%>
				
<%-- 				<c:when test="${party.festival.festivalNo != ''}"> --%>
<%-- 					<c:choose> --%>
<%-- 					<c:when test="${user.userId != partyMember.user.userId}"> --%>
<!--   						<button type='button' class='btn btn-primary btn-block' id='joinParty'>애프터파티 참여</button> -->
<%-- 					</c:when> --%>
<%--   					<c:when test="${user.userId == partyMember.user.userId}"> --%>
<!--   						<button type='button' class='btn btn-primary btn-block' id='cancelParty'>파티참여취소</button> -->
<%--   					</c:when> --%>
<%--   					</c:choose> --%>
<%-- 				</c:when> --%>
				
				
<%-- 		    	<c:when test="${party.festival.festivalNo == ''}"> --%>
<%-- 		    		<c:choose> --%>
<%-- 		    		<c:when test="${user.userId != partyMember.user.userId}"> --%>
			    		
<!-- 			    		<button type='button' class='btn btn-primary btn-block' id='addPurchase'>파티티켓구매</button> -->
<%-- 		    		</c:when>	 --%>
			    		
<%-- 			    	<c:when test="${user.userId == partyMember.user.userId}"> --%>
			    		
<!-- 			    		<button type='button' class='btn btn-primary btn-block' id='getPurchase'>티켓구매취소</button> -->
<%-- 			    	</c:when> --%>
<%-- 			    	</c:choose>	 --%>
<%-- 		    	</c:when> --%>
<%-- 			</c:choose> --%>
			
			
			
			<!-- 애프터 파티 -->
			<c:if test="${party.festival.festivalNo != ''}">
				<!-- 애프터 파티 참여 버튼 -->
  				<button type='button' class='btn btn-primary btn-block' id='joinParty'>${ user.userId == partyMember.user.userId? '파티참여취소' : '애프터파티 참여'}</button> 
  				<!-- <button type='button' class='btn btn-primary btn-block' id='joinParty'>애프터파티 참여</button> -->
  			
				<%-- <c:if test="${user.userId == partyMember.user.userId}">	
					<!-- 애프터 파티 취소 버튼 --> 
		    		<button type='button' class='btn btn-primary btn-block' id='cancelParty'>파티참여취소</button>
		    		
				</c:if> --%>
			</c:if>	 	    
		    <!-- 파티 -->		
		    <c:if test="${party.festival.festivalNo == ''}">
		   
		    	<c:if test="${user.userId != partyMember.user.userId}">
		    		<!-- 파티 티켓 구매 버튼  -->
		    		<button type='button' class='btn btn-primary btn-block' id='addPurchase'>파티티켓구매</button>
		    		
	    		</c:if>	
		    		
		    	<c:if test="${user.userId == partyMember.user.userId}">
		    		<!-- 파티 참여 취소 버튼 -->
		    		<button type='button' class='btn btn-primary btn-block' id='getPurchase'>티켓구매취소</button>
		    	
		    	</c:if>	
		    		
		    </c:if>
		</c:if>  
	</c:forEach> 


<%-- 							<c:set var="i" value="0" /> --%>
<%-- 							<c:set var="break" value="false"/> --%>
<%-- 							<c:forEach var="partyMember" items="${list}"> --%>
<%-- 								<c:set var="i" value="${ i+1 }" /> --%>
<!-- 								console.log("애프터 파티 버튼 구간 2"); -->
<%-- 								<c:if test="${ break != true }"> --%>
								
<%-- 								<c:choose> --%>
									
<%-- 									<c:when test="${ partyMember.user.userId==user.userId && partyMember.role=='guest'}"> --%>
									
<%-- 									<c:if test="${ partyMember.user.userId==user.userId }">	 --%>
<!-- 										console.log("애프터 파티 버튼 구간 3"); -->
<!-- 										<button type="button" class="btn btn-primary">파티참여취소</button> -->
<%-- 										<c:set var="break" value="true" /> --%>
<%-- 									</c:if> --%>
<%-- 									</c:when> --%>
<%-- 									<c:when test="${ partyMember.user.userId != user.userId &&  party.user.userId!=user.userId}">		 --%>
<%-- 									<c:if test="${ partyMember.user.userId != user.userId }"> --%>
<!-- 										console.log("애프터 파티 버튼 구간 4"); -->
<!-- 										<button type="button" class="btn btn-primary">애프터파티 참여</button> -->
<%-- 										<c:set var="break" value="true" /> --%>
<%-- 									</c:if>	 --%>
<%-- 									</c:when> --%>
<%-- 								</c:choose> --%>
<%-- 								</c:if> --%>
<%-- 							</c:forEach> --%>
<%-- 						</c:if> --%>
	
	