<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>



<!DOCTYPE html>
<html lang="ko">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width" />
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<!-- Bootstrap Dropdown Hover CSS -->
<link href="/resources/css/animate.min.css" rel="stylesheet">
<link href="/resources/css/bootstrap-dropdownhover.min.css" rel="stylesheet">

<!-- Bootstrap Dropdown Hover JS -->
<script src="/resources/javascript/bootstrap-dropdownhover.min.js"></script>

	<script type="text/javascript">
	

	function fncGetInitListDB() {
		
		$(function() {
				 
					$.ajax( 
							{
								url : "/festivalRest/json/getInitListDB",
								method : "GET" ,
								dataType : "json" ,
								headers : {
									"Accept" : "application/json",
									"Content-Type" : "application/json"
								},
								success : function(jsonData , status) {
									
									for(var i = 0 ; i<3; i++){
										
									var festivalName =  jsonData.list[i].festivalName;	
									var festivalImage = jsonData.list[i].festivalImage
									var festivalNo = jsonData.list[i].festivalNo
									var startDate = jsonData.list[i].startDate
									var endDate = jsonData.list[i].endDate
									var addr = jsonData.list[i].addr
									
									}
									
									/* 0 */
									$("#festivalName0").text(jsonData.list[0].festivalName);
									$("#image0").attr("src",jsonData.list[0].festivalImage);
									$("#festivalNo0 > p").text(jsonData.list[0].festivalNo);
									$("#date0").text(jsonData.list[0].startDate + " ~ " + jsonData.list[0].endDate);
									$("#addr0").text(jsonData.list[0].addr);
									$("c").attr("test",jsonData.list[0].festivalImage +".contains('http://')==false");
									
									/* 1 */
									$("#festivalName1").text(jsonData.list[1].festivalName);
									$("#image1").attr("src",jsonData.list[1].festivalImage);
									$("#festivalNo1 > p").text(jsonData.list[1].festivalNo);
									$("#date1").text(jsonData.list[1].startDate + " ~ " + jsonData.list[1].endDate);
									$("#addr1").text(jsonData.list[1].addr);
									
									/* 2 */
									$("#festivalName2").text(jsonData.list[2].festivalName);
									$("#image2").attr("src",jsonData.list[2].festivalImage);
									$("#festivalNo2 > p").text(jsonData.list[2].festivalNo);
									$("#date2").text(jsonData.list[2].startDate + " ~ " + jsonData.list[2].endDate);
									$("#addr2").text(jsonData.list[2].addr);
									
									
									
								}
						});
				});
	}
	
	$(function() {

		$(".panel-body").on("click", function() {

		var festivalNo = $("p", this).text();

		/* self.location = "/festival/getFestivalDB?festivalNo=" + festivalNo; */
		self.location = "/festival/getFestivalDB?festivalNo=" + festivalNo;
	});
});
			
	    
</script>


<style type="text/css">

/* body{
	background-color: black;	
} */

</style>



<title>Moana</title>
</head>

<jsp:include page="/toolbar/toolbar.jsp"></jsp:include>	


<body onload="fncGetInitListDB();">
	
	
		<div class="container">
	
  	<div class="row">
  	
  	<div class="col-md-12">
  	
  		<div class="page-header text-center">
					<h3 class="text-info">main</h3>
				</div>
				
	
	<jsp:include page="/view/festival/getFestivalListDB.jsp"></jsp:include>	
	
	
	<br/><br/><br/>

		
		
	<div class="col-md-4">
						<div class="panel panel-primary">
							<div class="panel-heading text-center panel-relative">
								
							<%-- 	<h3 class="panel-title" id="festivalName0"> ${festival.festivalName}</h3>
								<br/>
        						<div class="clearfix"></div> --%>
        						
							</div>
							
					<div class="panel-body">
					
					
					<img src="${festival.festivalImage }" class="img-rounded" id="image0" width="100%"height="300" />
					
					<c:if test="${festival.festivalImage.contains('http://')==false }">
					
					</c:if>
					
					<br/>
									<div id="festivalNo0" style="display: none">
										<p>${festival.festivalNo }</p>
									</div> 
						<br />
									
									<div class="col-md-12">
											<span class="glyphicon glyphicon-calendar" aria-hidden="true"></span>
											 <Strong id="date0">${festival.startDate} ~ ${festival.endDate}</Strong>
											 <br/>
											 <span class="glyphicon glyphicon-map-marker" aria-hidden="true"></span>
											 <Strong id="addr0">${festival.addr } </Strong>
									</div>
							</div>
						</div>
				</div>	
				
				<!-- 1 -->
				
		
	<div class="col-md-4">
						<div class="panel panel-primary">
							<div class="panel-heading text-center panel-relative">
							
								<%-- <h3 class="panel-title" id="festivalName1"> ${festival.festivalName}</h3>
								<br/>
        						<div class="clearfix"></div> --%>
        						
							</div>
							
					<div class="panel-body">
					
					
					<img src="${festival.festivalImage }" class="img-rounded" id="image1" width="100%"height="300" />
					
					<br/>
									<div id="festivalNo1" style="display: none">
										<p>${festival.festivalNo }</p>
									</div> 
						<br />
									
									<div class="col-md-12">
											<span class="glyphicon glyphicon-calendar" aria-hidden="true"></span>
											 <Strong id="date1">${festival.startDate} ~ ${festival.endDate}</Strong>
											 <br/>
											 <span class="glyphicon glyphicon-map-marker" aria-hidden="true"></span>
											 <Strong id="addr1">${festival.addr } </Strong>
									</div>
							</div>
						</div>
				</div>	
				
				
				<!-- 2 -->
				
				<div class="col-md-4">
						<div class="panel panel-primary">
							<div class="panel-heading text-center panel-relative">
							
								<%-- <h3 class="panel-title" id="festivalName2"> ${festival.festivalName}</h3>
								<br/>
        						<div class="clearfix"></div> --%>
        						
							</div>
							
					<div class="panel-body">
					
					<img src="${festival.festivalImage }" class="img-rounded" id="image2" width="100%"height="300" />
					
					<br/>
									<div id="festivalNo2" style="display: none">
										<p>${festival.festivalNo }</p>
									</div> 
						<br />
									
									<div class="col-md-12">
											<span class="glyphicon glyphicon-calendar" aria-hidden="true"></span>
											 <Strong id="date2">${festival.startDate} ~ ${festival.endDate}</Strong>
											 <br/>
											 <span class="glyphicon glyphicon-map-marker" aria-hidden="true"></span>
											 <Strong id="addr2">${festival.addr } </Strong>
									</div>
							</div>
						</div>
				</div>	
				
				<br/>
	</div>
	</div>
	</div>


    


	</body>
</html>