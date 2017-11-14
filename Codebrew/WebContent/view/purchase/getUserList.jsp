<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>

<html lang="ko">
	
<head>
	<meta charset="UTF-8">
	
	<!-- 참조 : http://getbootstrap.com/css/   참조 -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	
	<!-- Bootstrap Dropdown Hover CSS -->
   <link href="/resources/css/animate.min.css" rel="stylesheet">
   <link href="/resources/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
    <!-- Bootstrap Dropdown Hover JS -->
   <script src="/resources/javascript/bootstrap-dropdownhover.min.js"></script>
   
   
   <!-- jQuery ui -->
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<script src="https://code.jquery.com/ui/1.12.0/jquery-ui.min.js"></script>
	
	<link rel="stylesheet" href="/resources/css/badge.css">
	
    
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">
	
		//=============    검색 / page 두가지 경우 모두  Event  처리 =============	
		function fncGetList(currentPage) {
			$("#currentPage").val(currentPage)
			$("form").attr("method" , "POST").attr("action" , "/user/getUserList").submit();
		}
		
		$(function(){
			
			$(".mypage").each(function(){}).on("click", function(){
				console.log("이미지클릭"+$(this).find("input:hidden[name='requestId']").val());
				var requestId = $(this).find("input:hidden[name='requestId']").val();
				self.location ="/myPage/getMyPage?requestId="+requestId;
			});
			
		});
		
	</script>
	
	<style type="text/css">
	
		body {
			font-family: "Helvetica Neue", Helvetica, Arial;
		  font-size: 14px;
		  line-height: 20px;
		  font-weight: 400;
		  color: #3b3b3b;
		  padding-top : 70px;
		  -webkit-font-smoothing: antialiased;
		  font-smoothing: antialiased;
		  background-color: #f2f4f6;
	    }
	    
	     .text-info {
	    	color: #333333; 
	    }
	    
	    .page-header {
	    	border-bottom : 1px solid #f2f4f6;
	    }
	    
	    .table {
	    	margin-top: 70px;
	    }
	    
	    .table>thead>tr>th {
	    	font-weight: 900;
			color: #ffffff;
			background: #ea6153;
	    	text-align: center;
	    }
	    
	    .table>tbody>tr>td {
	    	font-size: 17px;
	    }
	    
	    .thead-dark th{color:#fff;background-color:#212529;border-color:#32383e}
	    /* div {
			border : 3px solid #D6CDB7;
			margin0top : 10px;
		} */
	
	</style>
	
	
	
</head>

<body>
	
	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/toolbar/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
	
	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container">
	
			<!-- page header -->
		<div class="row">
			<div class="col-md-offset-4 col-md-4">
				<div class="page-header text-center">
					<h3 class="text-info"><span class="glyphicon glyphicon-th-list" aria-hidden="true"></span>회원목록</h3>
				</div>
			</div>
		</div>
		
	    <!-- table 위쪽 검색 Start /////////////////////////////////////-->
	    <div class="row">
	    
		    <%-- <div class="col-md-6 text-left">
		    	<p class="text-primary">
		    		전체  ${resultPage.totalCount } 건수, 현재 ${resultPage.currentPage}  페이지
		    	</p>
		    </div> --%>
		    
		    <div class="col-md-offset-6 col-md-6 text-right">
			    <form class="form-inline" name="detailForm">
			    
				  <%-- <div class="form-group">
				    <select class="form-control" name="searchCondition" >
						<option value="1"  ${ ! empty search.searchCondition && search.searchCondition==2 ? "selected" : "" }>닉네임</option>
					</select>
				  </div>
				  
				  <div class="form-group">
				    <label class="sr-only" for="searchKeyword">검색어</label>
				    <input type="text" class="form-control" id="searchKeyword" name="searchKeyword"  placeholder="검색어"
				    			 value="${! empty search.searchKeyword ? search.searchKeyword : '' }"  >
				  </div>
				  
				  <button type="button" class="btn btn-default">검색</button> --%>
				  
				  <!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
				  <input type="hidden" id="currentPage" name="currentPage" value=""/>
				  
				 <!--  function fncGetList(currentPage) {
			$("#currentPage").val(currentPage)<----setValue 되서 value="" 널 초기값안에 쏙~ 들어감!
			$("form").attr("method" , "POST").attr("action" , "/user/getUserList").submit();
		}
		 -->
				  
				</form>
	    	</div>
	    	
	    	<c:forEach var="user" items="${list}">
		    	
		    	<div class="col-md-3 text-center mypage">
		    		<img  width="150" height="150" class="img-circle" alt="profileImage"
		    				onError="this.src='/resources/image/ui/default_error_image.jpg'" src="/resources/uploadFile/${user.profileImage }">
		    		<input type="hidden" name="requestId" value="${user.userId}">
		    		<h3>${user.nickname }</h3>
		    	</div>
	    	
	    	</c:forEach>
	    	
		</div>
	</div>
</body>

</html>