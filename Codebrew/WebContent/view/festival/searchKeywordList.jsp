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

<script type="text/javascript">

   function fncGetList(currentPage) {
	   
	    $("#currentPage").val(currentPage)
	   
	   $("form").attr("method" , "GET").attr("action" , "/festival/searchKeywordList").submit();
	   
	}  
   
   $(function(){
		 $( "button:contains('검색')" ).on("click" , function() {
			fncGetList(1);
		});
});

	function goSearch(){
		fncGetList(1);
}
   
	
	$(function(){
		
		$("input:text[name='searchKeyword']").on('keydown',function(event){
			
			if(event.keyCode ==13){
				/* alert("dpsxj") */
				event.preventDefault();
				$( "button:contains('검색')" ).click();
			}
		});
	
	});
	
	$(function(){
		$("button:contains('뒤로가기')").on("click", function(){
			self.location = "/festival/searchKeywordList.jsp";
		});
	});

   
   


	$(function() {

		$("td:nth-child(1)").on("click", function() {

			var festivalNo = $("p", this).text();

			self.location = "/festival/getFestival?festivalNo=" + festivalNo;
		});
	});
</script>

</head>
<body>

<jsp:include page="/toolbar/toolbar.jsp"></jsp:include>	


	<form>
	
	
	<br/>
	<br/>
	<br/>
	
	<strong><font size="7">검색허셈</font></strong>
	<br/>
	<br/>
	

		전체 게시물 수 : ${resultPage.totalCount }
		<br/>
		현재 페이지 : ${resultPage.currentPage }
		
		<br/>
		<br/>
		<br/>
		
		 지역검색
				  <div class="form-group">
				    <select class="form-control" name="searchCondition" >
					<option value="" ${ ! empty search.searchCondition && search.searchCondition=="" ? "selected" : "" }>전체지역</option>
					<option value="1" ${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>>서울</option>
					<option value="2" ${ ! empty search.searchCondition && search.searchCondition==2 ? "selected" : "" }>>인천</option>
					<option value="3" ${ ! empty search.searchCondition && search.searchCondition==3 ? "selected" : "" }>>대전</option>
					<option value="4" ${ ! empty search.searchCondition && search.searchCondition==4 ? "selected" : "" }>>대구</option>
					<option value="5" ${ ! empty search.searchCondition && search.searchCondition==5 ? "selected" : "" }>>광주</option>
					<option value="6" ${ ! empty search.searchCondition && search.searchCondition==6 ? "selected" : "" }>>부산</option>
					<option value="7" ${ ! empty search.searchCondition && search.searchCondition==7 ? "selected" : "" }>>울산</option>
					<option value="8" ${ ! empty search.searchCondition && search.searchCondition==8 ? "selected" : "" }>>세종특별자치시</option>
					<option value="31" ${ ! empty search.searchCondition && search.searchCondition==31 ? "selected" : "" }>>경기도</option>
					<option value="32" ${ ! empty search.searchCondition && search.searchCondition==32 ? "selected" : "" }>>강원</option>
					<option value="33" ${ ! empty search.searchCondition && search.searchCondition==33 ? "selected" : "" }>>충정북도</option>
					<option value="34" ${ ! empty search.searchCondition && search.searchCondition==34 ? "selected" : "" }>>충청남도</option>
					<option value="35" ${ ! empty search.searchCondition && search.searchCondition==35 ? "selected" : "" }>>경상북도</option>
					<option value="36" ${ ! empty search.searchCondition && search.searchCondition==36 ? "selected" : "" }>>경상남도</option>
					<option value="37" ${ ! empty search.searchCondition && search.searchCondition==37 ? "selected" : "" }>>전라북도</option>
					<option value="38" ${ ! empty search.searchCondition && search.searchCondition==38 ? "selected" : "" }>>전라남도</option>
					<option value="39" ${ ! empty search.searchCondition && search.searchCondition==39 ? "selected" : "" }>>제주도</option>
					
				</select>
				</div>
				
				  <div class="form-group">
				    <select class="form-control" name="arrange" >
					<option value="" ${ ! empty search.arrange && search.arrange=="" ? "selected" : "" }>>정렬</option>
					<option value="A" ${ ! empty search.arrange && search.arrange=="A" ? "selected" : "" }>>제목</option>
					<option value="B" ${ ! empty search.arrange && search.arrange=="B" ? "selected" : "" }>>조회순</option>
					<option value="C" ${ ! empty search.arrange && search.arrange=="C" ? "selected" : "" }>>수정일순</option>
					<option value="D" ${ ! empty search.arrange && search.arrange=="D" ? "selected" : "" }>>생성일순</option>
					<option value="o" ${ ! empty search.arrange && search.arrange=="o" ? "selected" : "" }>>제목2</option>
					<option value="p" ${ ! empty search.arrange && search.arrange=="p" ? "selected" : "" }>>조회순2</option>
					<option value="Q" ${ ! empty search.arrange && search.arrange=="Q" ? "selected" : "" }>>수정일순2</option>
					<option value="R" ${ ! empty search.arrange && search.arrange=="R" ? "selected" : "" }>>생성일순2</option>
				</select>
				</div>
				
				 <div class="form-group">
				    <label class="sr-only" for="searchKeyword">검색어</label>
				    <input type="text" class="form-control" id="searchKeyword" name="searchKeyword"  placeholder="검색어"
				    			 value="${! empty search.searchKeyword ? search.searchKeyword : '' }"  >
				  </div>

		<button type="button" class="btn btn-default">검색</button>
		
		<br/>
		<br/>
		
		<br/>
		<br/>
	
	
	<%-- <c:if test="${festival.isNull==false }"> --%>
		

		
		<c:forEach var="festival" items="${list}">
		
		<c:if test= "${festival.isNull==true }">
	 
			<strong><font size="7">썸띵스 우롱차임 다시검색허셈</font></strong>
			<br/>
			<br/>
			
		</c:if>
		
		<c:if test= "${festival.isNull==false }">
		
			<br />
			<table>
				<tr>
					<td><img src="${festival.festivalImage }" width="300"
						height="300" /> <br />
						<div id="festivalNo" style="display: none">
							<p>${festival.festivalNo }</p>
						</div> <span> ${festival.festivalName } </span> <br /></td>
				</tr>
			</table>
			<div>축제기간 ${festival.startDate } ~ ${festival.endDate }</div>
			<br />
			<br />
		
		</c:if>	
		</c:forEach>
		
		<%-- </c:if> --%>
		
		
			
			<input type = hidden id="currentPage" name = "currentPage" value = ${i } />
			
			
			<jsp:include page="../../common/pageNavigator.jsp"/>
			
	

	
	
	</form>


</body>
</html>