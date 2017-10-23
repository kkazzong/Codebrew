<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

	<!-- 참조 : http://getbootstrap.com/css/   참조 -->
	<meta name="viewport" content="width=device-width, initial-scale=1">
	
	<!-- 이거 필요없을듯...CDN 사용....
	<link rel="stylesheet" href="/css/admin.css" type="text/css"> -->
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	
	<!-- Bootstrap Dropdown Hover CSS -->
   <link href="/css/animate.min.css" rel="stylesheet">
   <link href="../resources/javascript/bootstrap-dropdownhover.min.css" rel="stylesheet">
    <!-- Bootstrap Dropdown Hover JS -->
   <script src="../resources/javascript/bootstrap-dropdownhover.min.js"></script>
	
	
	<!-- jQuery UI toolTip 사용 CSS-->
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<!-- jQuery UI toolTip 사용 JS-->
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
  
	<!-- <link rel="stylesheet" href="/resources/demos/style.css"> -->
  	 
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
	  body {
            padding-top : 50px;
        }
    </style>
    
	<!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">
	
	<!--  // 검색 / page 두가지 경우 모두 Form 전송을 위해 JavaScript 이용 --> 
	function fncGetList(currentPage) {
		$("#currentPage").val(currentPage)
	   	$("form").attr("method" , "POST").attr("action" , "/review/getReviewList").submit();
	}
	
	//=====> "검색", reviewTitle link Event 연결 및 처리
	$(function(){
		
		//==> 검색 Event 연결처리부분
		//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2. $(#id) : 3.$(.className)
		//==> 1과 3 방법 조합 : $("tagName.className:filter함수") 사용함.
		$("button.btn.btn-default").on("click", function(){
			//Debug..
			//alert($("button.btn.btn-default")).html();
			fncGetList(1);
		});
		
		/* 
		//==> reviewName LINK : mouserover Event 연결처리
		//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		//==> 3 과 1 방법 조합 : $(".className tagName:filter함수") 사용함.
		$( "td:nth-child(2)" ).on("mouseover", function(){
			
			var reviewNo = $("input:hidden[name='reviewNo']", $(this)).val();
			//alert("reviewNo :: "+reviewNo);
			
			$.ajax(
					{
						url : "/review/json/getReview/"+reviewNo ,
						method : "GET" ,
						dataType : "json" ,
						headers : {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
					},
					success : function(JSONData , status) {

						//Debug...
						//alert(status);
						//Debug...
						//alert("JSONData.fileName : \n"+JSONData);
						
						var displayValue = "<h5>"
											+"상품번호 : "+JSONData.reviewNo+"<br/>"
											+"<div style='width: 200px; height: 200px; overflow: hidden'>"
											+"<img src='../images/uploadFiles/"+JSONData.fileName+"' style='max-width: 100%; height: auto'><br/>"
											+"</div>"
											+"</h5>";
						//Debug...	
						//alert(displayValue);
						$("h5").remove();
						$( "#"+reviewNo+"" ).html(displayValue);
						
					}
				});
		});
		 */
		
		//==> reviewTitle LINK : Click Event 연결처리
		$( "td:nth-child(2)" ).on("click" , function() {
			
			//Debug..
			//alert(  $("input:hidden[name='reviewNo']",$(this)).val() );
			//self.location ="/review/getReview?reviewNo="+reviewNo; //$(this).text().trim()
			//alert($('.hidden_link', $(this)).text());
			self.location=$('.hidden_link', $(this)).text();
		});
		
		
		//==> updateTranCode LINK Event 연결처리
		//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		//==> 3 과 1 방법 조합 : $(".className tagName:filter함수") 사용함.
		$( "td:contains('배송하기')" ).on("click" , function() {
			
			//Debug..
			//alert(  $("input:hidden[name='reviewNo']",$(this)).val() );
			//self.location ="/review/getReview?reviewNo="+reviewNo; //$(this).text().trim()
			//alert($('.hidden_link', $(this)).text());
			self.location=$('.hidden_link', $(this)).text();
		
		});
		
		
		//==> UI 수정 추가부분  :  reviewTitle LINK Event End User 에게 보일수 있도록 
		$( ".ct_list_pop td:nth-child(2)" ).css("color" , "red");
		$("h7").css("color" , "red");
		$( ".ct_list_pop td:nth-child(7)" ).css("color" , "blue");
		
		//==> 아래와 같이 정의한 이유는 ??
		$(".ct_list_pop:nth-child(4n+6)" ).css("background-color" , "whitesmoke");
		
	});
	
	</script>




<title>Insert title here</title>
</head>
<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="../../toolbar/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
   	
   	<!-- 화면구성 div Start -->
   	<div class="container">
   	
   		
   		
   		<div class="page-header text-info">
   			<h3>후기목록조회</h3>
   		</div>
   		
   		<!--  table 위쪽 검색 Start -->
   		<div class="row">
   		
   			<div class="col-md-6 text-left">
   				<p class="text-primary">
   					전체  ${resultPage.totalCount } 건수, 현재 ${resultPage.currentPage}  페이지
   				</p>
   			</div>
   			
   			<div class="col-md-6 text-right">
   				<form class="form-inline" name="detailForm">
   					<input name="menu" value="${param.menu }" type="hidden"/>
   					<div class="form-group">
   						<select class="form-control" name="searchCondition">
   							<option value="0" ${! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>축제이름</option>
   							<option value="1" ${! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>축제장소</option>
   							<option value="2" ${! empty search.searchCondition && search.searchCondition==2 ? "selected" : "" }>해시태그</option>
   						</select>
   					</div>
   					
   					<div class="form-group">
   						<label class="sr-only" for="searchKeyword">검색어</label>
   						<input type="text" class="form-control" id="searchKeyword" name="searchKeyword" placeholder="검색어" 
   								value="${! empty search.searchKeyword ? search.searchKeyword : '' }" >
   					</div>
   					
   					<button type="button" class="btn btn-default">검색</button>
   					
   					<!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
   					<input type="hidden" id="currentPage" name="currentPage" value=""/>
   				
   				</form>
   			</div>
   		
   		</div>
   		<!--  table 위쪽 검색 End -->
   		
   		
   		<!-- table Start -->
   		<table class="table table-hover table-striped">
   		
   			<thead>
   				<tr>
   					<th align="left">
   						축제명
   					</th>
   					<th align="left">
   						후기명
   						<%-- <c:if test="${param.menu=='manage' }">
   							<h7>(reviewTitle click:상품수정)</h7>
   						</c:if>
   						<c:if test="${param.menu=='search' }">
   							<h7>(reviewTitle click:상품상세)</h7>
   						</c:if> --%>
   					</th>
   					<th align="left">
   						축제장소
   					</th>
   					<th align="left">
   						작성자
   					</th>
   				</tr>
   			</thead>
   			
   			<tbody>
   			
   				<c:set var="i" value="0"/>
   				<c:forEach var="review" items="${list }">
   					<c:set var="i" value="${i+1 }"/>
   					<tr class="ct_list_pop">
   						<td align="left">
   							${review.festivalName }
   						</td>
  						<td align="left">
   							${review.reviewTitle }
   							<input type="hidden" name="reviewNo" value=${review.reviewNo }>
								<span style="display: none" class="hidden_link">/review/getReview?reviewNo=${review.reviewNo }</span>
	   						<%-- <c:if test="${param.menu=='manage' }">
  									<span style="display: none" class="hidden_link">/review/updateReview?reviewNo=${review.reviewNo }&menu=${param.menu }</span>
  								</c:if>
	   						<c:if test="${param.menu=='search' }">
	   							<span style="display: none" class="hidden_link">/review/getReview?reviewNo=${review.reviewNo }&menu=${param.menu }</span>
	   						</c:if> --%>
   						</td>
   						<td align="left">
   							${review.reviewTitle }
   						</td>
   						<td align="left">
   							${review.userId }
   						</td>
	   				</tr>
   				</c:forEach>
   			
   			</tbody>
   			
   		</table>
   		<!-- table End -->
   	
   	</div>
   	<!-- 화면구성 div End -->
   	
	<!-- PageNavigation Start... -->
	<jsp:include page="../../common/pageNavigator_new.jsp"/>
	<!-- PageNavigation End... -->


</body>
</html>