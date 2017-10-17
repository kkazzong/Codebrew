<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>
<html lang="ko">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	
	<title>��Ƽ �� ��ȸ ȭ��</title>

	<!-- ���� : http://getbootstrap.com/css/   ���� -->
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
    
    <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">
		
		//============= "��Ƽ����"  Event ���� =============
		$(function(){
			$("button:contains('��Ƽ����')").on("click", function() {
				self.location="/party/updateParty/"+${party.partyNo};
		
			});
		});
		
		//============= "��Ƽ����"  Event ó�� ��  ���� =============
		$(function(){
			$("button:contains('��Ƽ����')").on("click", function() {
				self.location="/party/deleteParty/"+${party.partyNo}+"/"+${sessionScope.user.userId};
		
			});
		});
		
		//============= "��ƼƼ�ϱ���"  Event ó�� ��  ���� =============
		$(function(){
			$("button:contains('��ƼƼ�ϱ���')").on("click", function() {
				self.location="/party/joinParty/"+${party.partyNo}+"/"+${sessionScope.user.userId};
		
			});
		});
		
		//============= "��Ƽ�������"  Event ó�� ��  ���� =============
		$(function(){
			$("button:contains('��Ƽ�������')").on("click", function() {
				self.location="/party/cancelParty/"+${party.partyNo}+"/"+${sessionScope.user.userId};
		
			});
		});
		
		//============= "�����ڸ�Ϻ���"  Event ó�� ��  ���� =============
		$(function(){
			$("button:contains('�����ڸ�Ϻ���')").on("click", function() {
				self.location="/party/getMemberList/"+${party.partyNo};
		
			});
		});
		
		//============= "Ȯ��"  Event ó�� ��  ���� =============
		$(function(){
			$("button:contains('Ȯ��')").on("click", function() {
				self.location="/party/getGenderRatio/"+${party.partyNo}+"/"+${sessionScope.user.userId};
		
			});
		});
		
		//============= "������"  Event ó�� ��  ���� =============
		$(function(){
			$("div.host").on("click", function() {
				self.location="/user/getProfile/"+${party.user.userId};
		
			});
		});
		
	</script>
</head>
<body>

	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
	<div class="container">
		<h1 class="bg-primary text-center"> 
		${ empty party.festival.festivalNo  ? '��Ƽ �� ����' : '������ ��Ƽ �� ����'}
		</h1>
		<hr />

		<div class="container">
			<div class="host">
				<h2 class="text-center">${ party.partyName }</h2>
				<div>
					<%-- <p><img class="rounded-circle" src="/resources/image/uploadFile/${ party.user.profileImage }" alt="Generic placeholder image" width="40" height="40"></p> --%>
					<p><img class="rounded-circle" src="/resources/image/uploadFile/user01.jpg" alt="Generic placeholder image" width="40" height="40"></p>
					<p>${ party.user.userId }</p>
				</div>
			</div>
			
			<div class="text-center">
				<img src="/resources/image/uploadFile/${party.partyImage}" />
			</div>
			
			<br>
			
			<div>
				<div class="row">
					<br />
					<div class="col-xs-4 col-md-2 ">
						<strong>������</strong>
					</div>
					<div class="col-xs-8 col-md-4">${party.festival.festivalName}</div>
				</div>

				<hr />

				<div class="row">
					<div class="col-xs-4 col-md-2 ">
						<strong>��Ƽ��¥</strong>
					</div>
					<div class="col-xs-8 col-md-4">${party.partyDate}</div>
				</div>

				<hr />

				<div class="row">
					<div class="col-xs-4 col-md-2 ">
						<strong>��Ƽ�ο�</strong>
					</div>
					<div class="col-xs-4 col-md-2">${party.partyMemberLimit} �� �� ${partyMember.currentMemberCount} �� ������</div>
					
					<c:set var="i" value="0"/>
					<c:forEach var="partyMember" items="${list}">
						<c:set var="i" value="${i+1}"/>
						<c:if test="${sessionScope.user.userId == partyMember.userid }">
							
							<!-- Button trigger modal -->
							<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal">
							  �����ڸ�Ϻ���
							</button>
							
							<!-- Modal -->
							<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
							  <div class="modal-dialog" role="document">
							    <div class="modal-content">
							      <div class="modal-header">
							        <h5 class="modal-title" id="exampleModalLabel">��Ƽ ������ ���</h5>
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
												<img class="rounded-circle" src="/resources/image/uploadFile/${ partyMember.user.profileImage }" alt="Generic placeholder image" width="40" height="40">
												${ partyMember.user.userId }
												<c:if test="${partyMember.role =='host' }">
													<strong>host</strong>
												</c:if>
											</div>
										</c:forEach>
									</form>
							      </div>
							      <div class="modal-footer">
							        <button type="button" class="btn btn-secondary" data-dismiss="modal">�ݱ�</button>
							      </div>
							    </div>
							  </div>
							</div>
						
						</c:if>
					</c:forEach>
					
					
				</div>
				
				<hr/>
				
				<div class="row">
					<div class="col-xs-4 col-md-2 ">
						<strong>��Ƽ Ƽ�� ����</strong>
					</div>
					<div class="col-xs-8 col-md-4">${party.ticketPrice}</div>
				</div>
				
				<hr />

				<div class="row">
					<div class="col-xs-4 col-md-2">
						<strong>��Ƽ����</strong>
					</div>
					<div class="col-xs-8 col-md-4">${party.partyDetail}</div>
				</div>
				
				<hr/>

				<div class="jumbotron">
					<p>����� ���� �������� �������� ���������� �� �� �ֽ��ϴ�.....����� �ñ��մϴ�.....���ڳ��� ����� Ȯ���Ͻðڽ��ϱ�?</p>
				
					<!-- Button trigger modal -->
					<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal">
					  Ȯ��
					</button>
					
					<!-- Modal -->
					<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
					  <div class="modal-dialog" role="document">
					    <div class="modal-content">
					      <div class="modal-header">
					        <h5 class="modal-title" id="exampleModalLabel">��Ƽ ���� ����</h5>
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
										<img class="rounded-circle" src="/resources/image/uploadFile/${ partyMember.user.profileImage }" alt="Generic placeholder image" width="40" height="40">
										${ partyMember.user.userId }
										<c:if test="${partyMember.role =='host' }">
											<strong>host</strong>
										</c:if>
									</div>
								</c:forEach>
							</form>
					      </div>
					      <div class="modal-footer">
					        <button type="button" class="btn btn-secondary" data-dismiss="modal">�ݱ�</button>
					      </div>
					    </div>
					  </div>
					</div>
				
				</div>

				<hr />

				<div class="row">
					<div class="col-xs-4 col-md-2 ">
						<strong>��Ƽ ���</strong>
					</div>
					<div class="col-xs-8 col-md-4">${party.partyPlace}</div>
				</div>

				<hr />

				<div class="row">
					<div class="col-md-12 text-center ">
						<c:if test="${ ! empty party.user.userId && party.user.userId==sessionScope.user.userId }">
							<button type="button" class="btn btn-primary">��Ƽ����</button>
						</c:if>
						<c:if test="${ ! empty party.user.userId && party.user.userId==sessionScope.user.userId }">
							<button type="button" class="btn btn-primary">��Ƽ����</button>
						</c:if>
						<c:if test="${ ! empty party.user.userId && party.user.userId!=sessionScope.user.userId }">
							<button type="button" class="btn btn-primary">��ƼƼ�ϱ���</button>
						</c:if>
						<c:if test="${ ! empty party.user.userId && party.user.userId!=sessionScope.user.userId }">
							<button type="button" class="btn btn-primary">��Ƽ�������</button>
						</c:if>
					</div>
				</div>

			</div>

		</div>
	</div>
	<!--  ȭ�鱸�� div end /////////////////////////////////////-->

</body>
</html>