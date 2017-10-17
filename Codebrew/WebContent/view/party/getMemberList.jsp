<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

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

	<!-- Jquery DatePicker -->
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

</head>
<body>

	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="modal">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title">파티 참여자 목록</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
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
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
	      </div>
	    </div>
	  </div>
	</div>
	
	<div class="container">
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
	</div>
</body>
</html>