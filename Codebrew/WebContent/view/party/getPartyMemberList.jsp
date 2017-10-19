 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%--<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<title>파티 참여자 목록 화면</title>
	
	<!-- 참조 : http://getbootstrap.com/css/   참조 -->
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <link rel="stylesheet" href="/resources/demos/style.css">
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>

	<script type="text/javascript">
	
		$(function(){
			$("div.user").on("click", function() {
				var userId = $( "input[name=userId]", $(this) ).val();
				
				console.log(userId);
				self.location="/myPage/getProfile?userId="+userId;
		
			});
		});
	
	</script>

</head>
<body> --%>

	<!--  화면구성 div Start /////////////////////////////////////-->
	<!-- Modal -->
	<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	        <h1 class="modal-title" id="exampleModalLabel" align="center">파티 멤버 목록</h1>
	        <div><h4 align="center">${ partyMember.party.partyName }</h4></div>
	        
	      </div>
	      <div class="modal-body">
	        <form class="form-horizontal" enctype="multipart/form-data">
				
				<c:set var="i" value="0"/>
				<c:forEach var="partyMember" items="${list}">
					<div class="row" id="user">
						<input type="hidden" id="userId" name="userId" value="${ partyMember.user.userId }">
						<span>
						<img class="rounded-circle" src="/resources/uploadFile/${ partyMember.user.profileImage }" alt="Generic placeholder image" width="40" height="40">
						</span>
						<span>
						${ partyMember.user.nickname } &nbsp; ( ${ partyMember.user.userId } )
						</span>
						<span>
						<c:if test="${partyMember.role =='host' }">
							<strong>host</strong>
						</c:if>
						</span>
					</div>
				</c:forEach>
			</form>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
	      </div>
	    </div>
	  </div>
	</div> 
	
	<%-- <div class="container">
		<hr/>
		<h1 class="bg-primary text-center">파티 참여자 목록</h1>
		<hr/>
		<!-- form Start /////////////////////////////////////-->
		<form class="form-horizontal" enctype="multipart/form-data">
			${ partyMember.partyNo }
			<c:set var="i" value="0"/>
			<c:forEach var="partyMember" items="${list}">
				<div class="row">
					<img class="rounded-circle" src="../../images/uploadFiles/${ partyMember.user.profileImage }" alt="Generic placeholder image" width="40" height="40">
					${ partyMember.user.userId }
					<c:if test="${partyMember.role =='host' }">
						<strong>host</strong>
					</c:if>
				</div>
			</c:forEach>
			
		
		</form>
	</div> --%>
<!-- </body>
</html> -->