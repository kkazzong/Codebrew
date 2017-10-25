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
	<link href="/resources/css/animate.min.css" rel="stylesheet">
	<link href="/resources/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
	
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
	   	$("form").attr("method" , "POST").attr("action" , "/review/getReplyList").submit();
	}
	
	function fucAddReply(){
		
		//Form 유효성 검증 : 빈 내용 X
		
		var replyDetail = $("input[name='replyDetail']").val();
	
		if(replyDetail == null || replyDetail.length<1){
			alert("댓글내용을 입력한 후에 댓글을 등록할 수 있습니다.");
			return;
		}
		
		$("form").attr("method", "POST").attr("action", "/reply/addReply").submit();
	}
	
	//=====> "검색", replyTitle link Event 연결 및 처리
	$(function(){
		
		//==> 검색 Event 연결처리부분
		//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2. $(#id) : 3.$(.className)
		//==> 1과 3 방법 조합 : $("tagName.className:filter함수") 사용함.
		$("button.btn.btn-default").on("click", function(){
			//Debug..
			//alert($("button.btn.btn-default")).html();
			fncGetList(1);
		});
		
		$("button.btn.btn-primary:contains('댓글등록')").on("click", function(){
			//Debug..
			//alert($("button.btn.btn-primary")).html();
			fncAddReply();
		});
		
		
		//==> UI 수정 추가부분  :  replyTitle LINK Event End User 에게 보일수 있도록 
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

   	<!-- 화면구성 div Start -->
   	<div class="container">
   			
   			<!-- 'search' is only for 'Admin' menu -->
   			<c:if test="sessionScope.user.role == 'a'">
	   			<div class="col-md-offset-4 col-md-4">
	   				<form class="form-inline" name="detailForm">
	   					<%-- 
	   					<input name="menu" value="${param.menu }" type="hidden"/>
	   					 --%>
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
   			</c:if>
   		</div>
   		<!-- 화면구성 div End -->
   		
   		
   		<!--  table 위쪽 검색 End -->
   		
   		<!-- 댓글입력 form Start : 로그인한 사람만 댓글등록가능-->
   		<c:if test="${!empty sessionScope.user }">
   		<form class="form-horizontal" method="post" name="detailForm">
   			<div class="form-group">
   				<input type="hidden" id="reviewNo" name="reviewNo" value="${review.reviewNo }"/>
   				<input type="hidden" id="userId" name="userId" value="${sessionScope.user.userId }"/>
   				<!-- 
   				<label for="replyDetail" class="col-sm-offset-1 col-sm-3 control-label">댓글내용</label>
   				 -->
   				<div class="col-md-12">
   					<input type="text" class="form-control" id="replyDetail" name="replyDetail">
   					<button type="button" class="btn btn-primary">댓글등록</button>
   				</div>
   			</div>
   		</form>
   		</c:if>
   		<!-- 댓글입력 form End-->
   		
   		<!-- table Start -->
   		<table class="table table-hover table-striped">
   		
   			<thead>
   				<tr>
   					<th align="left">
   						댓글내용
   					</th>
   					<th align="left">
   						댓글작성자
   					</th>
   					<th align="left">
   						등록일자
   					</th>
   				</tr>
   			</thead>
   			
   			<tbody>
   				<c:if test="${!empty review.replyList }">
	   				<c:set var="i" value="0"/>
	   				<c:forEach var="replyList" items="${review.replyList }">
	   					<c:set var="i" value="${i+1}"/>
	   					<tr class="ct_list_pop">
	  						<td align="left">
	   							${replyList.replyDetail }
	   							<input type="hidden" name="reviewNo" value=${review.reviewNo }>
								<span style="display: none" class="hidden_link">/review/getReview?reviewNo=${review.reviewNo }</span>
								<c:if test="${sessionScope.user.role == 'a' || sessionScope.user.userId == reply.userId }">
						   			<center>
						   				<!-- <button class="btn btn-default" type="button">확인</button> -->
							   			<button type="button" class="btn pull-center btn-primary">댓글수정</button>
							   			<button type="button" class="btn pull-center btn-primary">댓글삭제</button>
							   		</center>
						   		</c:if>
	   						</td>
	   						<td align="left">
	   							${replyList.userId }
	   						</td>
	   						<td align="left">
	   							${replyList.replyRegDate }
	   						</td>
		   				</tr>
	   				</c:forEach>
   				</c:if>

			<!-- PageNavigation Start... -->
			<jsp:include page="../../common/pageNavigator_new.jsp"/>
			<!-- PageNavigation End... -->

   			</tbody>   			
   			
   		</table>
   		<!-- table End -->
   		

</body>
</html>