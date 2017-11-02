<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<!DOCTYPE html>
<html lang="ko">
<head>
	<title>getFestivalZzim</title>
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<!-- Bootstrap, jQuery CDN -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	
	<!-- Bootstrap Dropdown Hover CSS -->
	<link href="/resources/css/animate.min.css" rel="stylesheet">
	<link href="/resources/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
	
	<!-- Bootstrap Dropdown Hover JS -->
	<script src="/resources/javascript/bootstrap-dropdownhover.min.js"></script>

	<script type="text/javascript">
	
		$(function() {
			
			//썸네일 높이 조절
			var maxHeight = -1;

			$('.thumbnail').each(function() {
				maxHeight = maxHeight > $(this).height() ? maxHeight : $(this).height();
			});

			$('.thumbnail').each(function() {
				 $(this).height(maxHeight);
			});		
			
			
			//썸네일 클릭시
			$(".thumbnail > a").on("click", function(){
				var festivalNo = $(this).children("input:hidden[name='referNo']").val()
				console.log("썸네일클릭->"+festivalNo);
				self.location = "/festival/getFestivalDB?festivalNo="+festivalNo;
			})
			
		});
		
	</script>
	<style type="text/css">
	
		body {
			padding-top : 70px;
	    }
	    
	    .image {
			width : 100%;
			height : 300px;
		}
		
		.image .text {
			color : white;
			position:absolute;z-index:1;left:30px;bottom:100px;
			background-color: rbga(0, 0, 0, .5);
		}

	</style>
</head>

<body>

	<!-- 툴바 -->
	<%-- <jsp:include page="/toolbar/toolbar.jsp"></jsp:include> --%>	
	
	
		
		<div class="row">
			<div class="col-md-offset-3 col-md-6">
				<div class="row">
					<div class="col-md-12">
						<h3>찜찜찜 축제</h3>
					</div>
				</div>
				<div class="row">
						<c:set var="i" value="0" /> 
						<c:forEach var="stat" items="${statList}">
								<c:set var="i" value="${i+1}" /> 
									<!-- 썸네일 -->
									<div class="col-md-4">
										<div class="thumbnail image">
											<!-- 썸네일 이미지 -->
											<a href="#">
												<input type="hidden" name="referNo" value="${stat.referNo}">
												<c:if test="${stat.image.contains('http://')}">
													<img width="100%" height="300" src="${stat.image}">
												</c:if>
												<c:if test="${!stat.image.contains('http://')}">
													<img width="100%" height="300" src="/resources/uploadFile/${stat.image}">
												</c:if>
											</a>
											
											<!-- 썸네일 설명 -->
											<div class="caption">
												<span class="label label-default">${i}위</span> 
												<span class="glyphicon glyphicon-heart" aria-hidden="true"></span> ${stat.totalCount}
												<h4>${stat.name}</h4>
											</div>
											
										</div>
									</div>
						</c:forEach>				
				</div>
			</div>
		</div>
	
</body>
</html>