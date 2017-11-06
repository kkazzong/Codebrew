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
		$("#searchReply").on("click", function(){
			fncGetList(1);
		});
		
		$("#addReply").on("click", function(){
			alert("댓글등록 클릭");
			fncAddReply();
		});
		
		$(".btn-warning:contains('삭제')").on("click", function(){
			alert("댓글삭제버튼클릭 :: replyNo :: "+$(this).val());
			self.location="/reply/deleteReply?replyNo="+$(this).val();
		});
		
		//수정중
		$(".btn-info:contains('수정')").on("click", function(){
			//alert("댓글수정하기버튼클릭");
			//alert("#updateReply${replyList.replyNo }");
			var tempReplyNo = $(this).val();
			var tempReviewNo = $("#reviewNo").val();
			
			alert("임시reviewNo"+tempReviewNo);
			//alert("임시댓글번호"+tempReplyNo);
			//alert("button:#updateReply"+tempReplyNo);
			
			$("#replyDetail"+tempReplyNo).removeAttr("readonly")
			.focus()
			
			$("#updateReply"+tempReplyNo).html('완료').on("click", function(){
				
				alert("수정완료클릭 :: ajax 시작");
				
				$.ajax(
						{
							url : "/replyRest/json/updateReply", 
							method : "POST", 
							headers : {
								"Accept" : "application/json", 
								"Content-Type" : "application/json"
							}, 
							data : JSON.stringify({
								replyNo : tempReplyNo, 
								replyDetail : $("#replyDetail"+tempReplyNo).val()
							}),
							dataType : "json", 
							success : function(JSONData, status){
								$("#replyDetail"+tempReplyNo).val(JSONData.replyDetail);
								$("#replyDetail"+tempReplyNo).attr("readonly", true);
								$("#updateReply"+tempReplyNo).html('수정');
							}
						}
				)
				
			});
			
		});
		
		
		$( ".ct_list_pop td:nth-child(2)" ).css("color" , "red");
		$("h7").css("color" , "red");
		$( ".ct_list_pop td:nth-child(7)" ).css("color" , "blue");
		
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
	   					
	   					<button type="button" id = "searchReply" class="btn btn-default">검색</button>
	   					
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
   				<div class="col-md-10">
   					<input type="text" class="form-control" id="replyDetail" name="replyDetail">
   				</div>
   				<div class="col-md-2">
   					<button type="button" id = "addReply" class="btn btn-primary pull pull-left">댓글등록</button>
   				</div>
   			</div>
   		</form>
   		</c:if>
   		<!-- 댓글입력 form End-->
   		
   		<!-- table Start -->
   		<table class="table table-hover table-striped">
   		
   			<thead>
   				<tr>
					<td align="left">
						댓글내용
					</td>
					<td align="center">
						댓글작성자
					</td>
					<td align="center">
						등록일자
					</td>
					</tr>
   			</thead>
   			
   			<tbody>
	   			 <c:if test="${!empty review.replyList }">	
	   				<c:set var="i" value="0"/>
	   				<c:forEach var="replyList" items="${review.replyList }">
	   					<c:set var="i" value="${i+1}"/>
	   					<tr class="ct_list_pop">
	   						<td align="left">
	   							<div class="input-group">
								<input type="text" class="form-control" id="replyDetail${replyList.replyNo }" aria-label="replyDetail" value="${replyList.replyDetail }" readonly>
									<c:if test="${!empty sessionScope.user }">
										<c:if test="${!(sessionScope.user.role == 'a' || sessionScope.user.userId == replyList.userId) }">
											<div class="input-group-btn">
												<button type="button" name="replyNoForReport" id="willBeReported" class="btn btn-secondary btn-sm btn-danger">
									   				신고
									   			</button>
											</div>
										</c:if>
									</c:if>
									<c:if test="${!empty sessionScope.user}" >
										<c:if test="${sessionScope.user.role == 'a' || sessionScope.user.userId == replyList.userId }">
											<div class="input-group-btn">
									   			<button type="button" name="buttonForUpdate" id="updateReply${replyList.replyNo }" class="btn btn-secondary btn-sm btn-info" value="${replyList.replyNo }">
									   				수정
									   			</button>
								   				<button type="button" name="buttonForDelete" id="deleteReply${replyList.replyNo }" class="btn btn-secondary btn-sm btn-warning" value="${replyList.replyNo }">
								   					삭제
								   				</button>
											</div>
								   		</c:if>
								   	</c:if>
   									<input type="hidden" name="reviewNo" value=${review.reviewNo }>
									<span style="display: none" class="hidden_link">/review/getReview?reviewNo=${review.reviewNo }</span>
								</div>
	   						</td>
	   						<td align="center">
	   							${replyList.userId }
	   						</td>
	   						<td align="center">
	   							${replyList.replyRegDate }
	   						</td>
		   				</tr>
	   				</c:forEach>
   				</c:if>

			<!-- PageNavigation Start -->
			<%-- <jsp:include page="../../common/pageNavigator_new.jsp"/> --%> 
			<!-- PageNavigation End -->

   			</tbody>   			
   			
   		</table>
   		<!-- table End -->
   		

</body>
</html>