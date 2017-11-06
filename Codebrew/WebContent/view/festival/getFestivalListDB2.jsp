<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="http://code.jquery.com/jquery-3.2.1.min.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	
			<!-- Bootstrap Dropdown Hover CSS -->
	<link href="/resources/css/animate.min.css" rel="stylesheet">
	<link href="/resources/css/bootstrap-dropdownhover.min.css" rel="stylesheet">

	<!-- Bootstrap Dropdown Hover JS -->
	<script src="/resources/javascript/bootstrap-dropdownhover.min.js"></script>
	
	<!-- card css -->
	<link rel="stylesheet" href="/resources/css/card.css">

<script type="text/javascript">

   function fncGetList(currentPage) {
	   
	    $("#currentPage").val(currentPage)
	   
	   $("form").attr("method" , "POST").attr("action" , "/festival/getFestivalListDB?menu=db").submit();
	   
	}  
   
   $(function(){
		 $( "button:contains('검색')" ).on("click" , function() {
			fncGetList(1);
		});
});

	$(function() {

			/* $(".panel-body").on("click", function() { */
				$(".getDB").on("click", function() {

			var festivalNo = $("p", this).text();

			/* self.location = "/festival/getFestivalDB?festivalNo=" + festivalNo; */
			self.location = "/festival/getFestivalDB?festivalNo=" + festivalNo;
		});
	});
	
$(function(){
		
		$("input:text[name='searchKeyword']").on('keydown',function(event){
			
			if(event.keyCode ==13){
				event.preventDefault();
				$( "button:contains('검색')" ).click();
			}
		});
	
	});
	

	 $(function(){
			 
		var jsonValue="";	
		
		$(".areaCodePick").on('click',function(){
			$.ajax( 
					{
						url : "/festivalRest/json/getAreaCode",
						method : "GET" ,
						dataType : "json" ,
						headers : {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
						},
						success : function(jsonData , status) {
							$.each(jsonData.list,function(i,e){
								
								var rnum = e.rnum;
								var name = e.name;
								var code = e.code;
							    
							    var jsonValue = 
	"<option value='"+e.code+"' ${ ! empty search.searchCondition && search.searchCondition=='"+e.code+"' ? 'selected' : '' }>"+e.name+"</option>"
								$("select[name='searchCondition']").removeAttr("style");
							    

	
	
							$("select[name='searchCondition']").prepend(jsonValue).on("click", function(){
									
									var areaCode = $(this).val();
									
									console.log(areaCode);
									
									fncGetSigunguCode(areaCode);
									
				});
								
								
								
								
								
							});
						
						}
					});
				});
			});
	
	 
	 
	 function fncGetSigunguCode(areaCode){
		
		 
		 	$("#checkAreaCode").text(areaCode);
		 
		 $.ajax( 
					{
						url : "/festivalRest/json/getSigunguCode/"+areaCode,
						method : "GET" ,
						dataType : "json" ,
						headers : {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
						},
						success : function(jsonData , status) {
							
							$.each(jsonData.list,function(i,e){
								var rnum = e.rnum;
								var name = e.name;
								var code = e.code;		
								/* "<option value='"+e.code+"' ${ ! empty search.searchCondition && search.searchCondition=='"+e.code+"' ? 'selected' : '' }>"+e.name+"</option>" */								
							    /* var jsonValue = "<option value='"+e.code+"'>"+e.name+"</option>"; */
							    var jsonValue = 
							    "<option value='"+e.code+"' ${ ! empty search.sigunguCode && search.searchSigunguCode=='"+e.code+"' ? 'selected' : '' }>"+e.name+"</option>"

  						
 
	   								$("select[name='sigunguCode']").removeAttr("style");
	   	
		   							$("select[name='sigunguCode']").prepend(jsonValue).on("click", function(){
										
		   							var sigunguCode = $(this).val();
		   							
		   							$("#checkSigunguCode").text(sigunguCode);
		   							
		   							});
								
									
				});//each
								
			}//success	
		});//ajax
	 
	 }//javascript
	  
	 
	 
	 
	 
	 
	 
	 
	 
	 
	
</script>

<style type="text/css">
	body {
			padding-top : 70px;
			background-color: #f2f4f6;
	    }
	    
	    .card {
			margin-top : 50px;
	    }
	    
	    .panel-primary>.panel-heading {
	    	background-color: #000000;
	    }
	    
	    .text-info {
	    	color: #333333; 
	    }
	    
	    .page-header {
	    	border-bottom : 1px solid #f2f4f6;
	    }
	    
	    
	    .section {
	    	margin-top : 400px;
	    }
	    
	    em {
	    	font-family: tahoma;
	    }
	    
   </style>

</head>
<body>
	<jsp:include page="/toolbar/toolbar.jsp"></jsp:include>

	<div class="container">
	<%-- <jsp:include page="/view/statistics/getFestivalZzim.jsp"></jsp:include> --%>
	
  	<div class="row">
  	
  	<div class="col-md-12">
  	
  		<div class="page-header text-center">
					<h3 class="text-info">축제정보</h3>
				</div>

	<form>
	
	
	
		<br/>
		<br/>
		<br/>


		전체 게시물 수 : ${resultPage.totalCount }
		<br/>
		현재 페이지 : ${resultPage.currentPage }
		
		<br/>
		<br/>
		<br/>
		
		<input type="text" id="areaCode" value="">
			    
			    <table class ="areaCodePick">
			    	<tr>
			    		<td>지역검색</td>
			    		<td></td>
			    	 </tr>
			    	 <tr>
			    	 	<td>지역코드</td>
			    	 	<td id="checkAreaCode"></td>
			    	 </tr>
			    	 <tr>
			    	 	<td>시군구코드</td>
			    	 	<td id="checkSigunguCode"></td>
			    	 </tr>
			    </table>
			    
			    <br/>
			    <br/>
			    <br/>
			    
				  <div class="form-group">
				    <select class="form-control" name="searchCondition" style="display:none">
				    <!-- <select class="form-control" name="searchCondition"> -->
				    <option value="">전지역</option>
				</select>
				</div>
				
				  <div class="form-group">
				    <select class="form-control" name="sigunguCode" style="display:none" >
				    <option value="">전체시군구</option>
				</select>
				</div>
				
				정렬
				  <div class="form-group">
				    <select class="form-control" name="arrange" >
					<option value="" ${ ! empty search.arrange && search.arrange=="" ? "selected" : "" }>>정렬</option>
					<option value="A" ${ ! empty search.arrange && search.arrange=="A" ? "selected" : "" }>>제목</option>
					<option value="B" ${ ! empty search.arrange && search.arrange=="B" ? "selected" : "" }>>조회순</option>
					<option value="C" ${ ! empty search.arrange && search.arrange=="C" ? "selected" : "" }>>최근시작일순</option>
					<option value="D" ${ ! empty search.arrange && search.arrange=="D" ? "selected" : "" }>>축제종료일순</option>
				</select>
				</div>
				
				
				 <div class="form-group">
				    <label class="sr-only" for="searchKeyword">검색어</label>
				    <input type="text" class="form-control" id="searchKeyword" name="searchKeyword"  placeholder="검색어"
				    			 value="${! empty search.searchKeyword ? search.searchKeyword : '' }"  >
				  </div>

		<button type="button" class="btn btn-default btn-block">검색</button>
		
		<br/>
		<br/>
		
		
		<section>
		<div class="row">
		
		<c:forEach var="festival" items="${list}">
		
			<c:if test="${festival.deleteFlag == null }">
			
			<div class="col-md-6">
						<!-- <div class="panel panel-primary"> -->
						<div class="card">
							<div class="getDB">
								<c:if test="${festival.festivalImage.contains('http://')==true }">
									<img class="card-img-top" src="${festival.festivalImage }" width="100%" height="423" />
								</c:if>
								
								<c:if test="${festival.festivalImage.contains('http://')==false }">
									<img class="card-img-top" src="../../resources/uploadFile/${festival.festivalImage }" width="100%" height="423" />
								</c:if>
								
								<div id="festivalNo" style="display: none">
											<p>${festival.festivalNo }</p>
								</div> 
								</div>
					<div class="card-body">
					
						<div class="festivalInfo">
									
									<div class="col-md-12">
											<h4><Strong>${festival.festivalName}</Strong></h4>
									</div>
									
									<div class="col-md-12">
										<span class="glyphicon glyphicon-calendar" aria-hidden="true"></span>
										<Strong>${festival.startDate} ~ ${festival.endDate}</Strong>
									</div>
									
									<div class="col-md-12">
										 <span class="glyphicon glyphicon-map-marker" aria-hidden="true"></span>
										 <Strong>${festival.addr } </Strong>
									</div>
									
									
									</div>
									
							</div>
						</div>
				</div>	
			
			
			</c:if>
			
			</c:forEach>
		</div>
		</section>
		
		<input type = hidden id="currentPage" name = "currentPage" value = ${i } />
			
			<jsp:include page="../../common/pageNavigator_new.jsp"/>
			
				</form>
	</div>
	</div>
	
	</div>
	
	</body>
</html>

<!-- <table class="table">
							
								<tr>
									<td class="col-md-3 active"><h4>조회수</h4></td>
									<td>${festival.readCount }</td>
								</tr>
								<tr>
									<td class="col-md-3 active"><h4>날씨</h4></td>
									<td>
										<h4>
											<c:if test="${weather.main == 'Thunderstorm' }">
												<img src = "http://openweathermap.org/img/w/11d.png">
													${weather.description }
											</c:if>
											
											<c:if test="${weather.main == 'Drizzle' }">
												<img src = "http://openweathermap.org/img/w/09d.png">
													${weather.description }
											</c:if>
											
											<c:if test="${weather.main == 'Rain' }">
												<img src = "http://openweathermap.org/img/w/10d.png">
													${weather.description }
											</c:if>
											
											<c:if test="${weather.main == 'Snow' }">
												<img src = "http://openweathermap.org/img/w/13d.png">
													${weather.description }
											</c:if>
											
											<c:if test="${weather.main == 'Atmosphere' }">
												<img src = "http://openweathermap.org/img/w/50d.png">
													${weather.description }
											</c:if>
											
											<c:if test="${weather.main == 'Clear' }">
												<img src = "http://openweathermap.org/img/w/01d.png">
													${weather.description }
											</c:if>
											
											<c:if test="${weather.main == 'Clouds' }">
												<img src = "http://openweathermap.org/img/w/03d.png">
													${weather.description }
											</c:if>
											
											<c:if test="${weather.main == 'Haze' }">
												<img src = "http://openweathermap.org/img/w/50d.png">
													${weather.description }
											</c:if>
											
											<c:if test="${weather.main == 'Mist' }">
												<img src = "http://openweathermap.org/img/w/50n.png">
													${weather.description }
											</c:if>
											
											<c:if test="${weather.main == 'Extreme' && weather.id =='900' }">
												<img src = "../../resources/image/weather/tornado.gif">
													${weather.description }
											</c:if>
											
											<c:if test="${weather.main == 'Extreme' && weather.id =='901' }">
												<img src = "../../resources/image/weather/tropicalStorm.gif">
													${weather.description }
											</c:if>
											
											<c:if test="${weather.main == 'Extreme' && weather.id =='902' }">
												<img src = "../../resources/image/weather/hurricane.gif">
													${weather.description }
											</c:if>
											
											<c:if test="${weather.main == 'Extreme' && weather.id =='903' }">
												<img src = "../../resources/image/weather/cold.gif">
													${weather.description }
											</c:if>
											
											<c:if test="${weather.main == 'Extreme' && weather.id =='904' }">
												<img src = "../../resources/image/weather/hot.gif">
													${weather.description }
											</c:if>
											
											<c:if test="${weather.main == 'Extreme' && weather.id =='905' }">
												<img src = "../../resources/image/weather/windy.gif">
													${weather.description }
											</c:if>
											
											<c:if test="${weather.main == 'Extreme' && weather.id =='906' }">
												<img src = "../../resources/image/weather/hail.gif">
													${weather.description }
											</c:if>
										</h4>
									</td>
								</tr>
								
								<tr>
									<td class="col-md-3 active"><h4>축제명</h4></td>
									<td><h4><Strong>${festival.festivalName }</Strong></h4></td>
								</tr>
								
								<tr>
									<td class="col-md-3 active"><h4>홈페이지</h4></td>
									<td>
										<h4>
											<c:if test="${festival.homepage!=null}">
										  		${festival.homepage }
										  	</c:if>	
									 	</h4>
									</td>
								</tr>
								
								<tr>
									<td class="col-md-3 active"><h4>소개</h4></td>
									<td><h4>
									<c:if test="${festival.festivalOverview!=null }">
								  		${festival.festivalOverview }
								  	</c:if>
									</h4></td>
								</tr>
								
								<tr>
									<td class="col-md-3 active"><h4>개최장소</h4></td>
									<td><h4>
										<c:if test="${festival.addr!=null}">
									  		개최장소 : ${festival.addr }
									  	</c:if>
									</h4></td>
								</tr>
								
								<tr>
									<td class="col-md-3 active"><h4>축제기간</h4></td>
									<td><h4>
										${festival.startDate } ~ ${festival.endDate }
									</h4></td>
								</tr>
								
								<tr>
									<td class="col-md-3 active"><h4>내용</h4></td>
									<td><h4>
										<c:if test="${festival.festivalDetail!=null}">
									  		${festival.festivalDetail }
									  	</c:if>
									</h4></td>
								</tr>
								
								<tr>
									<td class="col-md-3 active"><h4>연락처</h4></td>
									<td><h4>
										<c:if test="${festival.orgPhone!=null}">
									  		${festival.orgPhone }
									  	</c:if>	
									</h4></td>
								</tr>
								
								<tr>
									<td class="col-md-3 active"><h4>부대행사</h4></td>
									<td><h4>
										<c:if test="${festival.subEvent!=null}">
									  		${festival.subEvent }
									  	</c:if>
									</h4></td>
								</tr>
								
								<tr>
									<td class="col-md-3 active"><h4>연령제한</h4></td>
									<td><h4>
										<c:if test="${festival.ageLimit!=null}">
									  		연령제한 : ${festival.ageLimit }
									  	</c:if>
									</h4></td>
								</tr>
								
								<tr>
									<td class="col-md-3 active"><h4>예매처</h4></td>
									<td><h4>
									<c:if test="${festival.bookingPlace!=null}">
								  		${festival.bookingPlace }
								  	</c:if>	  	
									</h4></td>
								</tr>
								
								<tr>
									<td class="col-md-3 active"><h4>할인정보</h4></td>
									<td><h4>
									<c:if test="${festival.discount!=null}">
								  		${festival.discount }
								  	</c:if>  	
									</h4></td>
								</tr>
								
								<tr>
									<td class="col-md-3 active"><h4>행사프로그램</h4></td>
									<td><h4>
									<c:if test="${festival.program!=null}">
								  		${festival.program }
								  	</c:if>	
									</h4></td>
								</tr>
								
								<tr>
									<td class="col-md-3 active"><h4>공연시간</h4></td>
									<td><h4>
									<c:if test="${festival.playTime!=null}">		
								  		${festival.playTime }
								  	</c:if>
									</h4></td>
								</tr>
								
								<tr>
									<td class="col-md-3 active"><h4>관람소요시간</h4></td>
									<td><h4>
										<c:if test="${festival.spendTimeFestival!=null}">
									  		${festival.spendTimeFestival }
									  	</c:if>
									</h4></td>
								</tr>
								
								<tr>
									<td class="col-md-3 active"><h4>이용요금</h4></td>
									<td><h4>
										<c:if test="${festival.useTimeFestival!=null}">
									  		${festival.useTimeFestival }
									  	</c:if>	
									</h4></td>
								</tr>
								
								<tr>
									<td class="col-md-3 active"><h4>티켓가격</h4></td>
									<td><h4>
										<c:if test= "${user.role=='u' }" >
											${festival.ticketPrice }
										</c:if>
									</h4></td>
								</tr>
								
								<tr>
									<td class="col-md-3 active"><h4>티켓수량</h4></td>
									<td><h4>
										<c:if test= "${user.role=='u' }" >
											${festival.ticketCount }
										</c:if>
									</h4></td>
								</tr>
							</table> -->
