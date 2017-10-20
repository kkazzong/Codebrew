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
   <link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
    <!-- Bootstrap Dropdown Hover JS -->
   <script src="/javascript/bootstrap-dropdownhover.min.js"></script>
	
	
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
	function fncGetUserList(currentPage) {
		$("#currentPage").val(currentPage)
	   	$("form").attr("method" , "POST").attr("action" , "/product/listProduct").submit();
	}
	
	//=====> "검색", prodName link Event 연결 및 처리
	$(function(){
		
		//==> 검색 Event 연결처리부분
		//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2. $(#id) : 3.$(.className)
		//==> 1과 3 방법 조합 : $("tagName.className:filter함수") 사용함.
		$("button.btn.btn-default").on("click", function(){
			//Debug..
			//alert($("button.btn.btn-default")).html();
			fncGetUserList(1);
		});
		
		
		//==> prodName LINK : mouserover Event 연결처리
		//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		//==> 3 과 1 방법 조합 : $(".className tagName:filter함수") 사용함.
		$( "td:nth-child(2)" ).on("mouseover", function(){
			
			var prodNo = $("input:hidden[name='prodNo']", $(this)).val();
			//alert("prodNo :: "+prodNo);
			
			$.ajax(
					{
						url : "/product/json/getProduct/"+prodNo ,
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
											+"상품번호 : "+JSONData.prodNo+"<br/>"
											+"<div style='width: 200px; height: 200px; overflow: hidden'>"
											+"<img src='../images/uploadFiles/"+JSONData.fileName+"' style='max-width: 100%; height: auto'><br/>"
											+"</div>"
											+"</h5>";
						//Debug...	
						//alert(displayValue);
						$("h5").remove();
						$( "#"+prodNo+"" ).html(displayValue);
						
					}
				});
		});
		
		
		//==> prodName LINK : Click Event 연결처리
		$( "td:nth-child(2)" ).on("click" , function() {
			
			//Debug..
			//alert(  $("input:hidden[name='prodNo']",$(this)).val() );
			//self.location ="/product/getProduct?prodNo="+prodNo; //$(this).text().trim()
			//alert($('.hidden_link', $(this)).text());
			self.location=$('.hidden_link', $(this)).text();
		});
		
		
		//==> updateTranCode LINK Event 연결처리
		//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		//==> 3 과 1 방법 조합 : $(".className tagName:filter함수") 사용함.
		$( "td:contains('배송하기')" ).on("click" , function() {
			
			//Debug..
			//alert(  $("input:hidden[name='prodNo']",$(this)).val() );
			//self.location ="/product/getProduct?prodNo="+prodNo; //$(this).text().trim()
			//alert($('.hidden_link', $(this)).text());
			self.location=$('.hidden_link', $(this)).text();
		
		});
		
		
		//==> UI 수정 추가부분  :  prodName LINK Event End User 에게 보일수 있도록 
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
   			<h3>상품목록조회</h3>
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
   							<option value="0" ${! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>상품NO</option>
   							<option value="1" ${! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>상품명</option>
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
   					<th align="center">NO</th>
   					<th align="left">
   						상품명
   						<c:if test="${param.menu=='manage' }">
   							<h7>(prodName click:상품수정)</h7>
   						</c:if>
   						<c:if test="${param.menu=='search' }">
   							<h7>(prodName click:상품상세)</h7>
   						</c:if>
   					</th>
   					<th align="left">가격</th>
   					<th align="left">등록일</th>
   					<th align="left">현재상태(재고여부)</th>
   				</tr>
   			</thead>
   			
   			<tbody>
   			
   				<c:set var="i" value="0"/>
   				<c:forEach var="product" items="${list }">
   					<c:set var="i" value="${i+1 }"/>
   					<tr class="ct_list_pop">
   						<td align="center">${i }</td>
   							<td align="left">
	   							${product.prodName }
								<input type="hidden" name="prodNo" value=${product.prodNo }>
		   						<c:if test="${param.menu=='manage' }">
   									<span style="display: none" class="hidden_link">/product/updateProductView?prodNo=${product.prodNo }&menu=${param.menu }</span>
   								</c:if>
		   						<c:if test="${param.menu=='search' }">
		   							<span style="display: none" class="hidden_link">/product/getProduct?prodNo=${product.prodNo }&menu=${param.menu }</span>
		   						</c:if>
	   						</td>
   						<td align="left">${product.price }</td>
   						<td align="left">${product.regDate }</td>
   						<td></td>
   						<c:if test="${product.proTranCode == null}">
	   						<td align="left">
	   							판매중
	   						</td>
	   					</c:if>
	   					<c:if test="${product.proTranCode == '1  '}">
	   						<td align="left">
	   							구매완료
	   							<c:if test="${param.menu=='manage' }">
	   								배송하기
	   								<span style="display: none" class="hidden_link">/purchase/updateTranCode?prodNo=${product.prodNo }&tranCode=2</span>
	   							</c:if>
	   						</td>
	   					</c:if>
	   					<c:if test="${product.proTranCode == '2  '}">
	   						<td align="left">
	   							배송중
	   						</td>
	   					</c:if>
	   					<c:if test="${product.proTranCode == '3  '}">
	   						<td align="left">
	   							배송완료
	   						</td>
	   					</c:if>
	   					<td align="left">
							<div id= "${product.prodNo}">미리보기</div>
							<input type="hidden" value="${product.prodNo}">
						</td>
	   				</tr>
   				</c:forEach>
   			
   			</tbody>
   			
   		</table>
   		<!-- table End -->
   	
   	</div>
   	<!-- 화면구성 div End -->


</body>
</html>