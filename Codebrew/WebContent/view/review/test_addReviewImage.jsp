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
	<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
	
	
	<!-- Generic page styles -->
	<link rel="stylesheet" href="../../resources/css/style.css">
	<!-- CSS to style the file input field as button and adjust the Bootstrap progress bars -->
	<link rel="stylesheet" href="../../resources/css/jquery.fileupload.css">
	
	
	<!-- 별점매기기 소스 start -->
	<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap.min.css" rel="stylesheet">
	<link href="../../resources/javascript/kartik-v-bootstrap-star-rating/css/star-rating.min.css" media="all" rel="stylesheet" type="text/css" />
	<script src="../../resources/javascript/kartik-v-bootstrap-star-rating/js/star-rating.min.js" type="text/javascript"></script>
	<!-- 이건 위에 있어서 혹시몰라 남겨둠...
	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
	별점매기기 소스 end -->
	
	
	
	<!-- jQuery Image Upload하여 등록전 실시간으로 선택하여 업로드 가능 혹은 삭제 -->
	<!-- 1. The jQuery UI widget factory, can be omitted if jQuery UI is already included -->
	<script src="../../resources/javascript/jquery.ui.widget.js" type="text/javascript"></script>
	
	<!-- 2. The Load Image plugin is included for the preview images and image resizing functionality -->
	<script src="http://blueimp.github.io/JavaScript-Load-Image/js/load-image.all.min.js"></script>
	
	<!-- 3. The Canvas to Blob plugin is included for image resizing functionality -->
	<script src="http://blueimp.github.io/JavaScript-Canvas-to-Blob/js/canvas-to-blob.min.js"></script>
	
	<!-- 4. The Iframe Transport is required for browsers without support for XHR file uploads -->
	<script src="../../resources/javascript/jquery.iframe-transport.js" type="text/javascript"></script>
	
	<!-- 5. The basic File Upload plugin -->
	<script src="../../resources/javascript/jquery.fileupload.js" type="text/javascript"></script>
	
	<!-- 6. The File Upload processing plugin 여기서부터 다운-->
	<script src="../../resources/javascript/jquery.fileupload-process.js"></script>
	
	<!-- 7. The File Upload image preview & resize plugin -->
	<script src="../../resources/javascript/jquery.fileupload-image.js"></script>
	
	<!-- 8. The File Upload audio preview plugin -->
	<script src="../../resources/javascript/jquery.fileupload-audio.js"></script>
	
	<!-- 9. The File Upload video preview plugin -->
	<script src="../../resources/javascript/jquery.fileupload-video.js"></script>
	
	<!-- 10. The File Upload validation plugin -->
	<script src="../../resources/javascript/jquery.fileupload-validate.js"></script>
	
	
	
	
	<!-- bootstrap은 위에서 cdn 처리 -->
	<!-- jQuery Image Upload하여 등록전 실시간으로 선택하여 업로드 가능 혹은 삭제 End-->
	
	
	<!-- 아래 테스트 중 sk editor 사용...안해 -->
	<!-- <script type = "text/javascript" src="../../resources/javascript/ckeditor/ckeditor.js"></script> -->
	
	<!-- The jQuery UI widget factory, can be omitted if jQuery UI is already included -->
	<!-- <script src="js/vendor/jquery.ui.widget.js"></script> -->
	<!-- The Iframe Transport is required for browsers without support for XHR file uploads -->
	<!-- <script src="js/jquery.iframe-transport.js"></script> -->
	<!-- The basic File Upload plugin -->
	<!-- <script src="js/jquery.fileupload.js"></script> -->
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
		/* body > div.container > .row{
			border: 3px solid #D6CDB7;
			margin-top: 10px;
		} */
    	
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
            background-color: #f2f4f6;
        }
        
        .imgs_wrap { 
        	/* border: 3px solid #333; */
        	/* width: 600px; */
        	/* height : 120px; */
        	margin-top: 50px;
        	aling-items: center;
        	justify-content: center;
        }
        
        .imgs_wrap img {
        	max-width: 200px;
        }
        
    </style>
    
	<!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">
	
	//=====기존 Code 주석 처리 후 jQuery 변경 =====//
	function fncAddReview() {
		
		
		var reviewTitle = $("input[name='reviewTitle']").val();
		var reviewDetail = $("textarea[name='reviewDetail']").val();
		var reviewImageList = $("input[name='uploadReviewImageList']").val();
		
		alert("reviewImageList :: "+reviewImageList);
		
		if(reviewTitle == null || reviewTitle.length<1){
			alert("후기제목은 반드시 입력하여야 합니다.");
			return;
		}
		if(reviewDetail == null || reviewDetail.length<1){
			alert("후기상세정보는 반드시 입력하여야 합니다.");
			return;
		}
		if(reviewImageList == null || reviewImageList.length<1){
			alert("후기사진는 반드시 1장 이상 등록하여야 합니다.");
			return;
		}
		
		//reviewDetail.replace("\r\n", "<br>");
		alert("reviewDetail 입력확인 :: "+reviewDetail); //debugging 용
		
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
		
		//modal창 띄우기
		$("button.btn.btn-info:contains('축제검색')").on("click", function(){
			window.open("/festival/getFestivalListDB?menu=pop", null, "height=450,width=600,status=yes,toolbar=no,menubar=no,location=no");
		});
		
		//등록예정인 해시태그들 삭제
		$("button.btn.btn-primary:contains('삭제')").on("click", function(){
			alert($('#reviewHashtag').val());
			$('#reviewHashtag').val("");
		});

		 
	});
	
	// 해시태그 등록
	$(document).ready(function(){
		$("input[name=toBeHashtag]").keydown(function(key){
			if(key.keyCode == 13){ //키 값이 13(enter)면 실행, 32(space)
				alert("hashtag로 등록됩니다.");
				console.log($(this).val());	
				var innerHtml = $("input:text[name=reviewHashtag]").val();
				innerHtml += "#"+$(this).val();
				
				$("input:text[name=reviewHashtag]").val(innerHtml);
				$(this).val("");
			}
			
		});
		
		/* $("#reviewDetail").keydown(function(key){
			if(key.keyCode == 13){
				var innerReviewDetail = $("textarea[name='reviewDetail']").val();
				//innerReviewDetail.replace("\r\n", "<br>");
				alert("innerReviewDetail :: "+innerReviewDetail); //debugging 용
			}
		}) */
	});
	
	
	/* jQuery File Upload Start */
	
	
	
	
	
	/* jQuery File Upload End */
	
	
	 
	</script>
	
</head>

<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="../../toolbar/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->

	<!-- 모달 -->
	<%--  
	<jsp:include page="getFestivalListDBmodal.jsp"></jsp:include>
	 --%>

<!-- ////////// 화면구성 div Start ////////// -->
<div class="container">

	  
	<div class="row">
		<div class="col-md-12">
			<div class="page-header text-center">
			<h3 class="text-info"><span class="glyphicon glyphicon-edit" aria-hidden="true"></span> 후기 등록</h3>
				<small>축제 후기를 공유해요.</small>
				<br>
				<br>
				<p>
					<button type="button" class="btn btn-info btn-lg" data-toggle="modal" data-target=".bs-example-modal-sm">
						축제검색
					</button>
				</p>
			</div>
		</div>
	</div>
	<!-- ////////// form Start ////////// -->
		
			<form class="form-horizontal" method="post" name="detailForm" enctype="multipart/form-data">
		
				<div class="form-group">
					<div class="col-md-offset-4 col-md-4 text-center">
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