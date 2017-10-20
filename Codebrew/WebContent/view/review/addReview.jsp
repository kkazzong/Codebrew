<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	
	<!-- 참조 : http://getbootstrap.com/css/   참조 -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
	
	<title>후기등록화면</title>
	
	<!-- <link rel="stylesheet" href="/css/admin.css" type="text/css"> -->
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN(Content Delivery Network) ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
	<!-- The jQuery UI widget factory, can be omitted if jQuery UI is already included -->
	<!-- <script src="js/vendor/jquery.ui.widget.js"></script> -->
	<!-- The Iframe Transport is required for browsers without support for XHR file uploads -->
	<!-- <script src="js/jquery.iframe-transport.js"></script> -->
	<!-- The basic File Upload plugin -->
	<!-- <script src="js/jquery.fileupload.js"></script> -->
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
		body > div.container{
			border: 3px solid #D6CDB7;
			margin-top: 10px;
		}
    	
    	.img_wrap{
        	width:600px;
        	margin-top: 50px;
        }
        
        .img_wrap img{
        max-width: 200px;
        }
        
        .form-control{
        	resize: none; /* cannot be changed by the user */
        }
        
 		body {
            padding-top : 50px;
        }
		        
    </style>
    
	<!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">
	
	//=====기존 Code 주석 처리 후 jQuery 변경 =====//
	function fncAddReview() {
		
		//Form 유효성 검증
	 	//var reviewTitle = document.detailForm.reviewTitle.value;
		//var reviewDetail = document.detailForm.reviewDetail.value;
		//var reviewImage = document.detailForm.reviewImage.value;
		
		var reviewTitle = $("input[name='reviewTitle']").val();
		var reviewDetail = $("input[name='reviewTitle']").val();
		var reviewImage = $("input[name='uploadReviewImage']").val();
		
		if(reviewTitle == null || reviewTitle.length<1){
			alert("후기제목은 반드시 입력하여야 합니다.");
			return;
		}
		if(reviewDetail == null || reviewDetail.length<1){
			alert("후기상세정보는 반드시 입력하여야 합니다.");
			return;
		}
		if(reviewImage == null || reviewImage.length<1){
			alert("후기사진는 반드시 1장 이상 등록하여야 합니다.");
			return;
		}
		
		$("form").attr("method", "POST").attr("action", "/review/addReview").submit();
	}
	
	
	$(function(){
		//==>"등록" Event 처리 및 연결
		//==> DOM Object GET 3가지 방법 ==> 1.$(tagName) : 2.(#id) : 3.$(.className)
		//==>1과 3 방법의 조합 : $("tagName.className:filter함수") 사용함.
		$("button.btn.btn-primary:contains('등록')").on("click", function(){
			//Debug..
			//alert($("td.ct_btn01:contains('등록')").html());
			fncAddReview();
		});
		
		//==>"취소" Event 처리 및 연결
		//==>DOM Object GET 3가지 방법 ==> 1.$(tagName) : 2.(#id) : 3.$(.className)
		//==>1과 3 방법의 조합 : $("tagName.className:filter함수") 사용함.
		$("button.btn.btn-primary:contains('취소')").on("click", function(){
			//Debug..
			//alert($("td.ct_btn01:contains('취소')").html());
			if(confirm("취소하면 모든 정보가 사라집니다. 계속 하시겠습니까?")){
				javascript:history.go(-1);
			}else{
				return;
			}
		});
		
		//debug
		$("input:text[name='festivalNo']").on("keydown", function(){
			console.log($(this).val());
		});
	});
	
	$(document).ready(function(){
		$("input[name=toBeHashtag]").keydown(function(key){
			if(key.keyCode == 13){ //키 값이 13(enter)면 실행
				alert("hashtag로 등록됩니다.");
				console.log($(this).val());	
				var innerHtml = $("input:text[name=uploadHashtag]").val();
				innerHtml += "#"+$(this).val()+";";
				
				$("input:text[name=uploadHashtag]").val(innerHtml);
				$(this).val("");
			}
			
		});
	});
	
	</script>
	
</head>

<body>

<!-- ////////// ToolBar Start ////////// -->
<!-- <div class="navbar navbar-default">
	<div class="container">
		<a class="navbar-brand" href="/index.jsp"><strong>MOANA addReview</strong></a>
	</div>
</div> -->
<!-- ////////// ToolBar End ////////// -->

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="../../toolbar/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->


<!-- ////////// 화면구성 div Start ////////// -->
<div class="container">
	<h1 class="bg-primary text-center">후기등록양식</h1>
	
	<!-- ////////// form Start ////////// -->
	<form class="form-horizontal" method="post" name="detailForm" enctype="multipart/form-data">

		<!-- in the form group, should be there the hidden prodNo? -->
		<div class="form-group">
			<label for="festivalName" class="col-sm-offset-1 col-sm-3 control-label">축제번호</label>
			<div class="col-sm-4">
				<!-- <input type="hidden" id="festivalNo" name="festivalNo" value="638576"/> -->
				<input type="text" class="form-control" id="festivalNo" name="festivalNo">
			</div>
		</div>
		
		<hr/>
		
		<div class="form-group">
			<label for="festivalName" class="col-sm-offset-1 col-sm-3 control-label">축제명</label>
			<div class="col-sm-4">
				<input type="text" class="form-control" id="festivalName" name="festivalName" value="${festival.festivalName}" >
			</div>
		</div>
		
		<hr/>
		
		<div class="form-group">
			<label for="festivalAddr" class="col-sm-offset-1 col-sm-3 control-label">축제위치</label>
			<div class="col-sm-4">
				<input type="text" class="form-control" id="festivalAddr" name="festivalAddr" value="${festival.addr }" >
			</div>
		</div>
		
		<hr/>
		
		<div class="form-group">
			<label for="reviewTitle" class="col-sm-offset-1 col-sm-3 control-label">후기제목</label>
			<div class="col-sm-4">
				<input type="text" class="form-control" id="reviewTitle" name="reviewTitle" value="${review.reviewTitle }"/>
			</div>
		</div>
		
		<hr/>
		
		<div class="form-group">
			<label for="userId" class="col-sm-offset-1 col-sm-3 control-label">작성자</label>
			<div class="col-sm-4">
				<input type="text" class="form-control" id="writerId" name="writerId" value="${sessionScope.user.userId }" readonly/>
			</div>
		</div>
		
		<hr/>
		
		<div class="form-group">
			<label for="reviewFestivalRating" class="col-sm-offset-1 col-sm-3 control-label">축제에대한 작성자의 평점</label>
			<div class="col-sm-2">
				<input type="number" class="form-control" id="reviewFestivalRating" name="reviewFestivalRating" value="${review.reviewFestivalRating }" min="1" max="10"> 
			</div>
		</div>
		
		<hr/>
		
		<div class="form-group">
			<label for="reviewImage" class="col-sm-offset-1 col-sm-3 control-label">후기사진</label>
			<div class="col-sm-3">
				<input type="file" class="form-control" id="uploadReviewImage" name="uploadReviewImage" multiple/>
			</div>
		</div>
		
		<div class="form-group">
			<label for="reviewDetail" class="col-sm-offset-1 col-sm-3 control-label">후기내용</label>
			<div class="col-sm-4">
				<textarea rows="5" cols="30" class="form-control" id="reviewDetail" name="reviewDetail">${review.reviewDetail }</textarea>
			</div>
		</div>
		
		<hr/>
		
		<div class="form-group">
			<label for="reviewVideo" class="col-sm-offset-1 col-sm-3 control-label">동영상</label>
			<div class="col-sm-4">
				<input type="file" class="form-control" id="uploadReviewVideo" name="uploadReviewVideo" multiple/>			
			</div>
		</div>
		
		<div class="form-group">
			<label for="toBeHashtag" class="col-sm-offset-1 col-sm-3 control-label">해시태그를 입력</label>
			<div class="col-sm-4">
				<input type="text" class="form-control" id="toBeHashtag" name="toBeHashtag" value="">
				<span id="helpBlock" class="help-block">
					<strong class="text-danger">해시태그를 입력한 후 스페이스 혹은 엔터 키를 누르세요</strong>
				</span>
			</div>
		</div>
		
		<hr/>
		
		<div class="form-group">
			<label for="hashtag" class="col-sm-offset-1 col-sm-3 control-label">등록예정 해시태그</label>
			<div class="col-sm-4">
				<input type="text" class="form-control" id="uploadHashtag" name="uploadHashtag" readonly>
			</div>
		</div>
		
		<hr/>
				
		<div class="form-group">
			<div class="col-sm-offset-4 col-sm-4 text-center">
				<button type="button" class="btn btn-primary">등록</button>
				<button type="button" class="btn btn-primary">취소</button>
			</div>
		</div>
	
	
	</form>
	<!-- form End -->

</div>
<!-- ////////// 화면구성 div End ////////// -->
</body>
</html>