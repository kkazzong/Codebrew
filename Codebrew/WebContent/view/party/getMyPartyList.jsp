<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
    
<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<title>My��Ƽ ��� ��ȸ</title>

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
	
		//=============    �˻� / page �ΰ��� ��� ���  Event  ó��	 =============	
		/* function fncGetList(currentPage) {
				$("#currentPage").val(currentPage)
				$("form").attr("method" , "POST").attr("action", "/product/listProduct/${menu}").submit();
		} 
		
		$(function(){
			$("button[type=button]").bind("click", function() {
				console.log( $("button[type=button]:contains('�˻�')").html() );
				fncGetList(1);
			});
			
			
		}); */		
		
		
		//=============    ��ǰ����ȸ(�����)  Event  ó�� 		=============
		$(function(){
			$("#partyBlock").on("click", function() {
				
				var partyNo = $( "input[name=partyNo]", $(this) ).val();
				
				console.log( $( "a.thumbnail_image img", $(this) ).val() );
				self.location="/party/getParty/"+partyNo;
		
			});
		});
		
		//=============    Select ���� ��Ƽ  Event  ó�� 		=============
		$(function(){
			$("button:contains('���� ��Ƽ')").on("click", function() {
				self.location="/party/getParty/3";
		
			});
		});
		
		//=============    Select �������� ��Ƽ  Event  ó�� 		=============
		$(function(){
			$("button:contains('�������� ��Ƽ')").on("click", function() {
				self.location="/party/getParty/4";
		
			});
		});
		
		//=============    Select �������� ��Ƽ  Event  ó�� 		=============
		$(function(){
			$("button:contains('����')").on("click", function() {
				self.location="/party/deleteParty";
		
			});
		});
		
		
	</script>
	
</head>
<body>

	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
	<div class="container">
	  <div class="page-header text-info">
   		   <h2 align="center">��Ƽ ���</h2>
	  </div>
	  
	  <!-- table ���� �˻� Start /////////////////////////////////////-->
	    <div class="row">
	    
		    <div class="col-md-6 text-left">
		    	<p class="text-primary">
		    		��ü  ${resultPage.totalCount } �Ǽ�
   		
		    	</p>
		    </div>
		    
		    <div class="col-md-6 text-right">
			    <form class="form-inline" name="detailForm">
			    
				  <div class="form-group">
				    <div class="form-select">
						<button type="button" class="btn btn-default" >�������� ��Ƽ</button>
						<button type="button" class="btn btn-default" >���� ��Ƽ</button>
						
					</div>
				  </div>
				  
				  <div class="form-group">
				    <label class="sr-only" for="searchKeyword">�˻���</label>
				    <input type="text" class="form-control" id="searchKeyword" name="searchKeyword" 
				    			 value="${! empty search.searchKeyword ? search.searchKeyword : '' }"  >
				    <button type="button" class="btn btn-default">�˻�</button>			 
				  </div>		  
				  
				  <!-- PageNavigation ���� ������ ���� ������ �κ� -->
				  <input type="hidden" id="currentPage" name="currentPage" value=""/>
				  
				</form>
	    	</div>
	    	
		</div>
	  <!-- table ���� �˻� End /////////////////////////////////////-->
	  
	  <br/>
	  
	  <!-- table ��� ��ȸ Start /////////////////////////////////////-->
		<div class="container_list">		
			<div class="row_list">
				<input type="hidden" id="currentPageList" name="currentPageList" value="${resultPage.currentPage}"/>
			
				<c:set var="i" value="0" />
				<c:forEach var="party" items="${list}">
					<c:set var="i" value="${ i+1 }" />
					<div class="col-sm-6 col-md-4" >
						<div class="thumbnail">
							<a href="#" class="thumbnail_image">
								<img src="../../images/uploadFiles/${party.fileName}" width="300" height="350"> 
								<input type="hidden" id="prodNo" name="prodNo" value="${party.partyNo }"/>
							</a> 
							<div class="caption">
								<h3 class="thumbnail_festivalName">${ !empty party.festival.festivalName ? party.festival.festivalName : '' }	
								</h3>
								<h3 class="thumbnail_partyName">${ party.partyName }
									<input type="hidden" id="partyNo" name="partyNo" value="${party.partyNo }"/>
								</h3>
								<p>${ party.user.nickname }</p>
								<p>${ party.partyDate }</p>
								<p>${ party.partyPlace }</p>
								<button type="button" class="btn btn-default" >����</button>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
		</div> 
		
		
		  
		
	 
	  
 	</div>
 	<!--  ȭ�鱸�� div End /////////////////////////////////////-->
</body>
</html>